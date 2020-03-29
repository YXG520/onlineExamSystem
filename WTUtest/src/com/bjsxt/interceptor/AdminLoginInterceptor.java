package com.bjsxt.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.bjsxt.pojo.Users;

public class AdminLoginInterceptor implements HandlerInterceptor{
	//在进入控制器之前执行
	//如果返回值为 false,阻止进入控制器
	//控制代码，后台身份过期拦截器
	@Override
	public boolean preHandle(HttpServletRequest arg0,
	HttpServletResponse arg1, Object arg2) throws Exception
	{
		Users admin_user=(Users) arg0.getSession().getAttribute("admin_user");
		 if(admin_user==null) {
			// arg0.getSession().setAttribute("error1","您的身份已过期");
		 arg1.sendRedirect(arg0.getContextPath()+"/index.jsp");		 
		 return false;

		}else
			// session未过期不拦截
	     return true;
	}
		@Override
	public void postHandle(HttpServletRequest arg0,
	HttpServletResponse arg1, Object arg2, ModelAndView arg3)
	throws Exception {
	}
		@Override
	public void afterCompletion(HttpServletRequest arg0,
	HttpServletResponse arg1, Object arg2, Exception arg3)
	throws Exception {
		

	}
	
	}

