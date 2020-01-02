package com.baizhi;

import com.baizhi.dao.UserDao;
import com.baizhi.entity.User;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.List;

@SpringBootTest(classes = Application.class)
@RunWith(SpringRunner.class)
public class ApplicationTests {
   @Autowired
   private UserDao userDao;
  @Test
  public void contextLoads() {
      List<User> list = userDao.selectAll(0, 1);
      for (User user : list) {
          System.out.println(user);
      }
  }
    @Test
    public void contextLoad() {
        int i = userDao.countAll();
        System.out.println(i);
    }
    @Test
    public void contextLoa() {
        User user = new User();

          user.setName("防水袋");
          user.setState("激活");
          user.setPhone("12456321125");
          user.setPassword("1234567");
          user.setBirthday("1999-9-6");
        userDao.insert(user);
    }
    @Test
    public void test(){
        List<User> users = userDao.queryDao();
        for (User user : users) {
            System.out.println(user);
        }
    }
}
