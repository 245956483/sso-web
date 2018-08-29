window.onload = function(){
	//$("#main").height( document.documentElement.clientHeight - $("#header").height() - $("#footer").height());
	$("#resetButton").click(function(){
		$("#username").val("");
		$("#password").val("");
	});
	document.getElementById('password').onkeypress = detectCapsLock;
	GetLastUser();
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