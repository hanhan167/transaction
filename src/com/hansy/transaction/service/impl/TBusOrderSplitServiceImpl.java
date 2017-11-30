
package com.hansy.transaction.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.hansy.transaction.common.BusinessMap;
import com.hansy.transaction.model.vo.TBusOrderSplitVo;
import com.hansy.transaction.model.vo.TBusOrderVo;
import com.hansy.transaction.service.ITBusOrderSplitService;
import com.hansy.transaction.service.base.BaseDao;

@Service
public class TBusOrderSplitServiceImpl extends BaseDao implements ITBusOrderSplitService {

	@Override
	public BusinessMap<Object> saveSplitOrder(List<TBusOrderSplitVo> orderSplitList) {
		BusinessMap<Object> bMap=new BusinessMap<>();
		try {
			getSqlMapClientTemplate().insert("busOrderSplit.saveSplitOrder", orderSplitList);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			e.printStackTrace();
			return bMap;
		}
		bMap.setIsSucc(true);
		return bMap;
	}

	@Override
	public TBusOrderSplitVo getByTableKey(String tableKey) {
		List<TBusOrderSplitVo> list=(List<TBusOrderSplitVo>) getSqlMapClientTemplate().queryForList("busOrderSplit.getByTableKey", tableKey);
		return list.size()>0?list.get(0):null;
	}
	@Override
	public BusinessMap<Object> updateOrderPrice(Map<String, Object> param) {
		BusinessMap<Object> bMap=new BusinessMap<>();
		try {
			getSqlMapClientTemplate().update("busOrderSplit.updateOrderPrice", param);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("操作失败，请重试");
			e.printStackTrace();
			return bMap;
		}
		bMap.setIsSucc(true);
		return bMap;
	}
}

