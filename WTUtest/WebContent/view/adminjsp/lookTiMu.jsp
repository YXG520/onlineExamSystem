<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/my.js"></script>
	<link rel="icon"
	href="${pageContext.request.contextPath}/images/logo.png"
	 type="image/x-icon" />
</head>

<body class="layui-layout-body">
	<div class="layui-layout layui-layout-admin">

		<jsp:include page="adminHeader.jsp" flush="true" />
		<div class="page-content">
			<div class="layui-row">
				<form class="layui-form  we-search" id="pageForm"
					action="${pageContext.request.contextPath }/tiKu/searchTiMuInHT"
					method="post">
					<!-- 隐藏域.当前页码 -->
					<%-- 					<input type="hidden" name="pn" id="currentPageInput" value="${page.pageNum }" /> --%>
					搜索：
					<div class="layui-inline">
						<select name="QStyleCode" class="layui-input">
							<option value="">请选择题目类型</option>
							<option value="pd" selected>判断题</option>
							<option value="dx">单选题</option>
							<option value="dd">多选题</option>
						</select>


					</div>
					<div class="layui-inline">
						<select name="subjectCode" class="layui-input">
							<option value="">请选择科目</option>
							<option value="SX" selected>思修</option>
							<option value="JDS">近代史</option>
							<option value="MKS">马克思</option>
							<option value="MZT">毛概</option>
						</select>
					</div>
					<div class="layui-inline">
						<input type="text" value="" name="Topic" placeholder="请输入题目关键字"
							autocomplete="off" class="layui-input">

					</div>
					<button class="layui-btn">
						<i class="layui-icon">&#xe615;</i>
					</button>
					
				</form>
<form class="layui-form  we-search" enctype="multipart/form-data" id="pageForm"
					action="${pageContext.request.contextPath }/tiKu/importTiKuExcel"
					method="post">
					 题库导入：
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
						<th>所属科目</th>
						<th>题目类型</th>
						<th>标题</th>
						<!-- 						<th>选项</th> -->
						<th>答案</th>
						<th>章节</th>
						<th>难度</th>
						<th>更新时间</th>
						<th>操作</th>
						<th>删除</th>
						<!-- 						<th>多文本格式?</th>						 -->
						<!-- 						<th>评论</th>						 -->
						<!-- 						<th>图片列表</th> -->
						<!-- 						<th>媒体列表</th> -->
						<!-- 						<th>错误</th> -->
						<!-- 						<th>OptionMax</th> -->
						<!-- 						<th>OptionType</th> -->
						<!-- 						<th>OptionStart</th>			 -->
						<!-- 						<th>ResultList</th>	 -->
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${pageInfo.list }" var="tiMu" varStatus="status">
						<tr>
							<td>${tiMu.QID }</td>
							<td>${tiMu.subjectCode }</td>
							<td>${tiMu.QStyleCode }</td>
							<td>${tiMu.topic}</td>
							<%-- 							<td>${tiMu.optionList}</td> --%>
							<td>${tiMu.result}</td>
							<td>${tiMu.chapter}</td>
							<td>${tiMu.difficulty}</td>
							<td>${tiMu.updateTime }</td>
							<%-- 							<td>${tiMu.IsRTF }</td> --%>
							<%-- 							<td>${tiMu.Comment}</td> --%>
							<%-- 							<td>${tiMu.ImageList}</td> --%>

							<%-- 							<td>${tiMu.MediaList}</td> --%>
							<%-- 							<td>${tiMu.Qid }</td> --%>
							<%-- 							<td>${tiMu.Error }</td> --%>
							<%-- 							<td>${tiMu.OptionMax }</td> --%>
							<%-- 							<td>${tiMu.OptionType}</td> --%>
							<%-- 							<td>${tiMu.OptionStart}</td> --%>
							<%-- 							<td>${tiMu.ResultList}</td> --%>
							<td><a class="layui-btn layui-btn-xs"
								href="${pageContext.request.contextPath }/view/adminjsp/updateTiMu.jsp?index=${status.index}">修改</a>
								<a class="layui-btn layui-btn-xs"
								href="${pageContext.request.contextPath }/view/adminjsp/updateTiMu.jsp?index=${status.index}">添加</a>

							</td>
							<td class="td-manage"><a title="删除"
								href="${pageContext.request.contextPath}/tiKu/deleteTiMu?QID=${tiMu.QID}&QStyleCode=${tiMu.QStyleCode}">
									<i class="layui-icon">&#xe640;</i>
							</a></td>
						</tr>
					</c:forEach>

				</tbody>
			</table>
			<div class="page"
				style="position: absolute; bottom: 30px; left: 500px;">
				<a
					href="${pageContext.request.contextPath }/tiKu/searchTiMuInHT?QStyleCode=${QStyleCode}&pn=1">首页</a>
				<c:if test="${pageInfo.hasPreviousPage}">
					<a
						href="${pageContext.request.contextPath }/tiKu/searchTiMuInHT?QStyleCode=${QStyleCode}&pn=${pageInfo.prePage}">上一页</a>
				</c:if>
				<c:if test="${!pageInfo.hasPreviousPage}">
					<a class="disabled-link">上一页</a>
				</c:if>
				<c:if test="${pageInfo.hasNextPage}">
					<a
						href="${pageContext.request.contextPath }/tiKu/searchTiMuInHT?QStyleCode=${QStyleCode}&pn=${pageInfo.nextPage}">下一页</a>
				</c:if>
				<c:if test="${! pageInfo.hasNextPage}">
					<a class="disabled-link">下一页</a>
				</c:if>
				<a
					href="${pageContext.request.contextPath }/tiKu/searchTiMuInHT?QStyleCode=${QStyleCode}&pn=<fmt:formatNumber value="${pageInfo.total/10+ ((pageInfo.total/10)/1==0?0:0.5)}" type="number" pattern="#"/>">尾页</a>
				<p class="page-info">总共${pageInfo.pages}页，当前是第${pageInfo.pageNum}页，共有${pageInfo.total }条数据</p>
			</div>
		</div>
	</div>

	<script src="${pageContext.request.contextPath}/layui/layui.all.js "></script>
</body>
</html>