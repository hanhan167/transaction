
package com.hansy.transaction.service;

import java.util.List;
import java.util.Map;

import com.hansy.transaction.common.BusinessMap;
import com.hansy.transaction.model.vo.TBusOrderSplitVo;
import com.hansy.transaction.model.vo.TBusOrderVo;

/**
 * 订单拆分service
 * TODO javadoc for com.hansy.transaction.service.ITBusOrderSplitService
 * @Copyright: 2017成都环赛信息技术有限公司 
 * @author: cj
 * @since: 2017年3月9日
 */
public interface ITBusOrderSplitService {
	public static final String BEAN_ID = "ITBusOrderSplitService";
	/**
	 * 
	 * @description: 批量插入订单拆分数据
	 * @creator: 欧诗阳
	 * @createDate: 2017年7月20日 
	 * @modifier:
	 * @modifiedDate:
	 * @param orderList
	 * @return
	 */
	BusinessMap<Object> saveSplitOrder(List<TBusOrderSplitVo> orderSplitList);
	
	TBusOrderSplitVo getByTableKey(String tableKey);
	BusinessMap<Object> updateOrderPrice(Map<String, Object> param);
}

