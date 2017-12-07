
package com.hansy.transaction.service;

import java.util.List;
import java.util.Map;

import com.hansy.transaction.common.BusinessMap;
import com.hansy.transaction.common.utils.AllPager;
import com.hansy.transaction.common.utils.Pager;
import com.hansy.transaction.model.bo.Order;
import com.hansy.transaction.model.vo.TBusOrderDetlVo;
import com.hansy.transaction.model.vo.TBusOrderSplitVo;
import com.hansy.transaction.model.vo.TBusOrderVo;
import com.hansy.transaction.model.vo.TUserSupplyInfoVo;

/**
 * 订单信息service
 * TODO javadoc for com.hansy.transaction.service.ITBusOrderService
 * @Copyright: 2017成都环赛信息技术有限公司
 * @author: cj
 * @since: 2017年3月9日
 */
public interface ITBusOrderService {
	public static final String BEAN_ID = "ITBusOrderService";

	/**
	 * 获取供方订单分页
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月10日
	 * @modifier:
	 * @modifiedDate:
	 * @param custNo
	 * @return
	 */
	BusinessMap<Pager> selectSupplyOrders(Map<String, Object> param,Pager pager);

	/**
	 * 获取买方订单分页
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月14日
	 * @modifier:
	 * @modifiedDate:
	 * @param custNo
	 * @param pager
	 * @return
	 */
	BusinessMap<Pager> selectBuyerOrders(Map<String, Object> param, Pager pager);

	/**
	 * 获取买方未开发票订单信息
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月14日
	 * @modifier:
	 * @modifiedDate:
	 * @param custNo
	 * @param pager
	 * @return
	 */
	BusinessMap<Pager> selectBuyerOrdersInvoic(Map<String, Object> param, Pager pager);
	
	/**
	 * 获取供方（全部，待发货，待确认，完成4种类型订单数量）
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月15日
	 * @modifier:
	 * @modifiedDate:
	 * @return
	 */
	BusinessMap<Object> getApplyOrderCount(Map<String, String> param);

	/**
	 * 获取买方（全部，待付款，待收货，完成4种类型订单数量）
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月15日
	 * @modifier:
	 * @modifiedDate:
	 * @param param
	 * @return
	 */
	BusinessMap<Object> getBuyerOrderCount(Map<String, String> param);

	/**
	 * 逻辑删除
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月17日
	 * @modifier:
	 * @modifiedDate:
	 * @param orderNo
	 * @return
	 */
	BusinessMap<Object> updateStatus(Map<String,Object> params);

	/**
	 * 卖家逻辑删除
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月17日
	 * @modifier:
	 * @modifiedDate:
	 * @param orderNo
	 * @return
	 */
	BusinessMap<Object> updateStatusSell(Map<String,Object> params);

	/**
	 * 生成订单
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月23日
	 * @modifier:
	 * @modifiedDate:
	 * @param orderDetlList
	 * @return
	 */
	BusinessMap<Object> saveOrder(List<TBusOrderVo> orderList);

	/**
	 * 根据id获取订单
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月23日
	 * @modifier:
	 * @modifiedDate:
	 * @param orderNo
	 * @return
	 */
	List<TBusOrderVo> getById(String orderNo);

	/**
	 * 更新订单状态
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月23日
	 * @modifier:
	 * @modifiedDate:
	 * @param param
	 * @return
	 */
	BusinessMap<Object> updateOrderStatus(Map<String, Object> param);

	/**
	 * 新增订单
	 * @description: TODO
	 * @creator: tx
	 * @createDate: 2017年7月9日
	 * @modifier:
	 * @modifiedDate:
	 * @param param
	 * @return
	 */
	BusinessMap<Object> insertOrderHis(TBusOrderVo tBusOrderVo);
	/**
	 * 更新订单价格及折扣
	 * @description: TODO
	 * @creator: tx
	 * @createDate: 2017年7月9日
	 * @modifier:
	 * @modifiedDate:
	 * @param param
	 * @return
	 */
	BusinessMap<Object> updateOrderPrice(Map<String, Object> param);


	/**
	 * 再次下单获取原订单信息
	 * @description: TODO
	 * @creator: tx
	 * @createDate: 2017年7月13日
	 * @modifier:
	 * @modifiedDate:
	 * @param orderNo
	 * @return
	 */
	BusinessMap<Object> getOldById(Map<String, Object> map);
	/**
	 *
	 * @description: 根据id产品编号查询数量
	 * @creator: 欧诗阳
	 * @createDate: 2017年7月19日
	 * @modifier:
	 * @modifiedDate:
	 * @param goodsNo
	 * @return
	 */
	TBusOrderVo getByGoodNo(String goodsNo);
	List<Order> getByidDteail(String orderNo);
	/**
	 *
	 * @description:修改订单的拆分状态
	 * @creator: 欧诗阳
	 * @createDate: 2017年7月20日
	 * @modifier:
	 * @modifiedDate:
	 * @param param
	 * @return
	 */
	BusinessMap<Object> updateOrderSpiltStatus(Map<String, Object> param);
	/**
	 *
	 * @description: 根据唯一主键查询订单
	 * @creator: 欧诗阳
	 * @createDate: 2017年7月25日
	 * @modifier:
	 * @modifiedDate:
	 * @param tableKey
	 * @return
	 */
	TBusOrderVo getByTableKey(String tableKey);
	/**
	 *
	 * @description: 插入订单备注
	 * @creator: 欧诗阳
	 * @createDate: 2017年7月25日
	 * @modifier:
	 * @modifiedDate:
	 * @param tBusOrderVo
	 * @return
	 */
	BusinessMap<Object> insertOrderHis1(TBusOrderSplitVo tBusOrderSplitVo);
	/**
	 * 根据custno查询详细数据
	 * @description: TODO
	 * @creator: 欧诗阳
	 * @createDate: 2017年7月18日
	 * @modifier:
	 * @modifiedDate:
	 * @param custNo
	 * @return
	 */
	TUserSupplyInfoVo getUserSupplyDetail(String custNo);

	public Pager productRank(Map<String, Object>map,Pager pager);

	public void lgtSend(TBusOrderVo busOrderVo);

	BusinessMap<AllPager> selectBuyerOrders(Map<String, Object> param);
	
	
	/**
	 * 获取买方（未开发票订单，已开发票订单信息）
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月15日
	 * @modifier:
	 * @modifiedDate:
	 * @param param
	 * @return
	 */
	BusinessMap<Object> getBuyerOrderCountInvoic(Map<String, String> param);
	/**
	 * 获取供方（未开发票订单、发票数量）
	 */
	BusinessMap<Object> getApplyOrderCountInvoice(Map<String, String> param);
	/**
	 * 获取供方数据（未开发票订单、发票数量）
	 */
	BusinessMap<Pager> selectSupplyOrdersInvoice(Map<String, Object> param,
			Pager pager);
	/**
	 * 批量修改订单发票状态
	 */
	BusinessMap<Object> updateOrderIncoiceStatus(String[] orderNoArr);
	
}

