
package com.hansy.transaction.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.hansy.transaction.common.BaseReslt;
import com.hansy.transaction.common.BusinessMap;
import com.hansy.transaction.common.constants.GoodsConstants;
import com.hansy.transaction.common.constants.OrderConstants;
import com.hansy.transaction.common.utils.Pager;
import com.hansy.transaction.common.utils.StringUtil;
import com.hansy.transaction.common.utils.UUIDUtil;
import com.hansy.transaction.model.bo.DataCatalogManage;
import com.hansy.transaction.model.bo.DataCp;
import com.hansy.transaction.model.bo.DataCpmls;
import com.hansy.transaction.model.bo.DataCpmlss;
import com.hansy.transaction.model.bo.GoodsAll;
import com.hansy.transaction.model.bo.GoodsDiscount;
import com.hansy.transaction.model.vo.TPubGoodsDiscount;
import com.hansy.transaction.model.vo.TPubSupplyBrand;
import com.hansy.transaction.model.vo.TPubSupplyGoods;
import com.hansy.transaction.model.vo.TSysCodeInfo;
import com.hansy.transaction.model.vo.TbusOrderDiscountVO;
import com.hansy.transaction.service.ITGoodsService;
import com.hansy.transaction.service.ITPubGoodsDiscountService;

import net.bull.javamelody.Main;

/**
 * 商品控制器
 * TODO javadoc for com.hansy.transaction.action.GoodsAction
 * @Copyright: 2017成都环赛信息技术有限公司 
 * @author: cj
 * @since: 2017年3月17日
 */
@Controller
@RequestMapping("/goods")
public class GoodsAction {
	@Resource
	private ITGoodsService goodsService;
	@Resource
	private ITPubGoodsDiscountService goodsDiscountService;
	
	
	@RequestMapping(value="/updateDiscounts",method=RequestMethod.POST)
	@ResponseBody
	public BaseReslt<Object> updateDiscounts(TbusOrderDiscountVO tbusOrderDiscountVO){
		BaseReslt<Object> bReslt=new BaseReslt<>();
		Map<String, String>map = new HashMap<>();
		Map<String, String>map1 = new HashMap<>();
		if(tbusOrderDiscountVO==null){
			bReslt.setSuccess(false);
			bReslt.setMsg("参数为空请联系后台管理员");
			return bReslt;
		};
		map.put("dsMinkc", tbusOrderDiscountVO.getDsMinkc());
		map.put("orderIncrement", tbusOrderDiscountVO.getOrderIncrement());
		map.put("defaultPayDat", tbusOrderDiscountVO.getDefaultPayDat());
		map.put("classTypeId", tbusOrderDiscountVO.getClassId());
		BusinessMap<Object> bMap = goodsService.updateDis(map);
		map1.put("discountRate", tbusOrderDiscountVO.getDiscountRate1());
		map1.put("classTypeId", tbusOrderDiscountVO.getClassId());
		BusinessMap<Object> bMap1 = goodsDiscountService.updateDis1(map1);
		map1.clear();
		map1.put("discountRate", tbusOrderDiscountVO.getDiscountRate2());
		map1.put("classTypeId", tbusOrderDiscountVO.getClassId());
		BusinessMap<Object> bMap2 = goodsDiscountService.updateDis2(map1);
		map1.clear();
		map1.put("discountRate", tbusOrderDiscountVO.getDiscountRate3());
		map1.put("classTypeId", tbusOrderDiscountVO.getClassId());
		BusinessMap<Object> bMap3 = goodsDiscountService.updateDis3(map1);
		map1.clear();
		map1.put("discountRate", tbusOrderDiscountVO.getDiscountRate4());
		map1.put("classTypeId", tbusOrderDiscountVO.getClassId());
		BusinessMap<Object> bMap4 = goodsDiscountService.updateDis4(map1);
		if(!bMap.getIsSucc()||!bMap1.getIsSucc()||!bMap2.getIsSucc()||!bMap3.getIsSucc()||!bMap4.getIsSucc()){
			bReslt.setSuccess(false);
			bReslt.setMsg("修改失败请重试");
			return bReslt;
		}else{
			bReslt.setSuccess(true);
			bReslt.setMsg("修改成功");
			return bReslt;
		}
	}
	
	
	
	
	/**
	 * 购物车跳转商品结算界面
	 * @description: TODO
	 * @creator: tx
	 * @createDate: 2017年7月7日 
	 * @modifier:
	 * @modifiedDate:
	 * @return
	 */
	@RequestMapping("/toConfirmOrder")
	public ModelAndView confirmOrder(HttpSession session,@RequestParam(value="orderArray[]",required=false) List<String> orderArray){
		if (orderArray == null) {
			String [] arry = (String[]) session.getAttribute("arry");
			session.setAttribute("arry", arry);
			return new ModelAndView("confirm_order");
		}
		String arry[] = new String [orderArray.size()];
		for (int i = 0; i < orderArray.size(); i++) {
			arry[i] = orderArray.get(i);
		}
		session.setAttribute("arry", arry);
		return new ModelAndView("confirm_order");
	}
	
	
	/**
	 * 购物车跳转商品结算界面App
	 * @description: TODO
	 * @creator: tx
	 * @createDate: 2017年7月7日 
	 * @modifier:
	 * @modifiedDate:
	 * @return
	 */
	@RequestMapping("/toConfirmOrderApp")
	public ModelAndView confirmOrderApp(HttpSession session,@RequestParam(value="orderArray[]",required=false) List<String> orderArray){
		if (orderArray == null) {
			String [] arry = (String[]) session.getAttribute("arry");
			session.setAttribute("arry", arry);
			return new ModelAndView("confirm_orderApp");
		}
		String arry[] = new String [orderArray.size()];
		for (int i = 0; i < orderArray.size(); i++) {
			arry[i] = orderArray.get(i);
		}
		
		
		
		session.setAttribute("arry", arry);
		return new ModelAndView("confirm_orderApp");
	}
	
	
	/**
	 * 跳转商品管理界面
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月17日 
	 * @modifier:
	 * @modifiedDate:
	 * @return
	 */
	@RequestMapping("/toCommodity")
	public ModelAndView toCommodityLeft(){
		return new ModelAndView("commodity");
	}
	
	 /*
	 * 跳转发票管理界面
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月17日 
	 * @modifier:
	 * @modifiedDate:
	 * @return
	 */
	@RequestMapping("/toInvoicMgt")
	public ModelAndView toInvoicMgts(){
		return new ModelAndView("Invoice_management");
	}
	
	
	/**
	 * 跳转商品销售页面
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月17日 
	 * @modifier:
	 * @modifiedDate:
	 * @return
	 */
	@RequestMapping("/toPubCommodity")
	public ModelAndView toPubCommodity(){
		return new ModelAndView("commodity_sell");
	}
	
