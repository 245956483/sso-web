<%@ page session="true" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="com.cserver.sso.util.ReadConfig" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE HTML>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="keywords" content="工业互联网平台,工业云,工业大数据,工业PaaS,工业APP,工业4.0,工业互联网,工业智能,工业大数据解决方案">
<meta name="description" content="工业互联网平台,工业云,工业大数据,工业PaaS,工业APP,工业4.0,工业互联网,工业智能,工业大数据解决方案">
<title>用户登录</title>
<link href="res/eazytec/css/style.css" rel="stylesheet">
<link href="res/eazytec/css/login.css" rel="stylesheet">
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/setCook.js"></script>
<script type="text/javascript" src="js/common_rosters.js"></script>
<script type="text/javascript" src="js/placeholder.js"></script>
<%

	String service = request.getParameter("service");
	if(service==null) service = "";
	String url = java.net.URLDecoder.decode(service);
	service = java.net.URLEncoder.encode(service);
	
	String fromurl = "";
	int endIndex;
	if(url.length()>0){
		if(url.indexOf("fromurl=")>-1){
			endIndex = url.indexOf("&", url.indexOf("fromurl="));
			if(endIndex<0){
				endIndex = url.length();
			}
			fromurl = url.substring(url.indexOf("fromurl=")+8,endIndex);
		}
	}
	
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
	      String isv = null;
	      if(url.length()>0){
		if(url.indexOf("isv=1")>-1){
			isv="1";
		}
	}
%>
</head>
<body>

<!--------------------head-------------------------->
<div style="height:71px">
<iframe id="myiframe" src="http://www.cloud.zqtong.com/ggtb/index.jhtml &#10;&#10;" style="border-style:none;width:100%;height:70px;min-width:1240px" border:0;fremeborder:0;frameborder="0" scrolling="no">
</iframe>
</div>
<!----------------------------banner---------------------------->



