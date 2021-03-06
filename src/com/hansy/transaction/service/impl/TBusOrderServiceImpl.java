package com.hansy.transaction.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import com.hansy.transaction.common.BusinessMap;
import com.hansy.transaction.common.utils.AllPager;
import com.hansy.transaction.common.utils.Pager;
import com.hansy.transaction.model.bo.Order;
import com.hansy.transaction.model.vo.GoodAlls;
import com.hansy.transaction.model.vo.TBusOrderDetlVo;
import com.hansy.transaction.model.vo.TBusOrderSplitVo;
import com.hansy.transaction.model.vo.TBusOrderVo;
import com.hansy.transaction.model.vo.TUserSupplyInfoVo;
import com.hansy.transaction.service.ITBusOrderService;
import com.hansy.transaction.service.base.BaseDao;

@Service
public class TBusOrderServiceImpl extends BaseDao implements ITBusOrderService {

	@Override
	public BusinessMap<Pager> selectSupplyOrders(Map<String, Object> param,
			Pager pager) {
		BusinessMap<Pager> bMap = new BusinessMap<>();
		// 获取分页的list
		List<Order> orderNoList = new ArrayList<>();
		List list = new ArrayList<>();

		try {
			orderNoList = getSqlMapClientTemplate().queryForList(
					"busOrder.selectSupplyOrdersCountpage", param,
					(pager.getPageNo() - 1) * pager.getPageSize(),
					pager.getPageSize());
			if (orderNoList.size() == 0) {
				param.put("orderNoList", null);
			} else {
				param.put("orderNoList", orderNoList);
			}

			list = getSqlMapClientTemplate().queryForList(
					"busOrder.selectSupplyOrders1", param);

		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("获取分页内容失败");
			e.printStackTrace();
			return bMap;
		}

		// 获取总记录数
		int count = 0;
		try {
			count = (int) getSqlMapClientTemplate().queryForObject(
					"busOrder.selectSupplyOrdersCount", param);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("获取总记录数失败");
			e.printStackTrace();
			return bMap;
		}
		pager.setTotal(count);
		pager.setRows(list);
		bMap.setInfoBody(pager);
		bMap.setIsSucc(true);
		return bMap;
	}

	@Override
	public BusinessMap<Pager> selectBuyerOrders(Map<String, Object> param,
			Pager pager) {
		BusinessMap<Pager> bMap = new BusinessMap<>();
		// 获取分页的list
		List<Order> orderNoList = new ArrayList<>();
		List list = new ArrayList<>();

		try {
			orderNoList = getSqlMapClientTemplate().queryForList(
					"busOrder.selectBuyerPageOrders", param,
					(pager.getPageNo() - 1) * pager.getPageSize(),
					pager.getPageSize());
			System.out.println(orderNoList.size());
			if (orderNoList.size() == 0) {
				param.put("orderNoList", null);
			} else {
				param.put("orderNoList", orderNoList);
			}
			list = getSqlMapClientTemplate().queryForList(
					"busOrder.selectBuyerOrders1", param);

		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("获取分页内容失败");
			e.printStackTrace();
			return bMap;
		}

		// 获取总记录数
		int count = 0;
		try {
			count = (int) getSqlMapClientTemplate().queryForObject(
					"busOrder.selectBuyerOrdersCount", param);
			System.out.println("count:"+count);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("获取总记录数失败");
			e.printStackTrace();
			return bMap;
		}
		pager.setTotal(count);
		pager.setRows(list);
		bMap.setInfoBody(pager);
		bMap.setIsSucc(true);
		return bMap;
	}

	
	
	/**
	 * App专用
	 */
	@Override
	public BusinessMap<AllPager> selectBuyerOrders(Map<String, Object> param) {
		BusinessMap<AllPager> bMap = new BusinessMap<>();
		AllPager allPager = new AllPager();
		// 获取分页的list
		List<Order> orderNoList = new ArrayList<>();
		List list = new ArrayList<>();

		try {
			orderNoList = getSqlMapClientTemplate().queryForList(
					"busOrder.selectBuyerPageOrders", param);
			if (orderNoList.size() == 0) {
				param.put("orderNoList", null);
			} else {
				param.put("orderNoList", orderNoList);
			}
			list = getSqlMapClientTemplate().queryForList(
					"busOrder.selectBuyerOrders1", param);

		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("获取分页内容失败");
			e.printStackTrace();
			return bMap;
		}

		// 获取总记录数
		int count = 0;
		try {
			count = (int) getSqlMapClientTemplate().queryForObject(
					"busOrder.selectBuyerOrdersCount", param);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("获取总记录数失败");
			e.printStackTrace();
			return bMap;
		}
		allPager.setCount(count);
		allPager.setTotal(count);
		allPager.setRows(list);
		bMap.setInfoBody(allPager);
		bMap.setIsSucc(true);
		return bMap;
	}

