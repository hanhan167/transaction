
package com.hansy.transaction.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.hansy.transaction.common.BusinessMap;
import com.hansy.transaction.model.bo.CreateCart;
import com.hansy.transaction.model.bo.CreateOrder;
import com.hansy.transaction.model.bo.UserAddress;
import com.hansy.transaction.model.vo.TBusShoppCartVo;
import com.hansy.transaction.service.ITBusShoppCartService;
import com.hansy.transaction.service.base.BaseDao;



@Service
public class TBusShoppCartServiceImpl extends BaseDao implements ITBusShoppCartService {
	@Override
	public int getGoodsNo(String custNo) {
		int result=(int) getSqlMapClientTemplate().queryForObject("shoppCart.getGoodsNo", custNo);
		return result;
	}
	@Override
	public BusinessMap<Object> getShoppCart(String custNo) {
		BusinessMap<Object> bMap=new BusinessMap<Object>();
		List<TBusShoppCartVo> list=new ArrayList<TBusShoppCartVo>();
		try {
			list=getSqlMapClientTemplate().queryForList("shoppCart.selectAll", custNo);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("获取购物车失败，请重试！");
			e.printStackTrace();
			return bMap;
		}
		bMap.setIsSucc(true);
		bMap.setInfoBody(list);
		return bMap;
	}

	@Override
	public BusinessMap<Object> getDefaultAddress(String userNo) {
		BusinessMap<Object> bMap=new BusinessMap<Object>();
		UserAddress address=new UserAddress();
		try {
			address=(UserAddress) getSqlMapClientTemplate().queryForObject("shoppCart.selectAddressByUserNo", userNo);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("获取默认收货地址失败！");
			e.printStackTrace();
			return bMap;
		}
		bMap.setIsSucc(true);
		bMap.setInfoBody(address);
		return bMap;
	}

	@Override
	public BusinessMap<Object> delete(List<String> tableKey) {
		BusinessMap<Object> bMap=new BusinessMap<>();
		try {
			getSqlMapClientTemplate().delete("shoppCart.delete",tableKey);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("删除失败，请重试!");
			e.printStackTrace();
			return bMap;
		}
		bMap.setIsSucc(true);
		return bMap;
	}

	@Override
	public BusinessMap<Object> deleteInvalidGoods(Map<String, String> param) {
		BusinessMap<Object> bMap=new BusinessMap<>();
		try {
			getSqlMapClientTemplate().delete("shoppCart.deleteInvalidGoods", param);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("清空失败，请重试!");
			e.printStackTrace();
			return bMap;
		}
		bMap.setIsSucc(true);
		return bMap;
	}

	@Override
	public CreateOrder getCreateOrder(String tableKey) {
		CreateOrder createOrder=(CreateOrder) getSqlMapClientTemplate().queryForObject("shoppCart.getCreateOrder", tableKey);
		return createOrder;
	}

	@Override
	public BusinessMap<Object> getUserAddress(String custNo) {
		BusinessMap<Object> bMap=new BusinessMap<>();
		List<UserAddress> list=new ArrayList<>();
		try {
			list=getSqlMapClientTemplate().queryForList("shoppCart.getUserAddress", custNo);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("获取收货地址失败，请重试!");
			e.printStackTrace();
			return bMap;
		}
		bMap.setInfoBody(list);
		bMap.setIsSucc(true);
		return bMap;
	}

	@Override
	public BusinessMap<CreateCart> getCreateCart(Map<String, String> param) {
		BusinessMap<CreateCart> bMap=new BusinessMap<>();
		CreateCart createCart=new CreateCart();
		try {
			createCart=(CreateCart) getSqlMapClientTemplate().queryForObject("shoppCart.getCreateCart", param);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			e.printStackTrace();
			return bMap;
		}
		bMap.setInfoBody(createCart);
		bMap.setIsSucc(true);
		return bMap;
	}

	@Override
	public BusinessMap<Object> insert(TBusShoppCartVo shoppCartVo) {
		BusinessMap<Object> bMap=new BusinessMap<>();
		try {
			getSqlMapClientTemplate().insert("shoppCart.insert", shoppCartVo);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			e.printStackTrace();
			return bMap;
		}
		bMap.setIsSucc(true);
		return bMap;
	}

	@Override
	public BusinessMap<Object> getShoppCartSelected(Map<String, Object> map) {
		BusinessMap<Object> bMap=new BusinessMap<Object>();
		List<TBusShoppCartVo> list=new ArrayList<TBusShoppCartVo>();
		try {
			list=getSqlMapClientTemplate().queryForList("shoppCart.selectCartSelected", map);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("获取购物车订单失败，请重试！");
			e.printStackTrace();
			return bMap;
		}
		bMap.setIsSucc(true);
		bMap.setInfoBody(list);
		return bMap;
	}

	@Override
	public BusinessMap<Object> updateShoppCartNum(List<Map<String, Object>> map) {
		BusinessMap<Object> bMap=new BusinessMap<>();
		try {
			getSqlMapClientTemplate().update("shoppCart.updateNum", map);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("更新数量失败，请重试!");
			e.printStackTrace();
			return bMap;
		}
		bMap.setIsSucc(true);
		return bMap;
	}

	@Override
	public BusinessMap<Object> inserts(List<TBusShoppCartVo> shoppCartVo) {
		BusinessMap<Object> bMap=new BusinessMap<>();
		try {
			getSqlMapClientTemplate().insert("shoppCart.saveCart", shoppCartVo);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			e.printStackTrace();
			return bMap;
		}
		bMap.setIsSucc(true);
		return bMap;
	}

	@Override
	public BusinessMap<Object> isExist(Map<String, Object> map) {
		BusinessMap<Object> bMap=new BusinessMap<>();
		TBusShoppCartVo Vo;
		try {
			Vo = (TBusShoppCartVo) getSqlMapClientTemplate().queryForObject("shoppCart.isExist", map);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			e.printStackTrace();
			return bMap;
		}
		if (Vo == null ) {
			bMap.setIsSucc(true);
			return bMap;
		}
		bMap.setInfoBody(Vo);
		bMap.setIsSucc(false);
		return bMap;
		
	}
	@Override
	public List<TBusShoppCartVo> selectIsExist(String custNo) {
		List<TBusShoppCartVo> list=new ArrayList<TBusShoppCartVo>();
		try {
			list=getSqlMapClientTemplate().queryForList("shoppCart.selectIsExist", custNo);
		} catch (Exception e) {
			
		}
		return list;
	}
	
	@Override
	public BusinessMap<Object> deleteInvalidGoods1(Map<String, String> param) {
		BusinessMap<Object> bMap=new BusinessMap<>();
		try {
			getSqlMapClientTemplate().delete("shoppCart.deleteInvalidGoods1", param);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("清空失败，请重试!");
			e.printStackTrace();
			return bMap;
		}
		bMap.setIsSucc(true);
		return bMap;
	}
	@Override
	public BusinessMap<CreateCart> getCreateCart1(Map<String, String> param) {
		BusinessMap<CreateCart> bMap = new BusinessMap<>();
		List<CreateCart> createCarts = new ArrayList<CreateCart>();
		try {
		createCarts = getSqlMapClientTemplate().queryForList("shoppCart.getCreateCart",param);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			e.printStackTrace();
			return bMap;
		}
		bMap.setInfoBody(createCarts.size()>0?createCarts.get(0):null);
		bMap.setIsSucc(true);
		return bMap;
	}

	

	

}

