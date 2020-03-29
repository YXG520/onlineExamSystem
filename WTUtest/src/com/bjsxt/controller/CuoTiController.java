package com.bjsxt.controller;

import java.io.IOException;
import java.util.ArrayList;
//import net.sf.json.JSONArray;
//import net.sf.json.JsonConfig;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.aspectj.weaver.ast.Var;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bjsxt.pojo.IncorrectRecord;
import com.bjsxt.pojo.MisQuestion;
import com.bjsxt.pojo.TiKu;
import com.bjsxt.service.CuoTiService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mysql.fabric.xmlrpc.base.Array;
import com.sun.org.apache.bcel.internal.generic.GETFIELD;

import net.sf.json.JSON;
import net.sf.json.JSONArray;
import net.sf.json.JsonConfig;

@Controller
public class CuoTiController {
	@Resource
	private CuoTiService cuoTiServiceImpl;

	/**
	 * 查找错误记录
	 */
	@RequestMapping(value = "/cuoTi/selByUserIdInRecord")
	public String selByUserIdInRecord(int id, ModelMap modelMap) throws IOException {
		List<IncorrectRecord> list = cuoTiServiceImpl.selUserIdInRecord(id);
		modelMap.addAttribute("IncorrectRecordList", list);
		return "forward:/cuoTi/selWrongRecordById";

	}

	/**
	 * 根据错题记录中的数据查找错题的具体内容
	 */
	@RequestMapping(value = "/cuoTi/selWrongRecordById", produces = "application/json;charset=utf-8")
	@ResponseBody
	public List<TiKu> selWrongRecordById(HttpServletRequest req) throws IOException {
		List<IncorrectRecord> IncorrectRecordList = (List<IncorrectRecord>) req.getAttribute("IncorrectRecordList");
		List<TiKu> listConcreteInfo = new ArrayList<TiKu>();
		TiKu tiKu = new TiKu();
		for (IncorrectRecord incorrectRecord : IncorrectRecordList) {
			tiKu.setQStyleCode(incorrectRecord.getTestType());
			tiKu.setQID(incorrectRecord.getQID());
			TiKu inRecords = cuoTiServiceImpl.selWrongRecordById(tiKu);
			inRecords.setIncorrectRecord(incorrectRecord);
			listConcreteInfo.add(inRecords);
		}
		return listConcreteInfo;
	}

	/*
	 * 插入一条错题数据
	 */
	@RequestMapping(value = "/cuoTi/insertCuoTi")
	public int insertCuoTi(IncorrectRecord incorrectRecord, HttpSession httpSession) {
		cuoTiServiceImpl.insertCuoTi(incorrectRecord);
		//return "view/qtjsp/tp_trainingDd";
		return 1;
	}

	/*
	 * 插入一条被用户投诉本身有毛病的题目数据
	 * 
	 */
	@RequestMapping("/cuoTi/insMisQuestion")
	public int ins_MisQuestion(MisQuestion misQuestion) {
		cuoTiServiceImpl.ins_MisQuestion(misQuestion);
		return 1;
	}

	/*
	 * 下面是要查询这些毛病题记录
	 */
	@RequestMapping(value = "/cuoTi/findFKofMaoBing")
	public String findFKofMaoBing( ModelMap modelMap) throws IOException {
		List<MisQuestion> MisQuestionPageInfo = cuoTiServiceImpl.findFKofMaobing();
		modelMap.addAttribute("MisQuestionPageInfo", MisQuestionPageInfo);
		return "forward:/cuoTi/findRelativeRecord";
	}

	/**
	 * 根据错题记录中的数据查找毛病题的具体内容
	 */
	@RequestMapping(value = "/cuoTi/findRelativeRecord", produces = "application/json;charset=utf-8")
	@ResponseBody
	public List<TiKu> findRelativeRecord(HttpServletRequest req) throws IOException {
		List<MisQuestion> MisQuestionPageInfo = (List<MisQuestion>) req.getAttribute("MisQuestionPageInfo");
		List<TiKu> list = new ArrayList<TiKu>();
		List<Integer> listInt = new ArrayList<Integer>();
		TiKu tiKu = new TiKu();
		for (MisQuestion misQuestion : MisQuestionPageInfo) {
			tiKu.setQStyleCode(misQuestion.getTestType());
			tiKu.setQID(misQuestion.getQID());
			TiKu inRecords = cuoTiServiceImpl.selWrongRecordById(tiKu);
			inRecords.setMisQuestion(misQuestion);
			list.add(inRecords);
		}
		req.getSession().setAttribute("listInt", listInt);
		return list;
	}

	/**
	 * 根据错题记录中的数据id删除对应的毛病题记录,注意只能删除misquestion表中的记录，不能删除题库中对应的题目
	 */
	@RequestMapping(value = "/cuoTi/deleteMaoBinRecord")
	public String deleteMaoBinRecord(int mid) throws Exception {
		cuoTiServiceImpl.deleteMaoBin(mid);
		return "view/adminjsp/lookBadTiMu";

	}

}
