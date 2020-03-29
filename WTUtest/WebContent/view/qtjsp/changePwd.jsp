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
	<link rel="icon"
	href="${pageContext.request.contextPath}/images/logo.png"
	 type="image/x-icon" />
<title>WTU刷题-找回密码</title>
</head>
<body>
	<div class="nav-simple">
		<div class="login-wrapper">
			<div class="logo"></div>
		</div>
	</div>
	<div class="login-center-wrap">
		<div class="login-wrapper">
			<form action="${pageContext.request.contextPath }/user/alterPwd"
				id="login-form" class="login" method="post">
				<div class="user-con">
					<div class="user-title">修改密码</div>
					<div class="user-box">
						<div class="error-item">
							<i class="fa fa-minus-circle error-icon"></i>
							<p class="error-msg" id="cue">${error }</p>
						</div>
						<div class="user-item">
							<label class="user-label">用户</label> <input class="user-content"
								id="username" name="username" v-model="sendCheckCode"
								placeholder="请输入邮箱或用户名"
								onkeyup="this.value=this.value.replace(/\s+/g,'')" type="text"
								autocomplete="off">
						</div>
						<div class="user-item">
							<label class="user-label">旧密码</label> <input class="user-content"
								id="password" name="password"
								onkeyup="this.value=this.value.replace(/\s+/g,'').replace(/[\u4e00-\u9fa5]/g, '')"
								type="password" placeholder="请确认新密码" autocomplete="off">
						</div>

						<div class="user-item">
							<label class="user-label">新密码</label> <input class="user-content"
								@blur="judgePwdLength" id="newPassword" name="newPassword"
								onkeyup="this.value=this.value.replace(/\s+/g,'').replace(/[\u4e00-\u9fa5]/g, '')"
								type="password" placeholder="请设置新密码" autocomplete="off">
						</div>
						<div class="user-item">
							<label class="user-label">确认</label> <input class="user-content"
								id="passwordSure" @blur="ifSame" name="passwordSure"
								onkeyup="this.value=this.value.replace(/\s+/g,'').replace(/[\u4e00-\u9fa5]/g, '')"
								type="password" placeholder="请确认新密码" autocomplete="off">
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
	src="${pageContext.request.contextPath }/js/changePwd.js"></script>

</html>