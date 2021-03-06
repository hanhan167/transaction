
package com.hansy.transaction.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.net.URLDecoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.http.HttpResponse;
import org.apache.http.util.EntityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;
import com.hansy.transaction.common.BaseReslt;
import com.hansy.transaction.common.BusinessMap;
import com.hansy.transaction.common.constants.OrderConstants;
import com.hansy.transaction.common.constants.UserConstants;
import com.hansy.transaction.common.utils.AllPager;
import com.hansy.transaction.common.utils.DateUtil;
import com.hansy.transaction.common.utils.Pager;
import com.hansy.transaction.common.utils.SerialNumberUtils;
import com.hansy.transaction.common.utils.StringUtil;
import com.hansy.transaction.common.utils.UUIDUtil;
import com.hansy.transaction.model.bo.CreateOrder;
import com.hansy.transaction.model.bo.CustomerDisplay;
import com.hansy.transaction.model.bo.Order;
import com.hansy.transaction.model.bo.SupplyLimitPrice;
import com.hansy.transaction.model.bo.TUserBaseInfoBo;
import com.hansy.transaction.model.vo.OrderList;
import com.hansy.transaction.model.vo.TBusAddress;
import com.hansy.transaction.model.vo.TBusBillVo;
import com.hansy.transaction.model.vo.TBusOrderDetlVo;
import com.hansy.transaction.model.vo.TBusOrderVo;
import com.hansy.transaction.model.vo.TUserAddressVo;
import com.hansy.transaction.model.vo.TUserBill;
import com.hansy.transaction.model.vo.TUserSupplyInfoVo;
import com.hansy.transaction.service.ICustomerDisplayService;
import com.hansy.transaction.service.ITBusAddressService;
import com.hansy.transaction.service.ITBusBillService;
import com.hansy.transaction.service.ITBusOrderDetlService;
import com.hansy.transaction.service.ITBusOrderService;
import com.hansy.transaction.service.ITBusOrderSplitService;
import com.hansy.transaction.service.ITBusShoppCartService;
import com.hansy.transaction.service.ITSupplyLimtPriceService;
import com.hansy.transaction.service.ITUserAddressService;
import com.hansy.transaction.service.ITUserBaseInfoService;
import com.hansy.transaction.service.ITUserBillService;
import com.hansy.transaction.util.HttpUtils;

/**
 * 订单类控制器
 * TODO javadoc for com.hansy.transaction.action.BusOrderAction
 * @Copyright: 2017成都环赛信息技术有限公司
 * @author: cj
 * @since: 2017年3月10日
 */
@Controller
@RequestMapping("/busOrder")
public class BusOrderAction {

	@Resource
	private ITBusOrderService busOrderService;
	@Resource
	private ITBusOrderDetlService orderDetlService;
	@Resource
	private ITBusShoppCartService shoppCartService;
	@Resource
	private ITBusOrderSplitService orderSplitService;
	@Resource
	private ITBusBillService itBusBillService;
	@Resource
	private ITUserBillService itUserBillService;
	@Resource
	private ITBusAddressService itBusAddressService;
	@Resource
	private ITUserAddressService addressService;
	@Resource
	private ITSupplyLimtPriceService priceService;
	@Resource
	private ITUserBaseInfoService baseInfoService;
	@Resource
	private ICustomerDisplayService customerDisplayService;

	@RequestMapping("/productRank")
	@ResponseBody
	public BaseReslt<Object> productRank(Integer pageNo,HttpSession session,String Sort1,String Sort2,String query,String startTime,String endTime)throws Exception{
		if (pageNo==null) {
			pageNo=1;
		}
		startTime ="2017-09-04";
		endTime = "2017-09-04";

		BaseReslt<Object> bReslt=new BaseReslt<Object>();
		TUserBaseInfoBo baseInfoVo=(TUserBaseInfoBo) session.getAttribute("loginUser");
		int pageSize=5;
		Pager pager=new Pager();
		pager.setPageNo(pageNo);
		pager.setPageSize(pageSize);
		Map<String, Object>map = new HashMap<>();
		map.put("query", query);
		map.put("startTime", startTime);
		if(Sort2!=null&&Sort2!=""){
			map.put("Sort2", Sort2);
		}
		if(Sort1!=null&&Sort1!=""){
			map.put("Sort1", Sort1);
		}
		map.put("orderStatus", "090005");
		if (endTime != "") {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Calendar cd = Calendar.getInstance();
			cd.setTime(sdf.parse(endTime));
			cd.add(Calendar.DATE, 1);//  增加一天
			map.put("endTime", sdf.format(cd.getTime()));
		}else{
			map.put("endTime", endTime);
		}
		Pager resultPage=busOrderService.productRank(map,pager);
		bReslt.setObj(pager);
		return bReslt;
	}



	@RequestMapping("/getBillByOrderNo")
	@ResponseBody
	public BaseReslt<Pager<TBusBillVo>> getBillByOrderNo(String orderNo,String pageNo,HttpSession session,String startTime,String endTime){
		BaseReslt<Pager<TBusBillVo>> bReslt=new BaseReslt<>();
		Pager<TBusBillVo>pager = new Pager<TBusBillVo>();
		Map<String, String>map = new HashMap<>();
//		String custNo=(String) session.getAttribute("custNo");
		map.put("orderNo", orderNo);
		map.put("pageNo", pageNo);
//		map.put("custNo", custNo);
		map.put("startTime", startTime);
		if (endTime != ""&&endTime!=null) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Calendar cd = Calendar.getInstance();
			try {
				cd.setTime(sdf.parse(endTime));
				cd.add(Calendar.DATE, 1);// 增加一天
				map.put("endTime", sdf.format(cd.getTime()));
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}else{
			map.put("endTime", endTime);
		}
		try {
			//默认每页8条数据
			pager.setPageNo(Integer.parseInt(pageNo == null ? "1" : pageNo));
			pager.setPageSize(8);
			Pager<TBusBillVo>pager2= itBusBillService.getBillByOrderNo(map, pager);
			bReslt.setSuccess(true);
			bReslt.setObj(pager2);
			return bReslt;
		} catch (Exception e) {
			bReslt.setSuccess(false);
			bReslt.setMsg("获取数据失败");
			return bReslt;
		}
	}




	@RequestMapping("/save")
	@ResponseBody
	public  BaseReslt<Object> save(HttpSession session,TBusBillVo tBusBillVo){
		System.out.println(tBusBillVo.toString());
		BaseReslt<Object> bReslt=new BaseReslt<Object>();
		String custNo=(String) session.getAttribute("custNo");
		tBusBillVo.setBillStatus("1");
		tBusBillVo.setInsertDate(new Date());
		tBusBillVo.setUpdateDate(new Date());
		tBusBillVo.setCustNo(custNo);
		System.out.println(tBusBillVo.toString());
		BusinessMap<Object> bMap2=itBusBillService.save(tBusBillVo);
		BusinessMap<Object> bMap1=itUserBillService.getById(custNo);
		TUserBill bill = new TUserBill();
		bill.setCustNo(custNo);
		bill.setBillReceipt(tBusBillVo.getBillReceipt());
		bill.setBillReceivePhone(tBusBillVo.getBillReceivePhone());
		bill.setBillReceiveAddress(tBusBillVo.getBillReceiveAddress());
		bill.setCompanyName(tBusBillVo.getCompanyName());
		bill.setRegisterPhone(tBusBillVo.getRegisterPhone());
		bill.setOpenBand(tBusBillVo.getOpenBand());
		bill.setBandCard(tBusBillVo.getBandCard());
		bill.setBillReceiveName(tBusBillVo.getBillReceiveName());
		bill.setBillReceiveMail(tBusBillVo.getBillReceiveMail());
		bill.setBillMoney(tBusBillVo.getBillMoney());
		bill.setBillTitle(tBusBillVo.getBillTitle());
		bill.setBillType(tBusBillVo.getBillType());
		bill.setBillStatus(tBusBillVo.getBillStatus());
		bill.setBillContent(tBusBillVo.getBillContent());
		System.out.println(bill.toString());
		if(bMap1.getInfoBody()==null){
			itUserBillService.save(bill);
		}else{
			itUserBillService.update(bill);
		}
		if (!bMap2.getIsSucc()||!bMap1.getIsSucc()) {
			bReslt.setSuccess(false);
			bReslt.setMsg(bMap2.getMsg());
		}
		return bReslt;
	}

