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
<html>
<head>
<meta charset="utf-8">
<title>SaaS超市登录</title>
<link rel="stylesheet" href="res/saas/css/index.css">
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/tabswitch.js"></script>
<script type="text/javascript" src="js/setCook.js"></script>
<script type="text/javascript" src="js/common_rosters.js"></script>
<script type="text/javascript" src="js/placeholder.js"></script>
<style>
#cnzz_stat_icon_1261593060 img{
 width: 20px;
    height: 15px;
    float: right;
    padding-top: 5px;
    padding-left: 2px;

}
</style>
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
	
<div class="header">
  <div class="w1220  cl"> <img class="logo" src="res/saas/images/logo.png"/>
    <div class="l">
      <ul class="nav cl">
        <li><a href="http://www.csaas.com.cn" style="color:#fff;">应用商店</a></li>
        <li><a href="http://www.<%=ReadConfig.getString("host.web")%>/develop/index.jhtml" target="_blank">开发者中心</a></li>
        <li><a href="http://www.<%=ReadConfig.getString("host.web")%>/qyjj/index.jhtml" target="_blank">关于我们</a></li>
      </ul>
    </div>
    <div class="nav_r">
      <div class="search cl">
        <form class="l" action="/search.jspx" target="_blank" id="searchForm">
          <!--<input name="q" type="text" value="" placeholder="请输入您要搜索的服务"><!--请输入您要搜索的服务" onFocus="if(this.value=='请输入您要搜索的服务')this.value=''
          <span class="search_span"><img src="res/saas/images/sousuo.png"/></span>-->
        </form>
       <!-- <div class="button r"><span class="cl"><a href="http://<%=ReadConfig.getString("host.platform")%>/saasRegisteruser.do">注册</a><a href="http://<%=ReadConfig.getString("host.platform")%>/mysystem/saasMysystem.do?layout=saas">登录</a></span></div>-->
      </div>
    </div>
  </div>
</div>
<div class="w1220 cl" style="padding:80px 0px;">
  <div class="w840 l">
    <ul class="kuai">
      <li class="kuai_one cl"><a href="http://www.csaas.com.cn" target="_blank"><img src="res/saas/images/ico1.png"/><font>
        <h1>综合办公管理</h1>
        <span>了解更多</span></font></a></li>
      <li class="kuai_one tow cl"><a href="http://www.csaas.com.cn" target="_blank"><img src="res/saas/images/ico2.png"/><font>
        <h1>合同管理</h1>
        <span>了解更多</span></font></a></li>
      <li class="kuai_one three cl"><a href="http://www.csaas.com.cn" target="_blank"><img src="res/saas/images/ico5.png"/><font>
        <h1>HR高校</h1>
        <span>了解更多</span></font></a></li>
      <li class="kuai_one four cl"><a href="http://www.csaas.com.cn" target="_blank"><img src="res/saas/images/ico3.png"/><font>
        <h1>OA企业版</h1>
        <span>了解更多</span></font></a></li>
      <li class="kuai_one five cl"><a href="http://www.csaas.com.cn" target="_blank"><img src="res/saas/images/ico4.png"/><font>
        <h1>车辆管理</h1>
        <span>了解更多</span></font></a></li>
      <li class="kuai_one six cl"><a href="http://www.csaas.com.cn" target="_blank"><img src="res/saas/images/ico5.png"/><font>
        <h1>HR企业</h1>
        <span>了解更多</span></font></a></li>
      <li class="kuai_one eight" style="float:right;"><a href="http://www.csaas.com.cn" target="_blank"><font>
        <h2>协同办公OA系统</h2>
        <h3>中服CServer PaaS云计算平台</h3>
        <span style="height: 16px;">以知识管理为核心，协同运作为进化手段</span>
        <p>协同办公保障办公管理向规范化、信息化、和谐化发展</p>
        <p>融合协同作业、实时通信、业务流程、信息集成、成本管控于一体</p>
        <p>为所有员工提供良好的办公手段和沟通协作平台，节约企业成本</p>
        <p>提高客户服务质量，整体提高公司办公效率</p>
        </font></a></li>
      <li class="kuai_one nine cl"><a href="http://www.csaas.com.cn" target="_blank"><img src="res/saas/images/ico1.png"/><font>
        <h1>绩效考核管理</h1>
        <span>了解更多</span></font></a></li>
    </ul>
  </div>
<div class="w360 r">
 <form:form method="post" id="fm1" cssClass="fm-v clearfix" commandName="${commandName}" htmlEscape="true">
        <div class="login">
          <ul class="content-tab" >
            <li class="content-tab-li"></li>		
        	<li class="content-tab-li">	</li>
         </ul>
	   <div class="contents">
	   <!----------begin----------->
   <div class="login_main">
	 <ul class="logon_tab" >
		<li class="logon_tab_pc">
			<div class="login_title">
			    <% if(isv!=null){ %>
                  <a href="#" style="color:#3c3c3c;">服务商登录</a>
                  <%}else{%>
                   <a href="#" style="color:#3c3c3c;">用户登录</a>           
                 <%}%>	
             </div>
			<div class="poptip">
			<div class="poptip-arrow">
				<em></em>
				<span></span>
			</div>
			<div class="poptip-content">
					<img src="res/saas/images/safe.png"/>微信扫码登录移动端
				</div>
		    </div>
		  </li>		
	 </ul>
	<div class="login_b_bg cl" >
		 <div class="username cl">
			  <span><b>用户名:</b>
				<c:if test="${not empty sessionScope.openIdLocalId}">
				   <strong>${sessionScope.openIdLocalId}</strong>
				 <input type="hidden" id="username" name="username" value="${sessionScope.openIdLocalId}" />
			 </c:if>							
				<c:if test="${empty sessionScope.openIdLocalId}">
				  <spring:message code="screen.welcome.label.netid.accesskey" var="userNameAccessKey" />
				  <form:input placeholder="手机号/邮箱" cssClass="required Ipt inputcw" cssErrorClass="error" id="username" maxlength="50" tabindex="1" accesskey="${userNameAccessKey}" path="username" autocomplete="false" onblur="this.className='Ipt inputcw';GetPwdAndChk();" onfocus="this.className='Ipt IptOnF inputcw'" htmlEscape="true" />
				</c:if>                    
			 </span>
	 </div>
	 <div class="username cl pt20">
		   <span><b>密&nbsp;&nbsp;码:</b>
			<spring:message code="screen.welcome.label.password.accesskey" var="passwordAccessKey" />
				 <form:password cssClass="required Ipt inputcw" cssErrorClass="error text_kuang txtw1" maxlength="50" id="password" tabindex="2" path="password"  accesskey="${passwordAccessKey}" htmlEscape="true" autocomplete="off" />
		   </span>
	 </div>
	  <div class="username cl pt20">
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
	   </c:otherwise>
		</c:choose>
	  </div>
