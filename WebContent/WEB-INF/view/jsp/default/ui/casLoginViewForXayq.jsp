<%@ page session="true" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="com.cserver.sso.util.ReadConfig" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE   HTML   PUBLIC   "-//W3C//DTD   HTML   4.01   Transitional//EN " "http://www.w3.org/TR/html4/loose.dtd "> 
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>
<title>用户登录</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/init.js"></script>
<script type="text/javascript" src="js/setCook.js"></script>
<script type="text/javascript" src="js/common_rosters.js"></script>
<link rel="stylesheet" href="res/xayq/css/xayq.css">


<script type="text/javascript">
		 $(function(){
		    $(document).keypress(function(e){
			   if(e.which==13){
			   SetPwdAndChk();
			   $("#fm1").submit();
			   };
			});
		 });
</script>
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
	String member="";
	if(url.indexOf("member=")>-1){
		member = url.substring(url.indexOf("member=")+7);	
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
%>
</head> 
	<body id="cas" class="login_body" style="background: url('');">			
	<form:form method="post" id="fm1" cssClass="fm-v clearfix" commandName="${commandName}" htmlEscape="true">
	<!--<form:errors></form:errors>	-->	
		<div class="box">
  <div class="top">
     <div class="logo"><img src="res/xayq/images/logo.jpg" /></div>
	 <div class="email">客服电话：4006866833   邮箱：teckjt@sina.com</div>
  </div>
  <div class="main">
      <div class="left"><img src="res/xayq/images/left.jpg" /></div>
	  <div class="right">
  <div class="r1">
  <div class="r2">
  <div class="r3">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="left" style="padding-bottom:12px;"><img src="res/xayq/images/dl.jpg" /><span id="register" style="display:none; height:18px; color: red;font-size: 14px;font-weight: bold;">注册成功,请登录</span><span id="createSys" style="display:none; height:18px; color: red;font-size: 14px;font-weight: bold;">开通成功,请登录</span></td>
  </tr>
  <tr>
    <td class="pt"><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="18%" class="name">用户名：</td>
    <td width="82%">
	<c:if test="${not empty sessionScope.openIdLocalId}">
		<label>
		<strong>${sessionScope.openIdLocalId}</strong>
		<input type="hidden" id="username" name="username" value="${sessionScope.openIdLocalId}" />
		</label>
		</c:if>
		
		<c:if test="${empty sessionScope.openIdLocalId}">
		<label>
		<spring:message code="screen.welcome.label.netid.accesskey" var="userNameAccessKey" />
		<form:input cssClass="required Ipt inputcw srk" cssErrorClass="error" id="username" maxlength="50" tabindex="1" accesskey="${userNameAccessKey}" path="username" autocomplete="false" onblur="this.className='Ipt inputcw srk';GetPwdAndChk();" onfocus="this.className='Ipt IptOnF inputcw srk'" htmlEscape="true" class="srk"/>
		</label>
	</c:if>
</td>
  </tr>
</table>
</td>
  </tr>
  <tr>
    <td class="pt">
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="18%" class="name">密&nbsp;&nbsp;&nbsp;&nbsp;码：</td>
    <td width="61%">
	<spring:message code="screen.welcome.label.password.accesskey" var="passwordAccessKey" />
	<form:password cssClass="required Ipt inputcw srk" cssErrorClass="error text_kuang txtw1" maxlength="50" id="password" tabindex="2" path="password"  accesskey="${passwordAccessKey}" htmlEscape="true" autocomplete="off" class="srk"/>
</td>
    <td width="21%" class="zhuce"><a href="http://<%=ReadConfig.getString("host.platform") %>/forgotPassword.do?layout=xayq">忘记密码</a></td>
  </tr>
</table></td>
  </tr>
  <tr>
    <td class="pt"><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="18%" class="name">验证码：</td>
    <td width="33%"><input type="text" id="j_captcha_response" name="authcode" class="srk1" tabindex="3"/></td>
	<td width="49%"><img id="codes" onclick="this.src='captcha.jpg?'+Math.random()" src="captcha.jpg">
   </tr>
</table></td>
  </tr>
  <tr>
    <td class="pt1"><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="18%"></td>
    <td width="8%">
      <label>
      <input type="checkbox" class="Chk_RName" id="rmbUser" name="rmbUser" />
      </label>
    </td>
    <td valign="top">记住密码&nbsp;&nbsp;&nbsp;  
	<span style="color: #b10000; font-family:"宋体"; font-size: 9pt; font-weight: bold; line-height: 13pt;">${code}&nbsp;</span></td>
  </tr>
</table></td>
  </tr>
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="38%">
	<input type="hidden" name="lt" value="${loginTicket}" />
	<input type="hidden" name="execution" value="${flowExecutionKey}" />
	<input type="hidden" name="_eventId" value="submit" />
	<img src="res/xayq/images/denglu.jpg" width="102" height="35" onclick="SetPwdAndChk();fm1.submit();"/></td>
    <td width="62%" class="zhuce"><a href="http://<%=ReadConfig.getString("host.platform") %>/registeruser.do?layout=xayq&service=/listsystemtemplatesother.do?layout=xayq&fromurl=register">立即注册</a></td>
   
  </tr>
</table></td>
  </tr>
</table>

			</div>
		 </div>
		 </div>
	  </div>
  </div>

</div>
		</form:form>
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
		 var fromurl = "<%=fromurl%>";
	     if(fromurl&&fromurl=="register"){
			 $("#register").show();
		 }
	     if(fromurl&&fromurl=="create"){
			 $("#createSys").show();
		 }
		 $("#resetButton").click(function(){
			$("#username").val("");
			$("#password").val("");
		});
		document.getElementById('password').onkeypress = detectCapsLock;
		 
	 };
	 </script>
</html>