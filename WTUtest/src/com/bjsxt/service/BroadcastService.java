package com.bjsxt.service;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Update;

import com.bjsxt.pojo.Broadcast;
import com.bjsxt.pojo.Comment;

public interface BroadcastService {
	void insertBroadcast(Broadcast broadcast);
	void deleteBroadcast(Broadcast broadcast);
	List<Broadcast> selBroadcast();

}
