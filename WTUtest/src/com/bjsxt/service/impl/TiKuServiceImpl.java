package com.bjsxt.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.bjsxt.mapper.TiKuMapper;
import com.github.pagehelper.*;
import com.bjsxt.pojo.TiKu;
import com.bjsxt.pojo.Users;
import com.bjsxt.service.TiKuService;

@Service
public class TiKuServiceImpl implements TiKuService {
	@Resource
	private TiKuMapper tiKuMapper;
//通过jq来实现分页控制
//	@Override
//	public PageInfo selByPdSubjectCode(String SubjectCode, int pageNumber, int pageSize) {
//		PageInfo pageInfo = new PageInfo();
//		pageInfo.setPageNumber(pageNumber);
//		pageInfo.setPageSize(pageSize);
//		long count = tiKuMapper.selCount(SubjectCode);
//		System.out.println(count + "");
//		pageInfo.setTotal(count % pageSize == 0 ? count / pageSize : count / pageSize + 1);
//		List<TiKu> tiKuList = tiKuMapper.selBySubjectCode(SubjectCode, pageSize * (pageNumber - 1), pageSize);
//		pageInfo.setList(tiKuList);
//		return pageInfo;
//	}

	@Override
	public List<TiKu> selAllByPdSubjectCode(String SubjectCode) {
		List<TiKu> list = tiKuMapper.selAllPdBySubjectCode(SubjectCode);
		return list;
	}

	@Override
	public List<TiKu> selRandomPdBySubjectCode(String SubjectCode) {
		List<TiKu> list = tiKuMapper.selRandomPd25BySubjectCode(SubjectCode);
		return list;
	}

	@Override
	public List<TiKu> selRandomDd15BySubjectCode(String SubjectCode) {
		List<TiKu> list = tiKuMapper.selRandomDd15BySubjectCode(SubjectCode);
		return list;
	}
	
	@Override
	public List<TiKu> selRandomDx60BySubjectCode(String SubjectCode) {
		List<TiKu> list = tiKuMapper.selRandomDx60BySubjectCode(SubjectCode);
		return list;		
	}

	@Override
	public List<TiKu> selAllPdBySubjectCode(String SubjectCode) {
		List<TiKu> list = tiKuMapper.selAllPdBySubjectCode(SubjectCode);
		return list;		
	}

	@Override
	public List<TiKu> selAllDdBySubjectCode(String SubjectCode) {
		List<TiKu> list = tiKuMapper.selAllDdBySubjectCode(SubjectCode);
		return list;
	}

	@Override
	public List<TiKu> selAllDxBySubjectCode(String SubjectCode) {
		List<TiKu> list = tiKuMapper.selAllDxBySubjectCode(SubjectCode);
		return list;
	}

	

	@Override
	public List<TiKu> selTiMu(TiKu tiKu) {
		List<TiKu> list= tiKuMapper.selTiMu(tiKu);
		return list;
	}

	@Override
	public List<TiKu> selPdByChapter(TiKu tiKu) {
		List<TiKu> list= tiKuMapper.selPdByChapter(tiKu);
		return list;
	}

	@Override
	public List<TiKu> selDxByChapter(TiKu tiKu) {
		List<TiKu> list= tiKuMapper.selDxByChapter(tiKu);
		return list;
	}

	@Override
	public List<TiKu> selDdByChapter(TiKu tiKu) {
		List<TiKu> list= tiKuMapper.selDdByChapter(tiKu);
		return list;
	}

	@Override
	public PageInfo<TiKu> findAllHTPd(Integer pn, Integer pageSize, String SubjectCode) {
		PageHelper.startPage(pn,pageSize);   
		 //startPage后紧跟的这个查询就是分页查询      
		 List<TiKu> list =tiKuMapper.selAllPdBySubjectCode(SubjectCode);        
		 //使用PageInfo包装查询结果，只需要将pageInfo交给页面就可以        
		 PageInfo <TiKu> pageInfo = new PageInfo<TiKu>(list);        
		 //pageINfo封装了分页的详细信息，也可以指定连续显示的页数

		return pageInfo;
	}

	@Override
	public PageInfo<TiKu> findAllHTDx(Integer pn, Integer pageSize, String SubjectCode) {
		PageHelper.startPage(pn,pageSize);   
		 //startPage后紧跟的这个查询就是分页查询      
		 List<TiKu> list =tiKuMapper.selAllDxBySubjectCode(SubjectCode);        
		 //使用PageInfo包装查询结果，只需要将pageInfo交给页面就可以        
		 PageInfo <TiKu> pageInfo = new PageInfo<TiKu>(list);        
		 //pageINfo封装了分页的详细信息，也可以指定连续显示的页数

		return pageInfo;
	}

	@Override
	public PageInfo<TiKu> findAllHTDd(Integer pn, Integer pageSize,String SubjectCode) {
		PageHelper.startPage(pn,pageSize);   
		 //startPage后紧跟的这个查询就是分页查询      
		 List<TiKu> list =tiKuMapper.selAllDdBySubjectCode(SubjectCode);        
		 //使用PageInfo包装查询结果，只需要将pageInfo交给页面就可以        
		 PageInfo <TiKu> pageInfo = new PageInfo<TiKu>(list);        
		 //pageINfo封装了分页的详细信息，也可以指定连续显示的页数

		return pageInfo;
	}
/*
 * 下面四个服务是对后台题库管理的增删改查四个常规操作
 * */
	@Override
	public PageInfo<TiKu> selTiMuInHT(Integer pn, Integer pageSize,TiKu tiKu) {
		PageHelper.startPage(pn,pageSize);   
		 //startPage后紧跟的这个查询就是分页查询      
		 List<TiKu> list =tiKuMapper.selTiMuInHT(tiKu);  
		 int i=0;
		 //使用PageInfo包装查询结果，只需要将pageInfo交给页面就可以        
		 PageInfo<TiKu> pageInfo = new PageInfo<TiKu>(list);        
		 //pageINfo封装了分页的详细信息，也可以指定连续显示的页数

		return pageInfo;
	}
	@Override
	public void deleteTiMu(TiKu tiKu) {
		tiKuMapper.deleteTiMu(tiKu);
	}

	@Override
	public void updateTiMu(TiKu tiKu) {
		tiKuMapper.updateTiMu(tiKu);
	}

	@Override
	public void insertTiMu(TiKu tiKu) {
		tiKuMapper.insertTiMu(tiKu);
	}

	@Override
	public void insertExcelTiMu(List<TiKu> list) {
		tiKuMapper.insertExcelTiMu(list);
		
	}

	@Override
	public void deleteAllTiKu(String QStyleCode) {
		tiKuMapper.deleteAllTiKu(QStyleCode);
		
	}

	


}
