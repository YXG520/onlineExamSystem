package com.bjsxt.mapper;


import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import com.bjsxt.pojo.IncorrectRecord;
import com.bjsxt.pojo.MisQuestion;
import com.bjsxt.pojo.TiKu;

/*
 * 用户答错的题目和本身有毛病的题目的挑选和插入放到一个mapper中
 * */
public interface CuoTiMapper {
	   //插入错题,打算用mysql存储过程来替换下面的sql语句  实现频率更新
	/*
	CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_IncorrectRecord`(IN p_testType char(2),IN p_qid int,IN p_id int,IN p_updateTime varchar(20))
BEGIN
declare v_frequency int;
declare v_recordId int;
		set v_recordId=(select recordId FROM incorrectrecord where testType=p_testType and  QID=p_qid and id=p_id);
		set v_frequency=(select frequency FROM incorrectrecord where testType=p_testType and  QID=p_qid and id=p_id);
   if v_recordId is null or v_frequency is null then
       insert into incorrectrecord (id,testType,QID,updateTime,frequency) values(p_id,p_testType,p_qid,p_updateTime,1);  	  
	 elseif v_recordId is not null and v_frequency is not null then
			 set v_frequency=v_frequency+1;
	     UPDATE incorrectrecord set updateTime=p_updateTime , frequency=v_frequency where recordId=v_recordId;
	 end if;
END
	 * */
	   //@Insert("insert into incorrectrecord values(default,#{id},#{testType},#{QID},#{updateTime})")
       int insertCuoTi(IncorrectRecord incorrectRecord); 
	  //查询错题界面
	   //先根据用户的id在incorrectrecord记录表中查出错题的题号，错题所在表名等信息
		@Select("select * from incorrectrecord where id=#{param1} order by updateTime desc")
		List<IncorrectRecord> selUserIdInRecord(int id);
		// 再根据上面的查询的题号和表名结果，查询相关的题库表 导出确切的表信息
		@Select("select * from ${QStyleCode} where QID=${QID}")
		TiKu  selWrongRecordById(TiKu tiKu);
		//有毛病的题目统一调用存储过程插入，方便统计次数,下面是mysql存储过程代码
		/*CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_MisQuestion`(IN p_testType char(2),IN p_qid int,IN p_updateTime varchar(20))
				BEGIN
					#Routine body goes here...
					 declare v_qid int;
					 declare v_mid int;
				   declare v_testType CHAR(2);
					 declare v_frequency int;

						set v_mid=(select mid FROM misquestion where testType=p_testType and  QID=p_qid);
						set v_frequency=(select frequency FROM misquestion where testType=p_testType and  QID=p_qid);
						select v_frequency,v_mid;
						
				   if v_mid is null || v_frequency is null then
				       insert into misquestion (testType,QID,updateTime,frequency) values(p_testType,p_qid,p_updateTime,1);  	  
					 elseif v_mid is not null || v_frequency is not null then
							 set v_frequency=v_frequency+1;
					     UPDATE misquestion set updateTime=p_updateTime , frequency=v_frequency where mid=v_mid;
					 end if;
				END
		*/
		void ins_MisQuestion(MisQuestion misQuestion);
		//查询所有在misquestion表中的毛病题的QID和testType
		@Select("select * from misquestion")
		List<MisQuestion> selInMaoBingRecord();
		@Delete("delete from misquestion where mid=#{mid}")
		void deleteMaoBin(int mid);	
	    List<MisQuestion>   SelectMisquestionRecord();
}