	/**
	 * 获取供应方订单列表
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月14日
	 * @modifier:
	 * @modifiedDate:
	 * @param pageNo
	 * @param session
	 * @return
	 */
	@RequestMapping("/getSupplyOrders")
	@ResponseBody
	public BaseReslt<Object> getSupplyOrders(Integer pageNo,HttpSession session,String orderStatus,String query){
		BaseReslt<Object> bReslt=new BaseReslt<Object>();
		String custNo=(String) session.getAttribute("custNo");
		//查询参数，第一个参数为custNo,第二个参数为orderStatus(可为空),
		Map<String, Object> param=new HashMap<String,Object>();
		param.put("custNo", custNo);
		param.put("orderStatus", orderStatus);
		param.put("queryWay", query);
		//默认每页1条数据
		int pageSize=8;
		Pager pager=new Pager();
		//初始化page对象
		pager.setPageSize(pageSize);
		pager.setPageNo(pageNo);
		BusinessMap<Pager> bMap=busOrderService.selectSupplyOrders(param,pager);
		if (!bMap.getIsSucc()) {
			bReslt.setSuccess(false);
			bReslt.setMsg(bMap.getMsg());
			return bReslt;
		}

		//循环遍历订单，获取备注消息
		Pager resultPage=bMap.getInfoBody();
		//获取订单list
				List<Order> oList=resultPage.getRows();
				//订单备注list
				List<Object> dList=new ArrayList<>();
				Map<String, String>map = new HashMap<>();

				for (int i = 0; i < oList.size(); i++) {
					map.put(oList.get(i).getOrderNo(), oList.get(i).getOrderNo());
				}
				Iterator<String> iter5=map.values().iterator();
				Map<String, Object> map2 = new HashMap<>();
				while (iter5.hasNext()){
					String xObject =iter5.next();
					BusinessMap<Object> bMap2=orderDetlService.getOrderDetl(xObject);
					dList=(List<Object>) bMap2.getInfoBody();
					map2.put(xObject, (List<Object>) bMap2.getInfoBody());
				}
				bReslt.setMap(map2);
		resultPage.setRows(oList);
		bReslt.setObj(resultPage);
		bReslt.setSuccess(true);
		return bReslt;
	}

	/**
	 * 获取买方订单列表
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月14日
	 * @modifier:
	 * @modifiedDate:
	 * @param pageNo
	 * @param session
	 * @return
	 */
	@RequestMapping("/getBuyerOrders")
	@ResponseBody
	public BaseReslt<Object> getBuyerOrders(Integer pageNo,HttpSession session,String orderStatus,String query){
		BaseReslt<Object> bReslt=new BaseReslt<Object>();
		String custNo=(String) session.getAttribute("custNo");
		//查询参数，第一个参数为custNo,第二个参数为orderStatus(可为空),
		Map<String, Object> param=new HashMap<String,Object>();
		param.put("custNo", custNo);
		param.put("orderStatus", orderStatus);
		param.put("queryWay", query);

		//默认每页8条数据
		int pageSize=8;
		Pager pager=new Pager();
		//初始化page对象
		pager.setPageSize(pageSize);
		pager.setPageNo(pageNo);
		BusinessMap<Pager> bMap=busOrderService.selectBuyerOrders(param,pager);
		if (!bMap.getIsSucc()) {
			bReslt.setSuccess(false);
			bReslt.setMsg(bMap.getMsg());
			return bReslt;
		}

		//循环遍历订单，获取备注消息
		Pager resultPage=bMap.getInfoBody();
		//获取订单list
		List<Order> oList=resultPage.getRows();
		//订单备注list
		List<Object> dList=new ArrayList<>();
		Map<String, String>map = new HashMap<>();

		for (int i = 0; i < oList.size(); i++) {
			map.put(oList.get(i).getOrderNo(), oList.get(i).getOrderNo());
		}
		Iterator<String> iter5=map.values().iterator();
		Map<String, Object> map2 = new HashMap<>();
		while (iter5.hasNext()){
			String xObject =iter5.next();
			BusinessMap<Object> bMap2=orderDetlService.getOrderDetl(xObject);
			dList=(List<Object>) bMap2.getInfoBody();
			map2.put(xObject, (List<Object>) bMap2.getInfoBody());
		}
		bReslt.setList(dList);
		bReslt.setMap(map2);
		resultPage.setRows(oList);
		bReslt.setObj(resultPage);
		bReslt.setSuccess(true);
		return bReslt;
	}


	/**
	 * 获取买方订单列表App
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月14日
	 * @modifier:
	 * @modifiedDate:
	 * @param pageNo
	 * @param session
	 * @return
	 */
	@RequestMapping("/getBuyerOrdersApp")
	@ResponseBody
	public BaseReslt<Object> getBuyerOrdersApp(Integer pageNo,HttpSession session,String orderStatus,String query){
		BaseReslt<Object> bReslt=new BaseReslt<Object>();
		String custNo=(String) session.getAttribute("custNo");
		//查询参数，第一个参数为custNo,第二个参数为orderStatus(可为空),
		Map<String, Object> param=new HashMap<String,Object>();
		param.put("custNo", custNo);
		param.put("orderStatus", orderStatus);
		param.put("queryWay", query);
		

		AllPager allPager=new AllPager();
		//初始化Allpage对象
		BusinessMap<AllPager> bMap=busOrderService.selectBuyerOrders(param);
		if (!bMap.getIsSucc()) {
			bReslt.setSuccess(false);
			bReslt.setMsg(bMap.getMsg());
			return bReslt;
		}

		//循环遍历订单，获取备注消息
		AllPager resultPage=bMap.getInfoBody();
		//获取订单list
		List<Order> oList=resultPage.getRows();
		//订单备注list
		List<Object> dList=new ArrayList<>();
		Map<String, String>map = new HashMap<>();

		for (int i = 0; i < oList.size(); i++) {
			map.put(oList.get(i).getOrderNo(), oList.get(i).getOrderNo());
		}
		Iterator<String> iter5=map.values().iterator();
		Map<String, Object> map2 = new HashMap<>();
		while (iter5.hasNext()){
			String xObject =iter5.next();
			BusinessMap<Object> bMap2=orderDetlService.getOrderDetl(xObject);
			dList=(List<Object>) bMap2.getInfoBody();
			map2.put(xObject, (List<Object>) bMap2.getInfoBody());
		}
		bReslt.setList(dList);
		bReslt.setMap(map2);
		resultPage.setRows(oList);
		bReslt.setObj(resultPage);
		bReslt.setSuccess(true);
		return bReslt;
	}



	/**
	 * 获取供方（全部，待发货，待确认，完成4种类型订单数量）
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月15日
	 * @modifier:
	 * @modifiedDate:
	 * @return
	 */
	@RequestMapping("/getApplyOrderCount")
	@ResponseBody
	public BaseReslt<Object> getApplyOrderCount(HttpSession session){
		BaseReslt<Object> bReslt=new BaseReslt<Object>();
		String custNo=(String) session.getAttribute("custNo");
		Map<String, String> param=new HashMap<String,String>();
		param.put("custNo", custNo);
		BusinessMap<Object> bMap=busOrderService.getApplyOrderCount(param);
		if (!bMap.getIsSucc()) {
			bReslt.setSuccess(false);
			bReslt.setMsg("获取订单数量失败");
			return bReslt;
		}
		bReslt.setObj(bMap.getInfoBody());
		bReslt.setSuccess(true);
		return bReslt;
	}

	/**
	 * 获取买方（全部，待付款，待收货，完成4种类型订单数量）
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月15日
	 * @modifier:
	 * @modifiedDate:
	 * @return
	 */
	@RequestMapping("/getBuyerOrderCount")
	@ResponseBody
	public BaseReslt<Object> getBuyerOrderCount(HttpSession session){
		BaseReslt<Object> bReslt=new BaseReslt<Object>();
		String custNo=(String) session.getAttribute("custNo");
		Map<String, String> param=new HashMap<String,String>();
		param.put("custNo", custNo);
		BusinessMap<Object> bMap=busOrderService.getBuyerOrderCount(param);
		if (!bMap.getIsSucc()) {
			bReslt.setSuccess(false);
			bReslt.setMsg("获取订单数量失败");
			return bReslt;
		}
		bReslt.setObj(bMap.getInfoBody());
		bReslt.setSuccess(true);
		return bReslt;
	}

	/**
	 * 删除订单(逻辑删除)
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月17日
	 * @modifier:
	 * @modifiedDate:
	 * @return
	 * @param orderNo订单编号
	 */
	@RequestMapping("/deleteOrder")
	@ResponseBody
	public BaseReslt<Object> deleteOrderByType(HttpSession session,String orderNo,String type){
		String userType=(String)session.getAttribute("userType");
		BaseReslt<Object> bReslt=new BaseReslt<>();
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("custType", userType);
		params.put("nowTime", new Date());
		params.put("orderNo", orderNo);
		if ("1".equals(type)) { //买方删除
			BusinessMap<Object> bMap=busOrderService.updateStatus(params);
			if (!bMap.getIsSucc()) {
				bReslt.setSuccess(false);
				bReslt.setMsg(bMap.getMsg());
				return bReslt;
			}
		}else{
			BusinessMap<Object> bMap=busOrderService.updateStatusSell(params);//供方删除
			if (!bMap.getIsSucc()) {
				bReslt.setSuccess(false);
				bReslt.setMsg(bMap.getMsg());
				return bReslt;
			}
		}
		bReslt.setSuccess(true);
		return bReslt;
	}
	/**
	 * 取消订单
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月17日
	 * @modifier:
	 * @modifiedDate:
	 * @return
	 * @param orderNo订单编号
	 * @param dealType 操作类型
	 */
	@RequestMapping("/cancelOrder")
	@ResponseBody
	public BaseReslt<Object> cancelOrderByType(HttpSession session,String orderNo,String dealType,
			String statusWay,String remark,String orderType
			){
		BaseReslt<Object> bReslt=new BaseReslt<>();
		String dealStatus="";
		//供方取消
		if("cancel".equals(dealType)){
			dealStatus="090006";
		}
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("orderNo", orderNo);
		params.put("orderStatus", dealStatus);
		params.put("custNo", (String)session.getAttribute("custNo"));
		params.put("nowTime", new Date());
		BusinessMap<Object> bMap=busOrderService.updateOrderStatus(params);
		String status;
		if("1".equals(statusWay)){
			status=OrderConstants.orderDetailCust;
		}else{
			status=OrderConstants.orderDetailSupply;
		}
		List<TBusOrderVo> list=busOrderService.getById(orderNo);
		TBusOrderDetlVo tBusOrderDetlVo = new TBusOrderDetlVo();
		tBusOrderDetlVo.setTableKey(UUIDUtil.getParseUUID());
		tBusOrderDetlVo.setGoodsNo(list.get(0).getGoodsNo());
		tBusOrderDetlVo.setOrderNo(orderNo);
		tBusOrderDetlVo.setOrderType(orderType);
		tBusOrderDetlVo.setUserNo((String)session.getAttribute("custNo"));
		tBusOrderDetlVo.setStatus(status);
		tBusOrderDetlVo.setInsertDate(new Date());
		tBusOrderDetlVo.setRemark(remark);
		BusinessMap<Object> bMap2=orderDetlService.save(tBusOrderDetlVo);
		if (!bMap2.getIsSucc()) {
			bReslt.setSuccess(false);
			bReslt.setMsg(bMap2.getMsg());
		}

		if (!bMap.getIsSucc()) {
			bReslt.setSuccess(false);
			bReslt.setMsg(bMap.getMsg());
			return bReslt;
		}
		bReslt.setSuccess(true);
		return bReslt;
	}

