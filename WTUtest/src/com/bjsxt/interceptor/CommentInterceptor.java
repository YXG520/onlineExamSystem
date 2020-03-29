package com.bjsxt.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.bjsxt.pojo.Comment;
import com.bjsxt.pojo.Users;

import sun.print.resources.serviceui;

public class CommentInterceptor implements HandlerInterceptor{
	//在进入控制器之前执行
	//如果返回值为 false,阻止进入控制器
	//控制代码
	@Override
	public boolean preHandle(HttpServletRequest arg0,
	HttpServletResponse arg1, Object handler) throws Exception
	{
		Users admin_user=(Users) arg0.getSession().getAttribute("admin_user");

		Users u=(Users) arg0.getSession().getAttribute("user");
		 if(u==null&&admin_user==null) {
		 arg1.sendRedirect(arg0.getContextPath()+"/index.jsp");
		 return false;
		}else {
			
			String content=arg0.getParameter("content");
			if(content!=null) {
				if(content.contains("操你妈")){
					 content=content.replace("操你妈", "**");
					 System.out.println("替换字符："+content);
				}
				 if(content.contains("垃圾")){
					 content=content.replace("垃圾", "**");
					 System.out.println("替换字符："+content);
				}if(content.contains("妈逼")){
					 content=content.replace("妈逼", "**");
					 System.out.println("替换字符："+content);
				}if(content.contains("狗逼")){
					 content=content.replace("狗逼", "**");
					 System.out.println("替换字符："+content);
				}
				if(content.contains("他妈")){
					 content=content.replace("他妈", "**");
				}
				arg0.setAttribute("content", content);
			}
			
	
			 return true;
		}
			// 有一个登陆登录成功就不拦截
	    
	}
	//控制器执行完成,进入到 jsp 之前执行.
	//日志记录.
	//敏感词语过滤
	@Override
	public void postHandle(HttpServletRequest arg0,
	HttpServletResponse arg1, Object arg2, ModelAndView arg3)
	throws Exception {
	
	}
	//jsp 执行完成后执行
	//记录执行过程中出现的异常.
	//可以把异常记录到日志中
	@Override
	public void afterCompletion(HttpServletRequest arg0,
	HttpServletResponse arg1, Object arg2, Exception arg3)
	throws Exception {
		

	}
	
	}

