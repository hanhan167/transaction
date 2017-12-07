
package com.hansy.transaction.service.impl;

import java.util.Map;
import java.util.Set;
import org.springframework.stereotype.Service;
import com.hansy.transaction.common.BusinessMap;
import com.hansy.transaction.model.bo.SupplyLimitPrice;
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
				sb.append("&nbsp;");
				sb.append(price+";");
				sb.append("当前累计金额为:&nbsp;"+myPrice+";请重新选择");
				sb.append("<br>");
			}
			}
			
			return sb;
			
			
		}
		
	
	
}

