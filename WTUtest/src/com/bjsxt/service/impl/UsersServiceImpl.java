package com.bjsxt.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import com.bjsxt.mapper.TiKuMapper;
import com.bjsxt.mapper.UsersMapper;
import com.bjsxt.pojo.PageInfo;
import com.bjsxt.pojo.Users;
import com.bjsxt.service.UsersService;

@Service
public class UsersServiceImpl implements UsersService{
@Resource
private UsersMapper usersMapper;

	@Override
	public int insRegister(Users users) {
		return usersMapper.insUsers(users);
	}
	@Override
	public Users login(Users users) {
		return usersMapper.selUsers(users);
	}
	@Override
	public String selUsersPhotos(String username) {
		String photoname=usersMapper.selPhotos(username);
		return photoname;
	}
	
	@Override
	public int updateUsers(Users users) {
		int i=usersMapper.updUsers(users);
		return i;
	}
	@Override
	public Users selMail(String mail) {
		Users users=usersMapper.selMail(mail);
		return users;
	}
	@Override
	public Users selUsername(String username) {
		Users users=usersMapper.selUsername(username);
		return users;
	}
	

}
