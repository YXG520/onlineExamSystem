package com.bjsxt.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.bjsxt.mapper.CommentMapper;
import com.bjsxt.pojo.Comment;
import com.bjsxt.service.CommentService;
@Service
public class CommentServiceImpl implements CommentService{
@Resource
private CommentMapper commentMapper;
	@Override
	public void insertComment(Comment comment) {
		commentMapper.insertComment(comment);
	}

	@Override
	public List<Comment> selComment() {
		List<Comment> list=	 commentMapper.selComment();
		return list;
	}

	@Override
	public void updateComment(Comment comment) {
		commentMapper.updateComment(comment);
	}

	@Override
	public void deleteComment(Comment comment) {
		commentMapper.deleteComment(comment);
		
	}

}
