package com.bjsxt.service;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Update;

import com.bjsxt.pojo.Comment;

public interface CommentService {
List<Comment> selComment();
void  updateComment(Comment comment);
void deleteComment(Comment comment);
void insertComment(Comment comment);

}
