package com.baizhi.controller;

import com.baizhi.entity.User;
import com.baizhi.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;
import java.util.UUID;

@Controller
@RequestMapping("user")
public class UserController {
          @Autowired
         private UserService userService;
          @Autowired
          private Myes myes;

          @RequestMapping("selectController")
          @ResponseBody
          public Map<String,Object> selectController(int page,int rows){
                return userService.selectService(page,rows);
          }
          @ResponseBody
          @RequestMapping("addupdatedelete")
          public void addupdatedelete(User user,String oper){
                 if("add".equals(oper)){
                     user.setId(UUID.randomUUID().toString());
                     userService.insertService(user);
                 }else if("edit".equals(oper)){
                     userService.updateService(user);
                 }else if("del".equals(oper)){
                     userService.deleteService(user.getId());
                 }
          }
    @ResponseBody
    @RequestMapping("gaoliang")
          public List<User> gaoliang(String ming, Model model){
        List<User> list = myes.findByUser(ming);
        System.out.println(list.size());
        if(list.size()==0){
            model.addAttribute("mms","不存在");
        }
            return list;
    }
}
