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
<link rel="icon"
	href="${pageContext.request.contextPath}/images/logo.png"
	 type="image/x-icon" />
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
				<c:forEach items="${pageInfo.list }" var="tiMu" varStatus="status">
					<c:if test="${status.index eq param.index}">
						<form action="${pageContext.request.contextPath }/tiKu/updateTiMu"
							method="post" style="display: block; float: left">

							<table>
								<thead>
									<th colspan="2">修改题目</th>
								</thead>
								<tbody>
									<tr>
										<td>ID:</td>
										<td><span>${pageInfo.list[status.index].QID}</span><input
											type="hidden" value="${pageInfo.list[status.index].QID}"
											name="QID"></td>
									<tr>
										<td>所属科目:</td>
										<td><input type="radio" class="alterSubject"
											name="SubjectCode" value="SX" />思修 <input type="radio"
											class="alterSubject" name="SubjectCode" value="JDS" />近代史 <input
											type="radio" class="alterSubject" name="SubjectCode"
											value="MKS" />马原 <input type="radio" class="alterSubject"
											name="SubjectCode" value="MZT" />毛概</td>
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
										<td><textArea name="Topic" rows="5" cols="50">${pageInfo.list[status.index].topic}</textArea>
										</td>
									</tr>
									<tr>
										<td>选项:</td>
										<td><textArea name="OptionList" rows="5" cols="50">${pageInfo.list[status.index].optionList}</textArea>
										</td>
									</tr>
									<tr>
										<td>答案:</td>
										<td><c:if
												test="${pageInfo.list[status.index].QStyleCode eq 'PD'}">
				对<input class="alterResult" name="Result" type="radio" value="Y" />
				错<input class="alterResult" name="Result" type="radio" value="N" />
											</c:if> <c:if
												test="${pageInfo.list[status.index].QStyleCode eq 'DD' or pageInfo.list[status.index].QStyleCode eq 'DX'}">
				A<input class="alterResult" name="Result" type="checkBox" value="A" />
				B<input class="alterResult" name="Result" type="checkBox" value="B" />
				C<input class="alterResult" name="Result" type="checkBox" value="C" />
				D<input class="alterResult" name="Result" type="checkBox" value="D" />
											</c:if></td>
									</tr>
									<tr>
										<td>章节:</td>
										<td><input name="Chapter" type="number"
											value="${pageInfo.list[status.index].chapter}" /></td>
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
										<td><span>上次：${pageInfo.list[status.index].updateTime}</span>
											本次：<input type="text" name="UpdateTime" class="updateTime"></td>
									</tr>
								</tbody>
							</table>
							<input type="submit" class="layui-btn" value="提交" />
						</form>

						<form action="${pageContext.request.contextPath }/tiKu/insertTiMu"
							method="post" style="display: block; float: left">
							<table>
								<thead>
									<th colspan="2">增加题目</th>
								</thead>
								<tbody>
									<tr>
										<td>ID:</td>
										<td>系统分配</td>
									<tr>
										<td>所属科目:</td>
										<td><input type="radio" class="alterSubject"
											name="SubjectCode" value="SX" />思修 <input type="radio"
											class="alterSubject" name="SubjectCode" value="JDS" />近代史 <input
											type="radio" class="alterSubject" name="SubjectCode"
											value="MKS" />马原 <input type="radio" class="alterSubject"
											name="SubjectCode" value="MZT" />毛概</td>
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
										<td><textArea name="Topic" rows="5" cols="50"></textArea>
										</td>
									</tr>
									<tr>
										<td>选项:</td>
										<td><textArea placeholder="请参考左边更新的格式" name="OptionList"
												rows="5" cols="50"></textArea></td>
									</tr>
									<tr>
										<td>答案:</td>
										<td><c:if
												test="${pageInfo.list[status.index].QStyleCode eq 'PD'}">
				对<input class="alterResult" name="Result" type="radio" value="Y" />
				错<input class="alterResult" name="Result" type="radio" value="N" />
											</c:if> <c:if
												test="${pageInfo.list[status.index].QStyleCode eq 'DD' or pageInfo.list[status.index].QStyleCode eq 'DX'}">
				A<input class="alterResult" name="Result" type="checkBox" value="A" />
				B<input class="alterResult" name="Result" type="checkBox" value="B" />
				C<input class="alterResult" name="Result" type="checkBox" value="C" />
				D<input class="alterResult" name="Result" type="checkBox" value="D" />
											</c:if></td>
									</tr>
									<tr>
										<td>章节:</td>
										<td><input name="Chapter" type="number" /></td>
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
										<td>新增时间:</td>
										<td><input type="text" name="UpdateTime"
											class="updateTime"></td>
									</tr>
								</tbody>
							</table>
							<input type="submit" class="layui-btn" value="提交" />
						</form>
					</c:if>

				</c:forEach>


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

var pageSubject="${pageInfo.list[param.index].subjectCode}";
var alterSubject=document.getElementsByClassName("alterSubject");
changeChecked(pageSubject,alterSubject);

var pageQStyleCode="${pageInfo.list[param.index].QStyleCode}";
var alterQStyleCode=document.getElementsByClassName("alterQStyleCode");
changeChecked(pageQStyleCode,alterQStyleCode);

var pageDifficulty="${pageInfo.list[param.index].difficulty}";
var alterDifficulty=document.getElementsByClassName("alterDifficulty");
changeChecked(pageDifficulty,alterDifficulty);

var pageResult="${pageInfo.list[param.index].result}";
var alterResult=document.getElementsByClassName("alterResult");
changeCheckBox(pageResult,alterResult);



</script>
</body>
</html>