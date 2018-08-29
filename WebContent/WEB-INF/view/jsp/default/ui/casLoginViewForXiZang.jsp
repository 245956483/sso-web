<%@ page session="true" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE   HTML   PUBLIC   "-//W3C//DTD   HTML   4.01   Transitional//EN " "http://www.w3.org/TR/html4/loose.dtd "> 

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">		
<title>西藏自治区发展和改革委员会业务办理情况登记系统</title>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/init.js"></script>
<script type="text/javascript" src="js/setCook.js"></script>
<script type="text/javascript" src="js/common_rosters.js"></script>
<script src="js/jQselect.js" type="text/javascript"></script>
<link href="res/xizang/css/style.css" rel="stylesheet" type="text/css">
<link href="res/xizang/css/style2.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="js/cookie.js"></script>
<script src="js/jquery_select.js" type="text/javascript"></script>
<%
String service = request.getParameter("service");
if(service==null) service = "";
service = java.net.URLEncoder.encode(service);
%>
</head>

<body id="cas" onunload="javascript:unLoad();" onload="javascript:load();">


		<div class="wrap" style="position: relative;">
			<div class="login_con" style="float:left;">
				<table border="0">

					<form:form method="post" id="fm1"  commandName="${commandName}" htmlEscape="true">		
					

						<input type="hidden" name="inputPwdErrorNum" value="0">
							<input type="hidden" name="maxErrorNum" value="6">
								<input type="hidden" name="getcodeflag" value="no">

									<tbody><tr class="login_tr" style="display: none">
										<td width="60">单位账号：
										</td>
										<td width="192" style="text-align: left;">
											<input class="login_input" type="text" name="domainAccount" value="whir">
										</td>
									</tr>
									<tr class="login_tr">
										<td width="60">账    号：
										</td>
										<td width="192" style="text-align: left;">
											<c:if test="${not empty sessionScope.openIdLocalId}">
												<strong>${sessionScope.openIdLocalId}</strong>
												<input type="hidden" id="username" name="username" value="${sessionScope.openIdLocalId}"  />
											</c:if>
											<c:if test="${empty sessionScope.openIdLocalId}">
												<spring:message code="screen.welcome.label.netid.accesskey" var="userNameAccessKey" />
												<form:input cssClass="login_input" cssErrorClass="login_input" id="username" maxlength="50" tabindex="1" accesskey="${userNameAccessKey}" path="username" autocomplete="false" onblur="GetPwdAndChk();"  htmlEscape="true" />
											</c:if>
										</td>
									</tr>
									<tr class="login_tr">
										<td width="60">密    码：
										</td>
										<td width="192" style="text-align: left;">
										    <spring:message code="screen.welcome.label.password.accesskey" var="passwordAccessKey" />
											<form:password cssClass="login_input"
											 cssErrorClass="login_input" maxlength="50" id="password" tabindex="2" path="password"  
											 accesskey="${passwordAccessKey}" htmlEscape="true" autocomplete="off"
											 />
										</td>
									</tr>
									<tr>
										<td></td>
										<td align="left">
												 	<input type="checkbox" class="Chk_RName" id="rmbUser" name="rmbUser"/>记住密码
												<br/>
												<span class="Text99">${code}</span>
												<span class="Text99" id="capslockmsg" style="display:none;">大写锁定键被按下，请注意大小写</span>
									  </td>
									  
									</tr>

									<!--获取验证码-start-->
									<tr class="login_tr" id="codetr" style="display:none">
										<td width="60" height="36" valign="middle">
											<span class="STYLE1"> <input type="button" value="获取验证码" style="cursor: hand; width: 68%;" onclick="getCode()" id="getcodebtn"> </span>
										</td>
										<td width="192" style="text-align: left;">
											<input type="text" name="usercode" value="">
										</td>
									</tr>

									<!--获取验证码-end-->
		

									<tr class="login_tr">
										<td colspan="2" style="text-align: center;">


											<input type="hidden" name="lt" value="${loginTicket}" />
											<input type="hidden" name="execution" value="${flowExecutionKey}" />
											<input type="hidden" name="_eventId" value="submit" />
											<div id="Layer5">
												 <input class="login_btn"  style="text-align:center;letter-spacing:2px;"  value="登录"  onmouseover="this.style.cursor=&#39;hand&#39;" name="submit" accesskey="l" value="" tabindex="4" type="submit" OnClick="SetPwdAndChk()"/>
											</div>
										</td>
									</tr>
									<input type="hidden" name="keyDigest" value="">
					
				</tbody></table>
			</div>
			<div  style="position:absolute;left:100%;top:68%;">
					<img src="res/xizang/images/fwh.jpg">
			</div>
		</div>

		<div class="login_foot">
			Copyright © 2017-2018 西藏自治区发展和改革委员会业务办理情况登记系统 All Rights Reserved 版权所有
			<br>
			建议使用1024*768以上的屏幕分辨率和6.0以上版本的IE来访问本站
		</div>
	


<script language="JavaScript">

</script>
</form:form>
</body></html>