<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<title>千里IT后台管理系统-用户列表</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/layui/css/layui.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/static/css/font.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/static/css/style.css">
<script type="text/javascript"
	src='${pageContext.request.contextPath }/js/jquery-3.3.1.js'></script>
<link rel="icon"
	href="${pageContext.request.contextPath}/images/logo.png"
	 type="image/x-icon" />
	<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/vue.js"></script>
<script src="https://cdn.staticfile.org/vue/2.2.2/vue.min.js"></script>
<script src="https://cdn.staticfile.org/axios/0.18.0/axios.min.js"></script>
<script
	src="https://cdn.staticfile.org/vue-resource/1.5.1/vue-resource.min.js"></script>
	
</head>

<body class="layui-layout-body">
	<div class="layui-layout layui-layout-admin">

		<jsp:include page="adminHeader.jsp" flush="true" />
		<div class="page-content">
			<div class="layui-row">
				<form class="layui-form  we-search"   id="pageForm"
					action="${pageContext.request.contextPath }/admin_user/findByRootUser"
					method="post">
					<!-- 隐藏域.当前页码 -->
					<%-- 					<input type="hidden" name="pn" id="currentPageInput" value="${page.pageNum }" /> --%>
					<input type="hidden" name="distinguish" id="currentPageInput"
						value="vague" /> 搜索：
					<div class="layui-inline">
						<select name="root" class="layui-input">
							<option value="">请选择用户身份</option>
							<option value="1" selected>普通用户</option>
							<option value="2">vip用户</option>
							<option value="3">管理员</option>
							<option value="4">超级管理员</option>
						</select>
					</div>
					<div class="layui-inline">
						<input type="text" value="" name="username"
							placeholder="请输入用户名/邮箱" autocomplete="off" class="layui-input">
					</div>
					<button class="layui-btn">
						<i class="layui-icon">&#xe615;</i>
					</button>
					
				</form>
<form class="layui-form  we-search" enctype="multipart/form-data" id="pageForm"
					action="${pageContext.request.contextPath }/admin_user/importUsersExcel"
					method="post">
					 用户导入：
					<div class="layui-inline">
					<input type="file" value="" name="file"
					 accept=".csv, application/vnd.ms-excel, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"  class="layui-input">
					</div>
					<button class="layui-btn">
						<i class="layui-icon">&#xe615;</i>
					</button>
                  
				</form>
		

				<span class="fr" style="line-height: 40px">共有数据：${pageInfo.total}
						条</span>
			</div>

			<table class="layui-table">
				<thead>
					<tr>
						<th>ID</th>
						<th>学号</th>
						<th>密码</th>
						<th>学院</th>
						<th>班级</th>
						<th>年级</th>
						<th>账号级别</th>
						<th>设置权限</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${pageInfo.list }" var="u">
						<tr>
							<td>${u.id }</td>
							<td>${u.username }</td>
							<td>${u.password }</td>
							<td>${u.school }</td>
							<td>${u.major}</td>
							<td>${u.grade}</td>
							<td><c:choose>
									<c:when test="${u.root eq 1 }">普通用户</c:when>
									<c:when test="${u.root eq 2 }">vip会员</c:when>
									<c:when test="${u.root eq 3 }">系统管理员</c:when>
									<c:when test="${u.root eq 4 }">超级管理员</c:when>
									<c:otherwise>状态未知</c:otherwise>
								</c:choose></td>
							<td><a class="layui-btn layui-btn-xs"
								href="${pageContext.request.contextPath }/admin_user/modifyRoot?id=${u.id}&root=1">普通用户</a>
								<a class="layui-btn layui-btn-xs"
								href="${pageContext.request.contextPath }/admin_user/modifyRoot?id=${u.id}&root=2">vip用户</a>
								<a class="layui-btn layui-btn-xs"
								href="${pageContext.request.contextPath }/admin_user/modifyRoot?id=${u.id}&root=3">管理员</a>

							</td>
							<td class="td-manage"><a title="删除"
								href="${pageContext.request.contextPath }/admin_user/deleteUser?id=${u.id}&root=${u.root}">
									<i class="layui-icon">&#xe640;</i>
							</a></td>
						</tr>
					</c:forEach>

				</tbody>
			</table>
			<div class="page"
				style="position: absolute; bottom: 30px; left: 500px;">
				<a
					href="${pageContext.request.contextPath }/admin_user/findByRootUser?root=${root}&pn=${pageInfo.navigateFirstPage}">首页</a>
				<c:if test="${pageInfo.hasPreviousPage}">
					<a
						href="${pageContext.request.contextPath }/admin_user/findByRootUser?root=${root}&pn=${pageInfo.prePage}">上一页</a>
				</c:if>
				<c:if test="${!pageInfo.hasPreviousPage}">
					<a class="disabled-link">上一页</a>
				</c:if>
				<c:if test="${pageInfo.hasNextPage}">
					<a
						href="${pageContext.request.contextPath }/admin_user/findByRootUser?root=${root}&pn=${pageInfo.nextPage}">下一页</a>
				</c:if>
				<c:if test="${! pageInfo.hasNextPage}">
					<a class="disabled-link">下一页</a>
				</c:if>
				<a
					href="${pageContext.request.contextPath }/admin_user/findByRootUser?root=${root}&pn=${pageInfo.navigateLastPage}">尾页</a>
				<p class="page-info">总共${pageInfo.pages}页，当前是第${pageInfo.pageNum}页，共有${pageInfo.total }条数据</p>
			</div>
		</div>
	</div>


	<script src="${pageContext.request.contextPath}/layui/layui.all.js "></script>
	<script type="text/javascript" src="${pageContext.request.contextPath }/js/my.js"></script>
		

</body>

</html>