package com.cserver.sso.authentication;
  
import java.security.GeneralSecurityException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Map;

import javax.annotation.Resource;
import javax.security.auth.login.AccountLockedException;
import javax.security.auth.login.AccountNotFoundException;
import javax.security.auth.login.FailedLoginException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.jasig.cas.authentication.HandlerResult;
import org.jasig.cas.authentication.PreventedException;
import org.jasig.cas.authentication.UsernamePasswordCredential;
import org.jasig.cas.authentication.handler.support.AbstractUsernamePasswordAuthenticationHandler;
import org.jasig.cas.authentication.principal.SimplePrincipal;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.cserver.saas.commons.util.DateUtil;
import com.cserver.saas.commons.util.key.KeyProvider;
import com.cserver.sso.bean.Authentication;
import com.cserver.sso.bean.UserInfo;
import com.cserver.sso.bean.UsernamePasswordCredentialWithAuthCode;
import com.cserver.sso.util.SaaSUserDaoJdbc;  
  
/**
* @author： byy 
* @date : 2017年11月23日 下午4:59:32
* @Description：自定义数据库方式认证类
*/  
public class SaaSAuthenticationHandler extends AbstractUsernamePasswordAuthenticationHandler {  
	 
    private static final String SQL_ONLOCK ="update AUTHENTICATION set isValid=0,failureTimes=0,sockedTime='',firstFailureTimes='' where lower(login_name) = lower(?)";
	private static final String SQL_RESETTIME ="update AUTHENTICATION set failureTimes=1,firstFailureTimes=? where lower(login_name) = lower(?)";
	private static final String SQL_LOCK_USER ="update AUTHENTICATION set isValid='1',sockedTime=? where lower(login_name) = lower(?)";
	private static final String SQL_FAILURETIME ="update AUTHENTICATION set firstFailureTimes=?, failureTimes=? where lower(login_name) = lower(?)";
	
	@Resource  
    private SaaSUserDaoJdbc userDaoJdbc;  
	
	Logger log = LoggerFactory.getLogger(SaaSAuthenticationHandler.class);
	
    protected HandlerResult authenticateUsernamePasswordInternal(UsernamePasswordCredential transformedCredential) throws GeneralSecurityException, PreventedException {  
        //UsernamePasswordCredential参数包含了前台页面输入的用户信息
        String usernameOriginal = transformedCredential.getUsername().
        				replaceAll(" ","").toLowerCase();//需要剔除空格,大写转小写  
        String password = transformedCredential.getPassword();
        HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.
				getRequestAttributes()).getRequest();
        Authentication authentication=userDaoJdbc.getAuthentication(usernameOriginal);       
        System.out.println("come on baby");
         //1.用户名是否存在验证
        if(authentication==null){
        	request.setAttribute("code", "用户名错误");
        	//登陆错误，需要验证码
			request.getSession().setAttribute("isNeedValid", "true");
        	//用户名错误用此异常
			log.info("username:"+usernameOriginal+",用户名错误");
        	throw new AccountNotFoundException();
        }
        /*若是绑定邮箱或者手机登陆的需要对登陆账户统一*/
        
