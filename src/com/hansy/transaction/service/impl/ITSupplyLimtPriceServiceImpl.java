
package com.hansy.transaction.service.impl;

import java.util.Map;
import java.util.Set;

import org.springframework.stereotype.Service;

import com.hansy.transaction.common.BusinessMap;
import com.hansy.transaction.model.bo.SupplyLimitPrice;
import com.hansy.transaction.model.vo.TBusAddress;
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
	public String selectLimitPriceSupply(String custNo) {
		// TODO Auto-generated method stub
		return null;
	}

	/**
	 * 客户查询
	 */
		@Override
		public StringBuilder selectLimitPriceCust(Set<String> set, Map map) {
			StringBuilder sb  = new StringBuilder();
			for (String object : set) {
			//下限金额
			Double price = (Double) getSqlMapClientTemplate().queryForObject("supplyLP.getLimitPriceCust", object);
			//订单金额
			String myPriceStr = String.valueOf(map.get(object));
			Double myPrice = Double.parseDouble(myPriceStr);
			if(myPrice<price)
			{
				sb.append(object+"的最小开单金额为:");
				sb.append(price+";");
			}
			}
			
			return sb;
			
			
		}
		
	
	
}

