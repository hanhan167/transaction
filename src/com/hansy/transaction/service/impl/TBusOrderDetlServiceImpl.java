
package com.hansy.transaction.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.hansy.transaction.common.BusinessMap;
import com.hansy.transaction.model.vo.TBusOrderDetlVo;
import com.hansy.transaction.service.ITBusOrderDetlService;
import com.hansy.transaction.service.base.BaseDao;

@Service
public class TBusOrderDetlServiceImpl extends BaseDao implements ITBusOrderDetlService {
	@Override
	public BusinessMap<Object> getOrderDetl(String orderNo) {
		BusinessMap<Object> bMap=new BusinessMap<>();
		List<TBusOrderDetlVo> list=new ArrayList<>();
		try {
			list=getSqlMapClientTemplate().queryForList("busOrderDetl.selectByOrderNo", orderNo);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("获取备注消息失败");
			e.printStackTrace();
			return bMap;
		}
		bMap.setInfoBody(list);
		bMap.setIsSucc(true);
		return bMap;
	}

	@Override
	public BusinessMap<Object> saveOrderDetail(List<TBusOrderDetlVo> orderDetlList) {
		BusinessMap<Object> bMap=new BusinessMap<>();
		try {
			getSqlMapClientTemplate().insert("busOrderDetl.saveOrderDetail", orderDetlList);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			e.printStackTrace();
			return bMap;
		}
		bMap.setIsSucc(true);
		return bMap;
	}

	@Override
	public BusinessMap<Object> save(TBusOrderDetlVo orderDetlVo) {
		BusinessMap<Object> bMap=new BusinessMap<>();
		try {
			getSqlMapClientTemplate().update("busOrderDetl.save", orderDetlVo);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("更新备注信息失败");
			e.printStackTrace();
			return bMap;
		}
		bMap.setIsSucc(true);
		return bMap;
	}
}

