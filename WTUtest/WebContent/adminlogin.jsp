<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="en">

<head>
<meta charset="UTF-8">
<title>WTU刷题后台管理系统-登录</title>
<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/logo.ico"/>
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
<meta http-equiv="Cache-Control" content="no-siteapp" />
<!-- <link rel="shortcut icon" -->
<%-- 	href="${pageContext.request.contextPath }/favicon.ico" --%>
<!-- 	type="image/x-icon" /> -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/static/css/font.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/static/css/style.css">
<script src="${pageContext.request.contextPath }/layui/layui.js"
	charset="utf-8"></script>
<link rel="icon"
	href="${pageContext.request.contextPath}/images/logo.png"
	style="background:red;" type="image/x-icon" />
</head>

<body class="login-bg">

	<div class="login">
		<div class="message">WTU刷题后台管理系统</div>
		<div id="darkbannerwrap"></div>
		<h2 align="center" style="color: red">${htError}</h2>
		<form class="layui-form"
			action="${pageContext.request.contextPath }/admin_user/adminLogin"
			method="post">
			<input name="username" placeholder="用户名/邮箱" type="text"
				class="layui-input">
			<hr class="hr15">
			<input name="password" placeholder="密码" type="password"
				class="layui-input">
			<hr class="hr15">
			<input type="submit" class="login-btn" style="width: 100%;"
				value="登录">
			<hr class="hr20">
		</form>
	</div>

</body>

</html>