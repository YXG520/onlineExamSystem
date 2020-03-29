package com.bjsxt.pojo;

public class IncorrectRecord {
private int recordId;//IncorrectRecord表的属性
private int id;//IncorrectRecord表的属性
private String testType;//IncorrectRecord表和misquestion表共有的属性
private int QID;//IncorrectRecord表和misquestion表共有的属性
private String updateTime;//IncorrectRecord表和misquestion表共有的属性
private int frequency;//misquestion表的属性
private int mid;//misquestion表的属性
public int getFrequency() {
	return frequency;
}
public void setFrequency(int frequency) {
	this.frequency = frequency;
}
public int getMid() {
	return mid;
}
public void setMid(int mid) {
	this.mid = mid;
}
public String getTestType() {
	return testType;
}
public void setTestType(String testType) {
	this.testType = testType;
}
public String getUpdateTime() {
	return updateTime;
}
public void setUpdateTime(String updateTime) {
	this.updateTime = updateTime;
}
public int getRecordId() {
	return recordId;
}
public void setRecordId(int recordId) {
	this.recordId = recordId;
}
public int getId() {
	return id;
}
public void setId(int id) {
	this.id = id;
}

public int getQID () {
	return QID;
}
public void setQID (int QID ) {
	this.QID = QID ;
}
}