	@Override
	public BusinessMap<Object> getApplyOrderCount(Map<String, String> param) {
		BusinessMap<Object> bMap = new BusinessMap<>();
		// 获取的总记录数封装成map
		Map<String, Integer> countMap = new HashMap<>();
		// 获取供方订单状态已完成
		param.put("orderStatus", "090005");
		Integer complete = (int) getSqlMapClientTemplate().queryForObject(
				"busOrder.selectSupplyOrdersCount", param);
		countMap.put("complete", complete);
		// 获取供方待付款订单数
		param.put("orderStatus", "090003");
		Integer pay = (int) getSqlMapClientTemplate().queryForObject(
				"busOrder.selectSupplyOrdersCount", param);
		countMap.put("pay", pay);
		// 获取供方待收货订单数
		param.put("orderStatus", "090004");
		Integer get = (int) getSqlMapClientTemplate().queryForObject(
				"busOrder.selectSupplyOrdersCount", param);
		countMap.put("get", get);

		// 获取供方待确认订单数
		param.put("orderStatus", "090001");
		Integer confirmed = (int) getSqlMapClientTemplate().queryForObject(
				"busOrder.selectSupplyOrdersCount", param);
		countMap.put("confirmed", confirmed);

		// 获取供方待发货订单数
		param.put("orderStatus", "090002");
		Integer readyShip = (int) getSqlMapClientTemplate().queryForObject(
				"busOrder.selectSupplyOrdersCount", param);
		countMap.put("readyShip", readyShip);
		// 获取供方取消订单数
		param.put("orderStatus", "090006");
		Integer cancel = (int) getSqlMapClientTemplate().queryForObject(
				"busOrder.selectSupplyOrdersCount", param);
		countMap.put("cancel", cancel);
		// 获取供方所有订单
		Integer all = 0;
		param.remove("orderStatus");
		try {
			all = (int) getSqlMapClientTemplate().queryForObject(
					"busOrder.selectSupplyOrdersCount", param);
		} catch (Exception e) {
			e.printStackTrace();
		}
		countMap.put("all", all);

		bMap.setIsSucc(true);
		bMap.setInfoBody(countMap);
		return bMap;
	}

	@Override
	public BusinessMap<Object> getBuyerOrderCount(Map<String, String> param) {
		BusinessMap<Object> bMap = new BusinessMap<>();
		// 获取的总记录数封装成map
		Map<String, Integer> countMap = new HashMap<>();
		// 获取买方待确认订单数
		param.put("orderStatus", "090001");
		Integer sure = (int) getSqlMapClientTemplate().queryForObject(
				"busOrder.selectBuyerOrdersCount", param);
		countMap.put("sure", sure);
		// 获取买方待发货订单数
		param.put("orderStatus", "090002");
		Integer post = (int) getSqlMapClientTemplate().queryForObject(
				"busOrder.selectBuyerOrdersCount", param);
		countMap.put("post", post);
		// 获取买方完成订单数
		param.put("orderStatus", "090005");
		Integer complete = (int) getSqlMapClientTemplate().queryForObject(
				"busOrder.selectBuyerOrdersCount", param);
		countMap.put("complete", complete);

		// 获取买方待付款订单数
		param.put("orderStatus", "090003");
		Integer payment = (int) getSqlMapClientTemplate().queryForObject(
				"busOrder.selectBuyerOrdersCount", param);
		countMap.put("payment", payment);

		// 获取买方待收货订单数
		param.put("orderStatus", "090004");
		Integer readCollect = (int) getSqlMapClientTemplate().queryForObject(
				"busOrder.selectBuyerOrdersCount", param);
		countMap.put("readCollect", readCollect);

		// 获取买方已取消订单数
		param.put("orderStatus", "090006");
		Integer cancelCollect = (int) getSqlMapClientTemplate().queryForObject(
				"busOrder.selectBuyerOrdersCount", param);
		countMap.put("cancel", cancelCollect);

		// 获取买方所有订单
		Integer all = 0;
		param.remove("orderStatus");
		try {
			all = (int) getSqlMapClientTemplate().queryForObject(
					"busOrder.selectBuyerOrdersCount", param);
		} catch (Exception e) {
			e.printStackTrace();
		}
		countMap.put("all", all);
		bMap.setIsSucc(true);
		bMap.setInfoBody(countMap);
		return bMap;
	}

