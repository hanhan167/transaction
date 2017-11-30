
package com.hansy.transaction.service;

import java.util.List;
import java.util.Map;

import com.hansy.transaction.common.BusinessMap;
import com.hansy.transaction.model.bo.CreateCart;
import com.hansy.transaction.model.bo.CreateOrder;
import com.hansy.transaction.model.vo.TBusShoppCartVo;

public interface ITBusShoppCartService {
int getGoodsNo(String custNo);
	/**
	 * 获取所有的购物车商品
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月15日 
	 * @modifier:
	 * @modifiedDate:
	 * @param custNo
	 * @return
	 */
	BusinessMap<Object> getShoppCart(String custNo);

	/**
	 * 获取用户默认收货地址
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月16日 
	 * @modifier:
	 * @modifiedDate:
	 * @param userNo
	 * @return
	 */
	BusinessMap<Object> getDefaultAddress(String userNo);

	/**
	 * 删除购物车内容
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月21日 
	 * @modifier:
	 * @modifiedDate:
	 * @param tableKey
	 * @return
	 */
	BusinessMap<Object> delete(List<String> tableKey);

	/**
	 * 清空失效的商品
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月21日 
	 * @modifier:
	 * @modifiedDate:
	 * @param goodsshelfhalted
	 * @return
	 */
	BusinessMap<Object> deleteInvalidGoods(Map<String, String> param);
	BusinessMap<Object> deleteInvalidGoods1(Map<String, String> param);
	/**
	 * 获取创建订单需要的数据
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月23日 
	 * @modifier:
	 * @modifiedDate:
	 * @param string
	 * @return
	 */
	CreateOrder getCreateOrder(String tableKey);
	/**
	 * 获取用户地址
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月28日 
	 * @modifier:
	 * @modifiedDate:
	 * @param custNo
	 * @return
	 */
	BusinessMap<Object> getUserAddress(String custNo);

	/**
	 * 根据商品编号获取创建购物车时所需要的参数
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月31日 
	 * @modifier:
	 * @modifiedDate:
	 * @param goodsNo
	 * @return
	 */
	BusinessMap<CreateCart> getCreateCart(Map<String, String> param);
	BusinessMap<CreateCart> getCreateCart1(Map<String, String> param);
	/**
	 * 创建购物车
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月31日 
	 * @modifier:
	 * @modifiedDate:
	 * @param shoppCartVo
	 * @return
	 */
	BusinessMap<Object> insert(TBusShoppCartVo shoppCartVo);
	
	/**
	 * 获取所有的购物车选取下单的商品
	 * @description: TODO
	 * @creator:tx
	 * @createDate: 2017年7月9日 
	 * @modifier:
	 * @modifiedDate:
	 * @param custNo
	 * @return
	 */
	BusinessMap<Object> getShoppCartSelected(Map<String, Object> map);
	List<TBusShoppCartVo> selectIsExist(String custNo);
	/**
	 * 更新购物车数量
	 * @description: TODO
	 * @creator:tx
	 * @createDate: 2017年7月11日 
	 * @modifier:
	 * @modifiedDate:
	 * @param custNo
	 * @return
	 */
	BusinessMap<Object>updateShoppCartNum(List<Map<String, Object>>map);

	/**
	 * 再次加入购物车
	 * @description: TODO
	 * @creator:tx
	 * @createDate: 2017年7月14日 
	 * @modifier:
	 * @modifiedDate:
	 * @param shoppCartVo
	 * @return
	 */
	BusinessMap<Object> inserts(List<TBusShoppCartVo> shoppCartVo);
	
	/**
	 * 再次加入购物车的商品是否存在
	 * @description: TODO
	 * @creator:tx
	 * @createDate: 2017年7月14日 
	 * @modifier:
	 * @modifiedDate:
	 * @param shoppCartVo
	 * @return
	 */
	BusinessMap<Object> isExist(Map<String, Object> map);
}

