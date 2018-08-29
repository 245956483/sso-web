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
<title>登录</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/setCook.js"></script>
<script type="text/javascript" src="js/common_rosters.js"></script>
<script type="text/javascript" src="js/placeholder.js"></script>
<script type="text/javascript" src="js/swfobject.js"></script>
<link rel="stylesheet" type="text/css" href="res/default/css/default.css" />
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
<div class="wrap " style="padding-top:30px;">
	<div class="w1002 logo cl">
		<div class="logo_l">
			<a href="http://cserver.com.cn">
				<img  src="res/default/images/logo.png">
			</a>
		</div>
		<div class="logo_r" style="position:relative; float:right; padding-top: 30px; width: 400px;">
			<div style="position: absolute; top: 0px; left: 0px; ">
				
				<span style="float: left; padding: 2px; margin-left: 0px;"> 分享到:</span>
		   		<a title="分享到微信" onclick="javascript:bShare.share(event,'weixin',0);return false;"  style="cursor:pointer;color:#2e3192; display: block;width: 20px;height: 20px;float: left;padding: 3px;">
				<img src="http://static.bshare.cn/frame/images/logos/s4/weixin.gif" style="height:20px; width:20px;"/>
				<span style="padding-left: 3px; vertical-align:middle;"></span>
				</a>

				<a title="分享到新浪微博" onclick="javascript:bShare.share(event,'sinaminiblog',0);return false;" style="cursor:pointer;color:#2e3192; display: block;width: 20px;height: 20px;float: left;padding: 2px;">
				   <img src="http://static.bshare.cn/frame/images/logos/s4/sinaminiblog.gif" style="height:20px; width:20px; vertical-align:middle;"/>
				   <span style="padding-left:2px; vertical-align:middle;"></span>
				</a>

				<a title="分享到QQ好友" onclick="javascript:bShare.share(event,'qqim',0);return false;" style="cursor:pointer;color:#2e3192; display: block;width: 20px;height: 20px;float: left;padding: 2px;">
				   <img src="http://static.bshare.cn/frame/images/logos/s4/qqim.gif" style="height:20px; width:20px; vertical-align:middle;"/>
				   <span style="padding-left:2px; vertical-align:middle;"></span>
				</a>

				<a title="分享到QQ空间" onclick="javascript:bShare.share(event,'qzone',0);return false;" style="cursor:pointer;color:#2e3192; display: block;width: 20px;height: 20px;float: left;padding: 2px;">
				   <img src="http://static.bshare.cn/frame/images/logos/s4/qzone.gif" style="height:20px; width:20px; vertical-align:middle;"/>
				   <span style="padding-left:2px; vertical-align:middle;"></span>
				</a>	
				<script type="text/javascript" charset="utf-8" src="http://static.bshare.cn/b/buttonLite.js#uuid=<你的UUID>&style=-1&ssc=true"></script>

				<script type="text/javascript" charset="utf-8">
				bShare.addEntry({
				    title: "西安中服软件",
				    url: "http://www.cserver.com.cn/zfff/index.htm",
				    summary: "亲爱的用户，感谢您一直以来对中服软件的支持。",
				    pic: "http://www.cserver.com.cn/u/cms/www/201407/04140659vxj7.jpg"
				});
				</script>
			</div>
			<span style="padding-right: 10px; margin-left: 0px;">服务热线：400-880-6725</span><span style="margin-left: 0px;">客服电话：029-88386725&nbsp;<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_1256362311'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s4.cnzz.com/stat.php%3Fid%3D1256362311%26show%3Dpic1' type='text/javascript'%3E%3C/script%3E"));</script></span>	
		</div>
	</div>
