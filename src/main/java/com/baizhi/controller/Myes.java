package com.baizhi.controller;

import com.baizhi.entity.User;

import java.util.List;

public interface Myes{
    //term关键字查询 高亮
     List<User> findByUser(String ming);
}