	/**
	 * 生成订单
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月22日
	 * @modifier:
	 * @modifiedDate:
	 * @return
	 */
	@RequestMapping("/createOrder")
	@ResponseBody
	public BaseReslt<Object> createOrder(String orderArray,HttpSession session){
		BaseReslt<Object> bReslt=new BaseReslt<>();
		List list=(List) JSONObject.parse(orderArray);

		//订单待生成list
		List<TBusOrderVo> orderList=new ArrayList<>();
		//订单跟踪待生成list
		List<TBusOrderDetlVo> orderDetlList=new ArrayList<>();
		//删除购物车list
		List<String> deleteParam=new ArrayList<>();
		String remark = null;
		String type = null;
		String custNo = null;
		String goodsNo = null;
		String address = null;
		Date insertDate = new Date();
		/*String orderNo=UUIDUtil.getParseUUID();*/
		Map<String, String> remarkMap = new HashMap<>();
		for (int i = 0; i < list.size(); i++) {
			String orderNo = SerialNumberUtils.getInstance().generateSerialNum(6);
			TBusOrderVo orderVo=new TBusOrderVo();
			//Map<String, String> map=JSONObject.parse(list.get(i));
			//页面提交的数据，包括：num数量、tableKey编号、type状态、wishDate期望收货时间、remark备注
			Map<String, String> orderMap=(Map<String, String>) JSONObject.parse(list.get(i).toString());
			remark=orderMap.get("remark");
			type=orderMap.get("type");
			address= orderMap.get("address");
			//获取创建订单需要的数据
			CreateOrder createOrder=shoppCartService.getCreateOrder(orderMap.get("tableKey"));
			if (createOrder==null) {
				bReslt.setSuccess(false);
				bReslt.setMsg("该商品已被卖家下架，请先清空失效商品");
				return bReslt;
			}
			custNo=createOrder.getCustNo();
			goodsNo=createOrder.getGoodsNo();

			String tableKey=UUIDUtil.getParseUUID();
			orderVo.setTableKey(tableKey);
			if(orderList.size()>0){
				for(int j = 0;j<orderList.size();j++){
					if(orderMap.get("supplyNo").equals(orderList.get(j).getSupplyNo())){
						orderNo = orderList.get(j).getOrderNo();

					}
				}
			}
			
			
			orderVo.setOrderNo(orderNo);
			remarkMap.put(orderNo, remark);
			orderVo.setOrderType(orderMap.get("type"));							//订单类型
			orderVo.setCustNo(createOrder.getCustNo());							//客户编号
			orderVo.setGoodsNo(createOrder.getGoodsNo());						//商品编号
			orderVo.setGoodsPrice(createOrder.getGoodsPrice());					//商品价格
			orderVo.setGoodsDiscount(createOrder.getGoodsDiscount());			//商品折扣
			orderVo.setSplitStatus(OrderConstants.orderSplitNo);				//是否拆分
			orderVo.setAddress(orderNo);						//收货地址
			orderVo.setDefaultPayDt(createOrder.getDefaultPayDt());				//默认交期(天)
			orderVo.setWishPayDt(DateUtil.getDay(orderMap.get("wishDate")));	//期望交期(天)
			orderVo.setOrderStatus(OrderConstants.orderStatusNoneConfirmed); //订单状态(待确认)
			orderVo.setInsertDate(insertDate);									//新增时间
			orderVo.setUpdateDate(insertDate);									//修改时间与新增时间设置为一致
			orderVo.setSupplyNo(createOrder.getSupplyNo());						//供应商编号
			orderVo.setGoodsCount(Integer.valueOf(orderMap.get("num")));		//商品数量
			orderVo.setStatus(OrderConstants.orderTypeNor);					//状态
			orderVo.setOrderStatusSel(OrderConstants.orderTypeNormal);
			orderVo.setGoodsMoney(0.1*createOrder.getGoodsPrice()*createOrder.getGoodsDiscount()*Integer.valueOf(orderMap.get("num")));
			orderList.add(orderVo);
			deleteParam.add(orderMap.get("tableKey"));
		}

		//保存订单表和订单备注表
		BusinessMap<Object> bMap1=busOrderService.saveOrder(orderList);
		if (!bMap1.getIsSucc()){
			bReslt.setSuccess(false);
			bReslt.setMsg("生成订单失败");
			return bReslt;
		}

		Map<String, String> orderMap1 = new HashMap<String,String>();
		String temp;
		for(int i = 0 ; i<orderList.size();i++){
			if (orderList.get(i).getOrderNo() != null) {
				temp = orderList.get(i).getOrderNo();
				orderMap1.put(temp, temp);
			}
		}
		Set<String> keySet = orderMap1.keySet();
		Iterator<String> it = keySet.iterator();
		while (it.hasNext()) {
		String key = it.next();// 获取Key值对象
		Map<String, Object>map2 = new HashMap<>();
		map2.put("orderNo", key);
		map2.put("address", address);
		BusinessMap<Object> bMap3=itBusAddressService.add(map2);
		if (!bMap3.getIsSucc()){
			bReslt.setSuccess(false);
			bReslt.setMsg("生成订单失败");
			return bReslt;
		}
		//订单备注表
		TBusOrderDetlVo orderDetlVo=new TBusOrderDetlVo();
				if(list.size()==1){
					orderDetlVo.setGoodsNo(goodsNo);
				}else{
					orderDetlVo.setGoodsNo("");
				}
				orderDetlVo.setInsertDate(new Date());

				orderDetlVo.setOrderNo(key);
				orderDetlVo.setOrderType(type);
				if(null==remark||""==remark||StringUtil.isEmpty(remark)){
					remark="......";
				}

				orderDetlVo.setRemark(remarkMap.get(key));
				orderDetlVo.setTableKey(UUIDUtil.getParseUUID());
				orderDetlVo.setUserNo(custNo);
				orderDetlVo.setStatus(OrderConstants.orderDetailCust);
				orderDetlList.add(orderDetlVo);
				}
				//保存备注表
		BusinessMap<Object> bMap2=orderDetlService.saveOrderDetail(orderDetlList);
		if (!bMap2.getIsSucc()){
			bReslt.setSuccess(false);
			bReslt.setMsg("生成订单失败");
			return bReslt;

		}
		//生成订单成功以后删除购物车
		shoppCartService.delete(deleteParam);

		//************************************插入Cd表***********************************
		String supplyNoCd = null;
		List cdList = new ArrayList<>();
		
		for (int i = 0; i < list.size(); i++) {
			//解析成为键值对形式
			Map<String, String> orderMap=(Map<String, String>) JSONObject.parse(list.get(i).toString());
			//判断有几个不同的供应商
			supplyNoCd= orderMap.get("supplyNo");
			cdList.add(supplyNoCd);
		}
		//去重
		Set set = new HashSet(cdList);
		
		String cdCustNo = (String) session.getAttribute("custNo");
		
		//通过电话判断是否重复地址表
		String telephoneAd = addressService.getTel(cdCustNo);
		List testList = new ArrayList<>();
		//查询cd表电话
		for (Object object : set) {
			CustomerDisplay cDisplay = new CustomerDisplay();
			cDisplay.setConntNums((String)object);
			cDisplay.setTelephone(Long.valueOf(telephoneAd));
			String telCd = customerDisplayService.findTelCd(cDisplay);
			if(telCd!=null && !"".equals(telCd))
			{
				testList.add((String)object);
			}
		}
		
		for (Object object : testList) {
			set.remove(object);
		}
		
		
		Integer flag = 0;
		//插入
		if(set.size()>0)
		{	
		for (Object object : set) {
			CustomerDisplay cd = new CustomerDisplay();
			cd.setUserNo("GR" + new Date().getTime());//主键
			String userName = baseInfoService.getCustName(cdCustNo);
			cd.setUserName(userName);//用户表名称
			cd.setUserStatus("1");
			String cdAddress = addressService.getAddress(cdCustNo);
			cd.setAddress(cdAddress);//收货地址(详细地址)
			TUserAddressVo notAddress = addressService.getNotAddress(cdCustNo);
			String city = notAddress.getProvince() + notAddress.getCity() + notAddress.getArea();
			cd.setCity(city);//省市县
			String telephone = addressService.getTel(cdCustNo);
			cd.setTelephone(Long.valueOf(telephone));
			cd.setConntNums((String)object);
			flag = customerDisplayService.addCd(cd);
			}	
		}
			if(flag==1)
			{
				System.out.println("插入成功!");
			}
		
		
		
		bReslt.setSuccess(true);
		bReslt.setMsg("生成订单成功");
		return bReslt;
	}

