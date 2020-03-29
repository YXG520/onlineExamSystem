package com.bjsxt.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.bjsxt.pojo.Users;

public class DemoInterceptor implements HandlerInterceptor{
	//在进入控制器之前执行
	//如果返回值为 false,阻止进入控制器
	//控制代码
	@Override
	public boolean preHandle(HttpServletRequest arg0,
	HttpServletResponse arg1, Object arg2) throws Exception
	{
		Users u=(Users) arg0.getSession().getAttribute("user");
		 if(u==null) {

		 arg1.sendRedirect(arg0.getContextPath()+"/index.jsp");

		 return false;

		}else
			// 登录成功不拦截
	     return true;
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

