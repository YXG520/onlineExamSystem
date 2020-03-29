<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page trimDirectiveWhitespaces="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta charset="UTF-8">
<title>错题集</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/css/mistakes.css">
<script src="${pageContext.request.contextPath }/js/vue.js"
	type="text/javascript" charset="utf-8"></script>
<script src="https://cdn.staticfile.org/vue/2.2.2/vue.min.js"></script>
<script src="https://cdn.staticfile.org/axios/0.18.0/axios.min.js"></script>
<script
	src="https://cdn.staticfile.org/vue-resource/1.5.1/vue-resource.min.js"></script>
	<link rel="icon"
	href="${pageContext.request.contextPath}/images/logo.png"
	 type="image/x-icon" />
</head>
<body
	style="background:url(${pageContext.request.contextPath }/images/bg.gif)">
	<jsp:include page="header.jsp"></jsp:include>
	<div id="showArea">
	<input type="hidden" id="rootUrl" value="${pageContext.request.contextPath }"  />
		<input type="button" class="targetPage" @click="targetPage" value="尾页">
		<input type="button" class="targetPage" @click="targetPage"
			value="下一页"> <input type="button" class="targetPage"
			@click="targetPage" value="上一页"> <input type="button"
			class="targetPage" @click="targetPage" value="首页"> <span>共计{{commentInfo.length}}道错题，当前所在词条{{parseInt(start)+1}}-{{parseInt(end)+1}},当前页码：{{pageNumber}}</span>

		<div v-for="(item,index) in info" class="mistakeItem"
			v-show="index>=start && index<=end">
			<div class="topic">
				<span>{{item.topic}}</span>
			</div>
			<div class="optionList"
				v-if="item.qstyleCode=='DX'||item.qstyleCode=='DD'">
				<div class="opt">A:{{JSON.parse(item.optionList)[0]}}</div>
				<div class="opt">B:{{JSON.parse(item.optionList)[1]}}</div>
				<div class="opt">C:{{JSON.parse(item.optionList)[2]}}</div>
				<div class="opt">D:{{JSON.parse(item.optionList)[3]}}</div>
			</div>
			<div class="pd" v-if="item.qstyleCode=='PD'">
				<div class="opt">A:对</div>
				<div class="opt">B:错</div>
			</div>
			<div class="imformation">
				<span>正确答案 {{item.result}}</span> <span>所属科目
					{{item.subjectCode}}</span> <span>所在章节 {{item.chapter}}</span> <span>做错时间
					{{item.updateTime}}</span> <span>难度等级 {{item.difficulty}}</span> <span>做错频率{{item.incorrectRecord.frequency}}</span>
				<input id="userId" type="hidden" value="${user.id}" />

			</div>
		</div>


	</div>

</body>
<script src="${pageContext.request.contextPath}/js/commonUtils.js"></script>
<script src="${pageContext.request.contextPath}/js/cuoTiRecord.js"></script>

</html>