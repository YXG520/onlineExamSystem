<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/logo.ico"/>
<title>分类训练</title>
<style type="text/css">
* {
	margin: 0;
	padding: 0;
}

body {
	background: #152A2F;
}

#items {
	width: 720px;
	height: 240px;
	margin: 200px auto;
}

.queType {
	box-sizing: border-box;
	height: 200px;
	width: 200px;
	border: #4B81A3 1px solid;
	float: left;
	margin: 20px 20px;
	font-size: 26px;
	background-color: #DBE1E2;
}

.Iimg {
	width: 30px;
	height: 30px;
	margin: 0 0 12px 0;
	float: left;
	position: relative;
	top: 50px;
	left: 80px;
}

.queType>a {
	text-decoration: none;
	color: #4B81A3;
	float: left;
	position: relative;
	top: 100px;
	left: 30px;
}

.queType>a:hover {
	border-bottom: #4B81A3 2px solid;
}
</style>
</head>
<body>
	<div id="items">
		<div class="queType">
			<img src="${pageContext.request.contextPath }/images/right.png"
				class="Iimg"> <a
				href="${pageContext.request.contextPath }/view/qtjsp/tp_trainingPd.jsp" target="view_window">判断题</a>
		</div>
		<div class="queType">
			<img src="${pageContext.request.contextPath }/images/A.png"
				class="Iimg"> <a
				href="${pageContext.request.contextPath }/view/qtjsp/tp_trainingDx.jsp" target="view_window">选择题</a>
		</div>
		<div class="queType">
			<img src="${pageContext.request.contextPath }/images/write.png"
				class="Iimg"> <a
				href="${pageContext.request.contextPath }/view/qtjsp/tp_trainingDd.jsp" target="view_window">多选题</a>
		</div>
	</div>
</body>
</html>