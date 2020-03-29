package com.bjsxt.pojo;

public class TiKu {
private int QID;
private String SubjectCode;
private String QStyleCode;
private String Topic;
private String Result;
private String Difficulty;
private String Chapter;
private String UpdateTime;
private String OptionList;
private IncorrectRecord incorrectRecord;
private String Comment;
public String getComment() {
	return Comment;
}
public void setComment(String comment) {
	Comment = comment;
}
public IncorrectRecord getIncorrectRecord() {
	return incorrectRecord;
}
public void setIncorrectRecord(IncorrectRecord incorrectRecord) {
	this.incorrectRecord = incorrectRecord;
}
private MisQuestion misQuestion;
public MisQuestion getMisQuestion() {
	return misQuestion;
}
public void setMisQuestion(MisQuestion misQuestion) {
	this.misQuestion = misQuestion;
}
public String getOptionList() {
	return OptionList;
}
public void setOptionList(String optionList) {
	OptionList = optionList;
}
public int getQID() {
	return QID;
}
public void setQID(int qID) {
	QID = qID;
}
public String getSubjectCode() {
	return SubjectCode;
}
public void setSubjectCode(String subjectCode) {
	SubjectCode = subjectCode;
}
public String getQStyleCode() {
	return QStyleCode;
}
public void setQStyleCode(String qStyleCode) {
	QStyleCode = qStyleCode;
}
public String getTopic() {
	return Topic;
}
public void setTopic(String topic) {
	Topic = topic;
}
public String getResult() {
	return Result;
}
public void setResult(String result) {
	Result = result;
}
public String getDifficulty() {
	return Difficulty;
}
public void setDifficulty(String difficulty) {
	Difficulty = difficulty;
}
public String getChapter() {
	return Chapter;
}
public void setChapter(String chapter) {
	Chapter = chapter;
}
public String getUpdateTime() {
	return UpdateTime;
}
public void setUpdateTime(String updateTime) {
	UpdateTime = updateTime;
}
}
