package com.bjsxt.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;

import com.bjsxt.pojo.Broadcast;
import com.bjsxt.pojo.Comment;

public interface BroadcastMapper {
void insertBroadcast(Broadcast broadcast);
void deleteBroadcast(Broadcast broadcast);
List<Broadcast> selBroadcast();
}
