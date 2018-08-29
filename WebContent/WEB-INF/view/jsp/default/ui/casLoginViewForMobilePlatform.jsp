<%@ page session="true" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="com.cserver.sso.util.ReadConfig" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<title>用户登陆</title>
<meta charset="gb2312">
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=no">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/setCook.js"></script>
<link href="res/defaultMobile/css/phoneStyle.css" rel="stylesheet" type="text/css"/>
<%

		String service = request.getParameter("service");
		if(service==null) service = "";
		String url = java.net.URLDecoder.decode(service);
		service = java.net.URLEncoder.encode(service);
	
		int endIndex;
	
		String logName = "";
		if(url.length()>0){
			if(url.indexOf("logName=")>-1){
				endIndex = url.indexOf("&", url.indexOf("logName="));
				if(endIndex<0){
					endIndex = url.length();
				}
				logName = url.substring(url.indexOf("logName=")+8,endIndex);
			}
		}
		String systemTemplateId = "";
		if(url.length()>0){
			if(url.indexOf("systemTemplateId=")>-1){
				endIndex = url.indexOf("&", url.indexOf("systemTemplateId="));
				if(endIndex<0){
					endIndex = url.length();
				}
				systemTemplateId = url.substring(url.indexOf("systemTemplateId=")+17,endIndex);
			}
		}
	%>
</head>
<body id="cas" class="login_body">
	
  <img src="res/defaultMobile/images/newpbanner.png" width="100%" height="150px" />
  <div class="form-unit">

     <form:form method="get" id="fm1" cssClass="fm-v clearfix" commandName="${commandName}" htmlEscape="true">		
	   <div class="form-field">
	     <form:input cssClass="form-control input" placeholder="手机号/邮箱" cssErrorClass="error" value="" id="username" maxlength="50" tabindex="1" accesskey="${userNameAccessKey}" path="username" autocomplete="false" onblur="GetPwdAndChk();" htmlEscape="true" />
	   </div>
	    <div id="mobileCK" class="validate"></div>
	    <input type="hidden"  id="type" name="type" value="mobile" class="form-control input" >
	   <div class="form-field">
	   <form:password cssClass="form-control input" placeholder="密码" cssErrorClass="error text_kuang txtw1" value="" maxlength="50" id="password" tabindex="2" path="password"  accesskey="${passwordAccessKey}" htmlEscape="true" autocomplete="off" />
	   <input style="display:none" checked="checked" type="checkbox"  class="Chk_RName" id="rmbUser" name="rmbUser" />
	   </div>
	   <span id="checkts"  class="validate">${code}</span>
	   <!--  
	   <button type="submit" class="btn form-control " data-gta="event" data-label="login-direct" onclick="check()">登 录</button>
	   -->
	   <div class="phone-pass">
	      <input type="hidden" name="lt" value="${loginTicket}" />
		<input type="hidden" name="execution" value="${flowExecutionKey}" />
		<input type="hidden" name="_eventId" value="submit" />
	     <a id="loginUser"  href="#" onclick="check()">登录</a>
       </div>
	   <div class="line"></div>
	   <div class="tb-auth">
	     <a href="#" onclick="goRegister()" class="btn form-control a-bj">还没有账号？免费注册</a>
		 <a href="#" onclick="goReset()" class="btn form-control a-bj">忘记密码？重置</a>
	</form:form>
	 
  </div>
<%@ include file="includes/cs.jsp" %>
<%CS cs = new CS(1256362311);cs.setHttpServlet(request,response);
String imgurl = cs.trackPageView();%> 
<img src="<%= imgurl %>" width="0" height="0"  />
</body>
<script language="JavaScript">

window.onload = function(){
	 var logName = "<%=logName%>";
	 if(logName){
		$("#username").val(logName);
		$("#password").val("");
	 }else{
		GetLastUser();
	 }
};

function goRegister(){
	window.location.href="http://<%=ReadConfig.getString("host.platform") %>/registeruser.do?service="+encodeURIComponent("/addToTaskList.do?type=0&state=3&systemTemplateId=<%=systemTemplateId%>");
}
function goReset(){
	window.location.href="http://<%=ReadConfig.getString("host.platform") %>/pwdReset.do?service="+encodeURIComponent("/addToTaskList.do?type=0&state=3&systemTemplateId=<%=systemTemplateId%>");
}
//用户登录时的校验
function check(){
	$("#loginUser").hide();
		//获取手机
	var phone = $("#username").val(); 
	//获取密码
	var pwd = $("#password").attr("value");
	var service = $("#service").val();
	if(pwd !=""){
		SetPwdAndChk();
	    fm1.submit();
	}else{
		 $("#checkts").text('*请输入密码!'); 
		 $("#loginUser").show();
	}
	
}

function isMobile(){   
	var s = $("#username").val(); 
	var mobileFlag = false;
	var reg = /^([1-9]\d*)$/;   
	if (reg.test(s) && s.length == 11)mobileFlag=true;   
	if(s!=""){   
		if (!mobileFlag){
			if(s.length != 11){
				$("#mobileCK").text('*手机号码不是11位!');
				$("#username").focus();   
			}else{
				$("#mobileCK").text('*请输入正确的手机号码!');
				$("#username").focus();   
			}
			
		}else{
			$("#mobileCK").text("");
		}
	}else{
		$("#mobileCK").text('*手机号码不能为空!');
		$("#username").focus();   
	}   
	return mobileFlag;
}  
</script>
</html>
