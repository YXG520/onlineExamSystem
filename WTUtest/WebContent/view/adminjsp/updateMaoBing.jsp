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
	<link rel="icon"
	href="${pageContext.request.contextPath}/images/logo.png"
	 type="image/x-icon" />
<style>
.layui-table form {
	padding: 0 85px;
	border-left: 1px solid gray;
	text-align: center;
}

.layui-table th {
	text-align: center;
}

.layui-table form  .updateSbmit {
	
}
</style>
</head>

<body class="layui-layout-body">
	<div class="layui-layout layui-layout-admin">

		<jsp:include page="adminHeader.jsp" flush="true" />
		<div class="page-content">
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

				</form>

			</div>
			<div class="layui-table">
				<form action="${pageContext.request.contextPath }/tiKu/updateTiMu"
					method="post"
					style="display: block; margin: 0 350px; border-left: 0px;">
					<table>
						<thead>
							<th colspan="2">修改题目</th>
						</thead>
						<tbody>
							<tr>
								<td>ID:</td>
								<td><span>${param.qid}</span><input type="hidden"
									value="${param.qid}" name="QID"></td>
							<tr>
								<td>所属科目:</td>
								<td><input type="radio" class="alterSubject" name="subject"
									value="SX" />思修 <input type="radio" class="alterSubject"
									name="subject" value="JDS" />近代史 <input type="radio"
									class="alterSubject" name="subject" value="MKS" />马原 <input
									type="radio" class="alterSubject" name="subject" value="MZT" />毛概</td>
							</tr>
							<tr>
								<td>题目类型:</td>
								<td><input type="radio" class="alterQStyleCode"
									name="QStyleCode" value="PD" />判断 <input type="radio"
									class="alterQStyleCode" name="QStyleCode" value="DX" />单选 <input
									type="radio" class="alterQStyleCode" name="QStyleCode"
									value="DD" />多选</td>
							</tr>
							<tr>
								<td>标题:</td>
								<td><textArea name="Topic" rows="5" cols="50">${param.topic}</textArea>
								</td>
							</tr>
							<tr>
								<td>选项:</td>
								<td><textArea name="OptionList" rows="5" cols="50">[${param.optionList}]</textArea>
								</td>
							</tr>
							<tr>
								<td>答案:</td>
								<td>
									<ul>

										<li id="pdResult">对<input class="alterPdResult"
											name="Result" type="radio" value="Y" /> 错<input
											class="alterPdResult" name="Result" type="radio" value="N" />
										</li>
										<li id="dxResult">A<input class="alterDxResult"
											name="Result" type="checkBox" value="A" /> B<input
											class="alterDxResult" name="Result" type="checkBox" value="B" />
											C<input class="alterDxResult" name="Result" type="checkBox"
											value="C" /> D<input class="alterDxResult" name="Result"
											type="checkBox" value="D" />
										</li>

									</ul>
								</td>
							</tr>
							<tr>
								<td>章节:</td>
								<td><input name="Chapter" type="number"
									value="${param.chapter}" /></td>
							</tr>
							<tr>
								<td>难度:</td>
								<td><input class="alterDifficulty" name="Difficulty"
									type="radio" value="难" />难 <input name="Difficulty"
									class="alterDifficulty" type="radio" value="中" />中 <input
									name="Difficulty" class="alterDifficulty" type="radio"
									value="易" />易</td>
							</tr>
							<tr>
								<td>更新时间:</td>
								<td><span>上次：${param.updateTime}</span> 本次：<input
									type="text" name="UpdateTime" class="updateTime"></td>
							</tr>
						</tbody>
					</table>
					<input type="submit" class="layui-btn" value="提交" />
				</form>
			</div>


		</div>
	</div>
	<script src="${pageContext.request.contextPath}/js/commonUtils.js "></script>
	<script src="${pageContext.request.contextPath}/layui/layui.all.js "></script>
	<script>
	

var obj=document.getElementsByClassName("updateTime");
for(var i=0;i<obj.length;i++){
	obj[i].value=curentTime();
}
function changeChecked(targetValue,obj){
	for (var i=0;i<obj.length;i++){
		if(obj[i].value==targetValue)
		{
			obj[i].checked=true;
		
		}
	}
}
function changeCheckBox(targetValue,obj){
	for (var i=0;i<obj.length;i++){
		if(targetValue.indexOf(obj[i].value)>-1)
		{	
			obj[i].checked=true;	
		}else{
			obj[i].checked=false;
		}
	}
}

var pageSubject="${param.subjectCode}";


var alterSubject=document.getElementsByClassName("alterSubject");
changeChecked(pageSubject,alterSubject);

var pageQStyleCode="${param.qstyleCode}";
var alterQStyleCode=document.getElementsByClassName("alterQStyleCode");
changeChecked(pageQStyleCode,alterQStyleCode);

var pageDifficulty="${param.difficulty}";
var alterDifficulty=document.getElementsByClassName("alterDifficulty");
changeChecked(pageDifficulty,alterDifficulty);

var pageResult="${param.result}";
 var alterResult;
 if(pageQStyleCode=='PD'){
	 document.getElementById("dxResult").style.display="none";
	 document.getElementById("pdResult").style.display="block"; 
	  alterResult=document.getElementsByClassName("alterPdResult");
	
 }else if(pageQStyleCode=='DX' || pageQStyleCode=='DD'){
	 document.getElementById("pdResult").style.display="none"; 
	 document.getElementById("dxResult").style.display="block";
	 alterResult=document.getElementsByClassName("alterDxResult");
 }
changeCheckBox(pageResult,alterResult);
</script>
</body>
</html>