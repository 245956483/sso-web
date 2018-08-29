<%@ page session="true"%>
<%@ page pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="com.cserver.sso.util.ReadConfig"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE   HTML   PUBLIC   "-//W3C//DTD   HTML   4.01   Transitional//EN " "http://www.w3.org/TR/html4/loose.dtd ">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>
<title>宝鸡公安现场督察公共云服务平台--登录</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="res/baojigongan/css/baojigongan.css">
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/init.js"></script>
<script type="text/javascript" src="js/setCook.js"></script>
<script type="text/javascript" src="js/common_rosters.js"></script>
<%
	String service = request.getParameter("service");
	if (service == null)
		service = "";
	service = java.net.URLEncoder.encode(service);
%>
</head>
<body id="cas" class="login_body" style="background: url('');">

<form:form method="post" id="fm1" cssClass="fm-v clearfix"
	commandName="${commandName}" htmlEscape="true">
	<div class="box cl">
	<div class="top cl">
	<div class="logo"><img src="res/baojigongan/images/logo.png"
		width="589" height="44" /></div>
	<div class="email">客服电话：4006866833 邮箱：support@szelink.com</div>
	</div>
	<div class="main cl">
	<div class="left"><img src="res/baojigongan/images/01.png"
		width="310" height="95" /></div>
	<div class="conter">
	<div class="r3">
	<table border="0" cellspacing="0" cellpadding="0">
		<tbody>
			<tr>
				<td class="pt">
				<table border="0" cellspacing="0" cellpadding="0">
					<tbody>
						<tr>
							<td class="name">用户名：</td>
							<td><label> <form:input
								class="required Ipt inputcw srk" tabindex="1"
								onFocus="this.className='Ipt IptOnF inputcw srk'"
								onBlur="this.className='Ipt inputcw srk';GetPwdAndChk();"
								maxlength="50" accesskey="${userNameAccessKey}" path="username"
								autocomplete="false" onblur="GetPwdAndChk();" htmlEscape="true" /></label></td>
						</tr>
					</tbody>
				</table>
				</td>
			</tr>
			<tr>
				<td class="pt">
				<table border="0" cellspacing="0" cellpadding="0">
					<tbody>
						<tr>
							<td class="name">密&nbsp;&nbsp;&nbsp;&nbsp;码：</td>
							<td><form:password class="required Ipt inputcw srk"
								tabindex="2" maxlength="50" path="password"
								accesskey="${passwordAccessKey}" htmlEscape="true"
								autocomplete="off" /></td>
						</tr>
					</tbody>
				</table>
				</td>
			</tr>
			<tr>
				<td class="pt pt2">
				<table border="0" cellspacing="0" cellpadding="0">
					<tbody>
						<tr>
							<td class="name">验证码：</td>
							<td><input type="text" id="j_captcha_response"
								name="authcode" class="srk1" tabindex="3"></td>
							<td>&nbsp;&nbsp;&nbsp;
							<img id="codes" onclick="this.src='captcha.jpg?'+Math.random()" src="captcha.jpg">
							</td>
						</tr>
					</tbody>
				</table>
				</td>
			</tr>
			<tr>
				<td class="pt1">
				<table border="0" cellspacing="0" cellpadding="0">
					<tbody>
						<tr>
							<td></td>
							<td><label> <input type="checkbox" class="Chk_RName"
								id="rmbUser" name="rmbUser" /></label></td>
							<td valign="top">记住密码&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
							<td align="center">
							<span class="Text99">${code}</span> <span class="Text99"
								id="capslockmsg" style="display: none;">大写锁定键被按下，请注意大小写</span></td>

						</tr>
					</tbody>
				</table>
				</td>
			</tr>
			<tr>
				<td align="center">
				<table border="0" cellspacing="0" cellpadding="0">
					<tbody>
						<tr>
							<td width="100%" align="center"><input type="hidden" name="lt" value="${loginTicket}" />
							<input type="hidden" name="execution" value="${flowExecutionKey}" />
							<input type="hidden" name="_eventId" value="submit" /> <a
								class="dv01" onClick="SetPwdAndChk();fm1.submit();"></a></td>
							<td style="display: none" class="zhuce"><a class="zc01"
								href="http://my.cserver.com.cn/registeruser.do?layout=yunfu&service="></a></td>
						</tr>
					</tbody>
				</table>
				</td>
			</tr>
		</tbody>
	</table>

	</div>

	</div>


	<div class="right"><img src="res/baojigongan/images/02.png" />
	</div>
	</div>
	</div>
</form:form>
<div class="foot"><img src="res/baojigongan/images/foot.png" /></div>

</body>
</html>