	/**
	 * 跳转所有商品
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月17日 
	 * @modifier:
	 * @modifiedDate:
	 * @return
	 */
	@RequestMapping("/toCommodityAll")
	public ModelAndView toCommodityAll(){
		return new ModelAndView("commodity_all");
	}
	
	/**
	 * 跳转上架商品
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月21日 
	 * @modifier:
	 * @modifiedDate:
	 * @return
	 */
	@RequestMapping("/toCommodityPutaway")
	public ModelAndView toCommodityPutaway(){
		return new ModelAndView("commodity_putaway");
	}
	
	/**
	 * 跳转下架商品
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月21日 
	 * @modifier:
	 * @modifiedDate:
	 * @return
	 */
	@RequestMapping("/toCommodityHalt")
	public ModelAndView toCommodityHalt(){
		return new ModelAndView("commodity_halt");
	}
	
	/**
	 * 跳转发布商品页面
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月24日 
	 * @modifier:
	 * @modifiedDate:
	 * @return
	 */
	@RequestMapping("/toPublishGoods")
	public ModelAndView toPublishGoods(){
		return new ModelAndView("commodity_publish");
	}
	
	/**
	 * 跳转编辑页面
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月28日 
	 * @modifier:
	 * @modifiedDate:
	 * @return
	 */
	@RequestMapping("/toEdit")
	public ModelAndView toEdit(String tableKey){
		ModelAndView view=new ModelAndView("commodity_all_compile");
		view.addObject("tableKey", tableKey);
		return view;
	}
	/**
	 * 获取所有商品
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月17日 
	 * @modifier:
	 * @modifiedDate:
	 * @return
	 */
	@RequestMapping(value="/getCommodityAll",method=RequestMethod.POST)
	@ResponseBody
	public BaseReslt<Object> getCommodityAll(HttpSession session,Integer pageNo,String brand,String gg,String pyname,String code,
			String query){
		BaseReslt<Object> bReslt=new BaseReslt<>();
		String custNo=(String) session.getAttribute("custNo");
		//查询参数，第一个参数为custNo,第二个参数为orderStatus(可为空),
		Map<String, Object> param=new HashMap<String,Object>();
		param.put("query", query);
		param.put("custNo", custNo);
		param.put("brand", brand);
		if(!StringUtil.isEmpty(gg)){
			code = code+gg;
			if(!StringUtil.isEmpty(pyname)){
				code = code + pyname;
			}
		}else{
			if(!StringUtil.isEmpty(pyname)){
				code = code +"%"+ pyname;
			}
		}
//		param.put("goodsType", code);
		
		//默认每页8条数据
		int pageSize=8;
		if (StringUtil.isEmpty(String.valueOf(pageNo))) {
			pageNo=1;
		}
		Pager pager=new Pager();
		//初始化page对象
		pager.setPageSize(pageSize);
		pager.setPageNo(pageNo);
		BusinessMap<Pager> bMap=goodsService.getGoodsAll(param,pager);
		if (!bMap.getIsSucc()) {
			bReslt.setMsg(bMap.getMsg());
			bReslt.setSuccess(false);
			return bReslt;
		}
		
		//循环遍历商品list  并查询每个商品的折扣
		Pager resultPage=bMap.getInfoBody();	
		//获取商品list
		List<GoodsAll> gList=resultPage.getRows();
		//转换启用状态（0-停用；1-启用）
		for (GoodsAll goodsAll : gList) {
			String s=goodsAll.getGoodsStatus().equals("0")?"停用":"启用";
			goodsAll.setGoodsStatus(s);
		}
		//商品折扣list
		List<GoodsDiscount> dList=new ArrayList<>();
		//查询参数，包括goodsNo、custNo
		Map<String, String> param1=new HashMap<>(); 
		for (int i = 0; i < gList.size(); i++) {
			param1.put("goodsNo", gList.get(i).getCpdm());
			param1.put("custNo",custNo);
			//获取每个goods的折扣list
			BusinessMap bMap2=goodsDiscountService.getDiscountAll(param1);
			if (!bMap2.getIsSucc()) {
				bReslt.setSuccess(false);
				bReslt.setMsg(bMap2.getMsg());
				return bReslt;
			}
			dList=(List<GoodsDiscount>)bMap2.getInfoBody();
			gList.get(i).setList(dList);
		}
		resultPage.setRows(gList);
		bReslt.setObj(resultPage);
		bReslt.setSuccess(true);
		return bReslt;
	}
	
	
	/**
	 * 获取销售商品
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月17日 
	 * @modifier:
	 * @modifiedDate:
	 * @return
	 */
	@RequestMapping(value="/getCommoditySellAll",method=RequestMethod.POST)
	@ResponseBody
	public BaseReslt<Object> getCommoditySellAll(HttpSession session,Integer pageNo,String brand,String gg,String pyname,String code,
			String query){
		BaseReslt<Object> bReslt=new BaseReslt<>();
		String custNo=(String) session.getAttribute("custNo");
		//查询参数，第一个参数为custNo,第二个参数为orderStatus(可为空),
		Map<String, Object> param=new HashMap<String,Object>();
		param.put("custNo", custNo);
		param.put("brand", brand);
		param.put("goodsStatus", "1");
		param.put("query", query);
		if(!StringUtil.isEmpty(gg)){
			code = code+gg;
			if(!StringUtil.isEmpty(pyname)){
				code = code + pyname;
			}
		}else{
			if(!StringUtil.isEmpty(pyname)){
				code = code +"%"+ pyname;
			}
		}
		param.put("goodsType", code);
		
		//默认每页8条数据
		int pageSize=8;
		if (StringUtil.isEmpty(String.valueOf(pageNo))) {
			pageNo=1;
		}
		Pager pager=new Pager();
		//初始化page对象
		pager.setPageSize(pageSize);
		pager.setPageNo(pageNo);
		BusinessMap<Pager> bMap=goodsService.getGoodsAll(param,pager);
		if (!bMap.getIsSucc()) {
			bReslt.setMsg(bMap.getMsg());
			bReslt.setSuccess(false);
			return bReslt;
		}
		
		//循环遍历商品list  并查询每个商品的折扣
		Pager resultPage=bMap.getInfoBody();	
		//获取商品list
		List<GoodsAll> gList=resultPage.getRows();
		//转换启用状态（0-停用；1-启用）
		for (GoodsAll goodsAll : gList) {
			String s=goodsAll.getGoodsStatus().equals("0")?"停用":"启用";
			goodsAll.setGoodsStatus(s);
		}
		//商品折扣list
		List<GoodsDiscount> dList=new ArrayList<>();
		//查询参数，包括goodsNo、custNo
		Map<String, String> param1=new HashMap<>(); 
		for (int i = 0; i < gList.size(); i++) {
			param1.put("goodsNo", gList.get(i).getCpdm());
			param1.put("custNo",custNo);
			//获取每个goods的折扣list
			BusinessMap bMap2=goodsDiscountService.getDiscountAll(param1);
			if (!bMap2.getIsSucc()) {
				bReslt.setSuccess(false);
				bReslt.setMsg(bMap2.getMsg());
				return bReslt;
			}
			dList=(List<GoodsDiscount>)bMap2.getInfoBody();
			gList.get(i).setList(dList);
		}
		resultPage.setRows(gList);
		bReslt.setObj(resultPage);
		bReslt.setSuccess(true);
		return bReslt;
	}
	
	
	/**
	 * 获取当前用户所有goodsCode
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年4月11日 
	 * @modifier:
	 * @modifiedDate:
	 * @return
	 */
	@RequestMapping("/getMyGoodsCode")
	@ResponseBody
	public BaseReslt<Object> getMyGoodsCode(HttpSession session,String goodsType){
		BaseReslt<Object> bReslt=new BaseReslt<>();
		HashMap<String, Object> param=new HashMap<String, Object>();
		String custNo=(String) session.getAttribute("custNo");
		if (!StringUtil.isEmpty(goodsType)) {
			if("W01".equals(goodsType)){
				param.put("codes", goodsType);
			}else{
				param.put("code", goodsType);
			}
			
		}
		param.put("custNo", custNo);
		//获取当前用户的所有goodsCode
//		BusinessMap<List<String>> bMap=goodsService.getMyGoodsCode(param);
		BusinessMap<List<Object>> bMap=goodsService.getGoodsSearch(param);
		if (!bMap.getIsSucc()) {
			bReslt.setSuccess(false);
			bReslt.setMsg(bMap.getMsg());
			return bReslt;
		}
		bReslt.setSuccess(true);
		bReslt.setObj(bMap.getInfoBody());
		return bReslt;
	}
	
