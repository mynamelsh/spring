package com.baizhi.controller;

import com.baizhi.entity.User;
import com.baizhi.service.UserService;
import com.baizhi.service.UserServiceImpl;
import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.search.SearchHit;
import org.elasticsearch.search.fetch.subphase.highlight.HighlightBuilder;
import org.elasticsearch.search.fetch.subphase.highlight.HighlightField;
import org.elasticsearch.search.sort.SortBuilders;
import org.elasticsearch.search.sort.SortOrder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.elasticsearch.core.ElasticsearchTemplate;
import org.springframework.data.elasticsearch.core.SearchResultMapper;
import org.springframework.data.elasticsearch.core.aggregation.AggregatedPage;
import org.springframework.data.elasticsearch.core.aggregation.impl.AggregatedPageImpl;
import org.springframework.data.elasticsearch.core.query.NativeSearchQuery;
import org.springframework.data.elasticsearch.core.query.NativeSearchQueryBuilder;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Repository
public class MyesImpl implements Myes {
     @Autowired
     //用于高级查询
     private ElasticsearchTemplate elasticsearchTemplate;
     @Autowired
     //用于增删改查
     private Myzhu myzhu;
     @Autowired
     private UserService service;
    @Override
    public List<User> findByUser(String ming) {
        //先把数据库的信息放到es中去
        List<User> userList = service.queryService();
        for (User user : userList) {
               myzhu.save(user);
        }

         //要高亮的字段的相关的设置（例如：field：所有的字段都高亮，preTags：前缀，postTags:后缀，requireFielMatch:展示所有的高亮字段，它默认是只展示所查询的字段）
        HighlightBuilder.Field field = new HighlightBuilder
                .Field("*")
                .preTags("<span style='color:red'>")
                .postTags("</span>")
                .requireFieldMatch(false);
        //高亮的字段
        NativeSearchQuery build = new NativeSearchQueryBuilder()
                .withQuery(QueryBuilders.termQuery("name", ming))//term关键字
                .withFields("*")//返回的字段
                .withPageable(PageRequest.of(0, 20))//分页
                .withHighlightFields(field)//高亮
                .build();

        AggregatedPage<User> users = elasticsearchTemplate.queryForPage(build,User.class,new SearchResultMapper() {
            @Override
            public <T> AggregatedPage<T> mapResults(SearchResponse searchResponse, Class<T> aClass, Pageable pageable) {
                  //通过
                SearchHit[] hits = searchResponse.getHits().getHits();
                    //把所有的user对象储存到集合中去
                ArrayList<User> list = new ArrayList<>();

                for (SearchHit hit : hits) {
                    //方法的返回值是List<User>,所以创建一个user对象用来储存元数据中的数据
                    User user = new User();
                    //元数据
                    Map<String, Object> sourceAsMap = hit.getSourceAsMap();
                    //判断元数据中的数据是否为空，为空就不储存到user对象中
                    /* 把元数据中数据放到对象中。方便更改字段
                    * */
                    if (sourceAsMap.get("id") != null) {
                        user.setId(sourceAsMap.get("id").toString());
                    }
                    if (sourceAsMap.get("name") != null) {
                        user.setName(sourceAsMap.get("name").toString());
                    }
                    if (sourceAsMap.get("password") != null) {
                        user.setPassword(sourceAsMap.get("password").toString());
                    }
                    if (sourceAsMap.get("birthday") != null) {
                        user.setBirthday(sourceAsMap.get("birthday").toString());
                    }
                    if (sourceAsMap.get("phone") != null) {
                        user.setPhone(sourceAsMap.get("phone").toString());
                    }
                    if (sourceAsMap.get("state") != null) {
                        user.setState(sourceAsMap.get("state").toString());
                    }

                    //获取高亮字段
                    Map<String, HighlightField> highlightFields = hit.getHighlightFields();
                        //判断高亮字段是否为空
                    if (highlightFields.get("name") != null) {
                        //将高亮字段替换user对象中元数据的相应字段，并在页面展示
                        user.setName(highlightFields.get("name").getFragments()[0].toString());
                    }
                    // 把后台响应的结果返回到页面去
                    list.add(user);
                }
                 //把list的集合转化为上面方法要类型
                return new AggregatedPageImpl<T>((List<T>) list);
            }
        });
        //把users的内容返回才行
        return users.getContent();
    }
}
