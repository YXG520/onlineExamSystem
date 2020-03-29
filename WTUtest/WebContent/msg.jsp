<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/logo.ico"/>
<title>操作成功</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

</head>

<body>
	<h1 style="color: red;" align="center">${success}</h1>
	<h2 style="color: green;" align="center">
		<span id="time">4</span>秒后返回${log}界面，如未返回，请点击右方链接<a
			href="${pageContext.request.contextPath }/index.jsp">${log}界面</a>
	</h2>
</body>
<script language="JavaScript" type="text/javascript">
   
	function delayURL(url) {
		var delay = document.getElementById("time").innerHTML;
		if (delay > 0) {
			delay--;
			document.getElementById("time").innerHTML = delay;
		} else {
			window.top.location.href = url;
		}
		setTimeout("delayURL('" + url + "')", 1000);
	}	
	
	<%String targetPage= (String) request.getAttribute("targetPage");
	out.print("delayURL('" + request.getContextPath()+"/"+targetPage+ "');");
	%>
</script>

</html>
