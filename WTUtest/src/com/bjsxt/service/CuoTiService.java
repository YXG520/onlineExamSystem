package com.bjsxt.service;


import java.util.List;

import org.springframework.stereotype.Component;
import com.bjsxt.pojo.IncorrectRecord;
import com.bjsxt.pojo.MisQuestion;
import com.bjsxt.pojo.TiKu;
import com.github.pagehelper.PageInfo;

@Component
public interface CuoTiService {

	int insertCuoTi(IncorrectRecord incorrectRecord);

	List<IncorrectRecord> selUserIdInRecord(int id);


	TiKu selWrongRecordById(TiKu tiKu);
	void ins_MisQuestion(MisQuestion misQuestion);

	List<MisQuestion> findFKofMaobing();

	void deleteMaoBin(int mid);

}
