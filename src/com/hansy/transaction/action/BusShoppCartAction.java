
package com.hansy.transaction.action;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hansy.transaction.common.BaseReslt;
import com.hansy.transaction.common.BusinessMap;
import com.hansy.transaction.common.constants.GoodsConstants;
import com.hansy.transaction.common.constants.OrderConstants;
import com.hansy.transaction.common.constants.UserConstants;
import com.hansy.transaction.common.utils.StringUtil;
import com.hansy.transaction.common.utils.UUIDUtil;
import com.hansy.transaction.model.bo.CreateCart;
import com.hansy.transaction.model.bo.Order;
import com.hansy.transaction.model.bo.TUserBaseInfoBo;
import com.hansy.transaction.model.vo.TBusAddress;
import com.hansy.transaction.model.vo.TBusOrderVo;
import com.hansy.transaction.model.vo.TBusShoppCartVo;
import com.hansy.transaction.model.vo.TPubSupplyBrand;
import com.hansy.transaction.model.vo.TUserAddressVo;
import com.hansy.transaction.service.ITBusAddressService;
import com.hansy.transaction.service.ITBusOrderService;
import com.hansy.transaction.service.ITBusShoppCartService;
import com.hansy.transaction.service.ITGoodsService;
import com.hansy.transaction.service.ITUserAddressService;
import com.hansy.transaction.service.ITUserBaseInfoService;
import com.hansy.transaction.service.ITUserBillService;

/**
 * 购物车action TODO javadoc for com.hansy.transaction.action.BusShoppCartAction
 * 
 * @Copyright: 2017成都环赛信息技术有限公司
 * @author: cj
 * @since: 2017年3月15日
 */
@Controller
@RequestMapping("/busShoppCart")
public class BusShoppCartAction {

	@Resource
	private ITBusShoppCartService shoppCartService;
	@Resource
	private ITUserAddressService addressService;
	@Resource
	private ITUserBaseInfoService baseInfoService;
	@Resource
	private ITBusOrderService busOrderService;
	@Resource
	private ITBusAddressService itBusAddressService;
	@Resource
	private ITGoodsService goodsService;

	/**
	 * 跳转购物车页面
	 * 
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月15日
	 * @modifier:
	 * @modifiedDate:
	 * @return
	 */
	@RequestMapping("/toShoppCart")
	public ModelAndView toShoppCart() {
		ModelAndView view = new ModelAndView("buyerIndent_shoppingCar");
		return view;
	}

	/**
	 * 获取购物车内容
	 * 
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月16日
	 * @modifier:
	 * @modifiedDate:
	 * @param session
	 * @return
	 */
	@RequestMapping("/getShoppCart")
	@ResponseBody
	public BaseReslt<Object> getShoppCart(HttpSession session) {
		BaseReslt<Object> bReslt = new BaseReslt<Object>();
		String custNo = (String) session.getAttribute("custNo");
		Map<String, Object> map = new HashMap<>();

		// 获取购物车内容
		BusinessMap<Object> bMap = shoppCartService.getShoppCart(custNo);
		if (!bMap.getIsSucc()) {
			bReslt.setSuccess(false);
			bReslt.setMsg(bMap.getMsg());
			return bReslt;
		}
		int goodsNo = shoppCartService.getGoodsNo(custNo);
		// 获取默认收货地址
		BusinessMap<Object> businessMap = shoppCartService.getDefaultAddress(custNo);
		if (!bMap.getIsSucc()) {
			bReslt.setSuccess(false);
			bReslt.setMsg(businessMap.getMsg());
			return bReslt;
		}
		map.put("goodsNo", goodsNo);
		map.put("userAddress", businessMap.getInfoBody());
		map.put("shoppCart", bMap.getInfoBody());
		bReslt.setMap(map);
		bReslt.setSuccess(true);
		return bReslt;
	}

	/**
	 * 删除购物车商品
	 * 
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月21日
	 * @modifier:
	 * @modifiedDate:
	 * @return
	 */
	@RequestMapping("/deleteShoppCar")
	@ResponseBody
	public BaseReslt<Object> deleteShoppCar(@RequestParam("tableKey[]") List<String> tableKey) {
		BaseReslt<Object> bReslt = new BaseReslt<>();
		BusinessMap<Object> bMap = shoppCartService.delete(tableKey);
		if (!bMap.getIsSucc()) {
			bReslt.setMsg(bMap.getMsg());
			bReslt.setSuccess(false);
			return bReslt;
		}
		bReslt.setSuccess(true);
		bReslt.setMsg("操作成功");
		return bReslt;
	}

