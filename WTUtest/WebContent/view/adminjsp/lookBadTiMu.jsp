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
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/my.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/vue.js"></script>
<script src="https://cdn.staticfile.org/vue/2.2.2/vue.min.js"></script>
<script src="https://cdn.staticfile.org/axios/0.18.0/axios.min.js"></script>
<script
	src="https://cdn.staticfile.org/vue-resource/1.5.1/vue-resource.min.js"></script>
<link rel="icon"
	href="${pageContext.request.contextPath}/images/logo.png"
	 type="image/x-icon" />
</head>

<body class="layui-layout-body">
	<div class="layui-layout layui-layout-admin">

		<jsp:include page="adminHeader.jsp" flush="true" />
		<div id="page_content" class="page-content">
			<div class="layui-row">
				<form class="layui-form layui-col-md12 we-search" id="pageForm"
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
					<span class="fr" style="line-height: 40px">共有数据：{{pageInfo.length}}
						条</span>
				</form>

			</div>

			<table class="layui-table">
				<thead>
					<tr>

						<th>ID</th>
						<th>所属科目</th>
						<th>题目类型</th>
						<th>标题</th>
						<th>选项</th>
						<th>答案</th>
						<th>章节</th>
						<th>难度</th>
						<th>更新时间</th>
						<th>投诉频率</th>
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

						</td>
					</tr>
				</thead>
				<tbody>

					<tr v-for="(item,index) in pageInfo"
						v-show="index>=start && index<=end">
						<td>{{item.qid}}
						<td>{{item.subjectCode}}</td>
						<td>{{item.qstyleCode }}</td>
						<td>{{item.topic}}</td>
						<td>{{item.optionList}}</td>
						<td>{{item.result}}</td>
						<td>{{item.chapter}}</td>
						<td>{{item.difficulty}}</td>
						<td>{{item.updateTime }}</td>
						<th>{{item.misQuestion.frequency}}</th>
						<td><a class="layui-btn layui-btn-xs" @click="updateMaoBin"
							:index="index" :href="updateMaoBinUrl">修改</a></td>
						<td class="td-manage"><a title="删除" class="layui-icon"
							@click="deleteTiMu" :href="deleteTiMuUrl" :index="index">
								&#xe640; </a></td>
					</tr>
				</tbody>
			</table>
			<div class="page"
				style="position: absolute; bottom: 30px; left: 500px;">
<input type="hidden" id="rootUrl" value="${pageContext.request.contextPath}" />
				<a @click="targetPage" href="javascript:;">首页</a> <a
					class="disabled-link" v-if="start==0" href="javascript:;">上一页</a> <a
					@click="targetPage" v-if="start!=0" href="javascript:;">上一页</a> <a
					@click="targetPage" v-if="end<pageInfo.length" href="javascript:;">下一页</a>
				<a class="disabled-link" v-if="end>=pageInfo.length"
					href="javascript:;">下一页</a> <a @click="targetPage"
					href="javascript:;">尾页</a>
				<p class="page-info">
					总共：{{Math.ceil(pageInfo.length/pageSize)}}页,当前页码：{{pageNumber}},当前所在词条范围{{parseInt(start)+1}}-{{parseInt(end)+1}}
				</p>
			</div> 
		</div>
	</div>

	<script src="${pageContext.request.contextPath}/js/commonUtils.js"></script>
	<script src="${pageContext.request.contextPath}/js/lookBadTiMu.js"></script>
	<script src="${pageContext.request.contextPath}/layui/layui.all.js"></script>
</body>

</html>