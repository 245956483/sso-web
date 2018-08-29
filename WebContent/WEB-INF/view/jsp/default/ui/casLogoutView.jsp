<%@ page import="com.cserver.sso.util.ReadConfig,
java.util.LinkedHashMap,
com.cserver.sso.bean.UserInfo" %>
<%
	LinkedHashMap<String, UserInfo> map=(LinkedHashMap<String, UserInfo>)application.getAttribute("map");
	if(map!=null){
		map.remove(session.getId());
		application.setAttribute("map", map);
	}
	String layout = request.getParameter("layout");
	if(layout==null||"null".equals(layout)||"".equals(layout)) {
		response.sendRedirect("http://www.cserver.com.cn/");
	}else if(ReadConfig.getString("logout.layout.xixian").equals(layout)){
		response.sendRedirect("http://"+ReadConfig.getString("logout.xixian"));
	}else if("xizang".equals(layout)){
		response.sendRedirect("http://"+ReadConfig.getString("host.platform")+"/mysystem/mysystem.do?layout="+request.getParameter("layout"));
	}else if("saas".equals(layout)){
		response.setHeader("Refresh","0.1;url="+"http://www.csaas.com.cn");
	}else if("cserver".equals(layout)){
		response.sendRedirect("http://www.cserver.com.cn/");
	}else if("toplayer".equals(layout)){//泰普来科技SaaS超市
	    response.setHeader("Refresh","0.1;url="+"http://toplayer.csaas.com.cn");
	}else if("microbill".equals(layout)){//中服互联
	    response.setHeader("Refresh","0.1;url="+ReadConfig.getString("microbilldomain"));
	}else if("eazytec".equals(layout)){//中服互联
	    response.setHeader("Refresh","0.1;url="+ReadConfig.getString("eazytecdomain"));
	}else if("sxiip".equals(layout)){//互联
		    response.setHeader("Refresh","0.1;url="+ReadConfig.getString("sxiipdomain"));
	}else if("tyiip".equals(layout)){//互联
	    response.setHeader("Refresh","0.1;url="+ReadConfig.getString("tyiipdomain"));
	}else if("nxiip".equals(layout)){//互联
	    response.setHeader("Refresh","0.1;url="+ReadConfig.getString("nxiipdomain"));
	}else if("xmeniip".equals(layout)){//厦门
	    response.setHeader("Refresh","0.1;url="+ReadConfig.getString("xmeniipdomain"));
	}else if("lyaniip".equals(layout)){//龙岩
	    response.setHeader("Refresh","0.1;url="+ReadConfig.getString("lyaniipdomain"));
	}else if("pueriip".equals(layout)){//普洱
	    response.setHeader("Refresh","0.1;url="+ReadConfig.getString("pueriipdomain"));
	}else if("zzhouiip".equals(layout)){//普洱
	    response.setHeader("Refresh","0.1;url="+ReadConfig.getString("zzhouiipdomain"));
	}{
		response.setHeader("Refresh","1;url="+"http://"+ReadConfig.getString("host.platform")+"/mysystem/saasMysystem.do?layout="+request.getParameter("layout"));
		//response.sendRedirect("http://"+ReadConfig.getString("host.platform")+"/mysystem/mysystem.do?layout="+request.getParameter("layout"));
	}
%>
