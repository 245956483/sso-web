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
<title>欢迎登陆新疆建设兵团--登录</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/init.js"></script>
<script type="text/javascript" src="js/setCook.js"></script>
<script type="text/javascript" src="js/common_rosters.js"></script>
<link href="res/xjfw/css/xjfw.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
 $(function(){
    $(document).keypress(function(e){
	   if(e.which==13){
	   SetPwdAndChk();
	   $("#fm1").submit();
	   };
	});
 });
 function quickLogin(flag){
	 if(flag == 1){
		 $("#J_Quick2Static").css("display","none");
		 $("#usernameLogin").css("display","block");
	 }else{
		 $("#J_Quick2Static").css("display","block");
		 $("#usernameLogin").css("display","none");
	 }
 }
</script>
<script type="text/javascript">
	MX.on("qr.events",function(event){
	 console.log(event);
	}) 
	function resetQRLogin () {
	  qrLogin.showUnscannedView();
	}
	MXCommon.getCurrentUser(
			  function(result){
			   //这里可以处理获取到的当前用户数据
			   console.log(result);
			  }
			);  
</script>
<%
String service = request.getParameter("service");
if(service==null) service = "";
service = java.net.URLEncoder.encode(service);
%>
</head> 
<body id="cas" class="login_body" style="background: url('');">

	<form:form method="post" id="fm1" cssClass="fm-v clearfix" commandName="${commandName}" htmlEscape="true">		
		<div class="box">
  <div class="top">
     <div class="logo"><img src="res/xjfw/images/logofw.jpg" /></div>
	 <div class="email">客服电话：4006866833   邮箱：xinjiang@sina.com</div>
  </div>
  <div class="main">
      <div class="left"><img  style="width: 570px" src="res/xjfw/images/leftfw.jpg" />
      
      	
      </div>
	  <div class="right">
	     <div class="r1">
		 <div class="r2">
		    <div class="r3" id="usernameLogin" style="display:none;">
		    <div style="float:right;" onclick="quickLogin(0);"><img alt="二维码登录" style="width: 30px;height: 30px;cursor:pointer;" src="images/login_01.png" /></div>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
	  <tr>
	    <td align="left" style="padding-bottom:12px;"><img src="res/xjfw/images/dl.jpg" /></td>
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
	    <td width="21%" class="zhuce"><a href="http://<%=ReadConfig.getString("host.platform") %>/forgotPassword.do?layout=xjiang"><!--  忘记密码--></a></td>
	  </tr>
	</table></td>
	  </tr>
	  <tr>
	    <td class="pt"><table width="100%" border="0" cellspacing="0" cellpadding="0">
	
	</table>
	
	</td>
	
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
		<span style="color: #b10000; font-family:"宋体"; font-size: 9pt; font-weight: bold; line-height: 13pt;">${code}&nbsp;</span>
		
		
		</td>
		
	  </tr>
	</table></td>
	  </tr>
	  <tr>
	    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
	  <tr>
	    <td width="38%">
	    <input type="hidden" name="isNeedValid" id="isNeedValid" value="false" />
		<input type="hidden" name="lt" id="lt" value="${loginTicket}" />
		<input type="hidden" name="execution" id="execution" value="${flowExecutionKey}" />
		<input type="hidden" name="_eventId" id="_eventId" value="submit" />
		<img src="res/xjfw/images/denglu.jpg" width="102" height="35" onclick="SetPwdAndChk();fm1.submit();"/></td>
	    <td width="62%" class="zhuce"><a href="<%=ReadConfig.getString("xjfw.zhuce") %>">立即注册 </a></td>
	  </tr>
	</table></td>
	  </tr>
	</table>
	</div>
			
	<div class="r3"  id="J_Quick2Static" >
    <div style="float:right;"onclick="quickLogin(1);"><img alt="密码登录" style="width: 30px;height: 30px;cursor:pointer;" src="res/xjfw/images/login_02.png" /></div>
    <div style="height: 18px; line-height: 18px;font-size: 16px;color: #3c3c3c;margin-top: 9px;padding-bottom: 8px;font-weight: 700;">手机扫码，安全登录</div>
	<div class="mc-widget-qrlogin" id="mc-widget-qrlogin" style="position:initial;width: auto;">
      <div class="mc-content-unscanned " style="left: 100px;">
            <img style="width: 140px;height: 140px;"/>
            <div class="mc-msg" style="font-size: 12px;color: #9c9c9c;">扫一扫登录</div>
      </div>
      <div class="mc-content-scanned">
          <img  style="width: 120px;height: 120px;"/>
          <div class="mc-msg" style="font-size: 12px;">
             	请在手机点击确认以登录
           <div class="mc-reset"><a href="javascript:void(0);" onclick="resetQRLogin(); return false;" style="font-size: 12px;">返回扫二维码登录</a></div>
         </div>
        <div class="mc-msg loading">
          	正在登陆...
        </div>
      </div>
   
    </div>

	</div>
 </div>
 </div>
</div>
</div>

</div>
</form:form>
</body>
<script>
	var qrLogin = MX.initQRLogin({
		containerId : "mc-widget-qrlogin"
		,sso_url:"http://sso.cserver.com.cn/sso.web/minXingCallback.do" //扫描成功后，敏行会回调该地址，需要全路径，该地址是第三方系统的，用于sso
	});
</script>
</html>