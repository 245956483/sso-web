package com.cserver.sso.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import com.cserver.sso.bean.Authentication;
import com.cserver.sso.util.DesUtil;
import com.cserver.sso.util.HttpRequest;
import com.cserver.sso.util.ReadConfig;
import com.cserver.sso.util.SaaSUserDaoJdbc;
/**
* @author： byy 
* @date : 2018年1月3日 上午9:47:16
* @Description：第三方调用中服登陆REST接口,代码写法受限于CAS
*/
public class LoginSSOController extends AbstractController{
	
	private static final String SQL_ONLOCK ="update AUTHENTICATION set isValid=0,failureTimes=0,sockedTime='',firstFailureTimes='' where lower(login_name) = lower(?)";

	Logger log = LoggerFactory.getLogger(LoginSSOController.class);
	
	private SaaSUserDaoJdbc userDaoJdbc;

	public void setUserDaoJdbc(SaaSUserDaoJdbc userDaoJdbc) {
		this.userDaoJdbc = userDaoJdbc;
	}	
	
	/**  
	  
	* 功能： 第三方调用登陆REST接口,对外暴露	  
	* @author baiyuanyuan	
	* @date   2018年1月3日 上午9:47:39  	
	* @param  
	* 		  username
	* 		  password      
	  
	* @return   
	
	*/
	protected ModelAndView  handleRequestInternal(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		System.out.println("访问接口loginsso");
		ModelAndView mav = new ModelAndView();
		MappingJackson2JsonView  view = new MappingJackson2JsonView ();
        Map<String,Object> attributes = new HashMap<String,Object>();
		
		String username=request.getParameter("username");
		String password=request.getParameter("password");
		String appid=request.getParameter("appid");
		//参数不合法
		if(isEmpty(username)||isEmpty(password)||isEmpty(appid)){
			log.info("REST认证接口访问，参数不合法("+username+":"
					+password+":"+appid+")");
			attributes.put("success", false);
			attributes.put("username", username);
			attributes.put("msg", "参数不全");
			view.setAttributesMap(attributes);
		    mav.setView(view);			
		    return mav;
		}
		//1.用户名是否存在验证
		Authentication authentication=userDaoJdbc.getAuthentication(username);               
        if(authentication==null){
        	log.info("REST认证接口访问,用户不存在");
        	attributes.put("success", false);
			attributes.put("username", username);
			attributes.put("msg", "用户名不存在");
			view.setAttributesMap(attributes);
		    mav.setView(view);			
		    return mav;
        }
        //2.验证用户是否锁定
        if(this.validatorAuthentication(authentication)!=null){
        	log.info("REST认证接口访问，用户多次访问错误，账户已被锁定");
        	attributes.put("success", false);
			attributes.put("username", username);
			attributes.put("msg", "用户已被锁定，请30分钟后登陆");
			view.setAttributesMap(attributes);
		    mav.setView(view);			
		    return mav;
        }
		String access_token=userDaoJdbc.getAccesstoken(appid);
		//3.access_token合法性
		if(isEmpty(access_token)){
			log.info("REST认证接口访问，appid不合法，找不到access_token");
			attributes.put("success", false);
			attributes.put("accessToken", access_token);
			attributes.put("username", username);
			attributes.put("msg", "access_token不合法");
			view.setAttributesMap(attributes);
		    mav.setView(view);			
		    return mav;
		}
		String passworddec=password;
		//4.密码解密
		try {
			
			password=DesUtil.decrypt(password,access_token);
		} catch (Exception e1) {
			log.info("REST认证接口访问，密码解密失败");

			attributes.put("password", passworddec);
			attributes.put("accessToken", access_token);
			attributes.put("success", false);
			attributes.put("username", username);
			attributes.put("msg", "服务异常");
			view.setAttributesMap(attributes);
		    mav.setView(view);			
		    return mav;
			
		}
		
		//5.先验证密码是否正确，否则第一个接口后台会报错
        if(!userDaoJdbc.verifyAccount(username, password)){       	
        	log.info("REST认证接口访问，"+username+":密码错误:"+password);
			attributes.put("accessToken", access_token);
			attributes.put("success", false);
			attributes.put("username", username);
			attributes.put("msg", "密码错误");
			view.setAttributesMap(attributes);
		    mav.setView(view);			
		    return mav;
        }
        //6.调用三个REST接口
		try {
			String url= ReadConfig.getString("sso.name")+"/v1/tickets";			
			String str="username="+username+"&password="+password+"&service=http://cserver.cn";			
			String msg=HttpRequest.sendPost(url, str);
			attributes.put("username", username);
			attributes.put("accessToken", access_token);
			if(!(msg.indexOf("/tickets/")>-1)){
				attributes.put("success", false);				
			}else{
				String TGT=msg.split("/tickets/")[1].split("\"")[0];
				String ST=HttpRequest.sendPost(url+"/"+TGT, "service=http://cserver.cn");				
				String info=HttpRequest.sendGet(ReadConfig.getString("sso.name")+"/serviceValidate?service=http://cserver.cn&ticket="+ST);								
				username=info.split("<cas:user>")[1].split("</cas:user>")[0];				
				attributes.put("success", true);
				attributes.put("msg", "认证成功");
			}			
		} catch (Exception e) {
			log.info("REST认证接口访问，服务异常，稍后再试");
			attributes.put("success", false);
			attributes.put("username", username);
			attributes.put("msg", "服务异常，稍后再试");
			e.printStackTrace();
		}

        view.setAttributesMap(attributes);
        mav.setView(view);			
        return mav;
	}
	/**  
	  
	* 功能：用于返回错误信息,不返回则代表账户正常,此时账户密码是正确的 
	  
	* @author baiyuanyuan
	
	* @date   2018年1月10日 下午4:54:23  
	
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
	private static boolean isEmpty(String str)  {
		   if("".equals(str)||str==null){
			   return true;
		   }
		   return false;
	}	
    	 	
}