	/**
	 * 根据goodsCode获取商品规格和tableKey
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年4月11日 
	 * @modifier:
	 * @modifiedDate:
	 * @return
	 */
	@RequestMapping("/getByGoodsCode")
	@ResponseBody
	public BaseReslt<Object> getByGoodsCode(String goodsCode){
		BaseReslt<Object> bReslt=new BaseReslt<>();
		//获取当前用户的所有goodsCode
		BusinessMap<List<GoodsAll>> bMap=goodsService.getByGoodsCode(goodsCode);
		if (!bMap.getIsSucc()) {
			bReslt.setSuccess(false);
			bReslt.setMsg(bMap.getMsg());
			return bReslt;
		}
		bReslt.setSuccess(true);
		bReslt.setObj(bMap.getInfoBody());
		return bReslt;
	}
	/**
	 * 商品的上架与下架
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月20日 
	 * @modifier:
	 * @modifiedDate:
	 * @return
	 */
	@RequestMapping("/goodsShelf")
	@ResponseBody
	public BaseReslt<Object> goodsShelf(String tableKey,String status){
		BaseReslt<Object> bReslt=new BaseReslt<>();
		String msg="";
		//判断前台提交的状态码是否正确，并把状态码更改
		if (status.equals(GoodsConstants.goodsShelfHalt)) {
			status=GoodsConstants.goodsShelfHalted;
			msg="商品下架成功";
		}else if(status.equals(GoodsConstants.goodsShelfHalted)){
			status=GoodsConstants.goodsShelfHalt;
			msg="商品上架成功";
		}else {
			bReslt.setSuccess(false);
			bReslt.setMsg("提交状态码错误");
			return bReslt;
		}
		Map<String, Object> param=new HashMap<>();
		param.put("tableKey", tableKey);
		param.put("status", status);
		param.put("updateDate", new Date());
		//更新状态
		BusinessMap<Object> bMap=goodsService.goodsShelf(param);
		if (!bMap.getIsSucc()) {
			bReslt.setSuccess(false);
			bReslt.setMsg(bMap.getMsg());
			return bReslt;
		}
		bReslt.setSuccess(true);
		bReslt.setMsg(msg);
		return bReslt;
	}
	
	/**
	 * 获取所有商品代码
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月24日 
	 * @modifier:
	 * @modifiedDate:
	 * @return
	 */
	@RequestMapping("/getGoodsCodes")
	@ResponseBody
	public BaseReslt<Object> getGoodsCodes(){
		BaseReslt<Object> bReslt=new BaseReslt<>();
		HashMap<String, Object> map=new HashMap<>();
		BusinessMap<Object> bMap=goodsService.getGoodsCodes();
		BusinessMap<Object> bMap2=goodsService.getAllGrades();
		if (!bMap.getIsSucc()) {
			bReslt.setSuccess(false);
			bReslt.setMsg(bMap.getMsg());
			return bReslt;
		}
		map.put("goodsCodes",bMap.getInfoBody());
		map.put("userGrades", bMap2.getInfoBody());
		bReslt.setSuccess(true);
		bReslt.setObj(map);
		return bReslt;
	}
	
	/**
	 * 获取商品名
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月24日 
	 * @modifier:
	 * @modifiedDate:
	 * @param goodsCode
	 * @return
	 */
	@RequestMapping("/getGoodsName")
	@ResponseBody
	public BaseReslt<Object> getGoodsName(String goodsCode){
		BaseReslt<Object> bReslt=new BaseReslt<>();
		BusinessMap<Object> bMap=goodsService.getGoodsNames(goodsCode);
		if (!bMap.getIsSucc()) {
			bReslt.setSuccess(false);
			bReslt.setMsg(bMap.getMsg());
			return bReslt;
		}
		bReslt.setSuccess(true);
		bReslt.setObj(bMap.getInfoBody());
		return bReslt;
	}
	