</div>
	<!--<div class="logo w1002" style="padding-top:30px;"><a href="/"><img src="http://www.cserver.com.cn/r/cms/www/cserver/img/new_img/logo.png"></a>
   		<span><img style="opacity: 1;" src="http://www.cserver.com.cn/r/cms/www/cserver/images/2wm_01.png"><img style="opacity: 1;" src="http://www.cserver.com.cn/r/cms/www/cserver/images/2wm_02.png"><img style="opacity: 1;" src="http://www.cserver.com.cn/r/cms/www/cserver/images/2wm_03.png"></span>
   	</div>-->
	<form:form method="post" id="fm1" cssClass="fm-v clearfix" commandName="${commandName}" htmlEscape="true">		
		<div class="w1002 main cl">
    <div class="flash l">
   
  <embed src="flash/tagcloud.swf" width="250" height="250" tplayername="SWF" splayername="SWF" type="application/x-shockwave-flash" mediawrapchecked="true" pluginspage="http://www.macromedia.com/go/getflashplayer" id="tagcloudflash" name="tagcloudflash"  quality="high" wmode="transparent" allowscriptaccess="always" flashvars="tcolor=0x333333&amp;tcolor2=0x666666&amp;hicolor=0xf5f5f5&amp;tspeed=100&amp;distr=true"></embed>
 </div>
 <div class="w389 login_h r">
     <div class="login">
	     <div style=" background:url(res/default/images/w3_bj.png) 0 0 no-repeat; width:389px; height:3px; overflow:hidden;"></div>
	 
		<div class="p23" style="border:1px solid #e5e3e3;">
		 <div style="border-bottom:1px solid #cccccc;"><font style="font-size:20px; padding-left:90px; font-weight:bold; color:#1c3f5f;   height:40px; line-height:40px; ">登录工作台</font>&nbsp;&nbsp;<span id="register" style="display:none; height:18px; color: red;font-size: 14px;font-weight: bold;">注册成功,请登录</span><span id="createSys" style="display:none; height:18px; color: red;font-size: 14px;font-weight: bold;">开通成功,请登录</span></div>
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
		    <c:choose>
		    	<c:when test="${isNeedValid eq 'true' }">
		    		<span class="l" style="width:174px;">
				  		<b>验证码:</b>
				  		<input id="j_captcha_response" class="inputcw" type="text" tabindex="3" style="width:103px;" name="authcode">
				  	</span>
				  	<span class="r" style=" width:105px;border: 0px solid #e8e8e8;">
							<img id="codes" onclick="this.src='captcha.jpg?'+Math.random()" src="captcha.jpg">
				  	</span>
		    	</c:when>
		    	<c:otherwise>
		    		<!-- <div style="height:30px;"></div> -->
		    	</c:otherwise>
		    </c:choose>			
		  </div>
		  <div class="valign pt10"><input type="checkbox"  class="Chk_RName"  id="rmbUser" name="rmbUser" /><b>记住密码</b><a href="http://<%=ReadConfig.getString("host.platform") %>/forgotPassword.do" class="reg">忘记密码了？</a></div>
		  <span style="color: #b10000; font-family:"宋体"; font-size: 9pt; font-weight: bold; line-height: 13pt;">${code}&nbsp;</span>
		  <div class="login_bg cl">
		  	<input type="hidden" name="isNeedValid" value="${isNeedValid }" />
		  	<input type="hidden" name="lt" value="${loginTicket}" />
			<input type="hidden" name="execution" value="${flowExecutionKey}" />
			<input type="hidden" name="_eventId" value="submit" />
        	<input class="login01" style="border:none; border-radius: 3px; color: #fff;  display: block;  height: 30px;  line-height: 30px; text-align: center; width: 90px;" name="submit" accesskey="l"   tabindex="4" type="submit" onclick="SetPwdAndChk()" value="登录"/>
        	<input class="resetButtonBg login02" style="border:none; border-radius: 3px; color: #fff; display: block; height: 30px; line-height: 30px; text-align: center; width: 90px;" id="resetButton"  tabindex="5" type="button" value="重置"/>
		  </div>
		  <div class="zhuce pt8"><a title="" target="_blank" href="http://<%=ReadConfig.getString("host.platform") %>/registeruser.do?service=/mysystem/listsystemtemplates.do?fromurl=register" class="reg">还不是会员？立即注册</a><span></span></div>
		 </div>
		</div>
	 </div>
  </div>
</div>
<div class="foot">
    <div class="w1002">
	   <ul class="foot_list cl">
	      <li class="pr22"><span><img src="res/default/images/fwh.png" style="width:60px; height:60px; padding-top:5px;" /></span><a href="javascript:void(0)">关注微信服务号</a></li>
		  <li class="pr22"><span><img src="res/default/images/shouji.png" style="width:60px; height:60px; padding-top:5px;" /></span><a href="http://www.cserver.com.cn/r/cms/www/cserver/download/CServerOA.apk">手机客户端下载</a></li>
		  <li class="pr22"><span><img src="res/default/images/weixin.png" style="width:60px; height:60px;padding-top:5px;" /></span><a href="#">关注微信公众号</a></li>
	   </ul>
	  
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
			prefs.setCharPref("browser.startup.homepage",'http://<%=ReadConfig.getString("host.web") %>');
		} else if (document.all) {
			document.body.style.behavior = "url(#default#homepage)";
			document.body
					.setHomePage('http://my.cserver.com.cn');
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