	/**
	 * 订单一系列操作，如确认收货、确认发货、确认信息、确认付款。。。。
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月23日
	 * @modifier:
	 * @modifiedDate:
	 * @return
	 */
	@RequestMapping("/orderOperator")
	@ResponseBody
	public BaseReslt<Object> orderOperator(TBusOrderVo tBusOrderVo,String remark,String orderNo,HttpSession session){
		//对传递的数值是否为null进行判断
		if(tBusOrderVo.getOrderNo()!=null && tBusOrderVo.getLgtNums()!=null)
		{
			//赋值
			if(tBusOrderVo.getLgtNums().equals("上门取货"))
			{
			tBusOrderVo.setLgtNums("0001001");
			}
			if(tBusOrderVo.getLgtNums().equals("滴滴配送"))
			{
			tBusOrderVo.setLgtNums("0002002");
			}
			busOrderService.lgtSend(tBusOrderVo);
		}

		BaseReslt<Object> bReslt=new BaseReslt<>();
		String orderStatus="";
		Map<String, Object> param=new HashMap<>();
		TBusOrderDetlVo orderDetlVo=new TBusOrderDetlVo();
		List<TBusOrderVo> list=busOrderService.getById(orderNo);
		//TBusOrderVo orderVo=busOrderService.getById(orderNo);
		//根据数据库里面orderStatus设置当前状态的下一个状态
		/*for (int i = 0; i < list.size(); i++) {
			
		}*/
		
		if (list.get(0).getOrderStatus().equals(OrderConstants.orderStatusNoneConfirmed)) {
			orderStatus=OrderConstants.orderStatusNonePayment;//卖方待确认
			orderDetlVo.setStatus(OrderConstants.orderDetailSupply);//供应商备注
		}else if(list.get(0).getOrderStatus().equals(OrderConstants.orderStatusReadyShip)){
			orderStatus=OrderConstants.orderStatusReadCollect;//买方待收货
			orderDetlVo.setStatus(OrderConstants.orderDetailSupply);//供应商发货备注
		}else if (list.get(0).getOrderStatus().equals(OrderConstants.orderStatusNonePayment)) {
			orderStatus=OrderConstants.orderStatusReadyShip;//卖方待发货
			orderDetlVo.setStatus(OrderConstants.orderDetailCust);//客户付款备注
		}else if (OrderConstants.orderTypeCancel.equals(list.get(0).getOrderStatus())){
			orderStatus=OrderConstants.orderTypeCancel;//订单已取消
			orderDetlVo.setStatus(OrderConstants.orderDetailSupply);
		}else if (OrderConstants.orderStatusReadCollect.equals(list.get(0).getOrderStatus())){
			orderStatus=OrderConstants.orderStatusComplete;//订单已完成
			orderDetlVo.setStatus(OrderConstants.orderDetailCust);//客户收货备注
		}else{
			orderStatus=OrderConstants.orderTypeDel;//订单买方已删除
		}
		param.put("orderStatus", orderStatus);
		param.put("orderNo", orderNo);
		param.put("nowTime", new Date());
		param.put("custType", (String)session.getAttribute("userType"));
		//订单备注表
		orderDetlVo.setGoodsNo(list.get(0).getGoodsNo());
		orderDetlVo.setInsertDate(new Date());
		orderDetlVo.setOrderNo(orderNo);
		orderDetlVo.setOrderType(list.get(0).getOrderType());
		if (StringUtil.isEmpty(remark)) {
			orderDetlVo.setRemark("......");
		}else{
			orderDetlVo.setRemark(remark);
		}
		orderDetlVo.setTableKey(UUIDUtil.getParseUUID());
		orderDetlVo.setUserNo((String)session.getAttribute("custNo"));
		

		BusinessMap<Object> bMap1=busOrderService.updateOrderStatus(param);
		if (!bMap1.getIsSucc()) {
			bReslt.setSuccess(false);
			bReslt.setMsg(bMap1.getMsg());
			return bReslt;
		}
		
		BusinessMap<Object> bMap2=orderDetlService.save(orderDetlVo);
		if (!bMap2.getIsSucc()) {
			bReslt.setSuccess(false);
			bReslt.setMsg(bMap2.getMsg());
		}
		return bReslt;
	}
	/**
	 *
	 * @description: 买家待付款
	 * @creator: 欧诗阳
	 * @createDate: 2017年8月1日
	 * @modifier:
	 * @modifiedDate:
	 * @return
	 */
	@RequestMapping("/toBuyerPay")
	public ModelAndView toBuyerPay() {
		return new ModelAndView("buyerIndent_Pay");
	}
	/**
	 *
	 * @description: 买家待 待收货
	 * @creator: 欧诗阳
	 * @createDate: 2017年8月1日
	 * @modifier:
	 * @modifiedDate:
	 * @return
	 */
	@RequestMapping("/toBuyerGet")
	public ModelAndView toBuyerGet() {
		return new ModelAndView("buyerIndent_Get");
	}
	/**
	 *
	 * @description: 卖家 待确认
	 * @creator: 欧诗阳
	 * @createDate: 2017年8月1日
	 * @modifier:
	 * @modifiedDate:
	 * @return
	 */
	@RequestMapping("/toApplySure")
	public ModelAndView toApplySure() {
		return new ModelAndView("applyIndent_Sure");
	}
	/**
	 *
	 * @description: 卖家 待发货
	 * @creator: 欧诗阳
	 * @createDate: 2017年8月1日
	 * @modifier:
	 * @modifiedDate:
	 * @return
	 */
	@RequestMapping("/toApplyPost")
	public ModelAndView toApplyGet() {
		return new ModelAndView("applyIndent_Post");
	}
	/**
	 * 跳转买方订单完成
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月15日
	 * @modifier:
	 * @modifiedDate:
	 * @return
	 */
	@RequestMapping("/toBuyerComplete")
	public ModelAndView toBuyerComplete(){
		return new ModelAndView("buyerIndent_complete");
	}
	/**
	 * 跳转已取消
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月15日
	 * @modifier:
	 * @modifiedDate:
	 * @return
	 */
	@RequestMapping(value = "/toPage/{fileName}",method=RequestMethod.GET)
	public ModelAndView toPage(@PathVariable String fileName){
		return new ModelAndView(fileName);
	}

	/**
	 * 跳转买方订单所有
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月15日
	 * @modifier:
	 * @modifiedDate:
	 * @return
	 */
	@RequestMapping("/toBuyerAll")
	public ModelAndView toBuyerAll(){
		return new ModelAndView("buyerIndent_all");
	}

	/**
	 * 跳转买方订单待付款
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月15日
	 * @modifier:
	 * @modifiedDate:
	 * @return
	 */
	@RequestMapping("/toBuyerPayment")
	public ModelAndView tobuyerPayment(){
		return new ModelAndView("buyerIndent_nonePayment");
	}

	/**
	 * 跳转买方订单待收货
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月15日
	 * @modifier:
	 * @modifiedDate:
	 * @return
	 */
	@RequestMapping("/toBuyerReadCollect")
	public ModelAndView toBuyerReadCollect(){
		return new ModelAndView("buyerIndent_readCollect");
	}

	
	
	
	
	
	/**
	 * 跳转供方订单完成
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月15日
	 * @modifier:
	 * @modifiedDate:
	 * @return
	 */
	@RequestMapping("/toApplyComplete")
	public ModelAndView toApplyComplete(){
		return new ModelAndView("applyIndent_complete");
	}

	/**
	 * 跳转供方订单所有
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月15日
	 * @modifier:
	 * @modifiedDate:
	 * @return
	 */
	@RequestMapping("/toApplyAll")
	public ModelAndView toApplyAll(){
		return new ModelAndView("applyIndent_all");
	}

	/**
	 * 跳转供方订单待确认
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月15日
	 * @modifier:
	 * @modifiedDate:
	 * @return
	 */
	@RequestMapping("/toApplyConfirmed")
	public ModelAndView toApplyConfirmed(){
		return new ModelAndView("applyIndent_noneConfirmed");
	}

	/**
	 * 跳转供方订单待发货
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月15日
	 * @modifier:
	 * @modifiedDate:
	 * @return
	 */
	@RequestMapping("/toApplyReadyShip")
	public ModelAndView toSellerReadyShip(){
		return new ModelAndView("applyIndent_readyShip");
	}


	@RequestMapping("/supplyIndentTab")
	public ModelAndView supplyIndentTab(){
		return new ModelAndView("applyIndent_tab");
	}

	@RequestMapping("/buyerIndentTab")
	public ModelAndView buyerIndentTab(){
		return new ModelAndView("buyerIndent_tab");
	}
	@RequestMapping("/borderBill")
	public ModelAndView borderBill(){
		return new ModelAndView("invoiceInformation");
	}
	@RequestMapping("/borderBillDetail")
	public ModelAndView borderBillDetail(){
		return new ModelAndView("invoiceInformationLook");
	}