	@Override
	public BusinessMap<Object> updateStatus(Map<String, Object> params) {
		BusinessMap<Object> bMap = new BusinessMap<>();
		try {
			getSqlMapClientTemplate().update("busOrder.updateStatus", params);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg(e.getMessage());
			e.printStackTrace();
			return bMap;
		}
		bMap.setIsSucc(true);
		return bMap;
	}

	@Override
	public BusinessMap<Object> saveOrder(List<TBusOrderVo> orderList) {
		BusinessMap<Object> bMap = new BusinessMap<>();
		try {
			getSqlMapClientTemplate().insert("busOrder.saveOrder", orderList);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			e.printStackTrace();
			return bMap;
		}
		bMap.setIsSucc(true);
		return bMap;
	}

	@Override
	public List<TBusOrderVo> getById(String orderNo) {
		List<TBusOrderVo> orderVo = (List<TBusOrderVo>) getSqlMapClientTemplate()
				.queryForList("busOrder.getById", orderNo);
		System.out.println(orderVo.toString());
		return orderVo;
	}

	@Override
	public TBusOrderVo getByGoodNo(String tablekey) {
		List<TBusOrderVo> orderVo = (List<TBusOrderVo>) getSqlMapClientTemplate()
				.queryForList("busOrder.getByGoodNo", tablekey);
		return orderVo.size() > 0 ? orderVo.get(0) : null;
	}

	@Override
	public BusinessMap<Object> updateOrderStatus(Map<String, Object> param) {
		BusinessMap<Object> bMap = new BusinessMap<>();
		try {
			getSqlMapClientTemplate().update("busOrder.updateOrderStatus",
					param);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("操作失败，请重试");
			e.printStackTrace();
			return bMap;
		}
		bMap.setIsSucc(true);
		return bMap;
	}

	@Override
	public BusinessMap<Object> updateOrderPrice(Map<String, Object> param) {
		BusinessMap<Object> bMap = new BusinessMap<>();
		try {
			getSqlMapClientTemplate()
					.update("busOrder.updateOrderPrice", param);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("操作失败，请重试");
			e.printStackTrace();
			return bMap;
		}
		bMap.setIsSucc(true);
		return bMap;
	}

	@Override
	public BusinessMap<Object> insertOrderHis(TBusOrderVo tBusOrderVo) {
		BusinessMap<Object> bMap = new BusinessMap<>();
		try {
			getSqlMapClientTemplate().insert("busOrder.saveOrderHis",
					tBusOrderVo);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("操作失败，请重试");
			e.printStackTrace();
			return bMap;
		}
		bMap.setIsSucc(true);
		return bMap;
	}

	@Override
	public BusinessMap<Object> updateStatusSell(Map<String, Object> params) {
		BusinessMap<Object> bMap = new BusinessMap<>();
		try {
			getSqlMapClientTemplate().update("busOrder.updateStatusSell",
					params);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg(e.getMessage());
			e.printStackTrace();
			return bMap;
		}
		bMap.setIsSucc(true);
		return bMap;
	}

	@Override
	public BusinessMap<Object> getOldById(Map<String, Object> map) {
		BusinessMap<Object> bmap = new BusinessMap<>();
		List<TBusOrderVo> orders = new ArrayList<>();
		try {
			orders = getSqlMapClientTemplate().queryForList(
					"busOrder.selectBuyerOldOrders", map);
			bmap.setInfoBody(orders);
		} catch (Exception e) {
			bmap.setIsSucc(false);
			bmap.setMsg(e.getMessage());
			e.printStackTrace();
			return bmap;
		}
		return bmap;
	}

	@Override
	public List<Order> getByidDteail(String orderNo) {
		List<Order> orderVo = (List<Order>) getSqlMapClientTemplate()
				.queryForList("busOrder.getByidDteail", orderNo);
		return orderVo;
	}

	@Override
	public BusinessMap<Object> updateOrderSpiltStatus(Map<String, Object> param) {
		BusinessMap<Object> bMap = new BusinessMap<>();
		try {
			getSqlMapClientTemplate().update("busOrder.updateOrderSpiltStatus",
					param);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("操作失败，请重试");
			e.printStackTrace();
			return bMap;
		}
		bMap.setIsSucc(true);
		return bMap;
	}

	@Override
	public TBusOrderVo getByTableKey(String tableKey) {
		List<TBusOrderVo> list = (List<TBusOrderVo>) getSqlMapClientTemplate()
				.queryForList("busOrder.getByTableKey", tableKey);
		return list.size() > 0 ? list.get(0) : null;
	}