	/**
	 * 清空失效的商品，即供应商下架的商品,以及品牌为空的产品
	 * 
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月21日
	 * @modifier:
	 * @modifiedDate:
	 * @return
	 */
	@RequestMapping("/clearShoppCar")
	@ResponseBody
	public BaseReslt<Object> clearShoppCar(HttpSession session,String listGoodCodes,String listbrandNames,String listSupplyNos) {
		BaseReslt<Object> bReslt = new BaseReslt<>();
		String custNo = (String) session.getAttribute("custNo");
		if(StringUtil.isEmpty(listbrandNames)&&StringUtil.isEmpty(listSupplyNos)){
			bReslt.setSuccess(false);
			bReslt.setMsg("加载数据失败请重试");
			return bReslt;
		}
		String brandNames[] = listbrandNames.split(",");
		String supplys[]  = listSupplyNos.split(",");
		// 封装参数
		Map<String, String> param = new HashMap<>();
		param.put("custNo", custNo);
		BusinessMap<Object> bMap = shoppCartService.deleteInvalidGoods(param);
		
		if (!bMap.getIsSucc()) {
			bReslt.setMsg(bMap.getMsg());
			bReslt.setSuccess(false);
			return bReslt;
		}
		//查询品牌是否已经失效
		Map<String, String> map5 = new HashMap<>();
		for(int i =0;i<brandNames.length;i++){
			map5.put("custNo", supplys[i]);
			map5.put("code", brandNames[i]);
			map5.put("tcustNo", custNo);
			//查询该商品是否在使用 在使用就能查出来
			List<TPubSupplyBrand> list1 = goodsService.getTopMenu1(map5);
			if(list1.size()==0){
				BusinessMap<Object> bMap1 = shoppCartService.deleteInvalidGoods1(map5);
				if (!bMap1.getIsSucc()) {
					bReslt.setMsg(bMap1.getMsg());
					bReslt.setSuccess(false);
					return bReslt;
				}
			}
		}
		bReslt.setSuccess(true);
		return bReslt;
	}
	
	 
	@RequestMapping("/selectIsExist")
	@ResponseBody
	public BaseReslt<Object> selectIsExist(HttpSession session,String listGoods,String listbrandNames,String listSupplyNos) {
		BaseReslt<Object> bReslt = new BaseReslt<>();
		//查询购物车里面的sp的产品编号
		String custNo = (String) session.getAttribute("custNo");
		if(StringUtil.isEmpty(listGoods)&&StringUtil.isEmpty(listbrandNames)&&StringUtil.isEmpty(listSupplyNos)){
			bReslt.setSuccess(false);
			bReslt.setMsg("加载数据失败请重试");
			return bReslt;
		}
		String goods[] = listGoods.split(",");
		String brandNames[] = listbrandNames.split(",");
		String supplys[]  = listSupplyNos.split(",");
		Map<String, String>map = new HashMap<>();
		for(int i =0;i<goods.length;i++){
			// 判断商品是否存在
			map.clear();
			map.put("custNo", custNo);
			map.put("goodsNo", goods[i]);
			BusinessMap<CreateCart> bMap2 = shoppCartService.getCreateCart(map);
			CreateCart createCart = bMap2.getInfoBody();
			if (!bMap2.getIsSucc()) {
				bReslt.setSuccess(false);
				bReslt.setMsg("服务器内部错误");
				return bReslt;
			} else {
				if (createCart == null) {
					bReslt.setSuccess(false);
					bReslt.setMsg("存在已失效的商品请先清空");
					return bReslt;
				}
			}
		}
		//查询品牌是否已经失效
		Map<String, String> map5 = new HashMap<>();
		for(int i =0;i<brandNames.length;i++){
			map5.put("custNo", supplys[i]);
			map5.put("code", brandNames[i]);
			//查询该商品是否在使用 在使用就能查出来
			List<TPubSupplyBrand> list1 = goodsService.getTopMenu1(map5);
			if(list1.size()==0){
				bReslt.setSuccess(false);
				bReslt.setMsg("存在已失效的商品请先清空");
				return bReslt;
			}
		}
		bReslt.setSuccess(true);
		return bReslt;
	}