	/**
	 * 新增商品
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月27日 
	 * @modifier:
	 * @modifiedDate:
	 * @param goodsNo
	 * @param goodsPrice
	 * @param status
	 * @param discountArray
	 * @return
	 */
	@RequestMapping("/goodsPublish")
	@ResponseBody
	public BaseReslt<Object> goodsPublish(@RequestParam("param") String param,HttpSession session){
		BaseReslt<Object> bReslt=new BaseReslt<>();
		TPubSupplyGoods supplyGoods=new TPubSupplyGoods();
		JSONObject object=JSONObject.parseObject(param);
		//折扣参数
		List<TPubGoodsDiscount> list=new ArrayList<>();
		
		String custNo=(String)session.getAttribute("custNo");
		String goodsNo=object.getString("goodsNo");
		String goodsPrice=object.getString("goodsPrice");
		String status=object.getString("status");
		String goodsName=object.getString("goodsName");
		Integer defaultPayDt=object.getInteger("defaultPayDt");
		
		supplyGoods.setCustNo(custNo);								  //用户编号
		supplyGoods.setGoodsName(goodsName);						  //商品名称
		supplyGoods.setGoodsNo(goodsNo);                              //商品编号
		supplyGoods.setInsertDate(new Date());            			  //新增日期
		supplyGoods.setStatus(status);								  //状态
		supplyGoods.setTableKey(UUIDUtil.getParseUUID());			  //主键
		supplyGoods.setDefaultPayDt(defaultPayDt);					  //默认交期
		supplyGoods.setGoodsPrice(goodsPrice);
		
		//判断该商品是否已经存在
		Map<String, String> param1=new HashMap<>();
		param1.put("custNo", custNo);
		param1.put("goodsNo", goodsNo);
		BusinessMap<Object> resultMap=goodsService.findIsExist(param1);
		if (!resultMap.getIsSucc()) {
			bReslt.setSuccess(false);
			bReslt.setMsg(resultMap.getMsg());
			return bReslt;
		}else{
			if ((Integer)resultMap.getInfoBody()==1) {
				bReslt.setSuccess(false);
				bReslt.setMsg("该商品已存在，无需重复添加");
				return bReslt;
			}
		}
		List<Object> discount=object.getJSONArray("discount");
		//循环遍历获取折扣信息
		for (int i = 0; i < discount.size(); i++) {
			JSONObject jsonObject=JSONObject.parseObject(discount.get(i).toString());
			TPubGoodsDiscount goodsDiscount=new TPubGoodsDiscount();
			goodsDiscount.setDiscountRate(jsonObject.getString("discount"));				
			goodsDiscount.setCustNo(custNo);
			goodsDiscount.setDiscountObject(jsonObject.getString("gradesNo"));
			goodsDiscount.setGoodsNo(goodsNo);
			goodsDiscount.setInsertDate(new Date());
			goodsDiscount.setTableKey(UUIDUtil.getParseUUID());
			goodsDiscount.setDiscountStatus(GoodsConstants.discountStatusNormal);
			list.add(goodsDiscount);
		}
		BusinessMap<Object> bMap=goodsService.saveGoodsSupply(supplyGoods);
		if (!bMap.getIsSucc()) {
			bReslt.setSuccess(false);
			bReslt.setMsg(bMap.getMsg());
			return bReslt;
		}
		BusinessMap<Object> bMap2=goodsDiscountService.save(list);
		if (!bMap.getIsSucc()) {
			bReslt.setSuccess(false);
			bReslt.setMsg(bMap.getMsg());
			return bReslt;
		}
		bReslt.setMsg("新增商品成功");
		bReslt.setSuccess(true);
		return bReslt;
	}
	
	/**
	 * 获取商品销售信息
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月27日 
	 * @modifier:
	 * @modifiedDate:
	 * @return
	 */
	@RequestMapping("/goodsSales")
	@ResponseBody
	public BaseReslt<Object> goodsSales(Integer pageNo,HttpSession session){
		if (pageNo==null) {
			pageNo=1;
		}
		BaseReslt<Object> bReslt=new BaseReslt<>();
		String custNo=(String) session.getAttribute("custNo");
		//查询参数，第一个参数为custNo,第二个参数为status,
		Map<String, Object> param=new HashMap<String,Object>();
		param.put("custNo", custNo);
		//查询已完成的订单
		param.put("status", OrderConstants.orderStatusComplete);
		//默认每页3条数据
		int pageSize=3;
		Pager pager=new Pager();
		//初始化page对象
		pager.setPageSize(pageSize);
		pager.setPageNo(pageNo);
		BusinessMap<Pager> bMap=goodsService.goodsSales(param,pager);
		if (!bMap.getIsSucc()) {
			bReslt.setMsg(bMap.getMsg());
			bReslt.setSuccess(false);
			return bReslt;
		}
		bReslt.setObj(bMap.getInfoBody());
		bReslt.setSuccess(true);
		return bReslt;
	}
	
	/**
	 * 获取商品价格和折扣
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月28日 
	 * @modifier:
	 * @modifiedDate:
	 * @return
	 */
	@RequestMapping(value="/getDiscountPrice",method=RequestMethod.POST)
	@ResponseBody
	public BaseReslt<Object> getDiscountPrice(String tableKey,HttpSession session){
		BaseReslt<Object> bReslt=new BaseReslt<>();
		String custNo=(String) session.getAttribute("custNo");
		BusinessMap<Object> bMap=goodsService.getDiscountPrice(tableKey,custNo);
		if (!bMap.getIsSucc()) {
			bReslt.setSuccess(false);
			bReslt.setMsg(bMap.getMsg());
			return bReslt;
		}
		bReslt.setObj(bMap.getInfoBody());
		bReslt.setSuccess(true);
		return bReslt;
	}
	