<!--------------------main-------------------------->
<div class="main LoginBg">
    <div class="main_wh">
       <div class="loginLf lf"> <img src="res/eazytec/images/poster.png"></div>
       <div class="loginRt rt">
           <div class="loginBox">
		   <form:form method="post" id="fm1" cssClass="fm-v clearfix" commandName="${commandName}" onsubmit="return check()" htmlEscape="true">
		    <% if(isv!=null){ %>
               <h3 class="LoginH3">服务商登录</h3>
			<%}else{%>
			   <h3 class="LoginH3">用户登录</h3>
			<%}%>
			   <span id="register" style="display:none; height:18px; color: red;font-size: 14px;font-weight: bold;">注册成功,请登录</span><span id="createSys" style="display:none; height:18px; color: red;font-size: 14px;font-weight: bold;">开通成功,请登录</span>
		 
                  <div class="LoginForm">
                      <div class="LoginDiv">
					   <c:if test="${not empty sessionScope.openIdLocalId}">
							<strong>${sessionScope.openIdLocalId}</strong>
                            <input type="hidden" id="username" name="username" value="${sessionScope.openIdLocalId}" />
							</c:if>
							<span class="spanName"><img src="res/eazytec/images/user.jpg"></span>
							<c:if test="${empty sessionScope.openIdLocalId}">
							<spring:message code="screen.welcome.label.netid.accesskey" var="userNameAccessKey" />
							<form:input placeholder="输入手机号或邮箱" cssClass="required Ipt inputcw txt" cssErrorClass="error txt" id="username" maxlength="50" tabindex="1" accesskey="${userNameAccessKey}" path="username" autocomplete="false" onblur="this.className='Ipt inputcw txt';GetPwdAndChk();" onfocus="this.className='Ipt IptOnF inputcw txt'" htmlEscape="true" />
						</c:if>
                         
                       </div>
                      <div class="LoginDiv">
					  <span class="spanName"><img src="res/eazytec/images/password.jpg"></span>
					   <spring:message code="screen.welcome.label.password.accesskey" var="passwordAccessKey" />
				       <form:password  cssClass="required Ipt inputcw txt" cssErrorClass="error text_kuang txtw1 txt" maxlength="50" id="password" tabindex="2" path="password"  accesskey="${passwordAccessKey}" htmlEscape="true" autocomplete="off" />
                      </div>
					 
					 <c:choose>
						 <c:when test="${isNeedValid eq 'true' }">
						<div class="LoginDiv">
						 <input id="j_captcha_response" class="inputcw txt txt1" type="text" tabindex="3" style="width:103px;" name="authcode" placeholder="输入验证码">
                         <span class="Spanyzm">
							<img id="codes" onclick="this.src='captcha.jpg?'+Math.random()" src="captcha.jpg">
						</span>
					
					  </div>
					   
						</c:when>
						<c:otherwise>
					  </c:otherwise>
					</c:choose>
                      <div class="LoginDiv">
                          <input type="checkbox" class="Chk_RName" id="rmbUser" name="rmbUser"> 记住密码
                          <span class="forgetPass"><a href="http://<%=ReadConfig.getString("host.platform")%>/saasForgotPassword.do?layout=eazytec">忘记密码</a></span>
                      </div>
					  <span id="checkts" style="color: #b10000; font-family:"宋体"; font-size: 9pt; font-weight: bold; line-height: 13pt;">${code}</span>
					  
                      <div class="LoginDiv">
					  
					  <input type="hidden" name="isNeedValid" value="${isNeedValid }" />
					<input type="hidden" name="lt" value="${loginTicket}" />
					<input type="hidden" name="execution" value="${flowExecutionKey}" />
					<input type="hidden" name="_eventId" value="submit" />
					<button class="aBtn redBg lf"   name="submit" accesskey="l"   tabindex="4" type="submit" onclick="" value="登录">登录</button>
					  
                      <button type="button" class="aBtn blankBg rt"  id="resetButton">重置</button>
                      </div>
                      <div class="LoginDiv">
					   <% if(isv!=null){ %>
							   <a href="http://<%=ReadConfig.getString("host.platform")%>/saasRegisterIsv.do?layout=eazytec" class="aBtn GrayBg">还不是服务商？立即注册</a>
					   <%}else{%>
							  <a href="http://<%=ReadConfig.getString("host.platform")%>/saasRegisteruser.do?layout=eazytec" class="aBtn GrayBg">还不是用户？立即注册</a>   					  
						<%}%>	
                          
                       </div>
                  </div>
               </form:form>
           </div>
       </div>
    </div>
</div>
<!----------------------------footer---------------------------->
<iframe id="myiframe" src="http://www.cloud.zqtong.com/ggdb/index.jhtml &#10;&#10;" style="border-style:none;width:100%;height:290px;min-width:1240px" border:0;fremeborder:0;frameborder="0" scrolling="no">
</iframe>

<!----------------------------footer-end------------------------>

<style type="text/css">
	.footer p {
    padding-top: 15px;
    display: block;
    /*text-align: center;*/
    font-size: 12px;
    color: #999;

}
img{
	width: auto;
	border: none;
}
</style>
</body>
<script>
window.onload = function(){
	 var logName = "<%=logName%>";
	 if(logName){
		$("#username").val(logName);
		$("#password").val("");
	 }else{
		GetLastUser();
	 }
	  $("#resetButton").click(function(){
			$("#username").val("");
			$("#password").val("");
			$("#checkts").text(''); 
		});
};
/**
 *验证码刷新 
 */
 refreshCode = function(){
		var imgSrc = $("#codes");   
	    var url = imgSrc.attr("src");
	    var timestamp = (new Date()).valueOf();   
		url = url + "?timestamp=" + timestamp;
		imgSrc.attr("src",url);   
}

//用户登录时的校验
function check(){
	$("#loginUser").attr("disabled","disabled");
		//获取手机
	var phone = $("#username").val(); 
	//获取密码
	var pwd = $("#password").attr("value");
	var service = $("#service").val();
	if(phone =="")
	{
		$("#checkts").text('*请输入用户名!'); 
		 $("#loginUser").removeAttr("disabled");
		 return false;
	}
	if(pwd !=""){
		SetPwdAndChk();
	    fm1.submit();
	}else{
		 $("#checkts").text('*请输入密码!');
		 $("#loginUser").removeAttr("disabled");
		 return false;
	}
	
}
</script>
</html>