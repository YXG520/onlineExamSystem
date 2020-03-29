package com.bjsxt.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.bjsxt.mapper.CuoTiMapper;
import com.bjsxt.pojo.IncorrectRecord;
import com.bjsxt.pojo.MisQuestion;
import com.bjsxt.pojo.TiKu;
import com.bjsxt.service.CuoTiService;
@Service
public class CuoTiServiceImpl implements CuoTiService{
	@Resource
	private	CuoTiMapper cuoTiMapper;
	@Override
	public int insertCuoTi(IncorrectRecord incorrectRecord) {
		int i=cuoTiMapper.insertCuoTi(incorrectRecord);
		return i;
	}
	@Override
	public List<IncorrectRecord> selUserIdInRecord(int id) {
		List<IncorrectRecord> list= cuoTiMapper.selUserIdInRecord(id);
		return list;
	}

	@Override
	public TiKu selWrongRecordById(TiKu tiKu) {
		TiKu inRecordS= cuoTiMapper.selWrongRecordById(tiKu);	
		return inRecordS;
	}
	@Override
	public void ins_MisQuestion(MisQuestion misQuestion) {
		cuoTiMapper.ins_MisQuestion(misQuestion);
		
	}
	
	//下面查询后台的毛病题
	@Override
	public List<MisQuestion> findFKofMaobing() {		
		List<MisQuestion> list=cuoTiMapper.selInMaoBingRecord();		
		return list;
	}
	@Override
	public void deleteMaoBin(int mid) {
		cuoTiMapper.deleteMaoBin(mid);
	}
	
	
}
