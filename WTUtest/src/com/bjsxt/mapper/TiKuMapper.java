package com.bjsxt.mapper;

import java.util.List;

import org.apache.ibatis.annotations.CacheNamespace;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.bjsxt.pojo.TiKu;
import com.bjsxt.pojo.Users;
//@CacheNamespace(flushInterval = 60000,size = 512,readWrite = false)
public interface TiKuMapper {
	//用JQ方法下的查询
	@Select("select QID,Topic,Result,Difficulty,QStyleCode,Chapter from pd where SubjectCode=#{param1} limit #{param2},#{param3}")
	List<TiKu> selBySubjectCode(String SubjectCode,int pageStart,int pageSize);
	@Select("select count(*) from pd where SubjectCode=#{SubjectCode}")
	long selCount(String SubjectCode);
	//对于平常的训练页面,此次我把后台的题目展示和前台的训练界面利用动态sql集合起来
	
	//@Select("select * from pd  where SubjectCode=#{SubjectCode}"),使用动态SQL测试
	List<TiKu> selAllPdBySubjectCode(@Param("SubjectCode")String SubjectCode);
	//@Select("select * from dd  where SubjectCode=#{SubjectCode}")
	List<TiKu> selAllDdBySubjectCode(@Param("SubjectCode")String SubjectCode);
	//@Select("select * from dx  where SubjectCode=#{SubjectCode}")
	List<TiKu> selAllDxBySubjectCode(@Param("SubjectCode")String SubjectCode);
	//对于模拟考试的页面
	@Select("select distinct DISTINCTROW* from pd where SubjectCode=#{param1}  order by rand() limit 25 ")
	List<TiKu> selRandomPd25BySubjectCode(String SubjectCode);
	@Select("select distinct DISTINCTROW* from dd where SubjectCode=#{param1}  order by rand() limit 15 ")
	List<TiKu> selRandomDd15BySubjectCode(String SubjectCode);
	@Select("select distinct DISTINCTROW* from dx where SubjectCode=#{param1}  order by rand() limit 60 ")
	List<TiKu> selRandomDx60BySubjectCode(String SubjectCode);
	 //前台搜索题目页面, , ,${QStyleCode}，采用了动态sql进行编写并且整合了
	@Select("select * from ${QStyleCode} where SubjectCode='${SubjectCode}' and Topic  like '%${Topic}%'")
	List<TiKu> selTiMu(TiKu tiKu);
	//后台的题目搜索、题目查询一体化
	List<TiKu> selTiMuInHT(TiKu tiKu);
	
	//按照章节和科目查询所有判断表中的题目
	@Select("select * from pd where SubjectCode='${SubjectCode}' and Chapter='${Chapter}'")
	List<TiKu> selPdByChapter(TiKu tiKu);
	//按照章节和科目查询单选表中所有的题目
	@Select("select * from dx where SubjectCode='${SubjectCode}' and Chapter='${Chapter}'")
	List<TiKu> selDxByChapter(TiKu tiKu);
	//按照章节和科目查询多选表中的所有题目
	@Select("select * from dd where SubjectCode='${SubjectCode}' and Chapter='${Chapter}'")
	List<TiKu> selDdByChapter(TiKu tiKu);
	
	/*
	 * 下面是指管理有毛病的题目（即被用户投诉上交的题目）
	 * */
	List<TiKu> manageBadQ(TiKu tiKu);
	/*
	 * 从题库中删除题目
	 * */
	void deleteTiMu(TiKu tiKu);
	/*
	 * 从题库中更新题目
	 * */
     //@Update("update ${QStyleCode} set SubjectCode=${subjectCode},Topic=${Topic},OptionList=${OptionList},Result=${Result},Chapter=${Chapter},Difficulty=${Difficulty},updateTime=${updateTime} where QID=${QID}")
	void updateTiMu(TiKu tiKu);
	/*
	 * 往题库中增加题目
	 * */
    void insertTiMu(TiKu tiKu);
    /*
	 * 导入excel表格并且往题库中批量增加题目
	 * */
    void insertExcelTiMu(List<TiKu> list);
    //删除所有题库
    @Delete("delete from ${QStyleCode}")
	void deleteAllTiKu(@Param(value="QStyleCode") String QStyleCode);
	
}
