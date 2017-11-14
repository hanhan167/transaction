
package com.hansy.transaction.service.impl;

import org.springframework.stereotype.Service;

import com.hansy.transaction.common.BusinessMap;
import com.hansy.transaction.model.vo.TUserBill;
import com.hansy.transaction.service.ITUserBillService;
import com.hansy.transaction.service.base.BaseDao;
@Service
public class ITUserBillServiceImpl extends BaseDao implements ITUserBillService{

	@Override
	public BusinessMap<Object> save(TUserBill tUserBill) {
		BusinessMap<Object> bMap=new BusinessMap<>();
		try {
			getSqlMapClientTemplate().update("userBill.save", tUserBill);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("添加发票信息失败");
			e.printStackTrace();
			return bMap;
		}
		bMap.setIsSucc(true);
		return bMap;
	}

	@Override
	public BusinessMap<Object> delete(String orderNo) {
		BusinessMap<Object> bMap=new BusinessMap<Object>();
	    try {
	    	getSqlMapClientTemplate().delete("userBill.delete", orderNo);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("删除发票地址失败");
			return bMap;
		}
	    bMap.setIsSucc(true);
		return bMap;
	}

	@Override
	public BusinessMap<Object> update(TUserBill tUserBill) {
		BusinessMap<Object> bMap=new BusinessMap<Object>();
		try {
			getSqlMapClientTemplate().delete("userBill.update", tUserBill);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("更新发票地址失败");
		}
		bMap.setIsSucc(true);
		return bMap;
	}

	@Override
	public BusinessMap<Object> getById(String id) {
		BusinessMap<Object> bMap=new BusinessMap<Object>();
		try {
			TUserBill tUserBill=(TUserBill) getSqlMapClientTemplate().queryForObject("userBill.getByTableKey", id);
			bMap.setInfoBody(tUserBill);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("更新发票地址失败");
		}
	
		bMap.setIsSucc(true);
		return bMap;
	}
	
}

