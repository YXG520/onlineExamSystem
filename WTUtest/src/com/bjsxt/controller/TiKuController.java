package com.bjsxt.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import com.github.pagehelper.PageInfo;

import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.bjsxt.pojo.TiKu;
import com.bjsxt.pojo.Users;
import com.bjsxt.service.TiKuService;
import com.bjsxt.utils.ExcelReader;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class TiKuController {
	@Resource
	private TiKuService tiKuServiceImpl;
	//前台通过jq来实现分页,不推荐使用
//	@RequestMapping("selPdBySubjectCode")
//	public void selPdBySubjectCode(PageInfo pageInfo, HttpServletRequest req,HttpServletResponse resp,HttpSession sessionParam) throws IOException {
//		String  SubjectCode= req.getParameter("SubjectCode");	
//		PageInfo pi = tiKuServiceImpl.selByPdSubjectCode(SubjectCode,pageInfo.getPageNumber(),pageInfo.getPageSize());	
//		System.out.println(pi);
//		resp.setContentType("application/json;charset=utf-8");
//		PrintWriter out = resp.getWriter();
//		ObjectMapper mapper = new ObjectMapper();
//		out.println(mapper.writeValueAsString(pi));
//		out.flush();
//		out.close();
//	}
	
	// 导入用户excel表
			@RequestMapping(value = "tiKu/importTiKuExcel")
			public String importUsersExcel( MultipartFile file,HttpServletRequest req, HttpSession httpSession) throws BiffException, IOException {
				 String pathname = req.getServletContext().getRealPath("customerImages") + "/" + file.getOriginalFilename();	
	     		 FileUtils.copyInputStreamToFile(file.getInputStream(), new File(pathname));
	     		 File newDirFile=new File(pathname);
	     		 Workbook wb = ExcelReader.getWorkBook(newDirFile);
		        	//读取Excel文件标签索引为0的表中的第1行，第2列的数据
	     		 Sheet sheet=wb.getSheet(0);
 	     		List<TiKu> list=new ArrayList<TiKu>();
	     		
	     		for(int i=1;i<sheet.getRows();i++) {
	     			    TiKu tiKu=new TiKu();
	          			if(sheet.getCell(0, i).getContents()!=null&&!sheet.getCell(0, i).getContents().equals("")) {
	          				tiKu.setSubjectCode(sheet.getCell(0, i).getContents());
	          				tiKu.setQStyleCode(sheet.getCell(1, i).getContents()); 
	          				tiKu.setChapter(sheet.getCell(2, i).getContents()); 
	          				tiKu.setTopic(sheet.getCell(3, i).getContents());  
	          				if (sheet.getCell(4, i).getContents()!=null&&!sheet.getCell(4, i).getContents().equals("")) {
	          					tiKu.setOptionList("[\""+sheet.getCell(4, i).getContents()+"\""+",\""+sheet.getCell(5, i).getContents()+"\""+",\""+sheet.getCell(6, i).getContents()+"\""+",\""+sheet.getCell(7, i).getContents()+"\"]");
							}
	          				tiKu.setResult(sheet.getCell(8, i).getContents()); 
	         			    tiKu.setDifficulty(sheet.getCell(9, i).getContents());
	         			    //tiKu.setComment(sheet.getCell(10, i).getContents());        
	         			   Date date=new Date();
	       	     		   SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");	       	     		    
	       	       	     	tiKu.setUpdateTime(simpleDateFormat.format(date));
	       	       	        tiKuServiceImpl.insertTiMu(tiKu);;   		
	         			    list.add(tiKu);
	     			}
	     			else {
	     				System.out.println("此条数据为空 不导入");
	     				break;
	     			}
	     		}
	     		wb.close();
				newDirFile.delete();
				
				return "redirect:/tiKu/searchTiMuInHT?QStyleCode=pd";
		

			}
			//一键删除三张题库表中的所有数据
			@RequestMapping(value = "/TiKu/deleteAllTiKu")
			public String deleteAllTiKu() throws Exception{
				tiKuServiceImpl.deleteAllTiKu("pd");
				tiKuServiceImpl.deleteAllTiKu("dd");
				tiKuServiceImpl.deleteAllTiKu("dx");
				return "redirect:/view/adminjsp/lookTiMu.jsp";

			}
	
	@RequestMapping("/selAllByPdSubjectCode")
	public void selAllPdBySubjectCode(String SubjectCode,HttpServletResponse resp) throws IOException {
		List<TiKu> list =tiKuServiceImpl.selAllByPdSubjectCode(SubjectCode);
		resp.setContentType("application/json;charset=utf-8");
		PrintWriter out = resp.getWriter();
		ObjectMapper mapper = new ObjectMapper();
		out.println(mapper.writeValueAsString(list));	
	}
	
	@RequestMapping("/selRandomPdByPdSubjectCode")
	public void selRandomPdByPdSubjectCode(String SubjectCode, HttpServletResponse resp) throws IOException {	
		List<TiKu> list =tiKuServiceImpl.selRandomPdBySubjectCode(SubjectCode);
		resp.setContentType("application/json;charset=utf-8");
		PrintWriter out = resp.getWriter();
		ObjectMapper mapper = new ObjectMapper();
		out.println(mapper.writeValueAsString(list));
		
	}
	//用@ResponseBody替换ObjectMapper将返回值转化为json格式的数据
	@RequestMapping(value="/selRandomPd25BySubjectCode",produces="application/json;charset=utf-8")
	@ResponseBody
	public List<TiKu> selRandomPdByPdSubjectCode2( String SubjectCode) throws IOException {
		List<TiKu>  list=tiKuServiceImpl.selRandomPdBySubjectCode(SubjectCode);
		return list;	
	}
	@RequestMapping(value="/selRandomDx60BySubjectCode",produces="application/json;charset=utf-8")
	@ResponseBody
	public List<TiKu> selRandomDx60BySubjectCode(String SubjectCode) throws IOException {	
		List<TiKu> list =tiKuServiceImpl.selRandomDx60BySubjectCode(SubjectCode);	
		return list;	
	}
	@RequestMapping(value="/selRandomDd15BySubjectCode",produces="application/json;charset=utf-8")
	@ResponseBody
	public List<TiKu> selRandomDd15BySubjectCode(String SubjectCode) throws IOException {
		List<TiKu> list =tiKuServiceImpl.selRandomDd15BySubjectCode(SubjectCode);
//		int i=0;
//		for(TiKu tiKu1:list) {
//			i++;
//			System.out.println("第"+i+"道"+tiKu1.getChapter());
//		}
		return list;	
	}
	//通过科目代码选择所有相关的多选题
	@RequestMapping(value="/selAllDdBySubjectCode",produces="application/json;charset=utf-8")
	@ResponseBody
	public List<TiKu> selAllDdBySubjectCode( TiKu tiKu) throws IOException {
		List<TiKu> list =tiKuServiceImpl.selAllDdBySubjectCode(tiKu.getSubjectCode());
		return list;	
	}
	//通过科目代码选择所有相关的判断题
	@RequestMapping(value="/selAllPdBySubjectCode",produces="application/json;charset=utf-8")
	@ResponseBody
	public List<TiKu> selAllPdBySubjectCode( TiKu tiKu) throws IOException {
		List<TiKu> list =tiKuServiceImpl.selAllPdBySubjectCode(tiKu.getSubjectCode());
		return list;	
	}
	//通过科目代码选择所有相关的单选题
	@RequestMapping(value="/selAllDxBySubjectCode",produces="application/json;charset=utf-8")
	@ResponseBody
	public List<TiKu> selAllDxBySubjectCode( TiKu tiKu) throws IOException {
		List<TiKu> list =tiKuServiceImpl.selAllDxBySubjectCode(tiKu.getSubjectCode());
		return list;	
	}
	//搜索题目
	@RequestMapping(value="/selTiMu",produces="application/json;charset=utf-8")
	@ResponseBody
	public List<TiKu> selTiMu(TiKu tiKu) throws IOException {
		List<TiKu> list =tiKuServiceImpl.selTiMu(tiKu);
		return list;	
	}
	/*按照章节和科目搜索三种类型的题目
	 * 
	 */
		@RequestMapping(value="/chapter/selPdByChapter",produces="application/json;charset=utf-8")
		@ResponseBody
		public List<TiKu> selPdByChapter(TiKu tiKu) throws IOException {
			List<TiKu> list =tiKuServiceImpl.selPdByChapter(tiKu);
//			int i=0;
//			for(TiKu tiKu2 : list) {
//				i++;
//				System.out.println("第"+i+"条pd数据"+tiKu2.getChapter()+tiKu2.getOptionList());
//			}
			return list;	
		}
		@RequestMapping(value="/chapter/selDxByChapter",produces="application/json;charset=utf-8")
		@ResponseBody
		public List<TiKu> selDxByChapter(TiKu tiKu) throws IOException {
			List<TiKu> list =tiKuServiceImpl.selDxByChapter(tiKu);
			return list;	
		}
		@RequestMapping(value="/chapter/selDdByChapter",produces="application/json;charset=utf-8")
		@ResponseBody
		public List<TiKu> selDdByChapter(TiKu tiKu) throws IOException {
			List<TiKu> list =tiKuServiceImpl.selDdByChapter(tiKu);
			return list;	
		}
		/*
		 * 
		 * 后台管理系统的题库管理部分,下面三个方法分别意为在后台查找所有判断、多选和单选题
		 */
		@RequestMapping(value = "/tiKu/findAllHTPd")
		public String findAllHTPd(ModelMap map, TiKu tiKu,@RequestParam(required = false, defaultValue = "1", value = "pn") Integer pn)  throws Exception{
			Integer pageSize = 10;// 每页显示记录数
			PageInfo<TiKu> pageInfo = tiKuServiceImpl.findAllHTPd(pn, pageSize,tiKu.getSubjectCode());
			map.addAttribute("pageInfo", pageInfo);
			return "view/adminjsp/lookPd";
		}
		@RequestMapping(value = "/tiKu/findAllHTDd")
		public String findAllHTDd(ModelMap map, TiKu tiKu,@RequestParam(required = false, defaultValue = "1", value = "pn") Integer pn)  throws Exception{
			Integer pageSize = 8;// 每页显示记录数
			PageInfo<TiKu> pageInfo = tiKuServiceImpl.findAllHTDd(pn, pageSize,tiKu.getSubjectCode());
			map.addAttribute("pageInfo", pageInfo);
			return "view/adminjsp/lookDd";
		}
		@RequestMapping(value = "/tiKu/findAllHTDx")
		public String findAllHTDx(ModelMap map, TiKu tiKu,@RequestParam(required = false, defaultValue = "1", value = "pn") Integer pn) throws Exception {
			Integer pageSize = 8;// 每页显示记录数
			PageInfo<TiKu> pageInfo = tiKuServiceImpl.findAllHTDx(pn, pageSize,tiKu.getSubjectCode());
			map.addAttribute("pageInfo", pageInfo);
			return "view/adminjsp/lookDx";
		}
		/*
		 * 下面是指在后台进行题目搜索,此servlet已经把上面的findAllHTPd，findAllHTDx，findAllHTDd进行了融合
		 * */
		@RequestMapping(value = "/tiKu/searchTiMuInHT")
		public String searchTiMuInHT(ModelMap map, HttpServletRequest req,TiKu tiKu,@RequestParam(required = false, defaultValue = "1", value = "pn") Integer pn) throws Exception {
			Integer pageSize = 10;// 每页显示记录数
			PageInfo<TiKu> pageInfo = tiKuServiceImpl.selTiMuInHT(pn, pageSize,tiKu);
			req.getSession().setAttribute("pageInfo", pageInfo);
			map.addAttribute("pageInfo", pageInfo);
			map.addAttribute("QStyleCode", tiKu.getQStyleCode());
			return "forward:/view/adminjsp/lookTiMu.jsp";
		}
		/*
		 * 下面三个控制器是对后台题目的增删改三个操作
		 */
		@RequestMapping(value = "/tiKu/deleteTiMu")
		public String deleteTiMu(TiKu tiKu) throws Exception {
	     		 tiKu.setQStyleCode((tiKu.getQStyleCode().toLowerCase()));
				 tiKuServiceImpl.deleteTiMu(tiKu); 
				 return "redirect:/tiKu/searchTiMuInHT?QStyleCode="+tiKu.getQStyleCode(); 
				}
		@RequestMapping(value = "/tiKu/updateTiMu")
			public String updateTiMu(TiKu tiKu,HttpServletRequest req, HttpSession httpSession) throws Exception {
			tiKu.setResult(tiKu.getResult().replace(",", ""));
			System.out.println(tiKu.getResult()+tiKu.getSubjectCode());
			tiKuServiceImpl.updateTiMu(tiKu);
			return "view/adminjsp/lookTiMu";			
				
				}
			@RequestMapping(value = "/tiKu/insertTiMu")
			public String insertTiMu(TiKu tiKu) throws Exception {
					 tiKuServiceImpl.insertTiMu(tiKu);
					 return "view/adminjsp/lookTiMu";			
				
				}
		
}
