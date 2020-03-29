package com.bjsxt.pojo;

import java.util.List;

public class PageInfo {
	//每一页显示的行数
	private int pageSize;
	//当前第几页
	private int pageNumber;
	//总页数
	private long total;
	
	//当前页显示的数据
	private List<?> list;
	
	public PageInfo() {
		super();
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getPageNumber() {
		return pageNumber;
	}
	public void setPageNumber(int pageNumber) {
		this.pageNumber = pageNumber;
	}
	public long getTotal() {
		return total;
	}
	public void setTotal(long total) {
		this.total = total;
	}
	public List<?> getList() {
		return list;
	}
	public void setList(List<?> list) {
		this.list = list;
	}
	public PageInfo(int pageSize, int pageNumber, long total, List<?> list) {
		super();
		this.pageSize = pageSize;
		this.pageNumber = pageNumber;
		this.total = total;
		this.list = list;
	}
}
