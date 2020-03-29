package com.bjsxt.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.catalina.User;
import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.github.pagehelper.PageInfo;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;

import com.bjsxt.pojo.Users;
import com.bjsxt.service.HTUsersService;
import com.bjsxt.utils.ExcelReader;
@Controller
public class HTUsersController {
	@Resource
	private 	HTUsersService hTUsersServiceImpl;

	// 退出登录
		@RequestMapping(value = "/admin_user/AClear")
		public String AClear(Users user, HttpSession httpSession) {

			httpSession.setAttribute("admin_user", null);
			
			return "forward:/index.jsp";

		}
		@RequestMapping(value = "/admin_user/deleteAllUsers")
		public String deleteAllUsers(Users user, HttpSession httpSession) {

			hTUsersServiceImpl.deleteAllUsers();
			
			return "redirect:/view/adminjsp/userlist.jsp";

		}
		
		// 导入用户excel表
		@RequestMapping(value = "/admin_user/importUsersExcel")
		public String importUsersExcel(Users users, MultipartFile file,HttpServletRequest req, HttpSession httpSession) throws BiffException, IOException {
			 String pathname = req.getServletContext().getRealPath("customerImages") + "/" + file.getOriginalFilename();	
     		 FileUtils.copyInputStreamToFile(file.getInputStream(), new File(pathname));
     		 File newDirFile=new File(pathname);
     		 Workbook wb = ExcelReader.getWorkBook(newDirFile);
     		 System.out.println(newDirFile+"  "+file.getOriginalFilename()+pathname);
        	//读取Excel文件标签索引为0的表中的第1行，第2列的数据
     		 Sheet sheet=wb.getSheet(0);
     		System.out.println("获取行数"+sheet.getRows()+"获取列数"+sheet.getColumns());
     		//System.out.println();
     		//System.out.println(sheet.getCell(0, i).getContents()+" "+sheet.getCell(1, i).getContents()+" "+sheet.getCell(2, i).getContents()+" "+sheet.getCell(3, i).getContents()+" "+sheet.getCell(4, i).getContents()+" "+sheet.getCell(5, i).getContents());
     		List<Users> list=new ArrayList<Users>();
     		for(int i=1;i<sheet.getRows();i++) {
     			    users=new Users();
          			if(sheet.getCell(0, i).getContents()!=null&&!sheet.getCell(0, i).getContents().equals("")) {
     				users.setUsername(sheet.getCell(0, i).getContents()); 
         			users.setName(sheet.getCell(1, i).getContents()); 
         			users.setMajor(sheet.getCell(2, i).getContents()); 
         			users.setSchool(sheet.getCell(3, i).getContents());  
         			users.setGrade(sheet.getCell(4, i).getContents());
         			users.setPassword(sheet.getCell(5, i).getContents()); 
         			users.setRoot(1);
         			double ran=Math.random()*20;
         			users.setPhoto("img"+(int)Math.ceil(ran)+".jpg");         			
         			list.add(users);
           			System.out.println("da数据监测"+users.getUsername()+users.getGrade()+users.getPassword()+users.getSchool()+users.getMajor());

     			}
     			else {
     				System.out.println("此条数据为空 不导入");
     				break;
     			}
     		}
     		wb.close();
			newDirFile.delete();
			for( Users users1:list) {
				System.out.println(users1.getUsername()+users1.getGrade()+users1.getPassword()+users1.getSchool()+users1.getMajor());

			}
     		hTUsersServiceImpl.insertExcelUsers(list);     		
     		return "redirect:/view/adminjsp/userlist.jsp";
	

		}
	 	@RequestMapping("/admin_user/exportHTPic")
	public void exportPic(HttpServletRequest req, HttpServletResponse res, HttpSession sessionParam)
			throws IOException {
		/* 输出文字流用 PrintWriter pWriter=res.getWriter();
		 *    输出字节流用ServletOutputStream os = res.getOutputStream();
		 */
		Users user = (Users) sessionParam.getAttribute("admin_user");
		String photoname = hTUsersServiceImpl.selUsersPhotos(user.getUsername());
		if (photoname != null) {
			ServletOutputStream os = res.getOutputStream();
			String filePath=null;
			if(photoname.length()>10) {			
				//长度大于10说明这张图片是用户自己上传的（非系统分配）
				filePath=	req.getServletContext().getRealPath("customerImages") + "/" + photoname;
			}else {
				filePath=	req.getServletContext().getRealPath("images") + "/regist/" + photoname;
			}	
			InputStream iStream = new FileInputStream(
					new File(filePath));
			int index = -1;
			while ((index = iStream.read()) != -1) {
				os.write(index);
			}
		} 

	}

