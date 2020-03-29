package com.bjsxt.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bjsxt.pojo.Comment;
import com.bjsxt.pojo.MisQuestion;
import com.bjsxt.service.CommentService;

@Controller
public class CommentController {
@Resource
private CommentService commentServiceImpl;

/* 
 *   插入一条用户评论
 *   
 */
	@RequestMapping("/comment/insComment")
	public String insComment(Comment comment,HttpServletRequest req) {
	  //使用过滤后的content替换掉用户的
		comment.setContent(req.getAttribute("content").toString());
		commentServiceImpl.insertComment(comment);	
		return "redirect:/newPost.jsp";
	}
	@RequestMapping("/comment/updateComment")
	public String updateComment(Comment comment) {
		commentServiceImpl.updateComment(comment);
		return "redirect:/newPost.jsp";
	}
	@RequestMapping("/comment/deleteComment")
	public String deleteComment(Comment comment) {
		commentServiceImpl.deleteComment(comment);	
		return "redirect:/newPost.jsp";
	}
	
	@RequestMapping("/comment/selComment")
	@ResponseBody
	public List<Comment> selComment(Model model) {
		List<Comment> list=	commentServiceImpl.selComment();
		model.addAttribute("list",list);
		return list;							
	}
}
