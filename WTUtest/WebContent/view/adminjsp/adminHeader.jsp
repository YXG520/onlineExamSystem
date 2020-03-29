<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<body>
	<div class="layui-header">
		<div class="layui-logo">WTU刷题官网后台管理系统</div>
		<ul class="layui-nav layui-layout-right">
			<li class="layui-nav-item"><img
				src="${pageContext.request.contextPath }/admin_user/exportHTPic"
				class="layui-nav-img"> <span>${admin_user.username}</span></li>
			<li class="layui-nav-item" style="margin-left: 30px;"><a
				href="${pageContext.request.contextPath }/admin_user/AClear">退出</a>
			</li>
		</ul>
	</div>
	<div id="adminHeader" class="layui-side layui-bg-black">
		<div class="layui-side-scroll">
			<ul class="layui-nav layui-nav-tree">
				<li class="layui-nav-item layui-nav-itemed"><a
					href="javascript:;">用户管理</a>
					<dl class="layui-nav-child">
						<dd>
							<a
								href="${pageContext.request.contextPath }/admin_user/findByRootUser">用户列表</a>
						</dd>
						<dd>
							<a
								href="${pageContext.request.contextPath }/admin_user/findByRootUser?root=2">会员列表</a>
						</dd>
						<dd>
							<a onclick="disp_confirm(this,'${pageContext.request.contextPath }/admin_user/deleteAllUsers?root=1')"
								href="#">一键删除</a>
						</dd>
					</dl></li>
				<li class="layui-nav-item layui-nav-itemed"><a
					href="javascript:;">题库管理</a>
					<dl class="layui-nav-child">
						<dd>
							<a
								href="${pageContext.request.contextPath }/tiKu/searchTiMuInHT?QStyleCode=pd">判断题管理</a>
						</dd>
						<dd>
							<a
								href="${pageContext.request.contextPath }/tiKu/searchTiMuInHT?QStyleCode=dx">单选题管理</a>
						</dd>
						<dd>
							<a
								href="${pageContext.request.contextPath }/tiKu/searchTiMuInHT?QStyleCode=dd">多选题管理</a>
						</dd>
						
						<dd>
							<a
								href="${pageContext.request.contextPath }/view/adminjsp/lookBadTiMu.jsp">毛病题管理</a>
						</dd>
						<dd>
	
							<a
								onclick="disp_confirm(this,'${pageContext.request.contextPath }/TiKu/deleteAllTiKu')" href="#">一键删除</a>
						</dd>
					</dl></li>
				<li class="layui-nav-item layui-nav-itemed"><a
					href="javascript:;">论坛管理</a>
					<dl class="layui-nav-child">
						<dd>
							<a href="${pageContext.request.contextPath }/newPost.jsp">留言管理</a>
						</dd>

					</dl></li>

				<li class="layui-nav-item layui-nav-itemed"><a
					href="javascript:;">网站管理</a>
					<dl class="layui-nav-child">
						<dd>
							<a
								href="${pageContext.request.contextPath }/view/adminjsp/new-announcement.jsp">新增公告</a>
						</dd>
						<dd>
							<a href="${pageContext.request.contextPath }/newPost.jsp">公告管理</a>
						</dd>

					</dl></li>
			</ul>
		</div>
	</div>
</body>
<script type="text/javascript">
function disp_confirm(dom,targetHref)
{
var r=confirm("您确定要一键删除？一旦删除，数据不会恢复")
if (r==true)
  {
	dom.href=targetHref; 
	alert("删除成功");
  }

}

</script>
</html>