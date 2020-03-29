<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>训练</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/css/tp_trainingPd.css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/jquery-3.3.1.js"></script>
<script src="${pageContext.request.contextPath }/js/vue.js"
	type="text/javascript" charset="utf-8"></script>
<script src="https://cdn.staticfile.org/vue/2.2.2/vue.min.js"></script>
<script src="https://cdn.staticfile.org/axios/0.18.0/axios.min.js"></script>
<script
	src="https://cdn.staticfile.org/vue-resource/1.5.1/vue-resource.min.js"></script>
	<link rel="icon"
	href="/images/logo.png"
	 type="image/x-icon" />
</head>
<body>
	<div id="practicing">
		<!-- 答题卡部分 -->
		<div class="guide floatleft">
			<div class="prac_user">
				<div class="userImgArea">
					<img class="userImg"
						src="${pageContext.request.contextPath }/user/exportPic" />
				</div>
				<div class="userDiv">
					<input type="hidden" value="${user.id}" ref="userId" />
					<h5 class="userSpan">用户：${user.username}</h5>
					<h5 class="userSpan">
						科目：
						<c:choose>
							<c:when test="${user.subjectCode eq 'SX'}">思修</c:when>
							<c:when test="${user.subjectCode eq 'JDS'}">近代史</c:when>
							<c:when test="${user.subjectCode eq 'MZT'}">毛概</c:when>
							<c:when test="${user.subjectCode eq 'MKS'}">马克思</c:when>
							<c:otherwise>未知</c:otherwise>
						</c:choose>
					</h5>
				</div>
			</div>
			<div class="answerSheet">
				<p class="title">答题卡</p>
				<div class="dtk">

					<!-- 判断题号 -->
					<div class="part" style="height: 200px;">
						<p>判断题 ({{pdInfo.length}}道) 错{{falseNumber}},对 {{trueNumber}}</p>
						<div class="que_num">
							<ul>
								<li  @click="pddatiArea"  v-for="(item,index) in pdInfo" :index="index"
									 class="floatleft daTiArea">{{index+1}}</li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 题干 -->
		<div class="que_block floatright">
			<div class="que_block_up" :style="'font-size:'+ fs+'px'">
				当前作答第 {{parseInt(index)+1}}道判断题目，科目代码： {{pdInfo[0].subjectCode}} <br>
				{{pdInfo[index].topic}}<br> <span v-if="ifShow"><span
					style="color: blue;" v-if="whetherRight=='回答正确' ">回答正确</span><span
					style="color: red;" v-if="whetherRight=='回答错误' ">回答错误,正确答案是
						{{ pdInfo[index].result}}</span></span>
			</div>
			<div class="part_select">
				<!-- 选项 -->
				<div class="parting_sel">
					<div ref="pdResult" class="selabel">
						<input type="radio" ref="pdInput" :disabled="whetherDisabled"
							name="judge" @click="verifyAnswer" value="Y" class="radio" /><span>对</span><br>
						<input type="radio" ref="pdInput" :disabled="whetherDisabled"
							name="judge" @click="verifyAnswer" value="N" class="radio" /><span>错</span>
					</div>
					<div class="btnArea">
						<!-- 隐藏框，方便纯js文件引用jstl的值 -->
						<input id="rootUrl" type="hidden"
							value="${pageContext.request.contextPath}" /> <input
							id="SubjectCode" type="hidden" value="${user.subjectCode}" /> <input
							type="button" @click="btnClick" value="上一题" /> <input
							type="button" @click="btnClick" value="下一题" />
					</div>
				</div>

			</div>
		</div>
		<!-- 改变字体大小和标记的按钮 -->
		<div class="fbtn">
			<div class="fsbtn floatleft" @click="fontsizeb()">A+</div>
			<div class="fsbtn floatleft" @click="fontsizes()">A-</div>
			<div class="fsbtn floatleft" @click="markQuestion">标记</div>
			<div class="mistakenQ floatleft" @click="submitMistakenQ">此题有问题？</div>
		</div>

	</div>

</body>
<script src="${pageContext.request.contextPath }/js/commonUtils.js"
	type="text/javascript" charset="utf-8"></script>
<script src="${pageContext.request.contextPath }/js/tp_trainingPd.js"
	type="text/javascript" charset="utf-8"></script>

</body>
</html>