	/**
	 * 获取用户的收货地址
	 * 
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月28日
	 * @modifier:
	 * @modifiedDate:
	 * @param session
	 * @return
	 */
	@RequestMapping("/getUserAddress")
	@ResponseBody
	public BaseReslt<Object> getUserAddress(HttpSession session) {
		BaseReslt<Object> bReslt = new BaseReslt<>();
		String custNo = (String) session.getAttribute("custNo");
		BusinessMap<Object> bMap = shoppCartService.getUserAddress(custNo);
		if (!bMap.getIsSucc()) {
			bReslt.setSuccess(false);
			bReslt.setMsg(bMap.getMsg());
			return bReslt;
		}
		bReslt.setObj(bMap.getInfoBody());
		bReslt.setSuccess(true);
		return bReslt;

	}

	@RequestMapping("/getUserAddressByOrderNo")
	@ResponseBody
	public BaseReslt<Object> getUserAddressByOrderNo(HttpSession session,String orderNo) {
		// 根据custNo获取用户
		BaseReslt<Object> bReslt = new BaseReslt<>();
		try {
			TBusAddress tBusAddress = itBusAddressService.getByTableKey(orderNo);
			bReslt.setObj(tBusAddress);
			bReslt.setMsg("加载数据失败");
			bReslt.setSuccess(true);
			return bReslt;
		} catch (Exception e) {
			bReslt.setSuccess(false);
			return bReslt;
		}

	}

	/**
	 * 获取购物车提交的订单内容
	 * 
	 * @description: TODO
	 * @creator: tx
	 * @createDate: 2017年7月8日
	 * @modifier:
	 * @modifiedDate:
	 * @param session
	 * @return
	 */
	@RequestMapping("/getOrderList")
	@ResponseBody
	public BaseReslt<Object> getOrderList(HttpSession session) {
		BaseReslt<Object> bReslt = new BaseReslt<Object>();
		String custNo = (String) session.getAttribute("custNo");
		Map<String, Object> map = new HashMap<>();
		Map<String, Object> map1 = new HashMap<>();
		String[] arry = (String[]) session.getAttribute("arry");
		String[] codeArray = (String[]) session.getAttribute("codeArray");
		List tableKey = new ArrayList(Arrays.asList(arry));
		map1.put("custNo", custNo);
		map1.put("orderArray", tableKey);
		// 获取购物车内容
		BusinessMap<Object> bMap = shoppCartService.getShoppCartSelected(map1);
		if (!bMap.getIsSucc()) {
			bReslt.setSuccess(false);
			bReslt.setMsg(bMap.getMsg());
			return bReslt;
		}
		// 获取默认收货地址
		BusinessMap<Object> businessMap = shoppCartService.getDefaultAddress(custNo);
		if (!bMap.getIsSucc()) {
			bReslt.setSuccess(false);
			bReslt.setMsg(businessMap.getMsg());
			return bReslt;
		}
		map.put("userAddress", businessMap.getInfoBody());
		map.put("shoppCart", bMap.getInfoBody());
		bReslt.setMap(map);
		bReslt.setSuccess(true);
		return bReslt;
	}

	/**
	 * 订单界面新增收货地址
	 * 
	 * @description: TODO
	 * @creator: tx
	 * @createDate: 2017年7月10日
	 * @modifier:
	 * @modifiedDate:
	 * @return
	 */
	@RequestMapping("/addSite")
	@ResponseBody
	public BaseReslt<Object> addSite(TUserAddressVo addressVo, HttpSession session) {
		BaseReslt<Object> bReslt = new BaseReslt<Object>();
		// 根据custNo获取用户
		String custNo = (String) session.getAttribute("custNo");
		BusinessMap<TUserBaseInfoBo> bMap1 = baseInfoService.getUser(custNo);
		// 判断tableKey是否为空，不为空则为修改，为空则为新增
		if (addressVo.getTableKey() != null) {
			// 更新时间
			addressVo.setUpdateDate(new Date());
			BusinessMap<Object> bMap = addressService.update(addressVo);
			if (bMap.getIsSucc() == false) {
				bReslt.setMsg(bMap.getMsg());
				bReslt.setSuccess(false);
				return bReslt;
			}
			bReslt.setSuccess(true);
		} else {
			// 主键
			addressVo.setTableKey(UUIDUtil.getParseUUID());
			// 用户编号
			addressVo.setUserNo(bMap1.getInfoBody().getCustNo());
			// 用户名称
			addressVo.setUserName(bMap1.getInfoBody().getUserName());
			// 插入时间
			addressVo.setInsertDate(new Date());
			// 默认地址标志
			addressVo.setAddressStatus(UserConstants.defaultAddressNo);
			BusinessMap<Object> bMap = addressService.add(addressVo);
			if (bMap.getIsSucc() == false) {
				bReslt.setMsg(bMap.getMsg());
				bReslt.setSuccess(false);
			}
			bReslt.setSuccess(true);
		}
		return bReslt;
	}