	/**
	 * 修改订单
	 * @description: TODO
	 * @creator: tx
	 * @createDate: 2017年7月9日
	 * @modifier:
	 * @modifiedDate:
	 * @return
	 * @param orderNo订单编号
	 * @param dealType 操作类型
	 */
	@RequestMapping("/changeOrder")
	@ResponseBody
	public BaseReslt<Object> changeOrderByOrderNo(HttpSession session,String orderNo,Double goodsPrice,Double goodsDiscount,String tableKey,Integer goodsCount,Double goodsMoney){
		BaseReslt<Object> bReslt=new BaseReslt<>();
		Map<String,Object> params=new HashMap<String,Object>();

		params.put("orderNo", orderNo);
		params.put("custNo", (String)session.getAttribute("custNo"));
		params.put("nowTime", new Date());

		params.put("tableKey", tableKey);
		if(goodsMoney!=null){
			try {
				Double goodsDiscoun =new BigDecimal(goodsMoney/goodsCount/goodsPrice*10).setScale(6, BigDecimal.ROUND_HALF_UP).doubleValue();
				params.put("goodsDiscount", goodsDiscoun);
				params.put("goodsMoney", goodsMoney);
			} catch (Exception e) {
				bReslt.setSuccess(false);
				bReslt.setMsg("操作失败，数据异常");
				return bReslt;
			}

		}
		if(goodsDiscount!=null){
			try {
				Double goodsMone = new BigDecimal(goodsDiscount*goodsCount*goodsPrice/10).setScale(6, BigDecimal.ROUND_HALF_UP).doubleValue();
				params.put("goodsDiscount", goodsDiscount);
				params.put("goodsMoney", goodsMone);
			} catch (Exception e) {
				bReslt.setSuccess(false);
				bReslt.setMsg("操作失败，数据异常");
				return bReslt;
			}
		}

		if(StringUtil.isEmpty(tableKey)){
			bReslt.setSuccess(false);
			bReslt.setMsg("操作失败，数据异常");
			return bReslt;
		}

		if(StringUtil.isEmpty(orderNo)){
			bReslt.setSuccess(false);
			bReslt.setMsg("操作失败，数据异常");
			return bReslt;
		}
			TBusOrderVo tBusOrderVo=busOrderService.getByTableKey(tableKey);
			if (tBusOrderVo == null) {
				bReslt.setSuccess(false);
				bReslt.setMsg("操作失败，请重试");
				return bReslt;
			}
			BusinessMap<Object> bMap1 = busOrderService.insertOrderHis(tBusOrderVo);
			if (!bMap1.getIsSucc()) {
				bReslt.setSuccess(false);
				bReslt.setMsg(bMap1.getMsg());
				return bReslt;
			}
			//修改订单价格及折扣
			BusinessMap<Object> bMap=busOrderService.updateOrderPrice(params);
			if (!bMap.getIsSucc()) {
				bReslt.setSuccess(false);
				bReslt.setMsg(bMap.getMsg());
				return bReslt;
			}


		bReslt.setSuccess(true);
		return bReslt;
	}
	/**
	 *
	 * @description: 订单拆分
	 * @creator: 欧诗阳
	 * @createDate: 2017年7月24日
	 * @modifier:
	 * @modifiedDate:
	 * @param session
	 * @param orderList
	 * @return
	 */
	@RequestMapping("/orderSplit")
	@ResponseBody
	public BaseReslt<Object> orderSplit(HttpSession session,@RequestBody OrderList orderList){
		BaseReslt<Object> bReslt=new BaseReslt<>();
		//老订单的商品数量总和
		int oldCount = 0;
		//新订单的商品数量总和
		int newCount = 0;
		//获取未拆分订单的数据
		List<TBusOrderVo> oldtBusOrderVoList = orderList.getOldtBusOrderVo();
		//获取已拆分订单的数据
		List<TBusOrderVo> newtBusOrderVoList = orderList.getNewtBusOrderVo();
		//循环遍历老订单
		for(int i = 0;i<oldtBusOrderVoList.size();i++){
			//获取老订单订单的商品数量
			TBusOrderVo tBusOrderVo = busOrderService.getByGoodNo(oldtBusOrderVoList.get(i).getTableKey());
			oldCount += tBusOrderVo.getGoodsCount();
		}
		//循环遍历新订单
		for(int i = 0;i<newtBusOrderVoList.size();i++){
			//获取新订单的商品数量
			newCount += newtBusOrderVoList.get(i).getGoodsCount();
		}
		//如果新商品数量与老商品数量不符侧返回false
		if(!(oldCount==newCount)){
			bReslt.setSuccess(false);
			bReslt.setMsg("拆分总数量与原有总数量不符");
			return bReslt;
		}

		//将新订单对象的数据根据标识放入map里面
		Map<String, List<TBusOrderVo>> orderMap = new HashMap<String,List<TBusOrderVo>>();
		String temp;
		List<TBusOrderVo> list;
		for(int i = 0 ; i<orderList.getNewtBusOrderVo().size();i++){
			if (orderList.getNewtBusOrderVo() != null) {
				temp = orderList.getNewtBusOrderVo().get(i).getIdentifying();
				list = orderMap.get(temp);
				if (list == null || list.size() <= 0) {
					list = new ArrayList<>();
					orderMap.put(temp, list);
				}
				list.add(orderList.getNewtBusOrderVo().get(i));
			}
		}
		//这时map里面就有根据标识分成的订单（可能一个订单里面有N个 A商品或者N个B商品）遍历map获取里面的订单对象的集合
		Iterator<List<TBusOrderVo>>  iter5=orderMap.values().iterator();

		//因为只需要获取值所以使用values遍历
	       while (iter5.hasNext()){
	    //订单跟踪待生成list
	    	   List<TBusOrderDetlVo> orderDetlList=new ArrayList<>();
	    //循环获取到第一个list订单集合
	    	   List<TBusOrderVo> val=iter5.next();
	    //循环遍历list订单集合获取集合里面的对象，第一个对象里面可能有n个a商品或者n个b商品，所以生成的主键id是一样的，这样就可以根据主键查找的时候找到这个拥有n个a商品或者n个b商品的订单
	    	   String orderNo = SerialNumberUtils.getInstance().generateSerialNum(6);
	    	   String goodsNo ="";
	    	   String orderType = "";
	    	   String userNo="";
	    	   String address = "";
	    	   String remark = "";
	    	   Date newDate = new Date();
	   		for(int i = 0 ;i<val.size();i++){
		   		//根据订单的商品编号获取到老订单的数据
		   		TBusOrderVo tBusOrderVo = busOrderService.getByGoodNo(val.get(i).getTableKey());
		   		address = tBusOrderVo.getAddress();
		   	  //由于这个tableKey是唯一的，所以每次都要生成一个新的tableKey
		   		String tableKey=UUIDUtil.getParseUUID();
		   		//组装新订单数据(即拆分订单)
		   	//组装订单数据
		   		val.get(i).setTableKey(tableKey);
		   		val.get(i).setOrderNo(orderNo);										//订单编号
		   		val.get(i).setOrderType(tBusOrderVo.getOrderType());							//订单类型
		   		val.get(i).setCustNo(tBusOrderVo.getCustNo());							//客户编号
		   		val.get(i).setGoodsNo(tBusOrderVo.getGoodsNo());						//商品编号
		   		val.get(i).setGoodsPrice(tBusOrderVo.getGoodsPrice());					//商品价格
		   		val.get(i).setGoodsDiscount(tBusOrderVo.getGoodsDiscount());			//商品折扣
		   		val.get(i).setSplitStatus(OrderConstants.orderSplitYes2);				//是否拆分
		   		val.get(i).setAddress(orderNo);						//收货地址
		   		val.get(i).setDefaultPayDt(tBusOrderVo.getDefaultPayDt());				//默认交期(天)
		   		val.get(i).setWishPayDt(tBusOrderVo.getWishPayDt());	//期望交期(天)
		   		val.get(i).setOrderStatus(OrderConstants.orderStatusNoneConfirmed); //订单状态(待确认)
		   		val.get(i).setInsertDate(newDate);									//新增时间
		   		val.get(i).setUpdateDate(newDate);									//修改时间
		   		val.get(i).setSupplyNo(tBusOrderVo.getSupplyNo());						//供应商编号
//		   		val.get(i).setGoodsCount(Integer.valueOf(newtBusOrderVoList.get(i).getGoodsCount()));		1//商品数量
		   		val.get(i).setStatus(OrderConstants.orderTypeNor);					//状态
		   		val.get(i).setOrderStatusSel(OrderConstants.orderTypeNormal);
		   		val.get(i).setUpdateCustsType("");
		   		val.get(i).setUpOrderNo(tBusOrderVo.getOrderNo());
		   		val.get(i).setGoodsMoney(0.1*tBusOrderVo.getGoodsDiscount()*tBusOrderVo.getGoodsPrice()*Integer.valueOf(val.get(i).getGoodsCount()));
		   		goodsNo=val.get(i).getGoodsNo();
		   		orderType=val.get(i).getOrderType();
		   		userNo=val.get(i).getCustNo();
		   		remark=val.get(i).getRemark();
	   		};
	   	//组装订单备注数据
	   		TBusOrderDetlVo orderDetlVo=new TBusOrderDetlVo();
	   		orderDetlVo.setGoodsNo(goodsNo);
			orderDetlVo.setInsertDate(new Date());
			orderDetlVo.setUpdateDate(new Date());
			orderDetlVo.setOrderNo(orderNo);
			orderDetlVo.setOrderType(orderType);
			orderDetlVo.setRemark(remark);
			orderDetlVo.setTableKey(UUIDUtil.getParseUUID());
			orderDetlVo.setUserNo(userNo);
			orderDetlVo.setStatus(OrderConstants.orderDetailCust);
			orderDetlList.add(orderDetlVo);
			//保存订单地址
			Map<String, Object>map = new HashMap<>();
			map.put("orderNo", orderNo);
			map.put("address", address);
			//保存地址
			BusinessMap<Object> bMap3=itBusAddressService.add1(map);
			//保存订单表和订单备注表和订单拆分表
	   		BusinessMap<Object> bMap1=busOrderService.saveOrder(val);
			BusinessMap<Object> bMap2=orderDetlService.saveOrderDetail(orderDetlList);
			if (!(bMap1.getIsSucc())&&bMap2.getIsSucc()&&bMap3.getIsSucc()) {
				bReslt.setSuccess(false);
				bReslt.setMsg("生成订单失败");
				return bReslt;
			}
	      }
	       Map<String, Object>param = new HashMap<>();
	       param.put("splitStatus", OrderConstants.orderSplitYes);
	       param.put("splitStatus1", OrderConstants.orderSplitNo);
	       //修改老订单的拆分状态
	       for(int i = 0;i<oldtBusOrderVoList.size();i++){
				//获取老订单订单的商品数量
				TBusOrderVo tBusOrderVo = busOrderService.getByGoodNo(oldtBusOrderVoList.get(i).getTableKey());
				 param.put("orderNo", tBusOrderVo.getOrderNo());
				try {
					busOrderService.updateOrderSpiltStatus(param);
				} catch (Exception e) {
					bReslt.setSuccess(false);
					bReslt.setMsg("生成订单失败,请检查订单拆分状态");
					return bReslt;
				}
			}
	       bReslt.setSuccess(true);
	       bReslt.setMsg("拆分成功");
	       return bReslt;
	}
	@RequestMapping("/getbygood")
	public ModelAndView getbygood(String goodeNo){

		return new ModelAndView("applyIndent_split");
	}

