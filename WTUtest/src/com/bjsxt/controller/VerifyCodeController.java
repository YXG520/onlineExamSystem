package com.bjsxt.controller;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bjsxt.utils.Mail;
import com.bjsxt.pojo.Users;
@Controller
public class VerifyCodeController {
	
	@RequestMapping(value="checkCodeForMail",produces="application/json;charset=utf-8")
	@ResponseBody
	public String checkCode(Users users, HttpServletRequest req) throws IOException {
		List<Integer> randomList = new ArrayList<Integer>();
		Random random = new Random();
		for (int i = 0; i < 6; i++) {
			randomList.add(random.nextInt(10));
		}
		String sixCodes = "" + randomList.get(0) + randomList.get(1) + randomList.get(2) + randomList.get(3)
				+ randomList.get(4) + randomList.get(5);
		Mail mail = new Mail();
		mail.sendEmai(users.getMail(), "[WTU刷题网]  请确认你的设备","尊敬的用户" + "您此次在WTU刷题网站操作的验证码为" + sixCodes + "请妥善保护，切勿告诉他人,请在有效时间120s内输入");
		HttpSession  session=req.getSession();		
		session.setAttribute("checkCodeSession", "" + sixCodes);
		session.setMaxInactiveInterval(120);
		String mailAlert="尊敬的用户，您好，邮件已发送至您的邮箱，如未收到，请核对您的邮箱是否正确";
		return mailAlert;
	}

	@RequestMapping("/code/validcodeForLogin")
	public void validcode(HttpServletResponse res,HttpServletRequest req) throws IOException {
		// 创建一张图片
		BufferedImage image = new BufferedImage(160, 80, BufferedImage.TYPE_INT_BGR);
		// 创建画板，在画板上画内容之前必须要要生成画笔
		Graphics2D graphics2d = image.createGraphics();
		graphics2d.setColor(Color.white);
		// 前面两个参数表示从哪个点开始画，后面两个表示一个矩形
		graphics2d.fillRect(0, 0, 160, 80);
		List<Integer> randomList = new ArrayList<Integer>();
		Random random = new Random();
		for (int i = 0; i < 4; i++) {
			randomList.add(random.nextInt(10));
		}
		// 设置字体
		graphics2d.setFont(new Font("宋体", Font.ITALIC | Font.BOLD, 40));
		Color[] colors = new Color[] { Color.RED, Color.GREEN, Color.PINK, Color.GREEN, Color.GRAY };
		for (int i = 0; i < randomList.size(); i++) {
			graphics2d.setColor(colors[random.nextInt(colors.length)]);
			graphics2d.drawString(randomList.get(i) + "", i * 40, 50 + (random.nextInt(21) - 10));
		}
		for (int i = 0; i < 2; i++) {
			graphics2d.setColor(colors[random.nextInt(colors.length)]);
			graphics2d.drawLine(0, random.nextInt(101), 200, random.nextInt(101));
		}
		ServletOutputStream outputStream = res.getOutputStream();
		HttpSession  session=req.getSession();
		
		session.setAttribute("codeSession",
				"" + randomList.get(0) + randomList.get(1) + randomList.get(2) + randomList.get(3));
		session.setMaxInactiveInterval(1800);
		ImageIO.write(image, "jpg", outputStream);
		
	}
}