	/**
	 * 修改默认收货地址
	 * 
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月6日
	 * @modifier:
	 * @modifiedDate:
	 * @return
	 */
	@RequestMapping("/defaultAddress")
	@ResponseBody
	public BaseReslt<Object> defaultAddress(String tableKey, HttpSession session) {
		BaseReslt<Object> bReslt = new BaseReslt<Object>();
		String custNo = (String) session.getAttribute("custNo");
		// 修改默认地址
		BusinessMap<Object> bMap = addressService.updateStatus(tableKey, custNo);
		if (bMap.getIsSucc() == false) {
			bReslt.setMsg(bMap.getMsg());
			bReslt.setSuccess(false);
		}
		bReslt.setSuccess(true);
		bReslt.setMsg("删除收货地址成功");
		return bReslt;
	}

	/**
	 * 删除收货地址
	 * 
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年2月27日
	 * @modifier:
	 * @modifiedDate:
	 * @param tableKey
	 * @return
	 */
	@RequestMapping("/deleteSite")
	@ResponseBody
	public BaseReslt<Object> deleteSite(String tableKey) {
		BaseReslt<Object> bReslt = new BaseReslt<Object>();
		BusinessMap<Object> bMap = addressService.delete(tableKey);
		if (bMap.getIsSucc() == false) {
			bReslt.setMsg(bMap.getMsg());
			bReslt.setSuccess(false);
		}
		bReslt.setSuccess(true);
		bReslt.setMsg("删除收货地址成功");
		return bReslt;
	}

	/**
	 * 更新购物车商品数量
	 * 
	 * @description: TODO
	 * @creator: tx
	 * @createDate: 2017年7月11日
	 * @modifier:
	 * @modifiedDate:
	 * @return
	 */
	@RequestMapping("/updateShoppCarNum")
	@ResponseBody
	public BaseReslt<Object> updateShoppCarNum(String tableKey, String num,String minkc) {
		BaseReslt<Object> bReslt = new BaseReslt<>();
		Map<String, Object> map = new HashMap<>();
		if(minkc==null||minkc==""){
			bReslt.setSuccess(false);
			bReslt.setMsg("数据有误");
			return bReslt;
		}
		if(Integer.parseInt(num)%Integer.parseInt(minkc)!=0){
			bReslt.setSuccess(false);
			bReslt.setMsg("数量必须是最小起订量的倍数");
			return bReslt;
		}
		map.put("tableKey", tableKey);
		map.put("num", num);
		List<Map<String, Object>> mapUpdate = new ArrayList<>();
		mapUpdate.add(map);
		BusinessMap<Object> bMap = shoppCartService.updateShoppCartNum(mapUpdate);
		if (!bMap.getIsSucc()) {
			bReslt.setMsg(bMap.getMsg());
			bReslt.setSuccess(false);
			return bReslt;
		}
		bReslt.setSuccess(true);
		bReslt.setMsg("操作成功");
		return bReslt;
	}