	@RequestMapping("/getById")
	@ResponseBody
	public BaseReslt<Object> getById(String orderNo){
		BaseReslt<Object> bReslt=new BaseReslt<>();
		try {
			List<Order> orderVo = busOrderService.getByidDteail(orderNo);
			bReslt.setSuccess(true);
			bReslt.setObj(orderVo);
			return bReslt;
		} catch (Exception e) {
			bReslt.setMsg("查询数据失败");
			bReslt.setSuccess(false);
			return bReslt;
		}
	}
	@RequestMapping("/getUserSupplyDetail")
	@ResponseBody
	public BaseReslt<Object> getUserSupplyDetail(HttpServletRequest request,HttpServletResponse response,String supplyNo){
		BaseReslt<Object> bReslt=new BaseReslt<Object>();
		if(StringUtil.isEmpty(supplyNo)){
			bReslt.setSuccess(false);
			bReslt.setMsg("获取供方信息失败，请重试");
			return bReslt;
		}
		try {
			TUserSupplyInfoVo tUserSupplyInfoVo= busOrderService.getUserSupplyDetail(supplyNo);
			if (tUserSupplyInfoVo==null) {
				bReslt.setSuccess(false);
				bReslt.setMsg("获取供方信息失败，请重试");
				return bReslt;
			}
			bReslt.setSuccess(true);
			bReslt.setObj(tUserSupplyInfoVo);
			return bReslt;
		} catch (Exception e) {
			bReslt.setSuccess(false);
			return bReslt;
		}

	}
	@RequestMapping("/adds")
	@ResponseBody
	public BaseReslt<Object> add(TUserBill tUserBill,HttpSession session){
		BaseReslt<Object> bReslt=new BaseReslt<Object>();
		//根据custNo获取用户
//		String custNo = (String) session.getAttribute("custNo");
		BusinessMap<Object> bMap1=itUserBillService.save(tUserBill);
			if (bMap1.getIsSucc()==false) {
				bReslt.setMsg(bMap1.getMsg());
				bReslt.setSuccess(false);
				return bReslt;
			}
			bReslt.setSuccess(true);
			return bReslt;
		}

	@RequestMapping("/deletes")
	@ResponseBody
	public BaseReslt<Object> delete(TUserBill tUserBill,HttpSession session){
		BaseReslt<Object> bReslt=new BaseReslt<Object>();
		//根据custNo获取用户
//		String custNo = (String) session.getAttribute("custNo");
		BusinessMap<Object> bMap1=itUserBillService.delete(tUserBill.getCustNo());
			if (bMap1.getIsSucc()==false) {
				bReslt.setMsg(bMap1.getMsg());
				bReslt.setSuccess(false);
				return bReslt;
			}
			bReslt.setSuccess(true);
			return bReslt;
	}
	@RequestMapping("/updates")
	@ResponseBody
	public BaseReslt<Object> update(TUserBill tUserBill,HttpSession session){
		BaseReslt<Object> bReslt=new BaseReslt<Object>();
		//根据custNo获取用户
//		String custNo = (String) session.getAttribute("custNo");
		BusinessMap<Object> bMap1=itUserBillService.update(tUserBill);
			if (bMap1.getIsSucc()==false) {
				bReslt.setMsg(bMap1.getMsg());
				bReslt.setSuccess(false);
				return bReslt;
			}
			bReslt.setSuccess(true);
			return bReslt;
	}
	
	@RequestMapping("/getByIds")
	@ResponseBody
	public BaseReslt<Object> getById(TUserBill tUserBill,HttpSession session,HttpServletRequest request){
		BaseReslt<Object> bReslt=new BaseReslt<Object>();
		//根据custNo获取用户
		String custNo = null;
		custNo = request.getParameter("custNo");
		if(custNo == null){
			custNo = (String) session.getAttribute("custNo");
		}
		BusinessMap<Object> bMap1=itUserBillService.getById(custNo);
			if (bMap1.getIsSucc()==false) {
				bReslt.setMsg(bMap1.getMsg());
				bReslt.setSuccess(false);
				return bReslt;
			}
			bReslt.setObj(bMap1.getInfoBody());
			bReslt.setSuccess(true);
			return bReslt;
	}
	@RequestMapping("/getByTableKey")
	@ResponseBody
	public BaseReslt<Object> getByTableKey(TBusAddress tUserBill,HttpSession session){
		//根据custNo获取用户
		BaseReslt<Object> bReslt = new BaseReslt<>();
		try {
			TBusAddress tBusAddress=itBusAddressService.getByTableKey(tUserBill.getOrderNo());
			bReslt.setObj(tBusAddress);
			bReslt.setMsg("加载数据失败");
			bReslt.setSuccess(true);
			return bReslt;
		} catch (Exception e) {
			bReslt.setSuccess(false);
			return bReslt;
		}
	}
	@RequestMapping("/addss")
	@ResponseBody
	public BaseReslt<Object> addss(TBusAddress tUserBill,HttpSession session){
	/*	BaseReslt<Object> bReslt=new BaseReslt<Object>();
		//根据custNo获取用户
		BusinessMap<Object> bMap1=itBusAddressService.add(tUserBill);
			if (bMap1.getIsSucc()==false) {
				bReslt.setMsg(bMap1.getMsg());
				bReslt.setSuccess(false);
				return bReslt;
			}
			bReslt.setSuccess(true);
			return bReslt;*/
		return null;
	}

