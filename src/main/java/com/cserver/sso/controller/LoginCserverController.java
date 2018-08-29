package com.cserver.sso.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;

import com.alibaba.fastjson.JSONObject;
import com.cserver.sso.util.ReadConfig;
import com.cserver.sso.util.SaaSUserDaoJdbc;
/**
* @author： byy 
* @date : 2018年1月3日 上午9:47:16
* @Description：第三方调用中服Oauth登陆接口,代码写法受限于CAS
*/
public class LoginCserverController extends AbstractController{
	
	private SaaSUserDaoJdbc userDaoJdbc;

	public void setUserDaoJdbc(SaaSUserDaoJdbc userDaoJdbc) {
		this.userDaoJdbc = userDaoJdbc;
	}
	Logger log = LoggerFactory.getLogger(LoginCserverController.class);

	/**  
	  
	* 功能： 第三方调用中服Oauth登陆接口,对外暴露
	  
	* @author baiyuanyuan
	
	* @date   2018年1月3日 上午9:47:39  
	
	* @param  returnUrl      
	  
	* @return   
	
	*/
	protected ModelAndView  handleRequestInternal(HttpServletRequest req,
			HttpServletResponse rep) throws Exception {
		String info=req.getParameter("info");
		JSONObject retrunJson =JSONObject.parseObject(info);
		String returnUrl = (String) retrunJson.get("returnUrl");		
		log.info("Oauth访问，返回地址returnUrl:"+returnUrl);
		if(returnUrl==null||"".equals(returnUrl)){			
			return null;
		}
		//验证access_token是否合法
		String access_token = (String) retrunJson.get("access_token");		
		if(!userDaoJdbc.verifyAccesstoken(access_token)){
			log.info("Oauth访问，access_token不合法");
			Map<String,Object> mapobj = new HashMap<String,Object>();
			mapobj.put("success", false);
			mapobj.put("resultMessage", "access_token不合法");						
			String jsonobj = JSONObject.toJSONString(mapobj);			
			ModelAndView mav=new ModelAndView("redirect:"+returnUrl);
			mav.addObject("info", jsonobj);	
			return mav;
		}
		HttpSession session =req.getSession();
		session.setAttribute("info", info);
		String url= ReadConfig.getString("sso.name")+"/oauth2.0/authorize?client_id=key&redirect_uri=" +
	    ReadConfig.getString("sso.name")+"/oauthCserver&response_type=code";				
        
        //重写Cookie重新设置JSESSIONID的声明周期  
        Cookie c=new Cookie("JSESSIONID", session.getId());  
        c.setPath(req.getContextPath());  
        c.setMaxAge(1800);  
        rep.addCookie(c); 
        rep.sendRedirect(url);
		return null;
	}
	
	
}