        String username=authentication.getLogin_name();
        transformedCredential.setUsername(username);
         //2.验证码错误程序直接OVER
        if(!validatorCode(transformedCredential)){
        	request.setAttribute("code", "验证码错误");
        	request.getSession().setAttribute("isNeedValid", "true");  
        	log.info("username:"+usernameOriginal+",验证码错误");
            throw new FailedLoginException();
    	}
        //3.认证用户名和密码是否正确  
        if(!userDaoJdbc.verifyAccount(username, password)){        	
        	String code=this.failureLogin(authentication);
        	request.setAttribute("code", code);
        	request.getSession().setAttribute("isNeedValid", "true");
        	log.info("username:"+usernameOriginal+",密码错误");
        	throw new FailedLoginException();
        }
        //4.账户当前是否处于锁定状态
         if(this.validatorAuthentication(authentication)!=null){
        	request.setAttribute("code","账户已经被锁，请30分钟后登陆");
        	log.info("username:"+usernameOriginal+",账户已经被锁，请30分钟后登陆");
        	throw new AccountLockedException();
        }
        //5.登陆成功添加登陆日志(此方法仅限平台库，其他库登陆日志待定)
        this.loginSuccessLog(username);
        //6.返回登陆成功状态，CAS程序继续运行
		return createHandlerResult(transformedCredential, new SimplePrincipal(username), null);				
    }
    /**  
	  
	* 功能： 验证账户是否可用，并返回提示消息
	  
	* @author baiyuanyuan
	
	* @date   2017年12月5日 下午5:17:15  
	
	* @param        
	  
	* @return   
	
	*/
	private String validatorAuthentication(Authentication authentication) {
    	/*用于返回错误信息,不返回则代表账户正常,此时账户密码是正确的*/   	
		String code=null;
        int sockedtime = 30;//锁定持续时间       
        //被锁时间
        String sockedTime = authentication.getSockedTime();
        //是否锁定
      	String isValid  = authentication.getIsValid()!=null?authentication.getIsValid():"0";		      		
		Calendar calendar=Calendar.getInstance();
		calendar.setTime(new Date());
		calendar.add(Calendar.MINUTE,-sockedtime);
		Date afterDate = calendar.getTime();
    	//锁定时间已过，自动解锁
		if(isValid.equals("1")&&this.equalTime(sockedTime,afterDate)){			
			userDaoJdbc.updateSQL(SQL_ONLOCK, new Object[]{authentication.getLogin_name()});
			isValid = "0";
		}
		if(isValid.equals("1")||authentication.getState()==1){
			code="账号已被锁定！";
		}
		return code;
	}
	/**  
	  
	* 功能：  登陆成功日志操作
	  
	* @author baiyuanyuan
	
	* @date   2017年12月6日 下午6:09:59  
	
	* @param        
	  
	* @return   
	
	*/
	private String loginSuccessLog(String username) {
    	/**/   	
		String code=null;
		UserInfo info=new UserInfo();
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.
				getRequestAttributes()).getRequest();	      
		//String ip=request.getRemoteHost();	
		// 获取真实客户端IP
		String ip = this.getIpAddr(request);
		String usersql=null;
		//本来是根据配置读取的暂时写死ReadConfig.getString("datasourcetype");
		String datasourcetype="platform";
		if("system".equals(datasourcetype)){
			usersql="select t.name from org_user t where t.login_name='"+username+"'";
		}
		if("platform".equals(datasourcetype)){
			usersql="select u.nick_name as name from pt_user u,authentication a where u.id=a.id and a.login_name='"+username+"'";
		}
		////就为了取个不知道有没有用的用户昵称？？？？？？
		Map<String, Object> map=userDaoJdbc.getInfoBySQL(usersql);
		if(map!=null){
			//设置用户昵称
			info.setUsername(map.get("name")!=null?(String)map.get("name"):"");
		}
		String id=KeyProvider.getKey_uuid();
		// 添加登录日志
		String os="";
		String browser="";
		String agent = request.getHeader("User-Agent");
		if(agent.indexOf("MSIE")>-1){
			browser="InternetExplorer";
		}else if(agent.indexOf("Chrome")>-1){
			browser="Chrome";
		}else if(agent.indexOf("Firefox")>-1){
			browser="Firefox";
		}
		if(agent.indexOf("Windows NT 5.1")>-1){
			os="WindowsXp";
		}else if(agent.indexOf("Windows NT 5.2")>-1){
			os="WindowsServer2003";
		}else if(agent.indexOf("Windows NT 6.0")>-1){
			os="WindowsServer2008";
		}else if(agent.indexOf("Windows NT 6.1")>-1){
			os="Windows7";
		}
		String logsql="insert into login_log(ID,USER_NAME,LOGIN_NAME,TIME,IP,BROWSER,OS ) values('"+id+"','"+info.getUsername()+"','"+username+"',to_date('"+DateUtil.datetimeToStr(new Date())+"','YYYY-MM-DD HH24:MI:SS'),'"+ip+"','"+browser+"','"+os+"')";
		
		userDaoJdbc.saveInfoBySQL(logsql);
			
		
		return code;
	}
    /**  
	  
	* 功能： 密码错误时，更新表数据，并返回提示消息
	  
	* @author baiyuanyuan
	
	* @date   2017年12月5日 下午8:17:23  
	
	* @param  request.getSession().setAttribute("isNeedValid", "true");      
	  
	* @return   
	
	*/
	private String failureLogin (Authentication authentication) {
    	/*用于返回错误信息,不返回则代表账户正常,此时账户密码是正确的*/
		String code=null;    	
        //int sockedtime = 30;//锁定持续时间
		int allowfailuretimes = 5;//容许连续登错次数
		int continuelogintime = 3;//连续登错时间长		
		
		//是否系统管理员
		String isSM = authentication.getIsSM();
		//当前登陆失败次数
		int failureTimes = authentication.getFailureTimes();
		//第一次登错时间
		String firstFailureTimes = authentication.getFirstFailureTimes();
		//被锁时间
		
		Calendar calendar=Calendar.getInstance();
		calendar.setTime(new Date());
		calendar.add(Calendar.MINUTE,-continuelogintime);
		Date afterDate2 = calendar.getTime();
		
		Date date = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String firstFailerTime = sf.format(date);
		
		if(!"1".equals(isSM)){//普通用户
			if(equalTime(firstFailureTimes,afterDate2)){//过了连续登错时间长，重新计数
				userDaoJdbc.updateSQL(SQL_RESETTIME,new Object[]{firstFailerTime,authentication.getLogin_name()});
				
				code="密码错误！";
			}else{
				if((failureTimes+1) >= allowfailuretimes){
					//最后一次登录错误，账号直接锁定
					userDaoJdbc.updateSQL(SQL_LOCK_USER,new Object[]{firstFailerTime,authentication.getLogin_name()});
					
					code="账号已被锁定！";
				}else{
					if(firstFailureTimes==null || firstFailureTimes.equals("")){
						firstFailureTimes = firstFailerTime;
					}									
					userDaoJdbc.updateSQL(SQL_FAILURETIME,new Object[]{firstFailureTimes,(failureTimes+1),authentication.getLogin_name()});
					
					code="密码错误！";
				}
			}
		}else{//管理员只提示密码错误
			code="密码错误！";
		}	
		return code;
	}
    /**  
	  
	* 功能： 验证验证码时是否正确
	  
	* @author baiyuanyuan
	
	* @date   2017年12月4日 上午11:53:44  
	
	* @param        
	  
	* @return   
	
	*/
	private boolean validatorCode(UsernamePasswordCredential transformedCredential) {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		HttpSession session =request.getSession();		
		  //rest接口不需要验证码
        if("/sso.web/v1/tickets".equals(request.getRequestURI())){
           return true;
        }
		UsernamePasswordCredentialWithAuthCode upc = (UsernamePasswordCredentialWithAuthCode) transformedCredential;        
        String submitAuthcode = upc.getAuthcode();
        String isNeedValid = request.getParameter("isNeedValid");
        //不需要验证码时，直接放行
        if(!"true".equals(isNeedValid)){
        	return true;
        }
        
        String authcode = (String) session.getAttribute(com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY);
        session.removeAttribute(com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY);
        if (StringUtils.isEmpty(submitAuthcode) || StringUtils.isEmpty(authcode)) {
            System.out.println("验证码没填OR验证码未生成");          
        }
        if (submitAuthcode.equalsIgnoreCase(authcode)) {
        	System.out.println("验证码正确");
            return true;
        }
        return false;
	}
	/**  
	  
	* 功能： 判断时间time是否大于afterDate
	  
	* @author baiyuanyuan
	
	* @date   2017年12月5日 下午3:55:38  
	
	* @param        
	  
	* @return   
	
	*/
	public boolean equalTime(String time,Date afterDate){
		boolean flag = true;
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		if(null==time || "".equals(time)){
			flag = false;
		}else{
			try {
				Date beforeDate = sf.parse(time);
				if(beforeDate.after(afterDate)){
					flag = false;
				}
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		return flag;
	}
	
	/**
	 * 获取访问者IP
	 * 
	 * 在一般情况下使用Request.getRemoteAddr()即可，但是经过nginx等反向代理软件后，这个方法会失效。
	 * 
	 * 本方法先从Header中获取X-Real-IP，如果不存在再从X-Forwarded-For获得第一个IP(用,分割)，
	 * 如果还不存在则调用Request .getRemoteAddr()。
	 * 
	 * @param request
	 * @return
	 */
	private String getIpAddr(HttpServletRequest request) {
		String ip = request.getHeader("X-Real-IP");
		if (!StringUtils.isBlank(ip) && !"unknown".equalsIgnoreCase(ip)) {
			if(ip.contains("../")||ip.contains("..\\")){
				return "";
			}
			return ip;
		}
		ip = request.getHeader("X-Forwarded-For");
		if (!StringUtils.isBlank(ip) && !"unknown".equalsIgnoreCase(ip)) {
			// 多次反向代理后会有多个IP值，第一个为真实IP。
			int index = ip.indexOf(',');
			if (index != -1) {
				ip= ip.substring(0, index);
			}
			if(ip.contains("../")||ip.contains("..\\")){
				return "";
			}
			return ip;
		} else {
			ip=request.getRemoteAddr();
			if(ip.contains("../")||ip.contains("..\\")){
				return "";
			}
			if(ip.equals("0:0:0:0:0:0:0:1")){
				ip="127.0.0.1";
			}
			return ip;
		}
		
	}
}  