
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
		try {
			 getSqlMapClientTemplate().update("supplyLP.updateLimitPrice",supplyLimitPrice);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
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
			if(price==null)
			{	
				price = 0.0;
			}
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
	
		/**
		 * 	查询下限金额和发票到达时间	
		 */	
		@Override
		public BusinessMap<Object> getLimitPrice(String custNo) {
			BusinessMap<Object> bMap=new BusinessMap<Object>();
			try {
				
				SupplyLimitPrice supplyLimitPrice = (SupplyLimitPrice) getSqlMapClientTemplate().queryForObject("supplyLP.getByCustNo", custNo);
				//System.out.println(supplyLimitPrice.toString());
				bMap.setInfoBody(supplyLimitPrice);
			} catch (Exception e) {
				e.printStackTrace();
				bMap.setIsSucc(false);
				bMap.setMsg("获取下限金额异常");
			}
	
		bMap.setIsSucc(true);
		return bMap;
	}

		@Override
		public BusinessMap<Object> getBillDateByName(String supplyName) {
			BusinessMap<Object> bMap=new BusinessMap<Object>();
			try {
				
				SupplyLimitPrice supplyLimitPrice = (SupplyLimitPrice) getSqlMapClientTemplate().queryForObject("supplyLP.getBillDateByName", supplyName);
				//System.out.println(supplyLimitPrice.toString());
				bMap.setInfoBody(supplyLimitPrice);
			} catch (Exception e) {
				e.printStackTrace();
				bMap.setIsSucc(false);
				bMap.setMsg("获取下限金额异常");
			}
	
		bMap.setIsSucc(true);
		return bMap;
		}
		
	
	
}

