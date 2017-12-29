
package com.hansy.transaction.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import com.hansy.transaction.common.BusinessMap;
import com.hansy.transaction.common.constants.UserConstants;
import com.hansy.transaction.common.utils.Pager;
import com.hansy.transaction.model.vo.TUserAddressVo;
import com.hansy.transaction.service.ITUserAddressService;
import com.hansy.transaction.service.base.BaseDao;


@Service
public class TUserAddressServiceImpl extends BaseDao implements ITUserAddressService {

	@Override
	public TUserAddressVo getByTableKey(String tableKey) {
		TUserAddressVo addressVo=(TUserAddressVo) getSqlMapClientTemplate().queryForObject("userAddress.getByTableKey", tableKey);
		return addressVo;
	}

	@Override
	public List<TUserAddressVo> getByUserNo(String userNo) {
		List<TUserAddressVo> addressList=getSqlMapClientTemplate().queryForList("userAddress.selectByUserNo", userNo);
		return addressList;
	}

	@Override
	public BusinessMap<Object> add(TUserAddressVo addressVo) {
		BusinessMap<Object> bMap=new BusinessMap<Object>();
		try {
			getSqlMapClientTemplate().insert("userAddress.insert", addressVo);
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
	    	getSqlMapClientTemplate().delete("userAddress.delete", tableKey);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("删除收货地址失败");
			return bMap;
		}
	    bMap.setIsSucc(true);
		return bMap;
	}

	@Override
	public Pager getPage(String custNo, Pager pager) {
		List<TUserAddressVo> list=new ArrayList<TUserAddressVo>();
		//获取pager后的list
		try {
			list=getSqlMapClientTemplate().queryForList("userAddress.selectByUserNo", custNo, (pager.getPageNo()-1)*pager.getPageSize(), pager.getPageSize());
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		//获取总记录数
		int count=0;
		try {
			count=(int) getSqlMapClientTemplate().queryForObject("userAddress.selectCountByUserNo", custNo);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		pager.setTotal(count);
		pager.setRows(list);
		return pager;
	}

	@Override
	public BusinessMap<Object> update(TUserAddressVo addressVo) {
		BusinessMap<Object> bMap=new BusinessMap<Object>();
		try {
			getSqlMapClientTemplate().delete("userAddress.update", addressVo);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("更新收货地址失败");
		}
		bMap.setIsSucc(true);
		return bMap;
	}

	@Override
	public BusinessMap<Object> updateStatus(String tableKey, String custNo) {
		BusinessMap<Object> bMap=new BusinessMap<Object>();
		Map<String, String> map1=new HashMap<String,String>();
		Map<String, String> map2=new HashMap<String,String>();
		map1.put("statusNo", UserConstants.defaultAddressNo);
		map1.put("status", UserConstants.defaultAddress);
		map1.put("custNo", custNo);
		map2.put("status", UserConstants.defaultAddress);
		map2.put("tableKey", tableKey);
		try {
			//把原先默认地址改为非默认地址
			int i = getSqlMapClientTemplate().update("userAddress.updateAddressNo",map1);
			//设置默认地址
			int j = getSqlMapClientTemplate().update("userAddress.updateAddress", map2);
			if (j == 1) {
				bMap.setIsSucc(true);
			}else{
				bMap.setIsSucc(false);
				bMap.setMsg("设为默认地址失败");
			}
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("设为默认地址失败");
		}
		return bMap;
	}

	@Override
	public TUserAddressVo getNotAddress(String custNo) {
		TUserAddressVo tAddressVo = new TUserAddressVo();
		try {
			tAddressVo = (TUserAddressVo) getSqlMapClientTemplate().queryForObject("userAddress.getNotAddress", custNo);
		} catch (DataAccessException e) {
			e.printStackTrace();
		}
		return tAddressVo;
	}

	@Override
	public String getAddress(String custNo) {
		String address = null;
		try {
			address = (String) getSqlMapClientTemplate().queryForObject("userAddress.getAddress", custNo);
		} catch (DataAccessException e) {
			e.printStackTrace();
		}
		return address;
	}

	@Override
	public String getTel(String custNo) {
		String tel = null;
		try {
			tel = (String) getSqlMapClientTemplate().queryForObject("userAddress.getTel", custNo);
		} catch (DataAccessException e) {
			e.printStackTrace();
		}
		return tel;
	}

}

