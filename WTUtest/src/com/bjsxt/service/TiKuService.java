package com.bjsxt.service;


import java.util.List;
import com.github.pagehelper.PageInfo;

import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Component;

import com.bjsxt.pojo.TiKu;
import com.bjsxt.pojo.Users;
@Component
public interface TiKuService {
	//PageInfo selByPdSubjectCode(String SubjectCode,int pageNumber,int pageSize);
	List<TiKu> selAllByPdSubjectCode(String SubjectCode);
	List<TiKu> selRandomPdBySubjectCode(String SubjectCode);
    List<TiKu> selRandomDd15BySubjectCode(String SubjectCode);
	List<TiKu> selRandomDx60BySubjectCode(String SubjectCode);
	List<TiKu> selAllPdBySubjectCode(String SubjectCode);
	List<TiKu> selAllDdBySubjectCode(String SubjectCode);
	List<TiKu> selAllDxBySubjectCode(String SubjectCode);
	//给用户的题目搜索
	List<TiKu> selTiMu(TiKu tiKu);
	//后台管理员的题目搜索
	PageInfo<TiKu> selTiMuInHT(Integer pn, Integer pageSize, TiKu tiKu);
	//按照章节和科目查询判断表中的题目
	List<TiKu> selPdByChapter(TiKu tiKu);
	//按照章节和科目查询单选表中的题目
	List<TiKu> selDxByChapter(TiKu tiKu);
	//按照章节和科目查询多选表中的题目
	List<TiKu> selDdByChapter(TiKu tiKu);
	PageInfo<TiKu> findAllHTDx(Integer pn, Integer pageSize, String SubjectCode);
	PageInfo<TiKu> findAllHTPd(Integer pn, Integer pageSize, String SubjectCode);
	PageInfo<TiKu> findAllHTDd(Integer pn, Integer pageSize, String SubjectCode);
	//删除题目
	void deleteTiMu(TiKu tiKu);
	/*
	 * 从题库中更新题目
	 * */
	void updateTiMu(TiKu tiKu);
		/*
		 * 从题库中插入题目
		 * */
	 void insertTiMu(TiKu tiKu);
	 /*
		 * 向题库中批量插入题目
		 * */
	 void insertExcelTiMu(List<TiKu> list);
	 
	 void deleteAllTiKu(String QStyleCode);
}
