<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh-CN">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="${pageContext.request.contextPath}/css/reset.css"
	rel="stylesheet">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/css/index/header.css" />
<script type="text/javascript">
	// 创建一个Socket实例
	//参数为URL，ws表示WebSocket协议。onopen、onclose和onmessage方法把事件连接到Socket实例上。每个方法都提供了一个事件，以表示Socket的状态。
	var websocket;
	//不同浏览器的WebSocket对象类型不同
	
	var host = window.location.host;
	if ('WebSocket' in window) {
		// alert("您的浏览器支持 WebSocket!");
		websocket = new WebSocket("ws://" + host + "/website/websocket/socketServer");
		console.log("=============WebSocket");
		//火狐
	} else if ('MozWebSocket' in window) {
		websocket = new MozWebSocket("ws://" + host + "/website/websocket/socketServer");
		console.log("=============MozWebSocket");
	} else {
		websocket = new SockJS("http://" + host + "/website/sockjs/socketServer");
		console.log("=============SockJS");
	}
	console.log("ws://" + host + "/website/websocket/socketServer");
	//打开Socket,
	websocket.onopen = function(event) {
		console.log("WebSocket:已连接");
	}

	websocket.onmessage = function(evt) {
		console.log('Client received a message', event);
		//var data=JSON.parse(event.data);
		var data = event.data;
		console.log("WebSocket:收到一条消息", data);
		//判断是否是欢迎消息（没用户编号的就是欢迎消息）
		if (data.from == undefined || data.from == null || data.from == "") {
			//===系统消息
			$('#count').text(data);
		}
	}
	websocket.onclose = function() {
		// 关闭 websocket
		// alert("websocket连接已关闭${pageContext.request.contextPath}."); 
	}
	
	websocket.onerror = function(event) {
	};
</script>

</head>

<body>
	<header>
	<div class="nav">
		<div id="logo">
			<img style="width: 20px; height: 20px;"
				src="${pageContext.request.contextPath }/images/logo.png" />WTU刷题网
		</div>
		<div class="login_regest nav_float">
			<c:if test="${user!=null&&user!=''}">
				<div class="already_login">
					<img class="userImg"
						src="${pageContext.request.contextPath }/user/exportPic" /> |<span
						class="userSpan">用户：${user.username}</span>| <span
						class="userSpan">练习科目：${user.subjectCode}</span>| <a
						href="${pageContext.request.contextPath }/view/qtjsp/changePwd.jsp" target="_blank"><span
						class="userSpan">修改密码?</span></a>| <a
						href="${pageContext.request.contextPath }/user/clearUser"><span
						class="userSpan">安全退出</span></a>
				</div>
			</c:if>
			<c:if test="${user==null||user==''}">
				<div class="non_login">
					<a v-on:click="gologin()" class="thefont">
						<div class="account_btn">登录</div>
					</a> <a href="regist.jsp" class="thefont" target="view_window"><div
							class="account_btn">注册</div></a>
				</div>
			</c:if>
		</div>
		<div class="nav_content">
			<ul class="thefont nav_ul">
				<li><a href="${pageContext.request.contextPath }/index.jsp"
					class="thefont">首页</a></li>
				<li><a href="javascript:;" @click="goToDetail('component')">刷题实战</a></li>
				<li><a href="${pageContext.request.contextPath }/newPost.jsp"
					target="view_window" class="thefont">新闻公告&用户评论</a></li>
				<li><a href="javascript:;" @click="goToDetail('bottomFooter')"
					class="thefont">关于我们</a></li>
				<li><a
					href="${pageContext.request.contextPath }/adminlogin.jsp"
					target="view_window" class="thefont">后台管理</a></li>
			</ul>
		</div>
	</div>
	</header>
</body>

</html>