	//发送物流信息
	@RequestMapping("/sendlgtMsg")
	@ResponseBody
	public void sendlgtMsg(String lgtNums,HttpServletResponse response) throws Exception
	{
		System.out.println("进来了action.............");
		response.setCharacterEncoding("UTF-8");
		//该单号表示客户自提
		if(lgtNums.equals("0001001"))
		{
			PrintWriter pw = response.getWriter();
			pw.print("1");
	    	pw.flush();
		}
		//该单号表示滴滴配送
		else if(lgtNums.equals("0002002"))
		{
			PrintWriter pw = response.getWriter();
			pw.print("2");
	    	pw.flush();
		}
		else
		{
		String host = "http://jisukdcx.market.alicloudapi.com";
	    String path = "/express/query";
	    String method = "GET";
	    String appcode = "61fe88dd2009462dbd676ec3a325b7df";
	    Map<String, String> headers = new HashMap<String, String>();
	    //?????header?е???(?м????????)?Authorization:APPCODE 83359fd73fe94948385f570e3c139105

	    headers.put("Authorization", "APPCODE " + appcode);
	    Map<String, String> querys =  new HashMap<String, String>();
	    querys.put("number", lgtNums);
	    querys.put("type", "auto");
	    try {
			PrintWriter pw = response.getWriter();
			HttpResponse response1 = HttpUtils.doGet(host, path, method, headers, querys);
			String groupBuyerName=URLDecoder.decode(EntityUtils.toString(response1.getEntity()),"UTF-8");
	    	pw.print(groupBuyerName);
	    	pw.flush();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		}

	}

			//发送物流信息App
			@RequestMapping("/sendlgtMsgApp")
			@ResponseBody
			public void sendlgtMsgApp(String lgtNums,HttpServletResponse response) throws Exception
			{
				response.setCharacterEncoding("UTF-8");
				//该单号表示客户自提
				if(lgtNums.equals("0001001"))
				{
					PrintWriter pw = response.getWriter();
					pw.print("1");
			    	pw.flush();
				}
				//该单号表示滴滴配送
				else if(lgtNums.equals("0002002"))
				{
					PrintWriter pw = response.getWriter();
					pw.print("2");
			    	pw.flush();
				}
				else
				{
				String host = "http://jisukdcx.market.alicloudapi.com";
			    String path = "/express/query";
			    String method = "GET";
			    String appcode = "61fe88dd2009462dbd676ec3a325b7df";
			    Map<String, String> headers = new HashMap<String, String>();

			    headers.put("Authorization", "APPCODE " + appcode);
			    Map<String, String> querys =  new HashMap<String, String>();
			    querys.put("number", lgtNums);
			    querys.put("type", "auto");
			    try {
					PrintWriter pw = response.getWriter();
					HttpResponse response1 = HttpUtils.doGet(host, path, method, headers, querys);
					String groupBuyerName=URLDecoder.decode(EntityUtils.toString(response1.getEntity()),"UTF-8");
			    	pw.print(groupBuyerName);
			    	pw.flush();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				}

			}
			
			
		/*****************************************新增发票系统*******************************************/
			/**
			 * 获取买方（未开发票订单信息，以及已开发票订单）
			 * @description: TODO
			 * @creator: cj
			 * @createDate: 2017年3月15日
			 * @modifier:
			 * @modifiedDate:
			 * @return
			 */
			@RequestMapping("/getBuyerOrderCountInvoic")
			@ResponseBody
			public BaseReslt<Object> getBuyerOrderCountInvoic(HttpSession session){
				BaseReslt<Object> bReslt=new BaseReslt<Object>();
				String custNo=(String) session.getAttribute("custNo");
				Map<String, String> param=new HashMap<String,String>();
				param.put("custNo", custNo);
				BusinessMap<Object> bMap=busOrderService.getBuyerOrderCountInvoic(param);
				if (!bMap.getIsSucc()) {
					bReslt.setSuccess(false);
					bReslt.setMsg("获取订单数量失败");
					return bReslt;
				}
				bReslt.setObj(bMap.getInfoBody());
				bReslt.setSuccess(true);
				return bReslt;
			}	
			
			
			/**
			 * 获取买方未开发票订单列表
			 * @description: TODO
			 * @creator: cj
			 * @createDate: 2017年3月14日
			 * @modifier:
			 * @modifiedDate:
			 * @param pageNo
			 * @param session
			 * @return
			 */
			@RequestMapping("/getBuyerOrdersInvoic")
			@ResponseBody
			public BaseReslt<Object> getBuyerOrdersInvoic(Integer pageNo,HttpSession session,String orderStatus,String query,String invoicStatus){
				BaseReslt<Object> bReslt=new BaseReslt<Object>();
				String custNo=(String) session.getAttribute("custNo");
				//查询参数，第一个参数为custNo,第二个参数为orderStatus(可为空),
				Map<String, Object> param=new HashMap<String,Object>();
				param.put("custNo", custNo);
				param.put("orderStatus", orderStatus);
				param.put("queryWay", query);
				if(invoicStatus!=null && invoicStatus!="")
				{
					param.put("invoicStatus", invoicStatus);
				}else{
					param.put("invoicStatus", null);
				}
				//默认每页8条数据
				int pageSize=8;
				Pager pager=new Pager();
				//初始化page对象
				pager.setPageSize(pageSize);
				pager.setPageNo(pageNo);
				BusinessMap<Pager> bMap=busOrderService.selectBuyerOrdersInvoic(param,pager);
				if (!bMap.getIsSucc()) {
					bReslt.setSuccess(false);
					bReslt.setMsg(bMap.getMsg());
					return bReslt;
				}

				//循环遍历订单，获取备注消息
				Pager resultPage=bMap.getInfoBody();
				//获取订单list
				List<Order> oList=resultPage.getRows();
				//订单备注list
				List<Object> dList=new ArrayList<>();
				Map<String, String>map = new HashMap<>();

				for (int i = 0; i < oList.size(); i++) {
					map.put(oList.get(i).getOrderNo(), oList.get(i).getOrderNo());
				}
				Iterator<String> iter5=map.values().iterator();
				Map<String, Object> map2 = new HashMap<>();
				while (iter5.hasNext()){
					String xObject =iter5.next();
					BusinessMap<Object> bMap2=orderDetlService.getOrderDetl(xObject);
					dList=(List<Object>) bMap2.getInfoBody();
					map2.put(xObject, (List<Object>) bMap2.getInfoBody());
				}
				bReslt.setList(dList);
				bReslt.setMap(map2);
				resultPage.setRows(oList);
				bReslt.setObj(resultPage);
				bReslt.setSuccess(true);
				return bReslt;
			}
			
			/**
			 * 获取供方（未开发票订单、发票数量）
			 * @description: TODO
			 * @creator: cj
			 * @createDate: 2017年3月15日
			 * @modifier:
			 * @modifiedDate:
			 * @return
			 */
			@RequestMapping("/getApplyOrderCountInvoice")
			@ResponseBody
			public BaseReslt<Object> getApplyOrderCountInvoice(HttpSession session){
				BaseReslt<Object> bReslt=new BaseReslt<Object>();
				String custNo=(String) session.getAttribute("custNo");
				Map<String, String> param=new HashMap<String,String>();
				param.put("custNo", custNo);
				BusinessMap<Object> bMap=busOrderService.getApplyOrderCountInvoice(param);
				if (!bMap.getIsSucc()) {
					bReslt.setSuccess(false);
					bReslt.setMsg("获取订单数量失败");
					return bReslt;
				}
				bReslt.setObj(bMap.getInfoBody());
				bReslt.setSuccess(true);
				return bReslt;
			}
			/**
			 * 获取供应方订单列表
			 * @description: TODO
			 * @creator: cj
			 * @createDate: 2017年3月14日
			 * @modifier:
			 * @modifiedDate:
			 * @param pageNo
			 * @param session
			 * @return
			 */
			@RequestMapping("/getSupplyOrdersInvoic")
			@ResponseBody
			public BaseReslt<Object> getSupplyOrdersInvoic(Integer pageNo,String invoiceStatus,HttpSession session,String query){
				BaseReslt<Object> bReslt=new BaseReslt<Object>();
				String custNo=(String) session.getAttribute("custNo");
				//查询参数，第一个参数为custNo,第二个参数为invoicStatus(可为空),
				Map<String, Object> param=new HashMap<String,Object>();
				param.put("custNo", custNo);
				param.put("orderStatus", "090005");
				param.put("queryWay", query);
				
				if(invoiceStatus!=null && invoiceStatus!="" && invoiceStatus != "undefined")
				{
					param.put("invoicStatus", invoiceStatus);
				}else{
					param.put("invoicStatus", null);
				}
				
				//默认每页1条数据
				int pageSize=8;
				Pager pager=new Pager();
				//初始化page对象
				pager.setPageSize(pageSize);
				pager.setPageNo(pageNo);
				BusinessMap<Pager> bMap=busOrderService.selectSupplyOrdersInvoice(param,pager);
				if (!bMap.getIsSucc()) {
					bReslt.setSuccess(false);
					bReslt.setMsg(bMap.getMsg());
					return bReslt;
				}

				//循环遍历订单，获取备注消息
				Pager resultPage=bMap.getInfoBody();
				//获取订单list
						List<Order> oList=resultPage.getRows();
						//订单备注list
						List<Object> dList=new ArrayList<>();
						Map<String, String>map = new HashMap<>();

						for (int i = 0; i < oList.size(); i++) {
							map.put(oList.get(i).getOrderNo(), oList.get(i).getOrderNo());
						}
						Iterator<String> iter5=map.values().iterator();
						Map<String, Object> map2 = new HashMap<>();
						while (iter5.hasNext()){
							String xObject =iter5.next();
							BusinessMap<Object> bMap2=orderDetlService.getOrderDetl(xObject);
							dList=(List<Object>) bMap2.getInfoBody();
							map2.put(xObject, (List<Object>) bMap2.getInfoBody());
						}
						bReslt.setMap(map2);
				resultPage.setRows(oList);
				bReslt.setObj(resultPage);
				bReslt.setSuccess(true);
				return bReslt;
			}
			
			/**
			 * 获取买方传递的价格和名称数组
			 * @description: TODO
			 * @creator: cj
			 * @createDate: 2017年3月15日
			 * @modifier:
			 * @modifiedDate:
			 * @return
			 */
			@RequestMapping( value ="/getBuyerInvoicArr",method=RequestMethod.POST)
			@ResponseBody
			public StringBuilder getBuyerInvoicArr(HttpSession session ,String[] priceArr,String[] nameArr){
				Map<String, Object> map = new HashMap<>();
				for (int i = 0; i < nameArr.length; i++) {
					map.put(nameArr[i], 0);
				}
				Set<String> keySet = map.keySet();
				for (String string : keySet) {
					List<Object> list = new ArrayList<>();
					for (int i = 0; i < nameArr.length; i++) {
						if(string.equals(nameArr[i])){
							list.add(i);
							map.put(string, list);
						}
					}
				}
				
				for (String string : keySet) {
					double price = 0;
					for (int i = 0; i < priceArr.length; i++) {
						if(UUIDUtil.compare((List<Object>) map.get(string),i)){
							price += Double.parseDouble(priceArr[i]);
						}
					}
					map.put(string, price);
					
				}
				
				//根据键来找出数据库中对应的金额，来进行比较 是否需要提示金额不足
				StringBuilder sb = priceService.selectLimitPriceCust(keySet,map);
								
				return sb;
			}		
			/**
			 * 获取供方传递的价格和名称数组
			 * @description: TODO
			 * @creator: cj
			 * @createDate: 2017年3月15日
			 * @modifier:
			 * @modifiedDate:
			 * @return
			 */
			@RequestMapping( value = "/getSupplyInvoicArr",method=RequestMethod.POST)
			@ResponseBody
			public BaseReslt<Object> getSupplyInvoicArr(HttpSession session ,String[] priceArr,String[] nameArr){
				BaseReslt<Object> baseReslt = new BaseReslt<Object>(); 
				//
				Map<String, Object> map = new HashMap<>();
				for (int i = 0; i < nameArr.length; i++) {
					map.put(nameArr[i], 0);
				}
				Set<String> keySet = map.keySet();
				for (String string : keySet) {
					List<Object> list = new ArrayList<>();
					for (int i = 0; i < nameArr.length; i++) {
						if(string.equals(nameArr[i])){
							list.add(i);
							map.put(string, list);
						}
					}
				}
				
				for (String string : keySet) {
					double price = 0;
					for (int i = 0; i < priceArr.length; i++) {
						if(UUIDUtil.compare((List<Object>) map.get(string),i)){
							price += Double.parseDouble(priceArr[i]);
						}
					}
					map.put(string, price);
					
				}
				
				String supplyCustNo = (String) session.getAttribute("custNo");
				BusinessMap<Object> priceSupply = priceService.selectLimitPriceSupply(supplyCustNo);
				
				if(priceSupply.getIsSucc()){
					Double price = (Double) priceSupply.getInfoBody();
					if(price == null){
						price = 0.0;
					}
					//根据键来找出数据库中对应的金额，来进行比较
					for (String name : keySet) {
						if (((Double)map.get(name))-price > 0.000001) {
							
						}else{
							baseReslt.setSuccess(false);
							baseReslt.setMsg("【"+name+"】订单金额不足</br>");
							
						}
					}
					
				}else{
					baseReslt.setSuccess(false);
					baseReslt.setMsg(priceSupply.getMsg());
				}
				
				return baseReslt;
			}	
			
			/**
			 * 保存发票信息
			 * @param session
			 * @param tBusBill
			 * @param orderNoArr
			 * @return
			 */
			@RequestMapping(value="/saveBill",method=RequestMethod.POST)
			@ResponseBody
			public  BaseReslt<Object> saveBill(HttpSession session,TBusBillVo tBusBill,String[] orderNoArr){
				System.out.println(tBusBill.toString());
				BaseReslt<Object> bReslt=new BaseReslt<Object>();
				//bus_bill
				String custNo = null;
				custNo = tBusBill.getCustNo();
				if(custNo == null){
					custNo=(String) session.getAttribute("custNo");
					tBusBill.setCustNo(custNo);
				}
				tBusBill.setBillStatus("1");
				tBusBill.setInsertDate(new Date());
				tBusBill.setUpdateDate(new Date());
				tBusBill.setApplyNo(UUIDUtil.generateSerialNum(5));//发票序号
				
				for (String orderNo : orderNoArr) {
					 BusinessMap<TBusOrderVo> bMapO = busOrderService.getOrderMoney(orderNo);
					 BusinessMap<TBusOrderVo> bMap01 = busOrderService.getOrderMoneyTotal(orderNo);
					 if(!bMapO.getIsSucc()){
						 bReslt.setSuccess(false);
						 bReslt.setMsg(bMapO.getMsg());
						 return bReslt;
					 }
					 if(!bMap01.getIsSucc()){
						 bReslt.setSuccess(false);
						 bReslt.setMsg(bMap01.getMsg());
						 return bReslt;
					 }
					 tBusBill.setOrderNo(orderNo);
					 tBusBill.setStartTime(bMapO.getInfoBody().getInsertDate());
					 tBusBill.setEndTime(bMapO.getInfoBody().getUpdateDate());
					 tBusBill.setSupplyNo(bMapO.getInfoBody().getSupplyNo());
					 tBusBill.setBillMoney(bMap01.getInfoBody().getGoodsMoney());
					 tBusBill.setTableKey(UUIDUtil.getParseUUID());
					 
					 
					//调用service
					System.out.println(tBusBill.toString());
					BusinessMap<Object> bMap1=itBusBillService.save(tBusBill);
					if(!bMap1.getIsSucc()){
						bReslt.setSuccess(false);
						bReslt.setMsg(bMap1.getMsg());
					}
				}
				
				//user bill
				TUserBill tUserBill = new TUserBill();
				tUserBill.setBillReceipt(tBusBill.getBillReceipt());//纳税人识别号
				tUserBill.setBillContent(tBusBill.getBillContent());//发票内容
				tUserBill.setBillReceivePhone(tBusBill.getBillReceivePhone());//收票人手机号
				tUserBill.setBillReceiveAddress(tBusBill.getBillReceiveAddress());//收票人邮箱
				tUserBill.setBillStatus(tBusBill.getBillStatus());//发票状态
				tUserBill.setBillMoney(tBusBill.getBillMoney());//发票总金额
				tUserBill.setCustNo(tBusBill.getCustNo());//客户编号
				tUserBill.setCompanyName(tBusBill.getCompanyName());//单位名称
				tUserBill.setRegisterAddress(tBusBill.getRegisterAddress());//单位注册地址
				tUserBill.setRegisterPhone(tBusBill.getRegisterPhone());//单位注册手机号码
				tUserBill.setOpenBand(tBusBill.getOpenBand());//开户行
				tUserBill.setBillReceiveName(tBusBill.getBillReceiveName());//收票人姓名
				tUserBill.setBillReceiveMail(tBusBill.getBillReceiveMail());//收票人邮箱
				tUserBill.setBillProvince(tBusBill.getBillProvince());//省
				tUserBill.setBillCity(tBusBill.getBillCity());//市
				tUserBill.setBillArea(tBusBill.getBillArea());
				//调用service
				BusinessMap<Object> bMap2=itUserBillService.getById(custNo);
				if(bMap2.getInfoBody()==null){
					tUserBill.setInsertDate(new Date());
					tUserBill.setUpdateDate(new Date());
					itUserBillService.save(tUserBill);
				}else{
					tUserBill.setUpdateDate(new Date());
					itUserBillService.update(tUserBill);
				}
				if (!bMap2.getIsSucc()) {
					bReslt.setSuccess(false);
					bReslt.setMsg(bMap2.getMsg());
				}
				//bus_order
				BusinessMap<Object> bMap3 = busOrderService.updateOrderIncoiceStatus(orderNoArr);
				if(!bMap3.getIsSucc()){
					bReslt.setSuccess(false);
					bReslt.setMsg(bMap3.getMsg());
				}
				return bReslt;
			}
			
			
			/**
			 * 获取下限金额 发票时间
			 * @param session
			 * @param tBusBill
			 * @param orderNoArr
			 * @return
			 */
			@RequestMapping(value="/getLimitPrice")
			@ResponseBody
			public  BaseReslt<Object> getLimitPrice(HttpSession session){
				BaseReslt<Object> bReslt=new BaseReslt<Object>();
				String custNo = (String) session.getAttribute("custNo");
				
				BusinessMap<Object> bMap = priceService.getLimitPrice(custNo);
				if(!bMap.getIsSucc()){
					bReslt.setMsg(bMap.getMsg());
					bReslt.setSuccess(false);
				}
				bReslt.setObj(bMap.getInfoBody());
				return bReslt;
			}
			
			/**
			 * 修改下限金额 发票时间
			 * @param session
			 * @param tBusBill
			 * @param orderNoArr
			 * @return
			 */
			@RequestMapping(value="/updateLimitPrice")
			@ResponseBody
			public  BaseReslt<Object> updateLimitPrice(HttpSession session,String limitPrice,String billArriveDate){
				BaseReslt<Object> bReslt=new BaseReslt<Object>();
				String custNo = (String) session.getAttribute("custNo");
				
				SupplyLimitPrice supplyLimitPrice= new SupplyLimitPrice();
				supplyLimitPrice.setCustNo(custNo);
				supplyLimitPrice.setLimitPrice(Double.parseDouble(limitPrice));
				supplyLimitPrice.setBillArriveDate(Integer.parseInt(billArriveDate));
				
				boolean updateLimitPrice = priceService.updateLimitPrice(supplyLimitPrice);
				if(!updateLimitPrice){
					bReslt.setSuccess(false);
				}
				return bReslt;
			}
			
			/**
			 * 获取 发票时间
			 * @param session
			 * @param tBusBill
			 * @param orderNoArr
			 * @return
			 */
			@RequestMapping(value="/getBillDateByName")
			@ResponseBody
			public  BaseReslt<Object> getBillDateByName(HttpSession session,String supplyName){
				BaseReslt<Object> bReslt=new BaseReslt<Object>();
				
				BusinessMap<Object> bMap = priceService.getBillDateByName(supplyName);
				if(!bMap.getIsSucc()){
					bReslt.setMsg(bMap.getMsg());
					bReslt.setSuccess(false);
				}
				bReslt.setObj(bMap.getInfoBody());
				return bReslt;
			}

}

