<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh-CN">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="${pageContext.request.contextPath }/css/findPwd.css"
	rel="stylesheet">
<script src="${pageContext.request.contextPath }/js/vue.js"
	type="text/javascript"></script>
<script src="https://cdn.staticfile.org/vue/2.2.2/vue.min.js"></script>
<script src="https://cdn.staticfile.org/axios/0.18.0/axios.min.js"></script>
<script
	src="https://cdn.staticfile.org/vue-resource/1.5.1/vue-resource.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/jquery-3.3.1.js"></script>
<title>WTU刷题-找回密码</title>
<link rel="icon"
	href="${pageContext.request.contextPath}/images/logo.png"
	 type="image/x-icon" />
</head>
<body>
	<div class="nav-simple">
		<div class="login-wrapper">
			<div class="logo"></div>
		</div>
	</div>
	<div class="login-center-wrap">
		<div class="login-wrapper">
			<form action="${pageContext.request.contextPath }/user/findPwd"
				id="login-form" class="login" method="post">
				<div class="user-con">
					<div class="user-title">找回密码</div>
					<div class="user-box">
						<div class="error-item">
							<i class="fa fa-minus-circle error-icon"></i>
							<p class="error-msg" id="cue">${error }</p>
						</div>
						<div class="user-item">
							<label class="user-label">邮箱 </label> <input class="user-content"
								id="username" @blur="checkemails" v-model="sendCheckCode"
								placeholder="请输入注册邮箱" name="mail"
								onkeyup="this.value=this.value.replace(/\s+/g,'')" type="text"
								autocomplete="off">
						</div>
						<div class="user-item">
							<label class="user-label">验证码</label> <input class="user-content"
								id="code" name="code"
								onkeyup="this.value=this.value.replace(/\s+/g,'').replace(/[\u4e00-\u9fa5]/g, '')"
								type="password" placeholder="请输入验证码" autocomplete="off">
							<input type="button" name="getcode" id="getCode"
								@click='checkBtnClick' value="获取验证码" />
						</div>
						<div>
							<input id="rootUrl" type="hidden"
								value="${pageContext.request.contextPath}" />
						</div>
						<br>
						<button type="button" class="btn btn-submit" value="提交"
							@click="matchStr">提交</button>
						<div class="link-item">
							<a class="link"
								href="${pageContext.request.contextPath }/index.jsp"
								target="_self">返回首页</a> <a class="link"
								href="${pageContext.request.contextPath }/regist.jsp"
								target="_self">点此注册</a>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
	<div class="footer">
		<div class="login-wrappper">
			<div class="links">
				<a href="#" class="link">马原</a> | <a href="#" class="link">思修</a> |
				<a href="#" class="link">毛概</a> | <a href="#" class="link">近代史</a>
			</div>
			<p class="copyright">千里之行，始于足下。</p>
		</div>
	</div>


</body>
<script type="text/javascript">
	 var error="${error}";
	 if(error!=""){
		 alert(error);
	 }
	</script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/commonUtils.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/findPwd.js"></script>


</html>