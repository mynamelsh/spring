package com.baizhi.controller;

import com.baizhi.entity.User;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

public interface Myzhu extends ElasticsearchRepository<User,String> {
}
