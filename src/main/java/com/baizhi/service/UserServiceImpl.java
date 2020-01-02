package com.baizhi.service;

import com.baizhi.dao.UserDao;
import com.baizhi.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Service
@Transactional
public class UserServiceImpl implements UserService {
    @Autowired
    private UserDao userDao;
    @Transactional(propagation = Propagation.SUPPORTS)
    @Override
    public Map<String,Object> selectService(int page, int rows) {
          int sa=(page-1)*rows;
        List<User> list = userDao.selectAll(sa, rows);
        //总条数
        int i = userDao.countAll();
        //总页数
        int aaa=i%rows==0?i/rows:i/rows+1;
         Map<String, Object> map = new HashMap<>();
              map.put("page",page);
              map.put("rows",list);
              map.put("total",aaa);
              map.put("records",i);
        return map;
    }

    @Override
    public void deleteService(String id) {
                 userDao.delete(id);
    }

    @Override
    public void updateService(User user) {
              userDao.update(user);
    }

    @Override
    public void insertService(User user) {
        userDao.insert(user);
    }
    @Transactional(propagation = Propagation.SUPPORTS)
    @Override
    public List<User> queryService() { return userDao.queryDao();
    }
}
