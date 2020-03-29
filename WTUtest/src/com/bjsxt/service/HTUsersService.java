package com.bjsxt.service;


import java.util.List;

import org.springframework.stereotype.Component;

import com.bjsxt.pojo.Users;
import com.github.pagehelper.PageInfo;

@Component
public interface HTUsersService {
int insRegister(Users users);
Users login(Users users);
String selUsersPhotos(String username);
Users selMail(String mail);
int updateUsers(Users users);
Users selUsername(String username);
PageInfo<Users> selectAll(int pn, int pageSize,Users users);
void delete(int uid);
void updateRoot(Users user);
PageInfo<Users> findByRootUser(int pn, int pageSize,Users users);
void insertExcelUsers(List<Users> list);
void deleteAllUsers();
}