	/**
	 * 修改折扣价格
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月29日 
	 * @modifier:
	 * @modifiedDate:
	 * @param param
	 * @return
	 */
	@RequestMapping(value="/updateDiscountPrice",method=RequestMethod.POST)
	@ResponseBody
	public BaseReslt<Object> updateDiscountPrice(@RequestParam("param") String param,HttpSession session){
		BaseReslt<Object> bReslt=new BaseReslt<>();
		JSONObject object=JSONObject.parseObject(param);
		String custNo=(String) session.getAttribute("custNo");
		String goodsNo=object.getString("goodsNo");
		//折扣参数
		List<TPubGoodsDiscount> listAdd=new ArrayList<>();
		List<Map<String, String>> mapUpdate=new ArrayList<>();
		
		Map<String, String> param1=new HashMap<>();
		//修改商品价格参数
		param1.put("tableKey",object.getString("goodsKey"));
		param1.put("goodsPrice",object.getString("goodsPrice"));
		
		List<Object> discount=object.getJSONArray("discount");
		//循环遍历获取折扣信息
		for (int i = 0; i < discount.size(); i++) {
			JSONObject jsonObject=JSONObject.parseObject(discount.get(i).toString());
			Map<String, String> updateParam=new HashMap<>();
			String tableKey=jsonObject.getString("tableKey");
			String dicount=jsonObject.getString("discount");
			//如果上传的tableKey为空，则为新增折扣，一般是出现在商品添加以后，后台又新增了等级时使用
			if (StringUtil.isEmpty(tableKey)) {
				TPubGoodsDiscount goodsDiscount=new TPubGoodsDiscount();
				goodsDiscount.setDiscountRate(dicount);				
				goodsDiscount.setCustNo(custNo);
				goodsDiscount.setDiscountObject(jsonObject.getString("gradeNo"));
				goodsDiscount.setGoodsNo(goodsNo);
				goodsDiscount.setInsertDate(new Date());
				goodsDiscount.setTableKey(UUIDUtil.getParseUUID());
				goodsDiscount.setDiscountStatus(GoodsConstants.discountStatusNormal);
				listAdd.add(goodsDiscount);
			}
			
			//更新参数
			updateParam.put("tableKey", tableKey);
			updateParam.put("discount", dicount);
			mapUpdate.add(updateParam);
		}
		
		BusinessMap<Object> bMap1=goodsService.updatePrice(param1);
		BusinessMap<Object> bMap2=goodsDiscountService.update(mapUpdate);
		if (listAdd.size()!=0) {
			BusinessMap<Object> bMap3=goodsDiscountService.save(listAdd);
		}
		if(bMap1.getIsSucc()&&bMap2.getIsSucc()){
			bReslt.setMsg("操作成功");
			bReslt.setSuccess(true);
		}else{
			bReslt.setSuccess(false);
			bReslt.setMsg("数据库异常，请重试");
		}
		return bReslt;
	}
	
	/**
	 * 获取刀具类型菜单
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年4月7日 
	 * @modifier:
	 * @modifiedDate:
	 * @return
	 */
	@RequestMapping("getCutterType")
	@ResponseBody
	public BaseReslt<Object> getCutterType(){
		BaseReslt<Object> bReslt=new BaseReslt<>();
		BusinessMap<List<TSysCodeInfo>> bMap=goodsService.getCutterType();  
		if (!bMap.getIsSucc()) {
			bReslt.setSuccess(false);
			bReslt.setMsg(bMap.getMsg());
			return bReslt;
		}
		bReslt.setSuccess(true);
		bReslt.setObj(bMap.getInfoBody());
		return bReslt;
	}
	
	/**
	 * 根据类型获取商品
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年4月7日 
	 * @modifier:
	 * @modifiedDate:
	 * @param type
	 * @return
	 */
	@RequestMapping("/getGoodsByType")
	@ResponseBody
	public BaseReslt<Object> getGoodsByType(String type){
		BaseReslt<Object> bReslt=new BaseReslt<>();
		BusinessMap<List<GoodsAll>> bMap=goodsService.getGoodsByType(type);  
		if (!bMap.getIsSucc()) {
			bReslt.setSuccess(false);
			bReslt.setMsg(bMap.getMsg());
			return bReslt;
		}
		bReslt.setSuccess(true);
		bReslt.setObj(bMap.getInfoBody());
		return bReslt;
	}
	
	/**
	 * 发布商品-根据产品类型获取产品品牌
	 * @description: TODO
	 * @creator: fj
	 * @createDate: 2017年4月26日 
	 * @modifier:
	 * @modifiedDate:
	 * @param type
	 * @return
	 */
	@RequestMapping("/getGoodsBrand")
	@ResponseBody
	public BaseReslt<Object> getGoodsBrand(String type){
		BaseReslt<Object> bReslt=new BaseReslt<>();
		BusinessMap<List<String>> bMap=goodsService.getGoodsBrand(type);  
		if (!bMap.getIsSucc()) {
			bReslt.setSuccess(false);
			bReslt.setMsg(bMap.getMsg());
			return bReslt;
		}
		bReslt.setSuccess(true);
		bReslt.setObj(bMap.getInfoBody());
		return bReslt;
	}
	
	/**
	 * 发布商品-通过产品品牌（brand）获取：产品名称（name）、产品规格（gg）、产品代码（code）、产品规格详情（pyname）
	 * @description: TODO
	 * @creator: fj
	 * @createDate: 2017年4月26日 
	 * @modifier:
	 * @modifiedDate:
	 * @param type
	 * @return
	 */
	@RequestMapping("/getGoodsInfo")
	@ResponseBody
	public BaseReslt<Object> getGoodsInfo(String brand){
		BaseReslt<Object> bReslt=new BaseReslt<>();
		BusinessMap<List<DataCpmls>> bMap=goodsService.getGoodsInfo(brand);  
		if (!bMap.getIsSucc()) {
			bReslt.setSuccess(false);
			bReslt.setMsg(bMap.getMsg());
			return bReslt;
		}
		bReslt.setSuccess(true);
		bReslt.setObj(bMap.getInfoBody());
		return bReslt;
	}
	
