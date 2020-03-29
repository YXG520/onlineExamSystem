package com.bjsxt.pojo;

public class Comment {
private int cid;
private int id;
private String content;
private String updateTime;
private String thumbUp;
private String thumbDown;
private Users users;
@Override
public String toString() {
	return "Comment [cid=" + cid + ", id=" + id + ", content=" + content + ", updateTime=" + updateTime + ", thumbUp="
			+ thumbUp + ", thumbDown=" + thumbDown + ", users=" + users + "]";
}
public Users getUsers() {
	return users;
}
public void setUsers(Users users) {
	this.users = users;
}
public int getCid() {
	return cid;
}
public void setCid(int cid) {
	this.cid = cid;
}
public int getId() {
	return id;
}
public void setId(int id) {
	this.id = id;
}
public String getContent() {
	return content;
}
public void setContent(String content) {
	this.content = content;
}
public String getUpdateTime() {
	return updateTime;
}
public void setUpdateTime(String updateTime) {
	this.updateTime = updateTime;
}
public String getThumbUp() {
	return thumbUp;
}
public void setThumbUp(String thumbUp) {
	this.thumbUp = thumbUp;
}
public String getThumbDown() {
	return thumbDown;
}
public void setThumbDown(String thumbDown) {
	this.thumbDown = thumbDown;
}
}
