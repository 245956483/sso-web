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
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>2014西咸新区新丝路长安杯大学生微电影节</title>

<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/init.js"></script>
<script type="text/javascript" src="js/setCook.js"></script>
<script type="text/javascript" src="js/common_rosters.js"></script>
<link href="res/mini/css/mini.css" rel="stylesheet"/>
<%
String service = request.getParameter("service");
if(service==null) service = "";
service = java.net.URLEncoder.encode(service);
%>
</head>
<body id="cas">

<form:form method="post" id="fm1"  commandName="${commandName}"  cssClass="fm-v clearfix" htmlEscape="true">
<div class="denglu">
<div class="dl_logo">
   <div class="l_left"><img src="res/mini/images/dl_logo.png" /></div>
    <div class="l_right">咨询热线：029-33186290&nbsp;&nbsp;&nbsp;029-33186216&nbsp;&nbsp;&nbsp;029-33186390 &nbsp;&nbsp;
   <a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=1480474916&site=qq&menu=yes" >
   <img border="0" style="vertical-align:middle;height:22px;"
 src="http://wpa.qq.com/pa?p=2:1480474916:51" alt="点击这里给我发消息" title="点击这里给我发消息"/>
 </a>
   <a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=673985666&site=qq&menu=yes">
<img border="0" src="http://wpa.qq.com/pa?p=2:673985666:51" alt="点击这里给我发消息" title="点击这里给我发消息" style="vertical-align:middle;height:22px;"/>
</a>
 </div>
</div>

<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_1256362311'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s4.cnzz.com/stat.php%3Fid%3D1256362311%26show%3Dpic1' type='text/javascript'%3E%3C/script%3E"));</script>
  <div class="denglu_bg" style="background:url(res/mini/images/a_bg.png) no-repeat; width:100%; padding-top:63px; height:478px; padding-left:650px; float:left;">
  	
 <table width="294" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td><img src="res/mini/images/n_top.png"/></td>
  </tr>
  <tr>
    <td style="background:#f6fcff; padding-left:25px;">
    <table width="269" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td colspan="2" style="font-size:16px; line-height:2em; padding-bottom:20px;">邮箱账号登陆</td>
  </tr>
  <tr>
    <td colspan="2" class="yhm" style="padding-bottom:20px;">
	
	<c:if test="${not empty sessionScope.openIdLocalId}">
	<strong>${sessionScope.openIdLocalId}</strong>
	<input type="hidden" id="username" name="username" value="${sessionScope.openIdLocalId}" />
	</c:if>
	<c:if test="${empty sessionScope.openIdLocalId}"> 
	<spring:message code="screen.welcome.label.netid.accesskey" var="userNameAccessKey" />
	<form:input  cssErrorClass="error" valign="middle" id="username" maxlength="50" tabindex="1" accesskey="${userNameAccessKey}" path="username" autocomplete="false" onblur="this.className='Ipt inputcw';GetPwdAndChk();" style="border:1px solid #fff;width:180px;height:28px;" htmlEscape="true" onFocus="this.style='border:1px solid #B3B3B3;width:180px;height:28px;'" onBlur="this.style='border:1px solid #fff;width:180px;height:28px;'"/>
	</c:if>
	</td>
  </tr>
  <tr>
    <td colspan="2" class="mima">
	<spring:message code="screen.welcome.label.password.accesskey" var="passwordAccessKey" />
							<form:password  cssErrorClass="error text_kuang txtw1" maxlength="50" id="password" tabindex="2" path="password"  accesskey="${passwordAccessKey}" htmlEscape="true" autocomplete="off" valign="middle" style="border:1px solid #fff;width:180px;height:28px;" onFocus="this.style='border:1px solid #B3B3B3;width:180px;height:28px;'" onBlur="this.style='border:1px solid #fff;width:180px;height:28px;'"/>
	</td>
  </tr>
   <tr style="line-height:70px;">
    <td width="33%"><input type="text" id="j_captcha_response" name="authcode" class="srk1" tabindex="3" onKeyDown="yzm_Keydown(event)"/></td>
	<td width="49%"><img id="codes" onclick="this.src='captcha.jpg?'+Math.random()" src="captcha.jpg"/>
	</td>
  </tr>
  <tr>
  	<td colspan="2"></td>
  </tr>
  <tr style="height:60px">
    <td  style="line-height:2em; color:#666; "><input type="checkbox" id="rmbUser" name="rmbUser"/>
      记住密码</td>
    <td align="right" style="padding-right:25px; line-height:2em; color:#666;"><a target="_blank" href="http://<%=ReadConfig.getString("host.platform") %>/forgotPasswordmm.do">忘记密码？</a></td>
  </tr>
  <tr>
    <td  align="center"><input type="hidden" name="lt" value="${loginTicket}" />
	<input type="hidden" name="execution" value="${flowExecutionKey}" />
	<input type="hidden" name="_eventId" value="submit" />
	<img src="res/mini/images/dl.png" width="110" height="44" style="cursor:pointer" onclick="validateNull();"/></td>
    <td align="center"><img src="res/mini/images/zc.png" width="110" height="44" style="cursor:pointer" onclick="regeditUser();" /></td>
  </tr>
</table>
</td>
  </tr>
  <tr>
    <td><img src="res/mini/images/n_foot.png" /></td>
  </tr>
  <tr>
	<td id="errTD" width="45%" class="Text5" style="color:red">
		${code}
	</td>
  </tr>
</table>
  </div>
  <div class="dlfoot1">主办单位： 中共陕西省委宣传部  中共陕西省委高教工委  西咸新区管理委员会</div>
  <div class="dlfoot1">承办单位： 陕西西咸文化旅游产业集团有限公司  中国（陕西）高校传媒联盟</div>
  <div class="dlfoot1">执行单位： 陕西西咸广告传媒有限责任公司</div>
</div>
</form:form>
</body>
<script type="text/javascript" language="javascript">
	
	function validateNull(){
		var username = document.getElementById("username").value;
		username = username.replace(/[ ]/g,"");
		if(username.length==0){
			document.getElementById('errTD').innerHTML = '';
			document.getElementById('errTD').innerHTML = "用户名不能为空！";
			return false;
		}
		var pwd = document.getElementById("password").value;
		pwd = pwd.replace(/[ ]/g,"");
		if(pwd.length==0){
			document.getElementById('errTD').innerHTML = '';
			document.getElementById('errTD').innerHTML = "密码不能为空！";
			return false;
		}
		var yzm=document.getElementById("j_captcha_response").value;
			yzm=yzm.replace(/[ ]/g,"");
			if(yzm.length==0){
				document.getElementById('errTD').innerHTML = '';
				document.getElementById('errTD').innerHTML = "验证不能为空！";
				return false;
			}
		SetPwdAndChk();
	    fm1.submit();
	}
	
	function yzm_Keydown(event){
		if (event.keyCode == 13){
			validateNull();
		}else{
			
		}
	}


	function regeditUser(){
	var host = "<%=ReadConfig.getString("host.platform")%>";
	var url="http://"+host+"/registerForMiniMovie.jsp";
	window.location.href=url;
}
</script>
</html>
