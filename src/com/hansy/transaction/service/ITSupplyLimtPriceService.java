
package com.hansy.transaction.service;

import java.util.Map;
import java.util.Set;

import com.hansy.transaction.common.BusinessMap;
import com.hansy.transaction.model.bo.SupplyLimitPrice;
import com.hansy.transaction.model.vo.TBusAddress;

public interface ITSupplyLimtPriceService {
	//新增
	boolean insertLimitPrice(SupplyLimitPrice supplyLimitPrice);
	//修改
	boolean updateLimitPrice(SupplyLimitPrice supplyLimitPrice);
	//查询  供应商
	BusinessMap<Object> selectLimitPriceSupply(String custNo);
	//查询  客户
	StringBuilder selectLimitPriceCust(Set<String> set,Map map);
	//查询下限金额和发票到达时间
	BusinessMap<Object> getLimitPrice(String custNo);
	//查询发票到达时间
	BusinessMap<Object> getBillDateByName(String supplyName);
}

