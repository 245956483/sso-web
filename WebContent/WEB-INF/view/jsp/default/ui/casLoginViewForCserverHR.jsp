<%@ page session="true" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="com.cserver.sso.util.ReadConfig" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>
<title>企业登录</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="res/cserverhr/css/cserverhr.css" />
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
%>
</head> 
<body id="cas" class="login_body">
	
<div class="wrap " style="padding-top:15px;">
	<div class="logo1">
		<div class="logo_l">
			<a href="http://www.cserverhr.com">
				<img border="0" src="res/cserverhr/images/logo.png">
			</a>
		</div>
		<div class="logo_r"  style="float:right;">
			<table width="100%" cellspacing="0" cellpadding="0" border="0">
				<tbody>
				<tr>
					<td height="5"></td>
				</tr>
				<tr height="20px">
					<td>服务热线：400-880-6725</td>
				</tr>
				<tr>
					<td>客服电话：029-88386725&nbsp;&nbsp;&nbsp;&nbsp;<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_1256362311'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s4.cnzz.com/stat.php%3Fid%3D1256362311%26show%3Dpic1' type='text/javascript'%3E%3C/script%3E"));</script></td>
				</tr>
				</tbody>
			</table>
		</div>
		<div style="float: right;padding: 5px 8px;color: #fff;width: 30px;line-height: 15px;background: #B1B1B1;text-align: center;margin-top: 8px;margin-right: 5px;"><a href="http://www.cserverhr.com" style="color:#fff;">返回首页</a></div>
	</div>