	/**
	 * 发布商品-通过产品品牌（brand）、产品名称（name）、产品规格（gg）、产品代码（code）、产品规格详情（pyname）查询商品信息
	 * @description: TODO
	 * @creator: fj
	 * @createDate: 2017年4月26日 
	 * @modifier:
	 * @modifiedDate:
	 * @param type
	 * @returnInteger 
	 */
	@RequestMapping("/getCommodityAlls")
	@ResponseBody
	public BaseReslt<Object> getCommodityAlls(Integer pageNo,String brand,String name,String gg,String code,String pyname,HttpSession session,
			String query){
		BaseReslt<Object> bReslt=new BaseReslt<>();
		Map<String, Object> param=new HashMap<String,Object>();
		String custNo=(String)session.getAttribute("custNo");
		if(custNo==null||"".equals(custNo)){
			bReslt.setSuccess(false);
			bReslt.setMsg("对不起，请先登录！");
			return bReslt;
		}
		param.put("custNo", custNo);
		param.put("brand", brand);
		param.put("query", query);
//		param.put("name", name);
//		param.put("gg", gg);
		if(!StringUtil.isEmpty(gg)){
			code = code+gg;
			if(!StringUtil.isEmpty(pyname)){
				code = code + pyname;
			}
		}else{
			if(!StringUtil.isEmpty(pyname)){
				code = code +"%"+ pyname;
			}
		}
		
		
		param.put("code", code);
//		param.put("pyname", pyname);
		//默认每页8条数据
		int pageSize=8;
		if (StringUtil.isEmpty(String.valueOf(pageNo))) {
			pageNo=1;
		}
		Pager pager=new Pager();
		//初始化page对象
		pager.setPageSize(pageSize);
		pager.setPageNo(pageNo);
		//查询满足条件的信息
		BusinessMap<Pager> bMap=goodsService.getCommodityAlls(param,pager);
		if (!bMap.getIsSucc()) {
			bReslt.setMsg(bMap.getMsg());
			bReslt.setSuccess(false);
			return bReslt;
		}
		//循环遍历商品list  并查询每个商品的折扣
		Pager resultPage=bMap.getInfoBody();	
		//获取商品list
		List<GoodsAll> gList=resultPage.getRows();
		//商品折扣list
		List<GoodsDiscount> dList=new ArrayList<>();
		//查询参数，包括goodsNo、custNo
		Map<String, String> param1=new HashMap<>(); 
		param1.put("custNo", custNo);
		for (int i = 0; i < gList.size(); i++) {
			param1.put("goodsNo", gList.get(i).getCpdm());
			//获取每个goods的折扣list
			BusinessMap bMap2=goodsDiscountService.getDiscountAlls(param1);
			if (!bMap2.getIsSucc()) {
				bReslt.setSuccess(false);
				bReslt.setMsg(bMap2.getMsg());
				return bReslt;
			}
			dList=(List<GoodsDiscount>)bMap2.getInfoBody();
			gList.get(i).setList(dList);
		}
		resultPage.setRows(gList);
		bReslt.setObj(resultPage);
		bReslt.setSuccess(true);
		return bReslt;
	}
	/**
	 * 发布商品-新增商品
	 * @description: TODO
	 * @creator: fj
	 * @createDate: 2017年4月27日 
	 * @modifier:
	 * @modifiedDate:
	 * @return
	 */
	@RequestMapping("/goodsPublishs")
	@ResponseBody
	public BaseReslt<Object> goodsPublishs(@RequestParam HashMap<String, Object> param,HttpSession session){
		BaseReslt<Object> bReslt=new BaseReslt<>();
		BusinessMap<Object> bMap = null;
		String custNo=(String)session.getAttribute("custNo");
		if(custNo==null||"".equals(custNo)){
			bReslt.setSuccess(false);
			bReslt.setMsg("对不起，请先登录！");
			return bReslt;
		}
		String checkIds = param.get("checkId")+"";
		param.put("custNo", custNo);
		String codes = param.get("codes")+"";
		param.put("codes", codes);
		if(StringUtil.isEmpty(checkIds)){
			bMap = goodsService.puhlishAll(param);
		}else{
			bMap = goodsService.puhlishChecked(param);
		}
		if (!bMap.getIsSucc()) {
			bReslt.setSuccess(false);
			bReslt.setMsg(bMap.getMsg());
			return bReslt;
		}
//		TPubSupplyGoods supplyGoods=new TPubSupplyGoods();
//		JSONObject object=JSONObject.parseObject(param);
//		//折扣参数
//		List<TPubGoodsDiscount> list=new ArrayList<>();
//		
//		String custNo=(String)session.getAttribute("custNo");
//		String goodsNo=object.getString("goodsNo");
//		String goodsPrice=object.getString("goodsPrice");
//		String status=object.getString("status");
//		String goodsName=object.getString("goodsName");
//		Integer defaultPayDt=object.getInteger("defaultPayDt");
//		Integer minkc=object.getInteger("minkc");
//		Integer orderIncrement=object.getInteger("orderIncrement");
//		String goodsCode=object.getString("goodsCode");
//		
//		supplyGoods.setCustNo(custNo);								  //用户编号
//		supplyGoods.setGoodsName(goodsName);						  //商品名称
//		supplyGoods.setGoodsNo(goodsNo);                              //商品编号
//		supplyGoods.setInsertDate(new Date());            			  //新增日期
//		supplyGoods.setStatus(status);								  //状态
//		supplyGoods.setTableKey(UUIDUtil.getParseUUID());			  //主键
//		supplyGoods.setDefaultPayDt(defaultPayDt);					  //默认交期
//		supplyGoods.setGoodsPrice(goodsPrice);						  //商品价格
//		supplyGoods.setMinkc(minkc);								  //最小起订量
//		supplyGoods.setOrderIncrement(orderIncrement);				  //订购递增量
//		supplyGoods.setGoodsCode(goodsCode);						  //产品类代码
//		
//		//判断该商品是否已经存在
//		/*Map<String, String> param1=new HashMap<>();
//		param1.put("custNo", custNo);
//		param1.put("goodsNo", goodsNo);
//		BusinessMap<Object> resultMap=goodsService.findIsExist(param1);
//		if (!resultMap.getIsSucc()) {
//			bReslt.setSuccess(false);
//			bReslt.setMsg(resultMap.getMsg());
//			return bReslt;
//		}else{
//			if ((Integer)resultMap.getInfoBody()==1) {
//				bReslt.setSuccess(false);
//				bReslt.setMsg("该商品已存在，无需重复添加");
//				return bReslt;
//			}
//		}*/
//		List<Object> discount=object.getJSONArray("discount");
//		//循环遍历获取折扣信息
//		for (int i = 0; i < discount.size(); i++) {
//			JSONObject jsonObject=JSONObject.parseObject(discount.get(i).toString());
//			TPubGoodsDiscount goodsDiscount=new TPubGoodsDiscount();
//			goodsDiscount.setDiscountRate(jsonObject.getString("discount"));				
//			goodsDiscount.setCustNo(custNo);
//			goodsDiscount.setDiscountObject(jsonObject.getString("gradesNo"));
//			goodsDiscount.setGoodsNo(goodsNo);
//			goodsDiscount.setInsertDate(new Date());
//			goodsDiscount.setTableKey(UUIDUtil.getParseUUID());
//			goodsDiscount.setDiscountStatus(GoodsConstants.discountStatusNormal);
//			list.add(goodsDiscount);
//		}
//		BusinessMap<Object> bMap=goodsService.saveGoodsSupplys(supplyGoods);
//		if (!bMap.getIsSucc()) {
//			bReslt.setSuccess(false);
//			bReslt.setMsg(bMap.getMsg());
//			return bReslt;
//		}
//		BusinessMap<Object> bMap2=goodsDiscountService.save(list);
//		if (!bMap.getIsSucc()) {
//			bReslt.setSuccess(false);
//			bReslt.setMsg(bMap.getMsg());
//			return bReslt;
//		}
		bReslt.setMsg("发布商品成功");
		bReslt.setSuccess(true);
		return bReslt;
	}
	
