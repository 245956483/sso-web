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
<title>欢迎登录学术联合体--登录</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="res/association/css/association.css">
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/init.js"></script>
<script type="text/javascript" src="js/setCook.js"></script>
<script type="text/javascript" src="js/common_rosters.js"></script>

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
</head> 
	<body id="cas" class="login_body" style="background: url('');">
	<%String service = request.getParameter("service");
		if(service==null) service = "";
		service = java.net.URLEncoder.encode(service);
	%>
	<form:form method="post" id="fm1" cssClass="fm-v clearfix" commandName="${commandName}" htmlEscape="true">
	 <div class="w12 header">
	   <a class="db logo fl"><img style="padding-top: 10px; width:600px;" src="res/association/images/logo.jpg"   alt=""></a>
	   <div class="fr logofr">
	   <!-- <a href="#" class="blk">返回首页</a> |<a href="#" class="blk">客服中心</a><br> -->
		服务热线：<strong style="font-size:14px;">029-88857950</strong></div>
   </div>
   <div class="head_border"></div>		
<div class="box">
 
  <div class="main">
      <div class="left"><img src="res/association/images/left.jpg" /></div>
	  <div class="right">
	     <div class="r1">
		 <div class="r2">
		    <div class="r3">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td align="left" style="padding-bottom:12px;"><img src="res/association/images/dl.jpg" /></td>
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
    <td width="21%" class="zhuce"><a href="http://<%=ReadConfig.getString("host.platform") %>/forgotPassword.do?layout=association">忘记密码</a></td>
  </tr>
</table></td>
  </tr>
  <tr>
    <td class="pt"><table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="18%" class="name">验证码：</td>
    <td width="33%"><input type="text" id="j_captcha_response" name="authcode" class="srk1" tabindex="3"/></td>
    <td width="49%"><img id="codes" onclick="this.src='captcha.jpg?'+Math.random()" src="captcha.jpg">
	</td>
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
	<img src="res/association/images/denglu.jpg" width="102" height="35" onclick="SetPwdAndChk();fm1.submit();"/></td>
	<td width="62%" class="zhuce"><a href="http://<%=ReadConfig.getString("host.platform") %>/registerForAssociation.do?layout=association&service=/listsystemtemplatesother.do?">立即注册 </a></td>
     <!-- <td width="62%" class="zhuce"><a href="http://<%=ReadConfig.getString("host.platform") %>/registeruser.do?layout=xjiang&service=/listsystemtemplatesother.do?layout=xjiang&fromurl=register">立即注册 </a></td> -->
    <!-- <td width="62%" class="zhuce"><a href="<%=ReadConfig.getString("xjfw.zhuce") %>">立即注册 </a></td> -->
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
</html>