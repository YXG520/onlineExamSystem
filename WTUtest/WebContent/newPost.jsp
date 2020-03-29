<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/logo.ico"/>
<title>新闻公告&评论</title>
<link href="${pageContext.request.contextPath}/css/reset.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/newPost.css"
	rel="stylesheet">
<script type="text/javascript"
	src="${pageContext.request.contextPath }/js/my.js"></script>
<script src="https://cdn.staticfile.org/vue/2.2.2/vue.min.js"></script>
<script src="https://cdn.staticfile.org/axios/0.18.0/axios.min.js"></script>
<script
	src="https://cdn.staticfile.org/vue-resource/1.5.1/vue-resource.min.js"></script>

</head>

<body
	style="background: url(${pageContext.request.contextPath }/images/board3.jpg);">
	<div id="board">

		<!-- 留言框 -->
		<div id="message">
			<div class="headertip">
				<span>留言</span>
			</div>
			<form action="${pageContext.request.contextPath }/comment/insComment"
				onsubmit="return vm.getCommentTime()" method="post">

				<input type="hidden" name="updateTime" ref="specificTime"
					id="specificTime" /> <input type="hidden" name="id"
					value="${user.id }" id="userId" />
				<textarea class="inputMessage" name="content"
					style="resize: none; height: 100px; width: 874px;"
					placeholder="请输入留言内容"></textarea>
				<div class="btns">

					<button type="submit">确定</button>
					<button type="reset">取消</button>
					<input type="button" @click="targetPage" value="首页"> <input
						type="button" @click="targetPage" value="上一页"> <input
						type="button" @click="targetPage" value="下一页"> <input
						type="button" @click="targetPage" value="尾页"> <span>共计{{commentInfo.length}}条评论，当前所在词条{{parseInt(start)+1}}-{{parseInt(end)+1}},当前页码：{{pageNumber}}</span>

				</div>
			</form>

			<ul>

				<li v-for="(item,index) in commentInfo"
					v-show="index>=start && index<=end">
					<!-- 用户的头像以及用户名 -->
					<div class="userinformation">
						<img :src="userImg[index]" :index="index" class="userImg">
						<div class="userName">{{item.users.username}}</div>

					</div> <!-- 留言内容 -->
					<div class="userMsg">
						<span>{{item.content}}</span>
					</div> <!-- 时间  点赞  踩 -->
					<div class="express">
						<span>{{item.updateTime}}</span>
						<div class="upAndDown">
							<%-- 							<img src="" class="upDownImg"/> --%>
							<%-- <img src="${pageContext.request.contextPath }/images/thumbUpDown/down.png" class="upDownImg"/> --%>
							<a @click="updateUpComment"
								style="background:url(${pageContext.request.contextPath }/images/thumbUpDown/up1.png)no-repeat;;background-size:20px 20px;"
								:href="thumbUpUrl" :index="index"></a>
							{{item.thumbUp==null?item.thumbUp=0:item.thumbUp}} <a
								@click="updateDownComment"
								style="background:url(${pageContext.request.contextPath }/images/thumbUpDown/down1.png)no-repeat;background-size:20px 20px;"
								:href="thumbDownUrl" :index="index"></a>
							{{item.thumbDown==null?item.thumbDown=0:item.thumbDown}} <a
								class="rootDelete" @click="deleteComment"
								:href="deleteCommentUrl" :index="index"
								v-if="${user.root>2}||${admin_user.root>2}">删除</a>
						</div>

					</div>
				</li>



			</ul>

		</div>
		<!-- 公告栏 -->
		<div id="bulletin">
			<div class="notices">
				<div class="headertip">
					<span>公告</span> <input type="button" @click="targeNewstPage"
						value="首页"> <input type="button" @click="targeNewstPage"
						value="上一页"> <input type="button" @click="targeNewstPage"
						value="下一页"> <input type="button" @click="targeNewstPage"
						value="尾页">

				</div>
				<!-- 公告的内容 v-for -->
				<ul>
					<span>共计{{broadcastInfo.length}}条评论，当前所在词条{{parseInt(broadcastStart)+1}}-{{parseInt(broadcastEnd)+1}},当前页码：{{pageNumber}}</span>

					<li v-for="(todo,index) in broadcastInfo"
						v-show="index>=broadcastStart&& index<=broadcastEnd">
						<h3>
							<a>{{todo.theme}}</a>
						</h3>
						<div class="details">
							<div class="info">{{todo.content}}</div>
							<p>
								{{todo.updateTime}} <a style="float: right;" class="rootDelete"
									@click="deleteBroadcast" :href="deleteBroadcastUrl"
									:index="index" v-if="${user.root>2}||${admin_user.root>2}">删除</a>
							</p>
						</div>
					</li>

				</ul>
			</div>
		</div>

	</div>
	<footer>
	<div class="copyright">© 2020 imooc.com 京ICP备 12003892号-11
		京公网安备11010802030151号 营业执照</div>
	</footer>
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/js/commonUtils.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath }/js/newPost.js"></script>

</body>

<script src="${pageContext.request.contextPath }/js/vue.js"
	type="text/javascript" charset="utf-8"></script>


</html>
