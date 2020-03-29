package com.bjsxt.controllerAdvice;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
@ControllerAdvice
public class GlobalExceptionHandler {


    /**
     * 处理Exception异常
     * @param ex
     * @return
     */
    @ExceptionHandler(value = Exception.class)
    public ModelAndView testErrorPage(Exception ex){
       ModelAndView mView=new ModelAndView();
       mView.addObject("error","操作失败");
       mView.setViewName("forward:/view/adminjsp/Msg.jsp");
        return mView;
    }

    /**
     * 处理自定义异常
     * @param ex
     * @return
     */
//    @ExceptionHandler(value = Exception.class)
//    @ResponseBody
//    public Map testDemoErrorPage(DemoException ex){
//        Map<String,Object> demoMap = new HashMap<>();
//        demoMap.put("code","500");
//        demoMap.put("message",ex.getMessage());
//        demoMap.put("data","请求异常");
//        return demoMap;
//    }
   
}