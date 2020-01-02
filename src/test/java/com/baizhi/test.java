package com.baizhi;

import com.baizhi.controller.Myes;
import com.baizhi.entity.User;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.List;

@RunWith(SpringRunner.class)
@SpringBootTest(classes = Application.class)
public class test {
    @Autowired
    private Myes myes;
    @Test
    public void tests(){
        List<User> user = myes.findByUser("我");
        for (User user1 : user) {
            System.out.println(user1);
        }
    }
}
