package com.baizhi.cache;

import com.baizhi.conf.MyUtil;
import com.baizhi.util.SerializeUtils;
import org.apache.ibatis.cache.Cache;
import org.aspectj.weaver.ast.Var;
import org.springframework.data.redis.core.HashOperations;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.util.ObjectUtils;
import org.springframework.util.SerializationUtils;
import org.springframework.util.StringUtils;

import java.util.concurrent.locks.ReadWriteLock;

public class MyRedis implements Cache {

    private String  id;

    public MyRedis(String id){
        this.id=id;
    }
    @Override
    public String getId() {
        return id;
    }
 /*
 * 添加缓存
 * */
    @Override
    public void putObject(Object o, Object o1) {
        System.out.println("======添加========");
        //通过工具类获取StringRedisTemplate对象
        StringRedisTemplate bean = (StringRedisTemplate) MyUtil.getBean(StringRedisTemplate.class);
          //判断o1这个对象是否为空
           if(!ObjectUtils.isEmpty(o1)){
               //获取HashOperations对象
               HashOperations<String, Object, Object> hash = bean.opsForHash();
               //put里面要的全是string,o1是list的集合，自定义一个方法把list转化成string
               String serialize = SerializeUtils.serialize(o1);
               //添加缓存 id是Dao的权限定名
               hash.put(id.toString(),o.toString(),serialize);
           }
    }

    /*
    * 获取缓存
    * */
    @Override
    public Object getObject(Object o) {
        System.out.println("===============获取缓存==============");
        StringRedisTemplate bean = (StringRedisTemplate) MyUtil.getBean(StringRedisTemplate.class);

        HashOperations<String, Object, Object> hash = bean.opsForHash();
        //获取o1
        String o1 = (String) hash.get(id.toString(), o.toString());
        if(!StringUtils.isEmpty(o1)){
            Object o2 = SerializeUtils.serializeToObject(o1);
            return o2;
        }
        return null;
    }
  /*
  * 删除缓存
  * */
    @Override
    public Object removeObject(Object o) {
        return null;
    }

    @Override
    public void clear() {
        StringRedisTemplate bean = (StringRedisTemplate) MyUtil.getBean(StringRedisTemplate.class);
        bean.delete(id);
    }

    @Override
    public int getSize() {
        return 0;
    }

    @Override
    public ReadWriteLock getReadWriteLock() {
        return null;
    }
}
