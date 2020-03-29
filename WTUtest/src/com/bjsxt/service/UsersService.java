package com.bjsxt.service;


import com.bjsxt.pojo.Users;

public interface UsersService {
int insRegister(Users users);
Users login(Users users);
String selUsersPhotos(String username);
Users selMail(String mail);
int updateUsers(Users users);
Users selUsername(String username);
}
