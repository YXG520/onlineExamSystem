<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page trimDirectiveWhitespaces="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/logo.ico"/>
<title>首页</title>

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/css/index/content.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/css/index/loging.css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/vue.js"></script>
<script src="https://cdn.staticfile.org/vue/2.2.2/vue.min.js"></script>
<script src="https://cdn.staticfile.org/axios/0.18.0/axios.min.js"></script>
<script
	src="https://cdn.staticfile.org/vue-resource/1.5.1/vue-resource.min.js"></script>
	 
</head>

<body>

	<div id="index">
		<%@ include file="/view/qtjsp/header.jsp"%>
		<div id="idendify">
			<div class="posi_abc">
				<div class="second_font">更智能的在线考试系统</div>
				<div class="second_font">让考试更简单</div>
				<div class="third_font">比你想象中更稳定</div>
				<div class="third_font">多种练习模式，强大统计分析让您轻松模拟考试</div>
			</div>
		</div>
		<!-- 功能的介绍 -->
		<div id="component">
			<div class="com_intro">满足多种练习场景</div>
			<ul class="com_ul">
				<a href="${pageContext.request.contextPath }/tp_training.jsp" ><li
					class="com_float">分类训练</li></a>
				<a
					href="${pageContext.request.contextPath }/view/qtjsp/tp_randomPractice.jsp" target="view_window"><li
					class="com_float">模拟考试</li></a>
				<a
					href="${pageContext.request.contextPath }/view/qtjsp/tp_chapterPractice.jsp" target="view_window"><li
					class="com_float">章节练习</li></a>
				<!-- 隐藏框，方便纯js文件引用jstl的值 -->
				<input id="rootUrl" type="hidden"
					value="${pageContext.request.contextPath}" />
				<input id="SubjectCode" type="hidden" value="${user.subjectCode}" />
			</ul>
			<ul class="com_ul2">
				<a
					href="${pageContext.request.contextPath }/view/qtjsp/searchTiMu.jsp" target="view_window"><li
					class="com_float">题目搜索</li></a>
				<a
					href="${pageContext.request.contextPath }/view/qtjsp/cuoTiRecord.jsp" target="view_window"><li
					class="com_float">错题记录</li></a>
			</ul>
		</div>
		<!-- 登录界面 -->
		<div id="loginweb" v-show="logining">
			<div id="logining_area">
				<div @click="gologin" :class="{ cross: Across, 'crosss': Acrossa}"
					@mouseover="changecross" @mouseleave="changecross()"></div>
				<div id="logining_box">
					<div class="title_wap">
						<span>用户登录</span>
					</div>
					<form id="loginForm"
						action="${pageContext.request.contextPath}/user/newLogin"
						onsubmit="return vm.stopRefresh()" method="post">
						<input type="text" v-model="username" autocomplete="off"
							name="username" class="user" placeholder="请输入登录邮箱/用户名" /> <input
							type="password" v-model="password" autocomplete="off"
							name="password" class="user" placeholder="请输入密码" /> <input
							type="text" v-model="code" name="code" autocomplete="off"
							class="code" placeholder="请输入验证码" /> <img ref="codeImg" id="codeImg"
							src="${pageContext.request.contextPath }/code/validcodeForLogin?num=1"
							class="codeImg" autocomplete="off" /><a id="fuzzy"  @click="changeImg" href="javascript:;">看不清</a>
							 <select id="subjectCode" name="SubjectCode" v-model="subjectCode">
							<option value="请选择科目" selected="selected">请选择科目</option>
							<option value="SX">思想道德与修养</option>
							<option value="JDS">中国近代史</option>
							<option value="MKS">马克思主义</option>
							<option value="MZT">毛泽东思想和中国特色社会主义理论体系</option>
						</select>
						<div class="forgetpwd">
							<a href="${pageContext.request.contextPath }/findPwd.jsp"
								class="blue">忘记密码?</a>


							<div class="regest_wap_right">
								还没有账号？ <a class="blue"
									href="${pageContext.request.contextPath}/regist.jsp">立即注册</a>
							</div>
						</div>
						<button type="button" @click="btnClick" class="login_btn">登录</button>
					</form>
				</div>
			</div>
		</div>

	</div>
	<div id="bottomFooter"
		style="width: 1518px; display: block; margin: 0 auto;"><%@ include
			file="view/qtjsp/footer.jsp"%></div>

</body>

<script src="${pageContext.request.contextPath }/js/index.js"
	type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
//  $(function(){ 
//  	$("#fuzzy").click(function(){		
//  		//浏览器带有缓存功能,不会多次请求相同数据,所以需要加一个时间戳，
//   		$(".codeImg").attr("src","validcodeForLogin?date="+new Date()); 
//  		return false; 
//   	}) 
//   }) 
  

//  var success="${success}";
//  if(success!=""){
// 	 alert(success);
//  }
 
//  var error="${error}";
//  if(error!=""){
// 	 alert(error);
//  }
 </script>
</body>
</html>