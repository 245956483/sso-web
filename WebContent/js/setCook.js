function onLoginLoaded() {
	/*if (isPostBack == "False") {
		GetLastUser();
	}*/
}
function GetLastUser() {
	var id = "49BAC005-7D5B-4231-8CEA-16939BEACD67";
	var usr = GetCookie(id);
	if (usr != null) {
		var arrays =usr.split(";");
		for(var i = 0 ; i <arrays.length; i++){
			var userNamestr = arrays[i].split("=");
			if(userNamestr[0] == "passwd"){
				if(userNamestr[1]){
					document.getElementById('username').value = userNamestr[1];
					$("#username").removeClass("phcolor");     
				}
				
			}
		}
	} else {
//		document.getElementById('username').value = "";
	}
	GetPwdAndChk();
}
//点击登录时触发客户端事件 
function SetPwdAndChk() {
	//取用户名 
	var usr = document.getElementById('username').value;
	//将最后一个用户信息写入到Cookie 
	SetLastUser(usr);
	//如果记住密码选项被选中 
	if (document.getElementById('rmbUser').checked == true) {
		//取密码值 
		var pwd = document.getElementById('password').value;
		var expdate = new Date();
		expdate.setTime(expdate.getTime() + 14 * (24 * 60 * 60 * 1000));
		//将用户名和密码写入到Cookie 
		SetCookie(usr, pwd, expdate,1);
	} else {
		//如果没有选中记住密码,则立即过期 
		ResetCookie();
	}
}
function SetLastUser(usr) {
	var id = "49BAC005-7D5B-4231-8CEA-16939BEACD67";
	var expdate = new Date();
	//当前时间加上两周的时间 
	expdate.setTime(expdate.getTime() + 14 * (24 * 60 * 60 * 1000));
	SetCookie(id, usr, expdate,1);
}
//用户名失去焦点时调用该方法 
function GetPwdAndChk() {
	var usr = document.getElementById('username').value;
	if(usr != ""){
		var returnvalue = GetCookie(usr);
		if(returnvalue != null){
			var strArr= returnvalue.split(";");
			 var cookistate = 1;
			 if(strArr&&strArr.length>0){
			     	var arrMap=strArr[0].split("=");
			     	if(arrMap && arrMap.length>1 && arrMap[1] != 'null')
			     		document.getElementById('password').value =arrMap[1];
			     }
			 if(strArr&&strArr.length>1){
			     	var arrMap=strArr[1].split("=");
			     	if(arrMap && arrMap.length>1)cookistate=arrMap[1];
			     }
			if (cookistate == 1) {
				document.getElementById('rmbUser').checked = true;
			} else {
				document.getElementById('rmbUser').checked = false;
			}
		}
	}
}
//取Cookie的值 
function GetCookie(name) {
	var arg = name + "=";
	var alen = arg.length;
	var clen = document.cookie.length;
	var i = 0;
	while (i < clen) {
		var j = i + alen;
		if (document.cookie.substring(i, j) == arg)
			return getCookieVal(j);
		i = document.cookie.indexOf(" ", i) + 1;
		if (i == 0)
			break;
	}
	return null;
}
var isPostBack = "<%= IsPostBack %>";
function getCookieVal(offset) {
	var endstr = document.cookie.indexOf(";", offset);
	if (endstr == -1)
		endstr = document.cookie.length;
	return unescape(document.cookie.substring(offset, endstr));
}
//写入到Cookie 
function SetCookie(name, value, expires,cookiestate) {
	var argv = SetCookie.arguments;
	var argc = SetCookie.arguments.length;
	var expires = (argc > 2) ? argv[2] : null;
	var cookiestate = (argc > 3) ? argv[3] : null;
	var path = (argc > 4) ? argv[4] : null;
	 document.cookie=name+"="+escape("passwd="+value+";cookiestate="+cookiestate)
			 	+ ((expires == null) ? "" : ("; expires=" + expires.toGMTString()))
				+ ((path == null) ? "" : ("; path=" + path));
}
function ResetCookie() {
	var usr = document.getElementById('username').value;
	var expdate = new Date();
	expdate.setTime(expdate.getTime() + 14 * (24 * 60 * 60 * 1000));
	SetCookie(usr, null, expdate,0);
}