	/**
	 * 修改商品状态
	 * @description: TODO
	 * @creator: fj
	 * @createDate: 2017年4月27日 
	 * @modifier:
	 * @modifiedDate:
	 * @return
	 */
	@RequestMapping("/startAndEnd")
	@ResponseBody
	public BaseReslt<Object> startAndEnd(String tableKey){
		BaseReslt<Object> bReslt=new BaseReslt<>();
		BusinessMap<Object> bMap=goodsService.startAndEnd(tableKey);
		if (!bMap.getIsSucc()) {
			bReslt.setSuccess(false);
			bReslt.setMsg(bMap.getMsg());
			return bReslt;
		}
		bReslt.setMsg("商品启用停用成功！");
		bReslt.setSuccess(true);
		return bReslt;
	}

	/**
	 * 发布商品-根据产品类型获取产品品牌
	 * @description: TODO
	 * @creator: fj
	 * @createDate: 2017年4月26日 
	 * @modifier:
	 * @modifiedDate:
	 * @param type
	 * @return
	 */
	@RequestMapping("/getGoodsBrand")
	@ResponseBody
	public BaseReslt<Object> getGoodDetal(String code,String guige,String id){
		BaseReslt<Object> bReslt=new BaseReslt<>();
		if(StringUtil.isEmpty(code)){
			bReslt.setSuccess(false);
			bReslt.setMsg("产品类代码为空");
			return bReslt;
		}
		if(StringUtil.isEmpty(guige)){
			bReslt.setSuccess(false);
			bReslt.setMsg("产品规格为空");
			return bReslt;
		}
		if(StringUtil.isEmpty(id)){
			bReslt.setSuccess(false);
			bReslt.setMsg("该产品不存在");
			return bReslt;
		}
		HashMap<String, Object> map = new HashMap<>();
		map.put("code", code);
		map.put("guige", guige);
		map.put("id", id);
		try {
			DataCp dataCp=goodsService.getGoodDetal(map);
			bReslt.setSuccess(true);
			bReslt.setObj(dataCp);
			return bReslt;
		} catch (Exception e) {
			bReslt.setSuccess(false);
			bReslt.setMsg("查询数据失败");
			return bReslt;
		}
	}
	
	/**
	 * 
	 * @description: 加载左边的菜单以及卡尺的类别（卡尺类 量块的信息）
	 * @creator: 欧诗阳
	 * @createDate: 2017年7月19日 
	 * @modifier:
	 * @modifiedDate:
	 * @return
	 */
	@RequestMapping("/getLeftMenu")
	@ResponseBody
	public BaseReslt<Object> getLeftMenu(HttpSession session){
		BaseReslt<Object> bReslt=new BaseReslt<>();
		String custNo=(String) session.getAttribute("custNo");
		try {
			List<DataCatalogManage> dataCatalogManage = goodsService.getLeftMenu(custNo);
			bReslt.setSuccess(true);
			bReslt.setObj(dataCatalogManage);
			return bReslt;
		} catch (Exception e) {
			bReslt.setSuccess(false);
			bReslt.setMsg("加载数据失败");
			return bReslt;
		}
	}
	/**
	 * 
	 * @description: 加载上边的信息
	 * @creator: 欧诗阳
	 * @createDate: 2017年7月27日 
	 * @modifier:
	 * @modifiedDate:
	 * @return
	 */
	@RequestMapping("/getTopMenu")
	@ResponseBody
	public BaseReslt<Object>getTopMenu(HttpSession session,HttpServletRequest request, HttpServletResponse response,String id){
		BaseReslt<Object> bReslt=new BaseReslt<>();
		Map<String, String>map = new HashMap<>();
		String custNo=(String)session.getAttribute("custNo");
		map.put("id", id);
		map.put("custNo", custNo);
		try {
			List<TPubSupplyBrand> list = goodsService.getTopMenu(map);
			bReslt.setSuccess(true);
			bReslt.setObj(list);
			return bReslt;
		} catch (Exception e) {
			bReslt.setSuccess(false);
			bReslt.setMsg("加载数据失败");
			return bReslt;
		}
	}
	@RequestMapping("/getLeftMenuNum")
	@ResponseBody
	public BaseReslt<Object>getLeftMenuNum(HttpSession session,HttpServletRequest request, HttpServletResponse response){
		BaseReslt<Object> bReslt=new BaseReslt<>();
		String custNo=(String)session.getAttribute("custNo");
		try {
			List<DataCatalogManage> dataCatalogManage = goodsService.getLeftMenuNum(custNo);
			bReslt.setSuccess(true);
			bReslt.setObj(dataCatalogManage);
			return bReslt;
		} catch (Exception e) {
			bReslt.setSuccess(false);
			bReslt.setMsg("加载数据失败");
			return bReslt;
		}
	}
	@RequestMapping("/getByGrade")
	@ResponseBody
	public BaseReslt<Object>getByGrade(HttpSession session,HttpServletRequest request, HttpServletResponse response,String grade){
		BaseReslt<Object> bReslt=new BaseReslt<>();
		Map<String, String>map = new HashMap<>();
		map.put("grade",grade);
		try {
			List<DataCatalogManage> dataCatalogManage = goodsService.getByGrade(map);
			bReslt.setSuccess(true);
			bReslt.setObj(dataCatalogManage);
			return bReslt;
		} catch (Exception e) {
			bReslt.setSuccess(false);
			bReslt.setMsg("加载数据失败");
			return bReslt;
		}
	}
	@RequestMapping("/getByGradeAndBrand")
	@ResponseBody
	public BaseReslt<Object>getByGradeAndBrand(HttpSession session,HttpServletRequest request, HttpServletResponse response,String grade,String brandId){
		BaseReslt<Object> bReslt=new BaseReslt<>();
		Map<String, String>map = new HashMap<>();
		String custNo = (String)session.getAttribute("custNo");
	/*	if(brandId==""){
			map.put("grade",grade);
			try {
				List<DataCatalogManage> dataCatalogManage = goodsService.getByGrade(map);
				bReslt.setSuccess(true);
				bReslt.setObj(dataCatalogManage);
				return bReslt;
			} catch (Exception e) {
				bReslt.setSuccess(false);
				bReslt.setMsg("加载数据失败");
				return bReslt;
			}
		}*/
		map.put("grade",grade);
		map.put("brandId",brandId);
		map.put("custNo", custNo);
		try {
			List<DataCatalogManage> dataCatalogManage = goodsService.getByGradeAndBrand(map);
			bReslt.setSuccess(true);
			bReslt.setObj(dataCatalogManage);
			return bReslt;
		} catch (Exception e) {
			bReslt.setSuccess(false);
			bReslt.setMsg("加载数据失败");
			return bReslt;
		}
	}
	/**
	 * 
	 * @description: 查询右边
	 * @creator: 欧诗阳
	 * @createDate: 2017年7月19日 
	 * @modifier:
	 * @modifiedDate:
	 * @param zh
	 * @return
	 */
	@RequestMapping("/getDataCpmlss")
	@ResponseBody
	public BaseReslt<Object> getDataCpmlss(String classTypeId,String brand,HttpSession session,String brandNo){
		BaseReslt<Object> bReslt=new BaseReslt<>();
		Map<String, String> map = new HashMap<>();
		map.put("classTypeId", classTypeId);
		map.put("brand", brand);
		map.put("brandNo", brandNo);
		if(StringUtil.isEmpty(brand)){
			String custNo=(String) session.getAttribute("custNo");
			map.put("custNo", custNo);
		}
		try {
			List<DataCpmlss>list = goodsService.getDataCpmlss(map);
			bReslt.setSuccess(true);
			bReslt.setObj(list);
			return bReslt;
		} catch (Exception e) {
			bReslt.setSuccess(false);
			bReslt.setMsg("加载数据失败");
			return bReslt;
		}
	}
	
	
	