</div>
<HR style="border:1 dashed #987cb9" width="75%" color=#cdcdcd SIZE=3>
	
	<form:form method="post" id="fm1" cssClass="fm-v clearfix" commandName="${commandName}" htmlEscape="true">		
		<div class="w1002 mainhr cl">
    <div class="flash l">
 </div>
 <div class="w389 login_h r">
     <div class="login">
	     <div style=" background:url(res/cserverhr/images/w3_bj.png) 0 0 no-repeat; width:389px; height:3px; overflow:hidden;"></div>
	 
		<div class="p23" style="border:1px solid #e5e3e3;">
		 <div style="border-bottom:1px solid #cccccc;"><font style="font-size:20px; padding-left:90px; font-weight:bold; color:#1c3f5f;   height:40px; line-height:40px; ">企业登录工作台</font>&nbsp;&nbsp;<span id="register" style="display:none; height:18px; color: red;font-size: 14px;font-weight: bold;">注册成功</span><span id="createSys" style="display:none; height:18px; color: red;font-size: 14px;font-weight: bold;">开通成功</span></div>
		 <div class="cl" style="padding:16px 11px 0px 11px;">
		  <div class="username cl"><span><b>用户名:</b>
			 <c:if test="${not empty sessionScope.openIdLocalId}">
				<strong>${sessionScope.openIdLocalId}</strong>
				<input type="hidden" id="username" name="username" value="${sessionScope.openIdLocalId}" />
				</c:if>
				
				<c:if test="${empty sessionScope.openIdLocalId}">
				<spring:message code="screen.welcome.label.netid.accesskey" var="userNameAccessKey" />
				<form:input placeholder="手机号/邮箱" cssClass="required Ipt inputcw" cssErrorClass="error" id="username" maxlength="50" tabindex="1" accesskey="${userNameAccessKey}" path="username" autocomplete="false" onblur="this.className='Ipt inputcw';GetPwdAndChk();" onfocus="this.className='Ipt IptOnF inputcw'" htmlEscape="true" />
			</c:if>
		</span></div>
		  <div class="username cl pt10"><span><b>密&nbsp;&nbsp;码:</b>
				<spring:message code="screen.welcome.label.password.accesskey" var="passwordAccessKey" />
				<form:password cssClass="required Ipt inputcw" cssErrorClass="error text_kuang txtw1" maxlength="50" id="password" tabindex="2" path="password"  accesskey="${passwordAccessKey}" htmlEscape="true" autocomplete="off" />
			</span></div>
		  <div class="username cl pt10">
		  	<span class="l" style="width:174px;">
		  		<b>验证码:</b>
		  		<input id="j_captcha_response" class="inputcw" type="text" tabindex="3" style="width:103px;" name="authcode">
		  	</span>
		  	<span class="r" style=" width:100px;    border: 0px;">
				<img id="codes" onclick="this.src='captcha.jpg?'+Math.random()" src="captcha.jpg">
		  	</span>
		  </div>
		  <div class="valign pt10"><input type="checkbox"  class="Chk_RName"  id="rmbUser" name="rmbUser" /><b>记住密码</b><a href="http://<%=ReadConfig.getString("host.platform") %>/forgotPassword.do" class="reg">忘记密码了？</a></div>
		  <span style="color: #b10000; font-family:"宋体"; font-size: 9pt; font-weight: bold; line-height: 13pt;">${code}&nbsp;</span>
		  <div class="login_bg cl">
		  	<input type="hidden" name="lt" value="${loginTicket}" />
			<input type="hidden" name="execution" value="${flowExecutionKey}" />
			<input type="hidden" name="_eventId" value="submit" />
        	<input class="login01" style="border:none; border-radius: 3px; color: #fff;  display: block;  height: 30px;  line-height: 30px; text-align: center; width: 90px;" name="submit" accesskey="l"   tabindex="4" type="submit" onclick="SetPwdAndChk()" value="登录"/>
        	<input class="resetButtonBg login02" style="border:none; border-radius: 3px; color: #fff; display: block; height: 30px; line-height: 30px; text-align: center; width: 90px;" id="resetButton"  tabindex="5" type="button" value="重置"/>
		  </div>
		  <!-- <div class="zhuce pt8"><a title="" target="_blank" href="http://<%=ReadConfig.getString("host.platform") %>/registeruser.do?service=<%=service%>" class="reg">还不是会员？立即注册</a><span></span></div> -->
		  <div class="zhuce pt8"><a title="" target="_blank" href="http://<%=ReadConfig.getString("host.platform") %>/registeruser.do?layout=cserverhr&service=/addToTaskList.do?layout%3Dcserverhr%26type%3D0%26state%3D3%26systemTemplateId%3D2526fa34-5297-44d5-9743-9d5fc46d5d02" class="reg">还没有账号？立即注册</a><span></span></div>
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
	function addHome() {
		if (window.sidebar) {
			try {
				netscape.security.PrivilegeManager
						.enablePrivilege("UniversalXPConnect");
			} catch (e) {
				alert("此操作被浏览器拒绝！\n请在浏览器地址栏输入“about:config”并回车\n然后将[signed.applets.codebase_principal_support]设置为true");
			}

			var prefs = Components.classes["@mozilla.org/preferences-service;1"]
					.getService(Components.interfaces.nsIPrefBranch);
			prefs.setCharPref("browser.startup.homepage",'');
		} else if (document.all) {
			document.body.style.behavior = "url(#default#homepage)";
			document.body
					.setHomePage('http://www.cserverhr.com');
		} else {
			;
		}
	}
	
	function changeImg(){
	    var imgSrc = $("#imgObj");
	    var src = imgSrc.attr("src");
	    imgSrc.attr("src",chgUrl(src));   
	}

	function chgUrl(url){   
	    var timestamp = (new Date()).valueOf(); 
	    url = url + "?timestamp=" + timestamp;
	    return url;   
	} 
	/*refresh code*/
	refreshCode = function(){
		var imgSrc = $("#codes");   
	    var url = imgSrc.attr("src");
	    var timestamp = (new Date()).valueOf();   
		url = url + "?timestamp=" + timestamp;
		imgSrc.attr("src",url);   
	}
	/*detect CapsLock*/
	function detectCapsLock(event){
	    var e = event||window.event;
	    var o = e.target||e.srcElement;
	    var oTip = document.getElementById('capslockmsg');
	    var keyCode = e.keyCode||e.which; // 按键的keyCode 
	    var isShift = e.shiftKey ||(keyCode ==   16 ) || false ; // shift键是否按住
	     if (
	     ((keyCode >=   65   && keyCode <=   90 ) &&   !isShift) // Caps Lock 打开，且没有按住shift键 
	     || ((keyCode >=   97   && keyCode <=   122 ) && isShift)// Caps Lock 打开，且按住shift键
	     ){oTip.style.display = '';}
	     else{oTip.style.display = 'none';} 
	}
</script>
</html>