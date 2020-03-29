<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<title>章节训练</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/layui/css/layui.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/static/css/font.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/static/css/style.css">
<script type="text/javascript"
	src='${pageContext.request.contextPath }/js/jquery-3.3.1.js'></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/my.js"></script>
<script src="${pageContext.request.contextPath }/js/vue.js"
	type="text/javascript" charset="UTF-8"></script>
<script src="https://cdn.staticfile.org/vue/2.2.2/vue.min.js"></script>
<script src="https://cdn.staticfile.org/axios/0.18.0/axios.min.js"></script>
<script
	src="https://cdn.staticfile.org/vue-resource/1.5.1/vue-resource.min.js"></script>
<link rel="icon"
	href="${pageContext.request.contextPath}/images/logo.png"
	 type="image/x-icon" />
</head>

<body class="layui-layout-body">
	<div id="bigBody">
		<div class="layui-layout layui-layout-admin">
			<jsp:include page="tp_chapterPracticeLeftPart.jsp" flush="true" />
		</div>

		<div class="page-content">
			<jsp:include page="tp_chapterRightPart.jsp" flush="true" />
		</div>
	</div>

</body>

<script src="${pageContext.request.contextPath}/layui/layui.all.js "></script>
<script
	src="${pageContext.request.contextPath }/js/tp_chapterPractice.js"
	type="text/javascript" charset="UTF-8"></script>
</html>