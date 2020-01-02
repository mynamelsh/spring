package com.baizhi.dao;

import com.baizhi.entity.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserDao {
    //分页
    List<User> selectAll(@Param("page") int page,@Param("rows") int rows);
    //总条数
    int countAll();
    //删除
    void delete(String id);
    //修改
    void update(User user);
    //添加
    void insert(User user);
    //查所有
    List<User> queryDao();
}
