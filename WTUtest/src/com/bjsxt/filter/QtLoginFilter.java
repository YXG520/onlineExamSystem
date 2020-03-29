package com.bjsxt.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.bjsxt.pojo.Users;

public class QtLoginFilter implements Filter {

	@Override
	public void doFilter(ServletRequest arg0, ServletResponse arg1, FilterChain arg2)
			throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest)arg0;
		request.setCharacterEncoding("utf-8");
		HttpServletResponse response = (HttpServletResponse)arg1;
		response.setContentType("text/html; charset=UTF-8");
		HttpSession session = request.getSession();
		Users  user=(Users) session.getAttribute("user");
		if(user==null){
			// 没有登录
			request.setAttribute("error","请先登录账号");	
			request.getRequestDispatcher("/index.jsp").forward(request, response);
		}else{
 			// 已经登录，继续请求下一级资源（继续访问）
			arg2.doFilter(arg0, arg1);
		}
		
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}
	}