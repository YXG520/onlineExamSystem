<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>题目搜索</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/css/searchTiMu.css" />
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
<body>
	<div id="searchArea">
		<div class="searchHeader">
		<input type="hidden" id="rootUrl" value="${pageContext.request.contextPath}" />
			<input type="hidden" id="subjectCode" value="${user.subjectCode}" />
			<span>请选择题目类型:</span> <select autocomplete="off" id="QstyleCode"
				v-model="QStyleCode"><br>
				<option value="pd" selected="selected">判断</option>
				<option value="dx">单选</option>
				<option value="dd">多选</option>
			</select> <span>请输入搜索内容:</span>
			 <input type="text" class="searchText"	ref="keyword" /><input type="button" value="搜索"
				class="searchBtn" @click="btnClick" />

		</div>

		<div>
			<div class="items" v-if="pdResult!=''" v-for="(item,index) in info">
				<div class="itemTopic">
					<span>{{item.topic}}</span>
				</div>
				<div class="pd">
					<span>Y:对</span><br> <span>N:错</span>
				</div>
				<div class="correct">正确答案是 {{item.result}}</div>
			</div>

			<div class="items" v-if="dxResult!=''" v-for="(item,index) in info">
				<div class="itemTopic">
					<span>{{item.topic}}</span>
				</div>
				<div class="multipleChoice">
					<span>A.{{JSON.parse(item.optionList)[0]}}</span><br> <span>B.{{JSON.parse(item.optionList)[1]}}</span><br>
					<span>C.{{JSON.parse(item.optionList)[2]}}</span><br> <span>D.{{JSON.parse(item.optionList)[3]}}</span>
				</div>
				<div class="correct">正确答案是 {{item.result}}</div>
			</div>

			<div class="items" v-if="ddResult!=''" v-for="(item,index) in info">
				<div class="itemTopic">
					<span>{{item.topic}}</span>
				</div>
				<div class="multipleChoice">
					<span>A.{{JSON.parse(item.optionList)[0]}}</span><br> <span>B.{{JSON.parse(item.optionList)[0]}}</span><br>
					<span>C.{{JSON.parse(item.optionList)[0]}}</span><br> <span>D.{{JSON.parse(item.optionList)[0]}}</span>
				</div>
				<div class="correct">正确答案是 {{item.result}}</div>
			</div>
		</div>

	</div>
	<script src="${pageContext.request.contextPath}/js/commonUtils.js"></script>

	<script src="${pageContext.request.contextPath}/js/searchTiMu.js"></script>

</body>
</html>