package com.baizhi.service;

import com.baizhi.entity.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface UserService {
    //分页
    Map<String,Object> selectService(int page, int rows);
    //删除
    void deleteService(String id);
    //修改
    void updateService(User user);
    //添加
    void insertService(User user);
    //查所有
    List<User> queryService();
}
