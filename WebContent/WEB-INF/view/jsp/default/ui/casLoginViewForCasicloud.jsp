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
<html>
<head>
<meta charset="utf-8">
<title>航天云网登录</title>
<link rel="stylesheet" href="res/casicloud/css/index.css">
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/init.js"></script>
<script type="text/javascript" src="js/setCook.js"></script>
<script type="text/javascript" src="js/common_rosters.js"></script>
<%String service = request.getParameter("service");
		if(service==null) service = "";
		service = java.net.URLEncoder.encode(service);
%>
</head>
<body>
<div class="header">
  <div class="w1220"> <img class="logo" src="res/casicloud/images/logo.png"/> </div>
</div>
<div class="bg">
  <div class="circle bubble-1"> </div>
  <div class="circle bubble-2"> </div>
  <!-- <div class="circle bubble-3"> </div> -->
  <div class="circle bubble-4"> </div>
  <!-- <div class="circle bubble-5"> </div> -->
  <div class="w1220 cl">
    <div class="Computer w840 l">
	   <img src="res/casicloud/images/Computer.png"/>	 </div>
    <div class="w360 r">
      <div class="login">
        <div class="login_main">
          <div class="login_title">用户登录</div>
          <form:form method="post" id="fm1" cssClass="fm-v clearfix" onsubmit="return check()" commandName="${commandName}"  htmlEscape="true">
          <div class="login_b_bg cl" >
            <div class="username cl"><span><img src="res/casicloud/images/User.png"/>
              <input id="username" name="username">
              </span>
            </div>
            
            <div class="username cl pt20"><span><img src="res/casicloud/images/Password.png"/>
              <input id="password" name="password" type="password">
              </span>
            </div>
            
            <input type="hidden" name="lt" value="${loginTicket}" />
			<input type="hidden" name="execution" value="${flowExecutionKey}" />
			<input type="hidden" name="_eventId" value="submit" />
			<input type="hidden" name="isNeedValid" value="${isNeedValid }" />
			<c:choose>
			<c:when test="${isNeedValid eq 'true' }">
            	<div class="username cl pt20">
	            	<span class="l" style="width:174px;">
				  		<b>验证码:</b>
				  		<input id="j_captcha_response" class="inputcw" type="text" tabindex="3" style="width:103px;" name="authcode">
				  	</span>
				  	<span class="r" style=" width:105px;border: 0px solid #e8e8e8;">
							<img id="codes" onclick="this.src='captcha.jpg?'+Math.random()" src="captcha.jpg">
				  	</span>
				</div>
			</c:when>
			   <c:otherwise>
			   </c:otherwise>
			</c:choose>
			<span id="checkts" style="color: #b10000; font-family:"宋体"; font-size: 9pt; font-weight: bold; line-height: 13pt;">${code}</span>
            <div class="login_bg cl"><button  onclick="fm1.submit()" >登录</button></div>
            <div class="valign pt20">
              <input type="checkbox" class="Chk_RName" id="rmbUser" name="rmbUser">
              <b>记住密码</b><a href="http://<%=ReadConfig.getString("host.platform") %>/saasForgotPassword.do?layout=casicloud">找回密码</a></div>
          </div>
          </form:form>
        </div>
      </div>
    </div>
  </div>
</div>

<script>

//用户登录时的校验
function submitcheck(){
	$("#username").attr("disabled","disabled");
		//获取手机
	var username = $("#username").val(); 
	//获取密码
	var pwd = $("#password").attr("value");
	var service = $("#service").val();
	if(username =="")
	{
		$("#checkts").text('*请输入用户名!'); 
		 $("#username").removeAttr("disabled");
		 return false;
	}
	if(pwd !=""){
		SetPwdAndChk();
		return true;
	}else{
		 $("#checkts").text('*请输入密码!');
		 $("#username").removeAttr("disabled");
		 return false;
	}
	
}

</script>
<div class="foot">
  <div class=" w1220  cl">
    <div class="foot_left"><font class="cl"><img src="res/casicloud/images/CServer_logo.png"/>
      <h1>服务热线</h1>
      <span>400 - 880 - 6725</span> </font>
      
    </div>
    <div  class="foot_right" >
      <div class="cl" style="width:240px;"> <span><i class="Android"></i><b>关注航天云网</b></span><span> <i class="IOS"></i><b>微信移动端</b></span> </div>
    </div>
  </div>
</div>
</body>
</html>
