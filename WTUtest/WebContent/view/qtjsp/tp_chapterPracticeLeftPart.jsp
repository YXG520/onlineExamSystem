<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<body>
	<div class="layui-header">
		<div class="layui-logo">WTU刷题按章节练习</div>
		<ul class="layui-nav layui-layout-right">
			<li class="layui-nav-item"><img
				src="${pageContext.request.contextPath }/user/exportPic"
				class="layui-nav-img"></li>
			<li class="layui-nav-item" style="margin-left: 30px;"><span>用户:${user.username}</span>

			</li>
		</ul>
	</div>
	<div class="layui-side layui-bg-black">
		<div class="layui-side-scroll">
			<ul class="layui-nav layui-nav-tree">
				<li class="layui-nav-item layui-nav-itemed"><a
					href="javascript:;">章节列表(1-4)</a>
					<dl class="layui-nav-child">
						<dd>
							<a @click="dynamicAction(1,'${user.subjectCode}')"
								href="javascript:;">第一章</a>
						</dd>
						<dd>
							<a @click="dynamicAction(2,'${user.subjectCode}')"
								href="javascript:;">第二章</a>
						</dd>
						<dd>
							<a @click="dynamicAction(3,'${user.subjectCode}')"
								href="javascript:;">第三章</a>
						</dd>
						<dd>
							<a @click="dynamicAction(4,'${user.subjectCode}')"
								href="javascript:;">第四章</a>
						</dd>
					</dl></li>
				<li class="layui-nav-item layui-nav-itemed"><a
					href="javascript:;">章节列表(5-8)</a>
					<dl class="layui-nav-child">
						<dd>
							<a @click="dynamicAction(5,'${user.subjectCode}')"
								href="javascript:;">第五章</a>
						</dd>
						<dd>
							<a @click="dynamicAction(6,'${user.subjectCode}')"
								href="javascript:;">第六章</a>
						</dd>
						<dd>
							<a @click="dynamicAction(7,'${user.subjectCode}')"
								href="javascript:;">第七章</a>
						</dd>
						<dd>
							<a @click="dynamicAction(8,'${user.subjectCode}')"
								href="javascript:;">第八章</a>
						</dd>
					</dl></li>
				<li class="layui-nav-item layui-nav-itemed"><a
					href="javascript:;">章节列表(9-12)</a>
					<dl class="layui-nav-child">
						<dd>
							<a @click="dynamicAction(9,'${user.subjectCode}')"
								href="javascript:;">第九章</a>
						</dd>
						<dd>
							<a @click="dynamicAction(10,'${user.subjectCode}')"
								href="javascript:;">第十章</a>
						</dd>
						<dd>
							<a @click="dynamicAction(11,'${user.subjectCode}')"
								href="javascript:;">第十一章</a>
						</dd>
						<dd>
							<a @click="dynamicAction(12,'${user.subjectCode}')"
								href="javascript:;">第十二章</a>
						</dd>
					</dl></li>

			</ul>
		</div>

	</div>

</body>
</html>