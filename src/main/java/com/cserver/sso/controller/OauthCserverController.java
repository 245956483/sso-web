package com.cserver.sso.controller;

import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;

import com.alibaba.fastjson.JSONObject;
import com.cserver.sso.bean.Authentication;
import com.cserver.sso.bean.UserDetail;
import com.cserver.sso.util.HttpRequest;
import com.cserver.sso.util.ReadConfig;
import com.cserver.sso.util.SaaSUserDaoJdbc;
/**
* @author： byy 
* @date : 2018年1月3日 上午9:45:42
* @Description：返回第三方登陆用户信息,不对外暴露，
* 			         仅供LoginCserverController回跳使用
*/
public class OauthCserverController extends AbstractController{
	/**
     * 正则表达式：验证手机号
     */
    public static final String REGEX_MOBILE = "^1[0-9]{10}$";
	  
	Logger log = LoggerFactory.getLogger(OauthCserverController.class);

    private SaaSUserDaoJdbc userDaoJdbc;

	public void setUserDaoJdbc(SaaSUserDaoJdbc userDaoJdbc) {
		this.userDaoJdbc = userDaoJdbc;
	}

	public ModelAndView  handleRequestInternal(HttpServletRequest req,
			HttpServletResponse rep) throws Exception {
		HttpSession session =req.getSession();		
		String info =(String) session.getAttribute("info");	
		JSONObject retrunJson =JSONObject.parseObject(info);
		String returnUrl = (String) retrunJson.get("returnUrl");
		//移除没用的返回信息
		retrunJson.remove("returnUrl");		
		String code=req.getParameter("code");		
		//获取accesstoken
		String getAccessTokenUrl=ReadConfig.getString("sso.name")+"/oauth2.0/accessToken?client_id=key&client_secret=secret&grant_type=authorization_code&redirect_uri=" +
			ReadConfig.getString("sso.name")+"/oauthCserver&code="+code;
		String accesstoken=HttpRequest.sendGet(getAccessTokenUrl);
		if(accesstoken!=null){
			accesstoken=accesstoken.split("&expires")[0].split("=")[1];
		}
		log.info("Oauth访问，accesstoken获取成功："+accesstoken);
		//获取用户信息
		String getProfileUrl=ReadConfig.getString("sso.name")+"/oauth2.0/profile?access_token="+accesstoken;
		
		String userinfoJson=HttpRequest.sendGet(getProfileUrl);			
		JSONObject json =JSONObject.parseObject(userinfoJson);
		
		log.info("Oauth访问，userinfoJson获取成功："+userinfoJson);
		
		String username=json.get("id").toString();
		//获取额外用户信息，并写入retrunJson
		UserDetail user = userDaoJdbc.getUserDetailByUsername(username);
		//手机号必须是手机注册或者认证过的手机号
		if(isMobile(username)){
			retrunJson.put("mobilePhone",username);
		}else{
			Authentication autoUser=userDaoJdbc.getAuthentication(username);
			String attachLoginName=autoUser.getAttach_login_name()!=null?autoUser.getAttach_login_name():"";
			if(isMobile(attachLoginName)){
				retrunJson.put("mobilePhone",attachLoginName);	
			}else{
				retrunJson.put("mobilePhone","");
			}
		}
		retrunJson.put("id", user.getId());
		retrunJson.put("success", true);
		retrunJson.put("msg", "登陆成功");
		retrunJson.put("username", username);				
		retrunJson.put("realname",user.getName()!=null?user.getName():"匿名");
		retrunJson.put("company",user.getCompany()!=null?user.getCompany():"");		
		String jsonobj = JSONObject.toJSONString(retrunJson);		
		ModelAndView mav=new ModelAndView("redirect:"+returnUrl);
		mav.addObject("info", jsonobj);	
        return mav;
	}	
	/**
     * 校验手机号
     * 
     * @param mobile
     * @return 校验通过返回true，否则返回false
     */
    public static boolean isMobile(String mobile) {
    	
        return Pattern.matches(REGEX_MOBILE, mobile);
    }
}
