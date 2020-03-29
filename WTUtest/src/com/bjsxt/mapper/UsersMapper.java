package com.bjsxt.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import com.bjsxt.pojo.PageInfo;
import com.bjsxt.pojo.Users;

public interface UsersMapper {
	@Select("select * from users where (username= #{username} or mail=#{username} )  and password=#{password}")
    Users selUsers(Users users);
	
	@Insert("insert into users values(default,#{mail},#{username},#{password},#{photo},1)")
    int insUsers(Users users);
	
	@Select("select photo from users where username= #{username} or mail= #{username}")
    String selPhotos(String username);
	
	@Select("select mail,username,password from users where  mail= #{mail}")
    Users selMail(String mail);
	
	@Select("select mail,username,password  from users where  username= #{username}")
    Users selUsername(String username);
	
	@Update("update users set password=#{password} where username= #{username} or mail=#{username}")
	int updUsers(Users users);
	
}
