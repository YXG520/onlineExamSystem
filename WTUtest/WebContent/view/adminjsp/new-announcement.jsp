<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<title>千里IT后台管理系统-新增公告</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/layui/css/layui.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/static/css/font.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/static/css/style.css">
<script src="https://cdn.staticfile.org/vue/2.2.2/vue.min.js"></script>
<link rel="icon"
	href="${pageContext.request.contextPath}/images/logo.png"
	 type="image/x-icon" />
</head>

<body class="layui-layout-body">
	<div class="layui-layout layui-layout-admin">

		<jsp:include page="adminHeader.jsp" flush="true" />

		<div id="page-content" class="page-content">
			<form class="layui-form"
				action="${pageContext.request.contextPath }/broadcast/insBroadcast"
				method="post">
				<div class="layui-form-item">
					<label class="layui-form-label">公告标题</label>
					<div class="layui-input-block">
						<input type="text" name="theme" required lay-verify="required"
							placeholder="请输入标题" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-form-item layui-form-text">
					<label class="layui-form-label">公告内容</label>
					<div class="layui-input-block">
						<textarea name="content" placeholder="请输入内容"
							class="layui-textarea"></textarea>
						<span>更新事件：{{updateTime}}</span><input type="hidden"
							name="updateTime" :value="updateTime" />
					</div>
				</div>
				<div class="layui-form-item">
					<div class="layui-input-block">
						<button class="layui-btn">提交</button>
						<button type="reset" class="layui-btn layui-btn-primary">重置</button>
					</div>
				</div>
			</form>
		</div>
	</div>
	<script src="${pageContext.request.contextPath }/js/commonUtils.js "></script>
	<script src="${pageContext.request.contextPath }/layui/layui.all.js "></script>
</body>
<script type="text/javascript">

var vm=new Vue({
	el:"#page-content",
	data:{
		updateTime:curentTime()
	}
})
</script>
</html>