<div class="valign pt20"><input type="checkbox" class="Chk_RName" id="rmbUser" name="rmbUser"><b>记住密码</b>
<a href="http://<%=ReadConfig.getString("host.platform")%>/saasForgotPassword.do?layout=saas">忘记密码了吗？</a></div>
 <span style="color: #b10000; font-family:"宋体"; font-size: 9pt; font-weight: bold; line-height: 13pt;">${code}</span>
  	  <div class="login_bg cl">
     	  <input type="hidden" name="isNeedValid" value="${isNeedValid }" />
	      <input type="hidden" name="lt" value="${loginTicket}" />
		  <input type="hidden" name="execution" value="${flowExecutionKey}" />
		  <input type="hidden" name="_eventId" value="submit" />
		  <input class="login01" style="background: #f88a40; float:left;border: 1px solid #f88a40; width: 135px; height: 36px;line-height: 36px;color: #fff;display: block;font-size:16px;font-family: inherit;"  name="button1" accesskey="l"   tabindex="4" type="button" onclick="SetPwdAndChk();btnstop();" value="登录"/>
		  <a href="#" class="login02" id="resetButton">重置</a>
	  </div>

	  <div class="zhuce pt8">
	  <% if(isv!=null){ %>
		   <a href="http://<%=ReadConfig.getString("host.platform")%>/saasRegisterIsv.do?layout=saas">还不是服务商？立即注册</a>
	  <%}else{%>
		   <a href="http://<%=ReadConfig.getString("host.platform")%>/saasRegisteruser.do?layout=saas">还不是用户？立即注册</a>         
	   <%}%>
	  <span></span>
	  </div>
		 </div>
    </div>
			    <!----------over----------->
			     <!----------begin----------->
		<div class="login_main"  style="display:none;">
		  <ul class="logon_tab" >
		  <li class="logon_tab_pc">
			  <div class="login_title">微信扫码登录移动端</div>
			  <div class="poptip">
				<div class="poptip-arrow">
					<em></em>
					<span></span>
				</div>
				<div class="poptip-content">
					<img src="res/saas/images/safe.png"/>通过用户名密码登录
				</div>
			  </div>
		   </li>		
		  </ul>
		 <div class="login_b_bg cl" >
		   <img style="margin-left: 29px;margin-top: 30px;"src="res/saas/images/fwh.png"/>
		 </div>
	 	</div>
			
		</div>
	 </div>
	 </form:form>
  </div>
</div>
<div class="foot">
  <div class=" w1220  cl">
    <div  class="foot_left" > 
      <div class="foot_left_ul cl"><span href="#">友情链接：</span>
	             <a href="http://www.cserver.com.cn/" target="_blank">中服首页</a>
              <a href="http://www.cserver.com.cn:80/qyjj/index.jhtml">企业简介 </a>
	      <a href="http://www.cserver.com.cn:80/xwdt/index.jhtml">新闻动态 </a>
              <a href="http://www.cserver.com.cn:80/ppsl/index.jhtml">品牌实力 </a>
              <a href="http://www.cserver.com.cn:80/dlhz/index.jhtml">代理合作 </a>
	      <a href="http://www.cserver.com.cn:80/rczp/index.jhtml">人才招聘 </a>
              <a href="http://www.cserver.com.cn:80/lxwm/index.jhtml">联系我们 </a>
              <a href="http://www.cserver.com.cn:80/jyc/index.jhtml">聚英才 </a>
              
	      
	  </div>
      <div class="foot_address cl" > <img src="res/saas/images/foot_y.png"/>
        <p>Copyright©2008-2013 CServer Corporation, All Rights Reserved</br>
          地址：陕西省西安市高新区高新二路协同大厦三楼  &nbsp;电话：029-88386725&nbsp; 建议邮箱：support@server.cn &nbsp; ICP备11002812号-1  
		  <script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_1261593060'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s95.cnzz.com/stat.php%3Fid%3D1261593060%26show%3Dpic1' type='text/javascript'%3E%3C/script%3E"));</script>
		  
		  </p>
      </div>
    </div>
    <div class="foot_right"><font class="cl"><img src="res/saas/images/phone.png"/>
      <h1>服务热线</h1>
      </font> <span>400 - 880 - 6725</span> </div>
  </div>
</div>
<script language="JavaScript">
    function btnstop(){
	$(".login01").css({"background":"#bfbdbc","border-color":"#bfbdbc"});
	$(".login01").attr("disabled",true);
	$("#fm1").submit();
	}
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
</body>
</html>