	// 后台登录权限验证
		@RequestMapping(value = "/admin_user/adminLogin")
		public String Alogin( HttpServletRequest req, Users users, HttpSession httpSession) throws Exception {	
			
				Users user = hTUsersServiceImpl.login(users);
				String flagPage =null;
				if(user!=null) {
					if(user.getRoot()>2) {
						httpSession.setAttribute("admin_user", user);
						httpSession.setMaxInactiveInterval(-1);
						flagPage="view/adminjsp/htIndex";
					}else {
						req.setAttribute("htError", "您的权限不足");	
						flagPage="forward:/adminlogin.jsp";
					}
				}else {
					req.setAttribute("htError", "用户名不存在或密码错误");
					flagPage="forward:/adminlogin.jsp";
				}
				
				return flagPage;
			
		}
		@RequestMapping(value = "/admin_user/findAll")
		public String userList(ModelMap map, Users users,@RequestParam(required = false, defaultValue = "1", value = "pn") Integer pn) {
			Integer pageSize = 5;// 每页显示记录数
			PageInfo<Users> pageInfo = hTUsersServiceImpl.selectAll(pn, pageSize,users);
			map.addAttribute("pageInfo", pageInfo);
			return "view/adminjsp/userlist";
		}
		/*
		 * 根据用户权限和用户名模糊查询
		 */
		@RequestMapping(value ="/admin_user/findByRootUser")
		public String findByRootUser(ModelMap map, Users users, HttpSession httpSession,@RequestParam(required = false, defaultValue = "1", value = "pn") Integer pn) throws Exception {
			int  pageSize=8;
			PageInfo<Users> pageInfo=hTUsersServiceImpl.findByRootUser(pn,pageSize,users);
			map.addAttribute("pageInfo", pageInfo);
			map.addAttribute("root",users.getRoot());
			return "view/adminjsp/userlist";
		}
		
		/*
		 * 删除用户
		 */
		
		@RequestMapping(value = "/admin_user/deleteUser")
		public String deleteUser(Users user,ModelMap map,HttpSession httpSession) throws Exception {
			 Users  adminUser=(Users) httpSession.getAttribute("admin_user");
			 if(adminUser.getRoot()>user.getRoot()) {
			  	 hTUsersServiceImpl.delete(user.getId());
			  	 return "redirect:/admin_user/findByRootUser";			
			 }else {
				 map.addAttribute("msg", "您的权限不够");
				 return "/view/adminjsp/Msg";
			 }
			}
		/*
		 * 修改用户权限
		 */
		@RequestMapping(value ="/admin_user/modifyRoot")
		public String modifyRoot(ModelMap map, Users user, HttpSession httpSession) throws Exception {
	    Users  adminUser=(Users) httpSession.getAttribute("admin_user");
	    if(adminUser.getRoot()<=user.getRoot()) {
	    	map.addAttribute("msg", "您的权限不够");
			return "forward:/view/adminjsp/Msg.jsp";
	    }else {
	    	hTUsersServiceImpl.updateRoot(user);
	    	return "redirect:/admin_user/findByRootUser";
	    }
		}
		
}
