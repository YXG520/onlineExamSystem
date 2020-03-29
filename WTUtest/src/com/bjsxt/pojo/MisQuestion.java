package com.bjsxt.pojo;

public class MisQuestion {
	private int mid;
	private int QID;
	private String testType;
	private String updateTime;
	private int frequency;
	private TiKu tiKu;
	@Override
	public String toString() {
		return "MisQuestion [mid=" + mid + ", QID=" + QID + ", testType=" + testType + ", updateTime=" + updateTime
				+ ", frequency=" + frequency + ", tiKu=" + tiKu + "]";
	}
	public TiKu getTiKu() {
		return tiKu;
	}
	public void setTiKu(TiKu tiKu) {
		this.tiKu = tiKu;
	}
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
	public int getQID() {
		return QID;
	}
	public void setQID(int qID) {
		QID = qID;
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
}