	@RequestMapping("/getDataCpmlss2")
	@ResponseBody
	public BaseReslt<Pager<DataCp>> getDataCpmlss2(String code,String pageNo,HttpSession session){
		BaseReslt<Pager<DataCp>> bReslt=new BaseReslt<>();
		String custNo=(String) session.getAttribute("custNo");
		Pager<DataCp>pager = new Pager<DataCp>();
		Map<String, String> map = new HashMap<>();
		map.put("code", code);
		map.put("custNo", custNo);
		Map<String, String> param1=new HashMap<>(); 
		try {
			//默认每页8条数据
			pager.setPageNo(Integer.parseInt(pageNo == null ? "1" : pageNo));
			pager.setPageSize(8);
			Pager<DataCp>pager2= goodsService.getDataCpmlss2(map,pager);
			Map<String, String>map1 = new HashMap<>();
			for (int i = 0; i <pager2.getRows().size(); i++) {
				map1.put(pager2.getRows().get(i).getId(), pager2.getRows().get(i).getId());
			}
			Iterator<String> iter5=map1.values().iterator();
			Map<String, Object> map2 = new HashMap<>();
			while (iter5.hasNext()){
				String xObject =iter5.next();
				param1.put("goodsNo", xObject);
				param1.put("custNo",custNo);
				BusinessMap bMap2=goodsDiscountService.getDiscountAll(param1);
				map2.put(xObject, (List<Object>) bMap2.getInfoBody());
			}
			bReslt.setMap(map2);
			bReslt.setSuccess(true);
			bReslt.setObj(pager2);
			return bReslt;
		} catch (Exception e) {
			bReslt.setSuccess(false);
			bReslt.setMsg("获取数据失败");
			return bReslt;
		}
	}
	
	/**
	 * 查出该类型下的详细信息
	 * @description: TODO
	 * @creator: 欧诗阳
	 * @createDate: 2017年7月19日 
	 * @modifier:
	 * @modifiedDate:
	 * @param id
	 * @return
	 */
	@RequestMapping("/getDataCpmlss1")
	@ResponseBody
	public BaseReslt<Pager<DataCp>> getDataCpmlss1(String code,String pageNo,HttpSession session,String isSell){
		BaseReslt<Pager<DataCp>> bReslt=new BaseReslt<>();
		String custNo=(String) session.getAttribute("custNo");
		if(isSell.equals("0")){
			isSell=null;
		}
		Pager<DataCp>pager = new Pager<DataCp>();
		Map<String, String> map = new HashMap<>();
		map.put("code", code);
		map.put("custNo", custNo);
		map.put("isSell", isSell);
		Map<String, String> param1=new HashMap<>(); 
		try {
			//默认每页8条数据
			pager.setPageNo(Integer.parseInt(pageNo == null ? "1" : pageNo));
			pager.setPageSize(8);
			Pager<DataCp>pager2= goodsService.getDataCpmlss1(map,pager);
			
			for (DataCp goodsAll : pager2.getRows()) {
				String s=goodsAll.getStatus().equals("0")?"停用":"启用";
				goodsAll.setStatus(s);
			}
			Map<String, String>map1 = new HashMap<>();
			for (int i = 0; i <pager2.getRows().size(); i++) {
//				map1.put(pager2.getRows().get(i).getId(), pager2.getRows().get(i).getId());
				
				map1.put(pager2.getRows().get(i).getCpdm(), pager2.getRows().get(i).getCpdm());
			}
			Iterator<String> iter5=map1.values().iterator();
			Map<String, Object> map2 = new HashMap<>();
			while (iter5.hasNext()){
				String xObject =iter5.next();
				param1.put("goodsNo", xObject);
				param1.put("custNo",custNo);
				BusinessMap bMap2=goodsDiscountService.getDiscountAll(param1);
				map2.put(xObject, (List<Object>) bMap2.getInfoBody());
			}
			bReslt.setMap(map2);
			bReslt.setSuccess(true);
			bReslt.setObj(pager2);
			return bReslt;
		} catch (Exception e) {
			bReslt.setSuccess(false);
			bReslt.setMsg("获取数据失败");
			return bReslt;
		}
	}
	@RequestMapping("/getByGuiGe")
	@ResponseBody
	public BaseReslt<Pager<DataCp>> getByGuiGe(String classTypeId,String pageNo,String brand){
		BaseReslt<Pager<DataCp>> bReslt=new BaseReslt<>();
		Pager<DataCp>pager = new Pager<DataCp>();
		Map<String, String> map = new HashMap<>();
		map.put("classTypeId", classTypeId);
		map.put("brand", brand);
		try {
			//默认每页8条数据
			pager.setPageNo(Integer.parseInt(pageNo == null ? "1" : pageNo));
			pager.setPageSize(8);
			Pager<DataCp>pager2= goodsService.getByGuiGe(map,pager);
			bReslt.setSuccess(true);
			bReslt.setObj(pager2);
			return bReslt;
		} catch (Exception e) {
			bReslt.setSuccess(false);
			bReslt.setMsg("获取数据失败");
			return bReslt;
		}
	}
}

