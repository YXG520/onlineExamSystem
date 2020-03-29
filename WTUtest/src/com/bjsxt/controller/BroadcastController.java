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

import com.bjsxt.pojo.Broadcast;
import com.bjsxt.pojo.Comment;
import com.bjsxt.pojo.MisQuestion;
import com.bjsxt.service.BroadcastService;
import com.bjsxt.service.CommentService;

@Controller
public class BroadcastController {
@Resource
private BroadcastService broadcastService;

/* 
 *   插入一条公告
 *   
 */
	@RequestMapping("/broadcast/insBroadcast")
	public String insComment(Broadcast broadcast) {
		broadcastService.insertBroadcast(broadcast);;	
		return "/view/adminjsp/new-announcement";
	}
	@RequestMapping("/broadcast/deleteBroadcast")
	public String deleteComment(Broadcast broadcast) {
		broadcastService.deleteBroadcast(broadcast);	
		return "newPost";
	}
	
	@RequestMapping("/broadcast/selBroadcast")
	@ResponseBody
	public List<Broadcast> selComment(Model model) {
		List<Broadcast> list=	broadcastService.selBroadcast();
		model.addAttribute("list",list);
		return list;							
	}
}
