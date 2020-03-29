package com.bjsxt.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.bjsxt.mapper.BroadcastMapper;
import com.bjsxt.mapper.CommentMapper;
import com.bjsxt.pojo.Broadcast;
import com.bjsxt.pojo.Comment;
import com.bjsxt.service.BroadcastService;
import com.bjsxt.service.CommentService;
@Service
public class BroadcastServiceImpl implements BroadcastService{
@Resource
private BroadcastMapper broadcastMapper;

@Override
public void insertBroadcast(Broadcast broadcast) {
	broadcastMapper.insertBroadcast(broadcast);
	
}

@Override
public void deleteBroadcast(Broadcast broadcast) {
	broadcastMapper.deleteBroadcast(broadcast);
	
}

@Override
public List<Broadcast> selBroadcast() {
	List<Broadcast> list= broadcastMapper.selBroadcast();
	return list;
}
	

}
