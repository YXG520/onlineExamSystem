package com.bjsxt.pojo;

public class Broadcast {
private int broadcastId;
private String theme;
private String content;
private String updateTime;
public int getBroadcastId() {
	return broadcastId;
}
public void setBroadcastId(int broadcastId) {
	this.broadcastId = broadcastId;
}
public String getTheme() {
	return theme;
}
public void setTheme(String theme) {
	this.theme = theme;
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
@Override
public String toString() {
	return "Broadcast [broadcastId=" + broadcastId + ", theme=" + theme + ", content=" + content + ", updateTime="
			+ updateTime + "]";
}
}
