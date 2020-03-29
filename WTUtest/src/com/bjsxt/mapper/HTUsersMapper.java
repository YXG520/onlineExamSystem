package com.bjsxt.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import com.bjsxt.pojo.Users;

public interface HTUsersMapper {
	@Select("select * from users where (username= #{username} or mail=#{username} )  and password=#{password}")
    Users selUsers(Users users);
	
	@Insert("insert into users values(default,#{mail},#{username},#{password},#{photo},0)")
    int insUsers(Users users);
	
	@Select("select photo from users where username= #{username} or mail= #{username}")
    String selPhotos(String username);
	
	@Select("select mail,username,password from users where  mail= #{mail}")
    Users selMail(String mail);
	
	@Select("select mail,username,password  from users where  username= #{username}")
    Users selUsername(String username);
	
	@Update("update users set password=#{password} where username= #{username} or mail=#{username}")
	int updUsers(Users users);
	//在后台显示全部用户，包括会员、管理员和超管
//    @Select("<script> select * from users <where> <if test=\" root != 0  \">and root= #{root}</if><if test=\" username != null and username !=''\">and username like \"%\"#{username}\"%\"</if></where><script>\r\n")
	 @Select("select * from users")
	 List<Users> findByUsers(Users users);
	 //实现模糊查询
	 //@Select("select * from users where ( mail  like '%${username}%' or username  like '%${username}%')  and root=${root}")
		 List<Users> findByRootUser(Users users);
	 
	//删除用户
//	@Delete("delete from  users where id =#{id}")
	void deleteUsers(int id);
	//更新用户权限
	@Update("update users set root=#{root} where id =#{id}")
	void updateUsersRoot(Users users);
	//导入excel表格实现用户的批量导入
	void insertExcelUsers(List<Users> list);
	//实现一键删除所有用户权限为1的用户
	@Delete("delete from users where root=1")
	void deleteAllUsers();
}
