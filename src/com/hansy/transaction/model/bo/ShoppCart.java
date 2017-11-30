
package com.hansy.transaction.model.bo;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Calendar;
import java.util.Date;

import com.hansy.transaction.common.utils.DateUtil;

/**
 * 购物车
 * TODO javadoc for com.hansy.transaction.model.bo.ShoppCart
 * @Copyright: 2017成都环赛信息技术有限公司 
 * @author: cj
 * @since: 2017年3月15日
 */
public class ShoppCart implements Serializable {
	/**
	 * Comment for <code>serialVersionUID</code>
	 */
	private static final long serialVersionUID = 2914958335150156157L;
	private String tableKey;		//主键
	private String goodsName;		//商品名称
	private String supplyName;		//供方名称
	private String buyType;			//购买类型
	private Integer buyNum;			//购买数量
	private Double goodsPrice;	//商品价格
	private String goodsNo;			//商品编号
	private String supplyNo;		//供方编号
	private String defaultPayDt;	//商品默认交期
	private String goodsCode;		//商品代码
	private String insertDate;		//新增时间
	private String supplyPhone;		//供应方电话
	private String goodsDiscount;	//商品折扣
	private String par;
	private String minkc;			//最小订购量
	private String brand;	//品牌
	private String code;//产品类代码
	
	
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getBrand() {
		return brand;
	}
	public void setBrand(String brand) {
		this.brand = brand;
	}
	public String getMinkc() {
		return minkc;
	}
	public void setMinkc(String minkc) {
		this.minkc = minkc;
	}
	public String getPar() {
		return par;
	}
	public void setPar(String par) {
		this.par = par;
	}
	public String getTableKey() {
		return tableKey;
	}
	public void setTableKey(String tableKey) {
		this.tableKey = tableKey;
	}

	public String getGoodsName() {
		return goodsName;
	}
	
	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}
	
	public String getSupplyName() {
		return supplyName;
	}
	
	public void setSupplyName(String supplyName) {
		this.supplyName = supplyName;
	}
	
	public String getBuyType() {
		return buyType;
	}
	
	public void setBuyType(String buyType) {
		this.buyType = buyType;
	}
	
	public Integer getBuyNum() {
		return buyNum;
	}
	
	public void setBuyNum(Integer buyNum) {
		this.buyNum = buyNum;
	}
	
	public Double getGoodsPrice() {
		return goodsPrice;
	}
	
	public void setGoodsPrice(Double goodsPrice) {
		this.goodsPrice = goodsPrice;
	}
	
	public String getDefaultPayDt() {
		return defaultPayDt;
	}
	
	public void setDefaultPayDt(String defaultPayDt) {
		defaultPayDt=DateUtil.addDate(Calendar.getInstance(), Integer.valueOf(defaultPayDt));
		this.defaultPayDt = defaultPayDt;
	}
	
	public String getGoodsCode() {
		return goodsCode;
	}
	
	public void setGoodsCode(String goodsCode) {
		this.goodsCode = goodsCode;
	}
	
	public String getInsertDate() {
		return insertDate;
	}
	
	public void setInsertDate(String insertDate) {
		this.insertDate = insertDate;
	}
	
	public String getSupplyPhone() {
		return supplyPhone;
	}
	
	public void setSupplyPhone(String supplyPhone) {
		this.supplyPhone = supplyPhone;
	}

	
	public String getGoodsNo() {
		return goodsNo;
	}

	
	public void setGoodsNo(String goodsNo) {
		this.goodsNo = goodsNo;
	}

	
	public String getSupplyNo() {
		return supplyNo;
	}

	
	public void setSupplyNo(String supplyNo) {
		this.supplyNo = supplyNo;
	}
	
	public String getGoodsDiscount() {
		return goodsDiscount;
	}
	
	public void setGoodsDiscount(String goodsDiscount) {
		this.goodsDiscount = goodsDiscount;
	}
}

