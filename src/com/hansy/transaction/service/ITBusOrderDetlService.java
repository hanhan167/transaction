
package com.hansy.transaction.service;

import java.util.List;

import com.hansy.transaction.common.BusinessMap;
import com.hansy.transaction.model.vo.TBusOrderDetlVo;
import com.hansy.transaction.model.vo.TBusOrderVo;

/**
 * 订单跟踪service
 * TODO javadoc for com.hansy.transaction.service.ITBusOrderDetl
 * @Copyright: 2017成都环赛信息技术有限公司 
 * @author: cj
 * @since: 2017年3月9日
 */
public interface ITBusOrderDetlService {
	public static final String BEAN_ID = "ITBusOrderDetlService";

	/**
	 * 获取订单备注信息
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月22日 
	 * @modifier:
	 * @modifiedDate:
	 * @param orderNo
	 * @return
	 */
	BusinessMap<Object> getOrderDetl(String orderNo);

	/**
	 * 生成订单备注信息
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月23日 
	 * @modifier:
	 * @modifiedDate:
	 * @param orderList
	 * @return
	 */
	BusinessMap<Object> saveOrderDetail(List<TBusOrderDetlVo> orderDetlList);

	/**
	 * 单个保存订单备注信息
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月23日 
	 * @modifier:
	 * @modifiedDate:
	 * @param orderDetlVo
	 * @return
	 */
	BusinessMap<Object> save(TBusOrderDetlVo orderDetlVo);
}

