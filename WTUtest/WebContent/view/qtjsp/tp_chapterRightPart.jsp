<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>刷题</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/css/tp_chapterRightPart.css" />
</head>
<body>
	<div id="practicing">
		<!-- 答题卡部分 -->
		<div class="guide floatleft">
			<div class="guideTop">
				<div class="prac_user floatleft">

					<div class="userDiv">
						<input type="hidden" value="${user.id}" ref="userId" />

						<h5 class="retime">
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


				<div class="retime floatleft">
					<h5 class="userSpan">当前章节:第{{chapterIndex}}章</h5>
				</div>
			</div>
			<div class="answerSheet">
				<p class="title">答题卡</p>
				<div class="dtk" ref="queNum">
					<!-- 单选 -->
					<div class="part">
						<p>单选题（{{dxResult.length}}道）</p>
						<div class="que_num">
							<ul ref="queNum1">
								<li v-for="(item, index1) in dxResult" class="floatleft"
									@click="goToClickedQuestion(1, index1,)">{{index1+1}}</li>
							</ul>
						</div>
					</div>
					<br>
					<hr>
					<!-- 多选 -->
					<div class="part">
						<p>多选题（{{ddResult.length}}道）</p>
						<div class="que_num">
							<ul ref="queNum2">
								<li v-for="(item, index2) in ddResult" class="floatleft"
									@click="goToClickedQuestion(2, index2)">{{index2+1}}</li>
							</ul>
						</div>
					</div>
					<br>
					<hr>
					<!-- 判断 -->
					<div class="part">
						<p>判断题（{{pdResult.length}}道）</p>
						<div class="que_num">
							<ul ref="queNum3">
								<li v-for="(item, index3) in pdResult" class="floatleft"
									@click="goToClickedQuestion(3, index3)">{{index3+1}}</li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 题目部分 -->
		<div class="que_block floatright">

			<input id="rootUrl" ref="rootUrl" id="rootUrl" type="hidden"
				value="${pageContext.request.contextPath}" /> <input
				ref="SubjectCode" id="SubjectCode" type="hidden"
				value="${user.subjectCode}" />
			<!-- 开始按钮 ,-->
			<button type="button" @click="clickStartBtn();" class="sposition"
				v-if="startBtn == 0">开始答题</button>
			<div class="que_block_up" v-if="startBtn == 1? true : false">
				<!-- 修改字体以及标记按钮 -->
				<div class="fbtn">
					<button type="button" class="fsbtn floatleft" @click="fontsizeb()">A+</button>
					<button type="button" class="fsbtn floatleft" @click="fontsizes()">A-</button>
					<button type="button" class="fsbtn floatleft" @click="mark()">标记</button>
					<button type="button" class="mistakenQ floatleft"
						@click="submitMistakenQ">此题有毛病？</button>

				</div>
				<!-- 题目框 -->
				<div class="que_block_cont" ref="queblockcont"
					:style="'font-size:'+ fs+'px'">
					<!-- 获取单选题的第一道题 -->
					{{questions[i]}} <br>

				</div>
				<!-- 上下题按钮 -->
				<div class="qbtn">
					<button class="qsbtn floatleft" @click="before()">上一题</button>
					<button class="qsbtn floatleft" @click="next();">下一题</button>
					<button class="qsbtn floatleft" @click="submit()">核验分数</button>
					<button class="qsbtn floatleft" @click="showAnswerbtn">{{btnContent}}</button>
					<span style="color: blue;" v-if="ifShowAnswer">正确答案是{{
						info[i].result}}</span>

				</div>
			</div>
			<div class="part_select" v-if="startBtn == 1">
				<!-- 单选框 -->
				<div class="parting_sel" v-if="i <=(dxLength-1)">
					<div class="selabel" ref="answerSelect">
						<input type="checkbox" name="" id="box1" value="A"
							@click="getCheckOption(0,$event)" /> <label for="box1"
							class="boxA">{{oneQueOpt[0]}}</label><br> <input
							type="checkbox" name="" id="box2" value="B"
							@click="getCheckOption(1,$event)" /> <label for="box2"
							class="boxB">{{oneQueOpt[1]}}</label><br> <input
							type="checkbox" name="" id="box3" value="C"
							@click="getCheckOption(2,$event)" /> <label for="box3"
							class="boxC">{{oneQueOpt[2]}}</label><br> <input
							type="checkbox" name="" id="box4" value="D"
							/@click="getCheckOption(3,$event)"> <label for="box4"
							class="boxD">{{oneQueOpt[3]}}</label>
					</div>
				</div>
				<!-- 多选框 -->
				<div class="parting_sel"
					v-if=" i>=dxLength && i <= (dxLength+ddLength-1) ">
					<div class="selabel" ref="answerSelect">
						<input type="checkbox" name="" id="box1" value="A"
							@click="getCheckOptionMul()" /> <label for="box1" class="boxA">{{twoQueOpt[0]}}</label><br>
						<input type="checkbox" name="" id="box2" value="B"
							@click="getCheckOptionMul()" /> <label for="box2" class="boxB">{{twoQueOpt[1]}}</label><br>
						<input type="checkbox" name="" id="box3" value="C"
							@click="getCheckOptionMul()" /> <label for="box3" class="boxC">{{twoQueOpt[2]}}</label><br>
						<input type="checkbox" name="" id="box4" value="D"
							@click="getCheckOptionMul()" /> <label for="box4" class="boxD">{{twoQueOpt[3]}}</label>
					</div>
				</div>
				<!-- 判断 -->
				<div class="parting_sel"
					v-if=" i>=(dxLength+ddLength) && i <=totalLength">
					<div class="selabel" ref="answerSelect">
						<input type="checkbox" name="" id="box5" value="Y"
							@click="getCheckOption(0)" /> <label for="box5" class="boxT">{{threeQueOpt[0]}}</label><br>
						<input type="checkbox" name="" id="box6" value="N"
							@click="getCheckOption(1)" /> <label for="box6" class="boxF">{{threeQueOpt[1]}}</label><br>
					</div>
				</div>
				<div class="tiMUIndex">
					当前作答第<span v-show="parseInt(i)<=(dxLength-1)">{{
						parseInt(i)+1}}道选择题目</span> <span
						v-show="parseInt(i)>=(dxLength)&&parseInt(i)<=(dxLength+ddLength-1)">{{
						parseInt(i)+1-dxLength}}道多选题目</span> <span
						v-show="parseInt(i)>=(dxLength+ddLength)&&parseInt(i)<totalLength">{{
						parseInt(i)+1-dxLength-ddLength}}道判断题目</span>
				</div>
			</div>
		</div>

		<div class="alert" v-if="ending == 1">
			<div class="alertContent">是否提交答题卡？</div>
			<div class="alertBtn">
				<button type="button" class="floatleft fsbtn"
					@click="clickCancel();">取消</button>
				<button type="button" class="floatright fsbtn" @click="clickYes();">确定</button>
			</div>
		</div>

		<div class="showTheScore" v-if="startBtn == 2">
			<div>得分：{{score}}分</div>
		</div>

	</div>
</body>
<%-- 	<script src="${pageContext.request.contextPath }/js/tp_chapterPractice.js" type="text/javascript" charset="UTF-8"></script> --%>
</html>
