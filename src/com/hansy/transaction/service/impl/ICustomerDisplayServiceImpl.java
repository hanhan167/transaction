package com.hansy.transaction.service.impl;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import com.hansy.transaction.common.BusinessMap;
import com.hansy.transaction.model.bo.CustomerDisplay;
import com.hansy.transaction.service.ICustomerDisplayService;
import com.hansy.transaction.service.base.BaseDao;

@Service
public class ICustomerDisplayServiceImpl extends BaseDao implements ICustomerDisplayService{

	@Override
	public Integer addCd(CustomerDisplay customerDisplay) {
		Integer flag = 0;
		try {
			getSqlMapClientTemplate().insert("customerDisplaySql.save", customerDisplay);
		} catch (DataAccessException e) {
			e.printStackTrace();
		}
		flag = 1;
		return flag;
	}

	
	@Override
	public String findTelCd(CustomerDisplay cDisplay) {
		String  tel = null;
		try {
			tel = (String) getSqlMapClientTemplate().queryForObject("customerDisplaySql.findTel",cDisplay);
		} catch (DataAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return tel;
	}

}
