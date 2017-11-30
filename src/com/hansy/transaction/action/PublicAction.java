
package com.hansy.transaction.action;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hansy.transaction.common.BaseReslt;
import com.hansy.transaction.common.BusinessMap;
import com.hansy.transaction.common.constants.OrderConstants;
import com.hansy.transaction.common.constants.UserConstants;
import com.hansy.transaction.common.execption.ServiceException;
import com.hansy.transaction.common.utils.StringUtil;
import com.hansy.transaction.common.utils.UUIDUtil;
import com.hansy.transaction.model.bo.CreateCart;
import com.hansy.transaction.model.bo.CreateOrder;
import com.hansy.transaction.model.bo.TUserBaseInfoBo;
import com.hansy.transaction.model.vo.TBusShoppCartVo;
import com.hansy.transaction.model.vo.TUserBaseInfoVo;
import com.hansy.transaction.service.ITBusShoppCartService;
import com.hansy.transaction.service.ITUserBaseInfoService;

/**
 * 通用action
 * TODO javadoc for com.hansy.transaction.action.PublicAction
 * @Copyright: 2017成都环赛信息技术有限公司 
 * @author: cj
 * @since: 2017年3月31日
 */
@Controller()
@RequestMapping("/public")
public class PublicAction {
	@Resource
	private ITUserBaseInfoService baseInfoService;
	@Resource
	private ITBusShoppCartService shoppCartService;
	
	@RequestMapping("/shoppingCart")
	@ResponseBody
	public BaseReslt<Object> createShoppCart(String custNo,String goodsNo,String buyNum,String buyType,String channel,HttpSession session){
		BaseReslt<Object> bReslt=new BaseReslt<>();
		//判断参数是否为空
		if (!StringUtil.isEmpty(custNo)&&StringUtil.isEmpty(goodsNo)&&StringUtil.isEmpty(buyNum)&&StringUtil.isEmpty(buyType)&&StringUtil.isEmpty(channel)) {
			bReslt.setSuccess(false);
			bReslt.setMsg("参数不正确");
			return bReslt;
		}
		//判断用户是否存在
		BusinessMap<TUserBaseInfoBo> bMap=baseInfoService.getUser(custNo);
		TUserBaseInfoBo baseInfoVo=bMap.getInfoBody();
		if (!bMap.getIsSucc()) {
			bReslt.setSuccess(false);
			bReslt.setMsg("服务器内部错误");
			return bReslt;
		}else{
			if (baseInfoVo==null) {
				bReslt.setSuccess(false);
				bReslt.setMsg("用户不存在");
				return bReslt;
			}
		}
		//判断商品是否存在
		Map<String, String>mapm = new HashMap<>();
		mapm.put("custNo", custNo);
		mapm.put("goodsNo", goodsNo);
		BusinessMap<CreateCart> bMap2=shoppCartService.getCreateCart(mapm);
		CreateCart createCart=bMap2.getInfoBody();
		if (!bMap2.getIsSucc()) {
			bReslt.setSuccess(false);
			bReslt.setMsg("服务器内部错误");
			return bReslt;
		}else{
			if (createCart==null) {
				bReslt.setSuccess(false);
				bReslt.setMsg("商品不存在");
				return bReslt;
			}
		}
		//判断数量是否正确
		Pattern pattern=Pattern.compile("^[1-9][0-9]*$");
		Matcher matcher=pattern.matcher(buyNum);
		if (!matcher.matches()) {
			bReslt.setSuccess(false);
			bReslt.setMsg("购买数量不正确");
			return bReslt;
		}
		//判断购买类型
		if (!OrderConstants.orderTypeTrial.equals(buyType)||OrderConstants.orderTypeBuy.equals(buyType)) {
			bReslt.setSuccess(false);
			bReslt.setMsg("购买类型不正确");
			return bReslt;
		}
		
		TBusShoppCartVo shoppCartVo=new TBusShoppCartVo();
		shoppCartVo.setBuyNum(Integer.valueOf(buyNum));				//购买数量
		shoppCartVo.setBuyType(buyType);							//购买类型
		shoppCartVo.setChannel(channel); 							//渠道
		shoppCartVo.setCustName(baseInfoVo.getCustName()); 	//客户名称
		shoppCartVo.setCustNo(baseInfoVo.getCustNo()); 		//客户编号
		shoppCartVo.setDefaultPayDt(createCart.getDefaultPayDt());	//默认交期
		shoppCartVo.setGoodsName(createCart.getGoodsName()); 		//商品名称
		shoppCartVo.setGoodsNo(goodsNo); 							//商品编号
		shoppCartVo.setGoodsPrice(createCart.getGoodsPrice()); 		//商品价格
		shoppCartVo.setInsertDate(new Date()); 						//插入时间
		shoppCartVo.setSupplyName(createCart.getSypplyName()); 		//供方姓名
		shoppCartVo.setSupplyNo(createCart.getSupplyNo());			//供方编号
		shoppCartVo.setTableKey(UUIDUtil.getParseUUID());			//主键
		BusinessMap<Object> bMap3=shoppCartService.insert(shoppCartVo);
		if (!bMap3.getIsSucc()) {
			bReslt.setSuccess(false);
			bReslt.setMsg("加入购物车失败，数据库异常");
			return bReslt;
		}
		bReslt.setMsg("成功");
		bReslt.setSuccess(true);
		return bReslt;
	}
	
	@RequestMapping("/toShoppingCart")
	public ModelAndView toShoppingCart(String custNo,HttpSession session){
		ModelAndView mView=null;
		//判断用户是否存在
		BusinessMap<TUserBaseInfoBo> bMap=baseInfoService.getUser(custNo);
		TUserBaseInfoBo baseInfoVo=bMap.getInfoBody();
		if (!bMap.getIsSucc()) {
			throw new ServiceException("服务器内部错误");
		}else{
			if (baseInfoVo==null) {
				throw new ServiceException("用户不存在");
			}
		}
		String turnAddress="";
		//根据用户类型判断是供方还是买方
		if (baseInfoVo.getUserType().equals(UserConstants.supplyUser)) {
			turnAddress="applyIndent_tab";
		}else{
			turnAddress="buyerIndent_tab";
		}
		ModelAndView view = new ModelAndView(turnAddress);
		session.setAttribute("custNo", custNo);
		return view;
	}
}

