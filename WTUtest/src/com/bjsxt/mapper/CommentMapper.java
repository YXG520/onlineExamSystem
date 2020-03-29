package com.bjsxt.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;

import com.bjsxt.pojo.Comment;

public interface CommentMapper {
void insertComment(Comment comment);
void deleteComment(Comment comment);
void updateComment(Comment comment);
List<Comment> selComment();
}
