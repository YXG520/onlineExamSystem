package com.bjsxt.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.bjsxt.mapper.HTUsersMapper;
import com.bjsxt.pojo.Users;
import com.bjsxt.service.HTUsersService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Service
public class HTUsersServiceImpl implements HTUsersService{
@Resource
private HTUsersMapper hTUsersMapper;

	@Override
	public int insRegister(Users users) {
		return hTUsersMapper.insUsers(users);
	}
	@Override
	public Users login(Users users) {
		return hTUsersMapper.selUsers(users);
	}
	@Override
	public String selUsersPhotos(String username) {
		String photoname=hTUsersMapper.selPhotos(username);
		return photoname;
	}
	
	@Override
	public int updateUsers(Users users) {
		int i=hTUsersMapper.updUsers(users);
		return i;
	}
	@Override
	public Users selMail(String mail) {
		Users users=hTUsersMapper.selMail(mail);
		return users;
	}
	@Override
	public Users selUsername(String username) {
		Users users=hTUsersMapper.selUsername(username);
		return users;
	}
	//查询所有用户，使用github分页插件进行分页
	@Override
	public PageInfo<Users> selectAll(int pn, int pageSize,Users users) {
		 PageHelper.startPage(pn,pageSize);   
		 //startPage后紧跟的这个查询就是分页查询      
		 List<Users> userlist =hTUsersMapper.findByUsers(users);        
		 //使用PageInfo包装查询结果，只需要将pageInfo交给页面就可以        
		 PageInfo <Users> pageInfo = new PageInfo<Users>(userlist);        
		 //pageINfo封装了分页的详细信息，也可以指定连续显示的页数

		return pageInfo;
	}
	//按照关键字和权限查询相关的用户,并且用github插件进行分页
		@Override
		public PageInfo<Users> findByRootUser(int pn, int pageSize,Users users) {
			 PageHelper.startPage(pn,pageSize);   
			 //startPage后紧跟的这个查询就是分页查询      
			 List<Users> userlist =hTUsersMapper.findByRootUser(users);        
			 //使用PageInfo包装查询结果，只需要将pageInfo交给页面就可以        
			 PageInfo <Users> pageInfo = new PageInfo<Users>(userlist);        
			 //pageINfo封装了分页的详细信息，也可以指定连续显示的页数

			return pageInfo;
		}
	//删除用户
	@Override
	public void delete(int id) {
		 hTUsersMapper.deleteUsers(id);
		
	}
	//更新用户权限
	@Override
	public void updateRoot(Users users) {
		 hTUsersMapper.updateUsersRoot(users);
		
	}
	@Override
	public void insertExcelUsers(List<Users> list) {
		 hTUsersMapper.insertExcelUsers(list);
	}
	@Override
	public void deleteAllUsers() {
		hTUsersMapper.deleteAllUsers();
		
	}
	
	

}