	/**
	 * 再次购买加入购物车
	 * 
	 * @description: TODO
	 * @creator: tx
	 * @createDate: 2017年7月12日
	 * @modifier:
	 * @modifiedDate:
	 * @return
	 */
	@RequestMapping("/buyAgain")
	@ResponseBody
	public BaseReslt<Object> buyAgain(String orderNo, HttpSession session,String supplyNo,String brand) {
		BusinessMap<Object> flag;
		String custNo = (String) session.getAttribute("custNo");
		BusinessMap<TUserBaseInfoBo> bmap3 = baseInfoService.getUser(custNo);
		BaseReslt<Object> bReslt = new BaseReslt<>();
		Map<String, Object> map = new HashMap<>();
		// 1.根据tableKey查询原订单信息
		map.put("orderNo", orderNo);
		BusinessMap<Object> bMap = busOrderService.getOldById(map);
		List<Order> list = (List<Order>) bMap.getInfoBody();
		List<TBusShoppCartVo> cartList = new ArrayList<>();
		List<Map<String, Object>> mapUpdate = new ArrayList<>();
		
		
		String brandNames[] = brand.split(",");
		Map<String, String> map5 = new HashMap<>();
		for(int i =0;i<brandNames.length;i++){
			map5.put("custNo", supplyNo);
			map5.put("code", brandNames[i]);
			//查询该商品是否在使用 在使用就能查出来
			List<TPubSupplyBrand> list1 = goodsService.getTopMenu1(map5);
			if(list1.size()==0){
				bReslt.setSuccess(false);
				bReslt.setMsg("商品已下架或品牌已过期");
				return bReslt;
			}
		}
	
		Map<String, String>mapm = new HashMap<>();
		for (int i = 0; i < list.size(); i++) {
			// 判断商品是否存在
			mapm.clear();
			mapm.put("custNo", custNo);
			mapm.put("goodsNo", list.get(i).getGoodsNo());
			BusinessMap<CreateCart> bMap2 = shoppCartService.getCreateCart(mapm);
			CreateCart createCart = bMap2.getInfoBody();
			if (!bMap2.getIsSucc()) {
				bReslt.setSuccess(false);
				bReslt.setMsg("服务器内部错误");
				return bReslt;
			} else {
				if (createCart == null) {
					bReslt.setSuccess(false);
					bReslt.setMsg("商品已下架或品牌已过期");
					return bReslt;
				}
			}
			// 查询再次购买的商品购物车中是否存在
			map.clear();
			map.put("custNo", custNo);
			map.put("goodsNo", list.get(i).getGoodsNo());
			flag = shoppCartService.isExist(map);
			if (flag.getIsSucc()) {
				TBusShoppCartVo Vo = new TBusShoppCartVo();
				Vo.setTableKey(UUIDUtil.getParseUUID()); // 设置主键
				Vo.setCustNo(custNo); // 用户编号
				Vo.setCustName(bmap3.getInfoBody().getCustName()); // 用户名称
				Vo.setGoodsNo(list.get(i).getGoodsNo()); // 商品编号
				Vo.setGoodsName(list.get(i).getGoodsName()); // 商品名称
				Vo.setSupplyNo(list.get(i).getSupplyNo()); // 供方编号
				Vo.setSupplyName(list.get(i).getSupperName()); // 供方名称
				Vo.setBuyType(OrderConstants.orderTypeBuy); // 购买类型
				Vo.setBuyNum(list.get(i).getGoodsCount()); // 数量
				Vo.setGoodsPrice(list.get(i).getGoodsPrice()); // 商品价格
				Vo.setDefaultPayDt(createCart.getDefaultPayDt()); // 默认交期
				Vo.setInsertDate(new Date()); // 当前时间
				Vo.setBuyType(list.get(i).getOrderType()); // 购买类型
				cartList.add(Vo);
			} else {
				// 购物车已存在选购商品，修改数量+1
				TBusShoppCartVo Vo = (TBusShoppCartVo) flag.getInfoBody();
				Map<String, Object> map1 = new HashMap<>();
				map1.put("num", (Vo.getBuyNum() + new Integer("1")));
				map1.put("tableKey", Vo.getTableKey());
				mapUpdate.add(map1);
			}

		}

		if (mapUpdate.size() > 0) {
			BusinessMap<Object> bMap1 = shoppCartService.updateShoppCartNum(mapUpdate);
			if (!bMap1.getIsSucc()) {
				bReslt.setMsg(bMap1.getMsg());
				bReslt.setSuccess(false);
				return bReslt;
			}
		}
		if (cartList.size() > 0) {
			BusinessMap<Object> bMap1 = shoppCartService.inserts(cartList);
			if (!bMap1.getIsSucc()) {
				bReslt.setMsg(bMap1.getMsg());
				bReslt.setSuccess(false);
				return bReslt;
			}
		}
		Map<String,Object> params=new HashMap<String,Object>();
		String userType=(String)session.getAttribute("userType");
		params.put("custType", userType);
		params.put("nowTime", new Date());
		params.put("orderNo", orderNo);
		BusinessMap<Object> bMap4=busOrderService.updateStatus(params);
		if (!bMap4.getIsSucc()) {
			bReslt.setSuccess(false);
			bReslt.setMsg(bMap.getMsg());
			return bReslt;
		}
		bReslt.setSuccess(true);
		bReslt.setMsg("操作成功");
		return bReslt;
	}
}
