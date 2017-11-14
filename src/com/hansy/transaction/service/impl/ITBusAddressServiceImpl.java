
package com.hansy.transaction.service.impl;

import java.util.Map;

import org.springframework.stereotype.Service;

import com.hansy.transaction.common.BusinessMap;
import com.hansy.transaction.model.vo.TBusAddress;
import com.hansy.transaction.service.ITBusAddressService;
import com.hansy.transaction.service.base.BaseDao;

@Service
public class ITBusAddressServiceImpl extends BaseDao implements ITBusAddressService{

	@Override
	public BusinessMap<Object> add(Map<String, Object> param) {
		BusinessMap<Object> bMap=new BusinessMap<Object>();
		try {
			getSqlMapClientTemplate().insert("busAddress.insert", param);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("新增收货地址失败");
			return bMap;
		}
		bMap.setIsSucc(true);
		return bMap;
	}

	@Override
	public BusinessMap<Object> delete(String tableKey) {
		BusinessMap<Object> bMap=new BusinessMap<Object>();
	    try {
	    	getSqlMapClientTemplate().delete("busAddress.delete", tableKey);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("删除收货地址失败");
			return bMap;
		}
	    bMap.setIsSucc(true);
		return bMap;
	}

	@Override
	public BusinessMap<Object> update(TBusAddress addressVo) {
		BusinessMap<Object> bMap=new BusinessMap<Object>();
		try {
			getSqlMapClientTemplate().delete("busAddress.update", addressVo);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("更新收货地址失败");
		}
		bMap.setIsSucc(true);
		return bMap;
	}

	@Override
	public TBusAddress getByTableKey(String tableKey) {
		TBusAddress addressVo=(TBusAddress) getSqlMapClientTemplate().queryForObject("busAddress.getByorderNo", tableKey);
		return addressVo;
	}

	@Override
	public BusinessMap<Object> add1(Map<String, Object> param) {
		BusinessMap<Object> bMap=new BusinessMap<Object>();
		try {
			getSqlMapClientTemplate().insert("busAddress.insert1", param);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("新增收货地址失败");
			return bMap;
		}
		bMap.setIsSucc(true);
		return bMap;
	}
	
}

