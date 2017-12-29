package com.hansy.transaction.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import com.hansy.transaction.common.BusinessMap;
import com.hansy.transaction.common.utils.Pager;
import com.hansy.transaction.model.bo.LoginUser;
import com.hansy.transaction.model.bo.TUserBaseInfoBo;
import com.hansy.transaction.model.vo.GoodAlls;
import com.hansy.transaction.model.vo.TUserBaseInfoVo;
import com.hansy.transaction.service.ITUserBaseInfoService;
import com.hansy.transaction.service.base.BaseDao;


@Service
public class TUserBaseInfoServiceImpl extends BaseDao implements ITUserBaseInfoService{

	@Override
	public List<TUserBaseInfoVo> selectUserBaseInfo(String userNo) {
		@SuppressWarnings("unchecked")
		List<TUserBaseInfoVo> list = (List<TUserBaseInfoVo>)getSqlMapClientTemplate().queryForList("userBaseInfo.selectUserbaseInfo", null);
	 	return list;
	}
	/*@Override
	public Pager getMyOrderNoBill(Map<String, Object> map, Pager pager) {
		List<GoodAlls> list=new ArrayList<GoodAlls>();
		//获取pager后的list
		try {
			list=getSqlMapClientTemplate().queryForList("userBaseInfo.getMyOrderNoBill", map, (pager.getPageNo()-1)*pager.getPageSize(), pager.getPageSize());
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		//获取总记录数
		int count=0;
		try {
			count=(int) getSqlMapClientTemplate().queryForObject("userBaseInfo.getMyOrderNoBillTotal", map);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		pager.setTotal(count);
		pager.setRows(list);
		return pager;
	}*/
	@Override
	public BusinessMap<TUserBaseInfoBo> getUser(String custNo) {
		BusinessMap<TUserBaseInfoBo> bMap=new BusinessMap<TUserBaseInfoBo>();
		TUserBaseInfoBo uBaseInfoVo=new TUserBaseInfoBo();
		try {
			uBaseInfoVo=(TUserBaseInfoBo) getSqlMapClientTemplate().queryForObject("userBaseInfo.getUser", custNo);
			bMap.setIsSucc(true);
			bMap.setInfoBody(uBaseInfoVo);
		} catch (Exception e) {
			bMap.setMsg(e.getMessage());
			bMap.setIsSucc(false);
			e.printStackTrace();
		}
		return bMap;
	}

	@Override
	public int getLoginUserOrderCount(Map<String, String> param) {

		Integer count = 0;
		try {
			Integer buyCount = (Integer)getSqlMapClientTemplate().queryForObject("busOrder.selectBuyerOrdersCount", param);
			Integer supplyCount = (Integer)getSqlMapClientTemplate().queryForObject("busOrder.selectSupplyOrdersCount", param);
			count=buyCount+supplyCount;
		} catch (DataAccessException e) {
			e.printStackTrace();
		}
		return count;
	}
	
	
	@Override
	public String getCustName(String custNo) {
		String  custName = null;
		try {
			  custName = (String)getSqlMapClientTemplate().queryForObject("userBaseInfo.getCustName", custNo);
		} catch (DataAccessException e) {
			e.printStackTrace();
		}
		return  custName;
	}
	
	
}
