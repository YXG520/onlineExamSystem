
function getRootUrl(){
//获取当前网址，如： http://localhost:8083/uimcardprj/share/meun.jsp
var curWwwPath=window.document.location.href;
//获取主机地址之后的目录，如： uimcardprj/share/meun.jsp
var pathName=window.document.location.pathname;
var pos=curWwwPath.indexOf(pathName);
//获取主机地址，如： http://localhost:8083
var localhostPaht=curWwwPath.substring(0,pos);
//获取带"/"的项目名，如：/uimcardprj
var projectName=pathName.substring(0,pathName.substr(1).indexOf('/')+1);
return projectName
}
//获取日期
//获取当前日期时间
function curentTime()
{
    var now = new Date();
    
    var year = now.getFullYear();       //年
    var month = now.getMonth() + 1;     //月
    var day = now.getDate();            //日

    var hh = now.getHours();            //时
    var mm = now.getMinutes();          //分
    var ss = now.getSeconds();          //分

    var clock = year + "-";

    if(month < 10)
        clock += "0";

    clock += month + "-";

    if(day < 10)
        clock += "0";

    clock += day + " ";

    if(hh < 10)
        clock += "0";

    clock += hh + ":";
    if (mm < 10)
        clock += '0';
    clock += mm + ":";

    if (ss < 10)
        clock += '0';
    clock += ss;
    return clock;
}

//获取多项选择radio中被选中的项以及值
function checkedRadio(radioClassName){
	var  obj = document.getElementsByClassName(radioClassName);
	var  str = "";				
	  for(var i = 0; i < obj.length; i++) { 
		  if(obj[i].checked){ 
			  str +=obj[i].value; 
	 } 
}
}	
//锁定input的值的状态
function changeChecked(targetValue,obj){
	for (var i=0;i<obj.length;i++){
		if(obj[i].value==targetValue)
		{
			obj[i].checked=true;
			break;
		}
	}
}
//将json类型的数据某一组相同key值放到数组里  
function getSomethings (data, field){
		var output = [];
		for(var i= 0; i <data.length; i++) {	
			output.push(data[i][field]);//不能用output.push(data[i].field);形式，会无效			
		}
		return output; 
		}
//加长版，增加对数组字符串的转化
 function getSthArray (data, field,type){
		var output = [];
		if(type=="arr"){
			for(var i= 0; i <data.length; i++) {	
				output.push(JSON.parse(data[i][optionList]));
			}
		}else if(type=="str"){
			for(var i= 0; i <data.length; i++) {	
				output.push(data[i][field]);
			}
		}
		
		return output; 
		}
 
//提交前判断相关的标签非空
function notNullStr(forName) {
	            var flag=null;
	 			for(var i=0;i<forName.length;i++){
	 				if(forName[i].value==""||forName[i].value==null){
	 					flag=false;
		 				break;	
		 			}
	 			}
	 			return flag;	
	 		 }
//再次确认新设置的密码
function matchStr(newName,confirmName) {
	var flag=true;
   if(document.getElementById(newName).value!=document.getElementById(confirmName).value){
	   flag=false;
   }
   return flag;
	 }
//判断字符串长度
function judgeLength(elementById){
	let str= document.getElementById(elementById).value;
	let len = 0;
	    for (var i=0; i<str.length; i++) { 
	     var c = str.charCodeAt(i); 
	    //单字节加1 
	     if ((c >= 0x0001 && c <= 0x007e) || (0xff60<=c && c<=0xff9f)) { 
	       len++; 
	     } 
	     else { 
	    //每一个汉字加2
	      len+=2; 
	     } 
	    } 
	    return len;
}
//验证邮箱格式
function checkemail(elementById){
	let btest=true;
			var regmail= document.getElementById(elementById).value;
			if(regmail!=""){
				var regex=/^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$/;
				btest=regex.test(regmail);
			}else{
				btest=false;
			}
			return btest;
		}
//获取验证码
function doCodes(nameStr,codeStr,seconds){	
	var username=document.getElementById(nameStr);
	var getCode=document.getElementById(codeStr);
	let flag=true;
	if(username.value!=""&&checkemail(nameStr)==true){
		getCode.disabled="true";
		seconds--;
		getCode.value=seconds+"S";	
		if(seconds==0){
			clearTimeout(timer);
			getCode.value="获取验证码"
			getCode.disabled="";
		}else{
			var	timer=setTimeout(function(){doCodes(nameStr,codeStr,seconds);}, 1000);
		}	
	}else{
		flag=false;	
	}	
	return flag;
  	}
