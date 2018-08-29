<%@page import="com.cserver.sso.util.ReadConfig"%>
<%
String service = request.getParameter("service");

if(service==null) service = "";
service = java.net.URLDecoder.decode(service,"utf-8");
String layout = null;
if(request.getParameter("layout") != null){
	layout = request.getParameter("layout");
}else{
	layout = service.length() != 0 && service.indexOf("?layout=") != -1 ? service.substring(service.indexOf("?layout=")+8,(service.indexOf("&") != -1 ? service.indexOf("&") : service.length())) : null;
}
String forUrl = ReadConfig.getString("defaultUrl");
service = java.net.URLEncoder.encode(service);
boolean isMobile = false;
String[] mobileAgents = { "iphone", "android", "phone", "mobile", "wap", "netfront", "java", "opera mobi",
		"opera mini", "ucweb", "windows ce", "symbian", "series", "webos", "sony", "blackberry", "dopod",
		"nokia", "samsung", "palmsource", "xda", "pieplus", "meizu", "midp", "cldc", "motorola", "foma",
		"docomo", "up.browser", "up.link", "blazer", "helio", "hosin", "huawei", "novarra", "coolpad", "webos",
		"techfaith", "palmsource", "alcatel", "amoi", "ktouch", "nexian", "ericsson", "philips", "sagem",
		"wellcom", "bunjalloo", "maui", "smartphone", "iemobile", "spice", "bird", "zte-", "longcos",
		"pantech", "gionee", "portalmmm", "jig browser", "hiptop", "benq", "haier", "^lct", "320x320",
		"240x320", "176x220", "w3c ", "acs-", "alav", "alca", "amoi", "audi", "avan", "benq", "bird", "blac",
		"blaz", "brew", "cell", "cldc", "cmd-", "dang", "doco", "eric", "hipt", "inno", "ipaq", "java", "jigs",
		"kddi", "keji", "leno", "lg-c", "lg-d", "lg-g", "lge-", "maui", "maxo", "midp", "mits", "mmef", "mobi",
		"mot-", "moto", "mwbp", "nec-", "newt", "noki", "oper", "palm", "pana", "pant", "phil", "play", "port",
		"prox", "qwap", "sage", "sams", "sany", "sch-", "sec-", "send", "seri", "sgh-", "shar", "sie-", "siem",
		"smal", "smar", "sony", "sph-", "symb", "t-mo", "teli", "tim-", "tsm-", "upg1", "upsi", "vk-v",
		"voda", "wap-", "wapa", "wapi", "wapp", "wapr", "webc", "winw", "winw", "xda", "xda-",
		"Googlebot-Mobile" };
if (request.getHeader("User-Agent") != null) {
	for (String mobileAgent : mobileAgents) {
		if (request.getHeader("User-Agent").toLowerCase().indexOf(mobileAgent) >= 0) {
			isMobile = true;
			break;
		}
	}
}
if(isMobile){
	if(layout!=null)
	{
		if(!"".equals(ReadConfig.getString(layout+"Url")))
		{
			forUrl = ReadConfig.getString(layout+"MobileUrl");
		}
	}else{
		forUrl = ReadConfig.getString("defaultMobileUrl");
	}
	
}else{
	if(layout!=null)
	{
		if(!"".equals(ReadConfig.getString(layout+"Url")))
		{
			forUrl = ReadConfig.getString(layout+"Url");
		}
	}
}
request.getSession().setAttribute("firstLayout",layout);
request.getRequestDispatcher(forUrl).forward(request,response);
%>
