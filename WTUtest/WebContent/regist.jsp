<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/logo.ico"/>
<title>注册界面</title>
<script type="text/javascript" src="js/jquery-3.3.1.js"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/regist.css" />
<script src="${pageContext.request.contextPath}/js/vue.js"
	type="text/javascript" charset="utf-8"></script>
<script src="https://cdn.staticfile.org/vue/2.2.2/vue.min.js"></script>
<script src="https://cdn.staticfile.org/axios/0.18.0/axios.min.js"></script>
<script
	src="https://cdn.staticfile.org/vue-resource/1.5.1/vue-resource.min.js"></script>
</head>
<body>
	<div id="regestweb">
		<div :class="{ cross: Across, 'crosss': Acrossa}"
			@mouseover="changecross" @mouseleave="changecross()"></div>
		<div id="regest_area">
			<div id="title_wap">
				<span>用户注册</span> <a href="login.jsp">我有账号，去登录</a>
			</div>
			<form action="${pageContext.request.contextPath }/user/newRegister"
				id="forms" enctype="multipart/form-data" method="post"
				class="regestform">
				<input type="text" class="isNull" id="mail" v-model="forMail"
					@change="mailIfExist" name="mail" placeholder="请输入可用邮箱，用于激活登录" />
				<div style="color: red; height: 20px;">
					<span v-if="mailExist!=''">{{mailExist}}</span><span>${error}</span>
				</div>
				<input type="text" class="isNull" id="mailcode" name="mailCode"
					placeholder="请输入验证码" /><br> <input type="button" id="getCode"
					@click="btnCheckClick" value="获取验证码" /> <input type="text"
					class="isNull" id="username" name="username" v-model="forUsername"
					@change="usernameIfExist" placeholder="请设置用户名" />
				<div style="color: red; height: 20px;">
					<span v-if="usernameExist!=''">{{usernameExist}}</span>
				</div>
				<input type="password" class="isNull" @change="judgeLength"
					id="password" name="password" placeholder="请设置密码" /> <input
					type="password" class="isNull" @change="ifSame" id="passwordsure"
					name="passwordsure" placeholder="确定密码" /><br> <input
					type="file" name="file" accept="image/*" id="fileInput"
					@change="uploadImg($event)" ref="getfilename" value="" /> <input
					type="hidden" class="isNull" name="systemPicUrl" id="systemPicUrl"
					ref="systemPicUrl" value="img1.jpg" /> <label class="fileTip"
					for="fileInput">+</label>
				<div class="fileTip2">
					<div class="tip3">
						不想上传？点击右边图片，系统为您随机分配头像<span ref="setfilename" style="color: blue;"></span>
					</div>
					<img
						src="${pageContext.request.contextPath }/images/regist/img1.jpg"
						class="accountImg" ref="accountImg" @click="getNum();">
				</div>
				<!-- 	<label>请选择头像文件</label><input type="file" name="file" placeholder=""/><br> -->
				<!-- 		<img  src=""/> -->
				<input type="button" @click="ifNotNullStr" value="注册" id="regestbtn" /><br>
				<input id="rootUrl" type="hidden"
					value="${pageContext.request.contextPath}" />
			</form>
		</div>
	</div>
</body>
<script language=javascript
	src="${pageContext.request.contextPath}/js/commonUtils.js"></script>
<script src="${pageContext.request.contextPath}/js/regist.js"
	type="text/javascript" charset="utf-8"></script>
</html>