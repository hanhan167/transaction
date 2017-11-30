package com.hansy.transaction.service.base;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.ibatis.sqlmap.client.SqlMapClient;

public class BaseDao extends SqlMapClientDaoSupport {

	 	@Resource(name="sqlMapClient")  //ͨ��bean���ע��  
	    private SqlMapClient sqlMapClient;  
	      
	    @PostConstruct  //���sqlMapClient��ʼ������  
	    public void initSqlMapClient(){  
	        super.setSqlMapClient(sqlMapClient);  
	    }  
	
}
