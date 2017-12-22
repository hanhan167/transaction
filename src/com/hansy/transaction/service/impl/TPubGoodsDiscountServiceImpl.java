
package com.hansy.transaction.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.hansy.transaction.common.BusinessMap;
import com.hansy.transaction.model.bo.GoodsDiscount;
import com.hansy.transaction.model.vo.TPubGoodsDiscount;
import com.hansy.transaction.service.ITPubGoodsDiscountService;
import com.hansy.transaction.service.base.BaseDao;

@Service
public class TPubGoodsDiscountServiceImpl extends BaseDao implements ITPubGoodsDiscountService {

	@Override
	public BusinessMap getDiscountAll(Map<String, String> param1) {
		BusinessMap bMap=new BusinessMap<>();
		List<GoodsDiscount> list=new ArrayList<>();
		try {
			list=getSqlMapClientTemplate().queryForList("goodsDiscount.getDiscountAll", param1);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("获取折扣信息失败");
			e.printStackTrace();
			return bMap;
		}
		bMap.setIsSucc(true);
		bMap.setInfoBody(list);
		return bMap;
	}

	@Override
	public BusinessMap<Object> save(List<TPubGoodsDiscount> param) {
		BusinessMap bMap=new BusinessMap<>();
		try {
			getSqlMapClientTemplate().insert("goodsDiscount.save", param);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("保存折扣信息失败");
			e.printStackTrace();
			return bMap;
		}
		bMap.setIsSucc(true);
		return bMap;
	}

	@Override
	public BusinessMap<Object> update(List<Map<String, String>> mapUpdate) {
		BusinessMap bMap=new BusinessMap<>();
		try {
			getSqlMapClientTemplate().update("goodsDiscount.update", mapUpdate);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("折扣信息更新异常，请重试");
			e.printStackTrace();
			return bMap;
		}
		bMap.setIsSucc(true);
		return bMap; 
	}

	@Override
	public BusinessMap getDiscountAlls(Map<String, String> param1) {
		BusinessMap bMap=new BusinessMap<>();
		List<GoodsDiscount> list=new ArrayList<>();
		try {
			list=getSqlMapClientTemplate().queryForList("goodsDiscount.getDiscountAlls", param1);
			if(list.size() < 4){
				if(list.size() == 3){
					list.add(new GoodsDiscount());
				}
				if(list.size() == 2){
					list.add(new GoodsDiscount());
					list.add(new GoodsDiscount());
				}
				if(list.size() == 1){
					list.add(new GoodsDiscount());
					list.add(new GoodsDiscount());
					list.add(new GoodsDiscount());
				}
				if(list.size() == 0){
					list.add(new GoodsDiscount());
					list.add(new GoodsDiscount());
					list.add(new GoodsDiscount());
					list.add(new GoodsDiscount());
				}
			}
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("获取折扣信息失败");
			e.printStackTrace();
			return bMap;
		}
		bMap.setIsSucc(true);
		bMap.setInfoBody(list);
		return bMap;
	}

	@Override
	public BusinessMap<Object> updateDis1(Map<String, String> map) {
		BusinessMap bMap=new BusinessMap<>();
		try {
			getSqlMapClientTemplate().update("goodsDiscount.updateDis1", map);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("折扣信息更新异常，请重试");
			e.printStackTrace();
			return bMap;
		}
		bMap.setIsSucc(true);
		return bMap;
	}

	@Override
	public BusinessMap<Object> updateDis2(Map<String, String> map) {
		BusinessMap bMap=new BusinessMap<>();
		try {
			getSqlMapClientTemplate().update("goodsDiscount.updateDis2", map);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("折扣信息更新异常，请重试");
			e.printStackTrace();
			return bMap;
		}
		bMap.setIsSucc(true);
		return bMap;
	}

	@Override
	public BusinessMap<Object> updateDis3(Map<String, String> map) {
		BusinessMap bMap=new BusinessMap<>();
		try {
			getSqlMapClientTemplate().update("goodsDiscount.updateDis3", map);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("折扣信息更新异常，请重试");
			e.printStackTrace();
			return bMap;
		}
		bMap.setIsSucc(true);
		return bMap;
	}

	@Override
	public BusinessMap<Object> updateDis4(Map<String, String> map) {
		BusinessMap bMap=new BusinessMap<>();
		try {
			getSqlMapClientTemplate().update("goodsDiscount.updateDis4", map);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("折扣信息更新异常，请重试");
			e.printStackTrace();
			return bMap;
		}
		bMap.setIsSucc(true);
		return bMap;
	}


}

