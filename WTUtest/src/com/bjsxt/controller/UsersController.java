package com.bjsxt.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.UUID;
import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.io.FileUtils;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.bjsxt.utils.Mail;
import com.bjsxt.pojo.Users;
import com.bjsxt.service.UsersService;
@Controller
public class UsersController {
	@Resource
	private UsersService usersServiceImpl;
	@RequestMapping("user/newLogin")
	public String newLogin(Users users,String code,ModelMap map, HttpServletRequest req, HttpSession sessionParam) throws IOException {
		// 匹配验证码
				String codeSession = req.getSession().getAttribute("codeSession").toString();
				Users user = null;
				if (code.equals(codeSession)) {
					user = usersServiceImpl.login(users);
					if (user != null) {
						user.setSubjectCode(users.getSubjectCode());
						sessionParam.setAttribute("user", user);
						sessionParam.setMaxInactiveInterval(1800);
						map.addAttribute("success", "恭喜你，登陆成功");					   			    
					} else {
						map.addAttribute("error", "用户名或者密码不正确");
					}
				} else {
					    map.addAttribute("error", "验证码不匹配");
				}
		return "forward:/index.jsp";
	}
	
	//验证邮箱是否已被注册
	@RequestMapping(value="/user/mailIfExist",produces="application/json;charset=utf-8")
	@ResponseBody
	public Users mailIfExist(String mail) throws IOException {
	Users user= usersServiceImpl.selMail(mail);
		return user;
	}
	
	//验证用户名是否已被使用
	@RequestMapping(value="/user/usernameIfExist",produces="application/json;charset=utf-8")
	@ResponseBody
	public Users usernameIfExist(String username) throws IOException {
		Users user= usersServiceImpl.selUsername(username);
		return user;
	}
	@RequestMapping("/user/newRegister")
	public String newRegister(Users users,MultipartFile file,String mailCode , String systemPicUrl,HttpServletRequest req,ModelMap modelMap) throws IOException {
//		String systemPicUrlPath = req.getServletContext().getRealPath("images") + "/regist/" + systemPicUrl;	
//下面的注释是将file文件转换为spring能识别的MultipartFile格式，需要导入spring-test包
//        File files = new File(systemPicUrlPath);
//        InputStream inputStream = new FileInputStream(files);
//        MultipartFile systemMultipartFile = new MockMultipartFile(files.getName(), inputStream);
              String filename = null;
        String pathname=null;
        if(file.getOriginalFilename().lastIndexOf(".")>-1) {
        	 filename = UUID.randomUUID().toString() + file.getOriginalFilename().lastIndexOf(".");		
           	 pathname = req.getServletContext().getRealPath("customerImages") + "/" + filename;	
     		 FileUtils.copyInputStreamToFile(file.getInputStream(), new File(pathname));
        }else {
        	 filename= systemPicUrl;
        }
		String checkCodeSession = req.getSession().getAttribute("checkCodeSession").toString();
		users.setPhoto(filename);
		String flagPage = "forward:/regist.jsp"; 
		if (mailCode.equals(checkCodeSession)) {
			int index = usersServiceImpl.insRegister(users);
			if (index > 0) {
				flagPage = "forward:/index.jsp";
				modelMap.addAttribute("success", "恭喜你，注册成功，请登录");
			}			
			else {				
				modelMap.addAttribute("error", "注册失败,请查看注册邮箱是否有效");
			}
		} else {
			modelMap.addAttribute("error", "注册失败，验证码不匹配");
		}
		return flagPage;
	}

	@RequestMapping("/user/findPwd")
	public String findPwd(Users users,String code,HttpServletRequest req,ModelMap map) throws IOException {
		String checkCodeSession = req.getSession().getAttribute("checkCodeSession").toString();
		String flagPage = "";
		if (code.equals(checkCodeSession)) {
			Users user = usersServiceImpl.selMail(users.getMail());
			if (user!=null) {
				Mail mail = new Mail();
				mail.sendEmai(user.getMail(),"WTU刷题网密码找回","尊敬的用户，"+users.getMail() + "。您在WTU刷题网站注册的密码为" + user.getPassword() + "请妥善保护，切勿告诉他人");		
				flagPage = "index";
			} 		
			else {
				map.addAttribute("error", "该邮箱未注册");
				flagPage = "forward:/findPwd.jsp";
				
			}
		} else {
			map.addAttribute("error", "验证码不匹配");
			flagPage = "forward:/findPwd.jsp";
		}
		return flagPage;
	}
	@RequestMapping("/user/alterPwd")
	public String alterPwd(Users users, String newPassword,ModelMap map) throws IOException {
		System.out.println("newPassword"+newPassword);
		String flagPage=null;	
			Users user = usersServiceImpl.login(users);
			if (user != null) {
				users.setPassword(newPassword);
				int i=usersServiceImpl.updateUsers(users);
				if(i>0) {
					flagPage = "msg";
					map.addAttribute("success", "恭喜你，密码修改成功");
					map.addAttribute("log", "登陆");
					map.addAttribute("targetPage", "index.jsp");
				}
				
			} else {
			     	map.addAttribute("error", "用户名或者邮箱不正确,修改密码失败");
				    flagPage = "redirect:/view/qtjsp/changePwd.jsp";
			}	
		return flagPage;
	}
	
	@RequestMapping("/user/exportPic")
	public void exportPic(HttpServletRequest req, HttpServletResponse res, HttpSession sessionParam)
			throws IOException {
		/* 输出文字流用 PrintWriter pWriter=res.getWriter();
		 *    输出字节流用ServletOutputStream os = res.getOutputStream();
		 */
		Users user = (Users) sessionParam.getAttribute("user");
		String photoname = usersServiceImpl.selUsersPhotos(user.getUsername());
		System.out.println(photoname);
		if (photoname != null) {
			String filePath=null;
			ServletOutputStream os = res.getOutputStream();
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
 
	// 退出登录
			@RequestMapping(value = "/user/clearUser")
			public String AClear(Users user, HttpSession httpSession) {

				httpSession.setAttribute("user", null);
				
				return "redirect:/index.jsp";

			}
		
}
