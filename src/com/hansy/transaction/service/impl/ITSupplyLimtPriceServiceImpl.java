
package com.hansy.transaction.service.impl;

import java.util.Map;

import org.springframework.stereotype.Service;

import com.hansy.transaction.common.BusinessMap;
import com.hansy.transaction.model.bo.SupplyLimitPrice;
import com.hansy.transaction.model.vo.TBusAddress;
import com.hansy.transaction.model.vo.TUserBill;
import com.hansy.transaction.service.ITSupplyLimtPriceService;
import com.hansy.transaction.service.base.BaseDao;
@Service
public class ITSupplyLimtPriceServiceImpl extends BaseDao implements ITSupplyLimtPriceService {

	/**
	 * 新增限定金额
	 */
	@Override
	public boolean insertLimitPrice(SupplyLimitPrice supplyLimitPrice) {
		// TODO Auto-generated method stub
		return false;
	}

	/**
	 * 更新限定金额
	 */
	@Override
	public boolean updateLimitPrice(SupplyLimitPrice supplyLimitPrice) {
		// TODO Auto-generated method stub
		return false;
	}

	/**
	 * 供应商查询
	 */
	@Override
	public BusinessMap<Object> selectLimitPriceSupply(String custNo) {
		BusinessMap<Object> bMap=new BusinessMap<Object>();
		try {
			
			Double supplyLimitPrice = (Double) getSqlMapClientTemplate().queryForObject("supplyLP.getLimitPriceSupply", custNo);
			
			bMap.setInfoBody(supplyLimitPrice);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("获取下限金额失败");
		}
	
		bMap.setIsSucc(true);
		return bMap;
	
	}

	/**
	 * 客户查询
	 */
	@Override
	public String selectLimitPriceCust(String supplyName) {
		// TODO Auto-generated method stub
		return null;
	}
	
}