	@Override
	public BusinessMap<Object> insertOrderHis1(TBusOrderSplitVo tBusOrderSplitVo) {
		BusinessMap<Object> bMap = new BusinessMap<>();
		try {
			getSqlMapClientTemplate().insert("busOrder.saveOrderHis1",
					tBusOrderSplitVo);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("操作失败，请重试");
			e.printStackTrace();
			return bMap;
		}
		bMap.setIsSucc(true);
		return bMap;
	}

	@Override
	public TUserSupplyInfoVo getUserSupplyDetail(String custNo) {
		List<TUserSupplyInfoVo> list = (List<TUserSupplyInfoVo>) getSqlMapClientTemplate()
				.queryForList("busOrder.getUserSupplyDetail", custNo);

		return list.size() > 0 ? list.get(0) : null;
	}

	@Override
	public Pager productRank(Map<String, Object> map, Pager pager) {
		List<GoodAlls> list = new ArrayList<GoodAlls>();
		// 获取pager后的list
		try {
			list = getSqlMapClientTemplate().queryForList(
					"busOrder.productRank", map,
					(pager.getPageNo() - 1) * pager.getPageSize(),
					pager.getPageSize());
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		// 获取总记录数
		int count = 0;
		try {
			count = (int) getSqlMapClientTemplate().queryForObject(
					"busOrder.productRankTotal", map);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		pager.setTotal(count);
		pager.setRows(list);
		return pager;
	}

	// 新增物流号
	@Override
	public void lgtSend(TBusOrderVo busOrderVo) {
		try {
			getSqlMapClientTemplate().update("busOrder.updateLgt", busOrderVo);
		} catch (DataAccessException e) {
			e.printStackTrace();
		}
	}

	/**********************************新增发票信息**********************************/
	
	/**
	 * 获取买方的未开发票订单以及已开发票订单的条数
	 */
	@Override
	public BusinessMap<Object> getBuyerOrderCountInvoic(
			Map<String, String> param) {
		BusinessMap<Object> bMap = new BusinessMap<>();
		// 获取的总记录数封装成map
		Map<String, Integer> countMap = new HashMap<>();
		// 获取买方未打印订单数量(完成订单数)
		param.put("orderStatus", "090005");
		Integer buyerNoInvoice = (int) getSqlMapClientTemplate().queryForObject(
				"busOrder.selectBuyerOrdersCountInvoic", param);
		countMap.put("buyerNoInvoice", buyerNoInvoice);
		// 获取买方已打印订单数量(完成订单数)
		param.put("invoicStatus", "001");
		Integer buyerOpenInvoice = (int) getSqlMapClientTemplate().queryForObject(
				"busOrder.selectBuyerOrdersCountInvoic", param);
		countMap.put("buyerOpenInvoice", buyerOpenInvoice);
		bMap.setIsSucc(true);
		bMap.setInfoBody(countMap);
		return bMap;
	}

	@Override
	public BusinessMap<Pager> selectBuyerOrdersInvoic(
			Map<String, Object> param, Pager pager) {
		BusinessMap<Pager> bMap = new BusinessMap<>();
		// 获取分页的list
		List<Order> orderNoList = new ArrayList<>();
		List list = new ArrayList<>();

		try {
			
			orderNoList = getSqlMapClientTemplate().queryForList(
					"busOrder.selectBuyerPageOrdersInvoic", param,
					(pager.getPageNo() - 1) * pager.getPageSize(),
					pager.getPageSize());
			System.out.println(orderNoList.size());
			if (orderNoList.size() == 0) {
				param.put("orderNoList", null);
			} else {
				param.put("orderNoList", orderNoList);
			}
			list = getSqlMapClientTemplate().queryForList(
					"busOrder.selectBuyerOrders1Invoic", param);

		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("获取分页内容失败");
			e.printStackTrace();
			return bMap;
		}

		// 获取总记录数
		int count = 0;
		try {
			count = (int) getSqlMapClientTemplate().queryForObject(
					"busOrder.selectBuyerOrdersCountInvoic", param);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("获取总记录数失败");
			e.printStackTrace();
			return bMap;
		}
		pager.setTotal(count);
		pager.setRows(list);
		bMap.setInfoBody(pager);
		bMap.setIsSucc(true);
		return bMap;
	}
	
	/**
	 * 获取供方方的未开发票订单以及已开发票订单的条数
	 */
	@Override
	public BusinessMap<Object> getApplyOrderCountInvoice(Map<String, String> param) {
		BusinessMap<Object> bMap = new BusinessMap<>();
		// 获取的总记录数封装成map
		Map<String, Integer> countMap = new HashMap<>();
		// 获取供方未打印发票订单数量(完成订单数)
		param.put("orderStatus", "090005");
		Integer supplyNoInvoice = (int) getSqlMapClientTemplate().queryForObject(
				"busOrder.selectSupplyOrdersCountInvoice", param);
		countMap.put("supplyNoInvoice", supplyNoInvoice);
		//获取供方已打印发票订单数量(完成订单数)
		param.put("invoicStatus", "001");
		Integer supplyOpenInvoice = (int) getSqlMapClientTemplate().queryForObject(
				"busOrder.selectSupplyOrdersCountInvoice", param);
		countMap.put("supplyOpenInvoice", supplyOpenInvoice);
		bMap.setIsSucc(true);
		bMap.setInfoBody(countMap);
		return bMap;
	}

	@Override
	public BusinessMap<Pager> selectSupplyOrdersInvoice(Map<String, Object> param,
			Pager pager) {
		BusinessMap<Pager> bMap = new BusinessMap<>();
		// 获取分页的list
		List<Order> orderNoList = new ArrayList<>();
		List list = new ArrayList<>();

		try {
			orderNoList = getSqlMapClientTemplate().queryForList(
					"busOrder.selectSupplyOrdersCountpageInvoice", param,
					(pager.getPageNo() - 1) * pager.getPageSize(),
					pager.getPageSize());
			if (orderNoList.size() == 0) {
				param.put("orderNoList", null);
			} else {
				param.put("orderNoList", orderNoList);
			}

			list = getSqlMapClientTemplate().queryForList(
					"busOrder.selectSupplyOrders1Invoice", param);

		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("获取分页内容失败");
			e.printStackTrace();
			return bMap;
		}

		// 获取总记录数
		int count = 0;
		try {
			count = (int) getSqlMapClientTemplate().queryForObject(
					"busOrder.selectSupplyOrdersCountInvoice", param);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("获取总记录数失败");
			e.printStackTrace();
			return bMap;
		}
		pager.setTotal(count);
		pager.setRows(list);
		bMap.setInfoBody(pager);
		bMap.setIsSucc(true);
		return bMap;
	}

	@Override
	public BusinessMap<Object> updateOrderIncoiceStatus(String[] orderNoArr) {
		BusinessMap<Object> bMap = new BusinessMap<>();
		bMap.setIsSucc(true);
		
		TBusOrderVo busOrder = new TBusOrderVo();
		if(orderNoArr == null){
			bMap.setIsSucc(false);
			bMap.setMsg("没拿到orderNo");
			return bMap;
		}
		for (int i = 0; i < orderNoArr.length; i++) {
			busOrder.setOrderNo(orderNoArr[i]);
			try {
				getSqlMapClientTemplate().update("busOrder.updateInvoiceStatus", busOrder);
			} catch (Exception e) {
				bMap.setIsSucc(false);
				bMap.setMsg(e.getMessage());
				e.printStackTrace();
			}
		}
		return bMap;
	}

	@Override
	public BusinessMap<TBusOrderVo> getOrderMoney(String orderNo) {
		BusinessMap<TBusOrderVo> bMap = new BusinessMap<>();
		bMap.setIsSucc(true);
		
//		TBusOrderVo busOrder = new TBusOrderVo();
//		busOrder.setOrderNo(orderNo);
		try {
			TBusOrderVo	busOrder = (TBusOrderVo) getSqlMapClientTemplate().queryForObject("busOrder.getOrderMoney", orderNo);
			System.out.println(busOrder.toString());
			bMap.setInfoBody(busOrder);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("查询订单信息异常");
			e.printStackTrace();
		}
		
		return bMap;
	}

	@Override
	public BusinessMap<TBusOrderVo> getOrderMoneyTotal(String orderNo) {
		BusinessMap<TBusOrderVo> bMap = new BusinessMap<>();
		bMap.setIsSucc(true);
		
//		TBusOrderVo busOrder = new TBusOrderVo();
//		busOrder.setOrderNo(orderNo);
		try {
			TBusOrderVo	busOrder = (TBusOrderVo) getSqlMapClientTemplate().queryForObject("busOrder.getOrderMoneyTotal", orderNo);
			System.out.println(busOrder.toString());
			bMap.setInfoBody(busOrder);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("查询总额异常");
			e.printStackTrace();
		}
		
		return bMap;
	}

}
