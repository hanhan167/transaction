
package com.hansy.transaction.service;

import java.util.List;
import java.util.Map;

import com.hansy.transaction.common.BusinessMap;
import com.hansy.transaction.model.vo.TPubGoodsDiscount;

public interface ITPubGoodsDiscountService {
	/**
	 * 根据goodsNo和custNo获取折扣
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月20日 
	 * @modifier:
	 * @modifiedDate:
	 * @param param1
	 * @return
	 */
	BusinessMap getDiscountAll(Map<String, String> param1);

	/**
	 * 保存折扣信息
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月27日 
	 * @modifier:
	 * @modifiedDate:
	 * @param param
	 * @return
	 */
	BusinessMap<Object> save(List<TPubGoodsDiscount> param);

	/**
	 * 批量更新折扣信息
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月29日 
	 * @modifier:
	 * @modifiedDate:
	 * @param mapUpdate
	 * @return
	 */
	BusinessMap<Object> update(List<Map<String, String>> mapUpdate);

	/**
	 * 发布商品-获取折扣信息
	 * @description: TODO
	 * @creator: fj
	 * @createDate: 2017年4月26日 
	 * @modifier:
	 * @modifiedDate:
	 * @param mapUpdate
	 * @return
	 */
	BusinessMap getDiscountAlls(Map<String, String> param1);
	BusinessMap<Object> updateDis1(Map<String, String>map);
	BusinessMap<Object> updateDis2(Map<String, String>map);
	BusinessMap<Object> updateDis3(Map<String, String>map);
	BusinessMap<Object> updateDis4(Map<String, String>map);
}

