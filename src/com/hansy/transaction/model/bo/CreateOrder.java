
package com.hansy.transaction.model.bo;

import java.io.Serializable;
import java.math.BigDecimal;

/**
 * 
 * TODO javadoc for com.hansy.transaction.model.bo.CreateOrder
 * @Copyright: 2017成都环赛信息技术有限公司 
 * @author: cj
 * @since: 2017年3月22日
 */
public class CreateOrder implements Serializable {

	/**
	 * Comment for <code>serialVersionUID</code>
	 */
	private static final long serialVersionUID = -7823324023304120319L;
	private String custNo;				//客户编号
	private String goodsNo;				//商品编号
	private Double goodsPrice;		//商品价格
	private Double goodsDiscount;  //商品折扣
	private Integer defaultPayDt;		//默认交期(天)
	private String supplyNo;			//供应商编号
	
	public String getCustNo() {
		return custNo;
	}
	
	public void setCustNo(String custNo) {
		this.custNo = custNo;
	}
	
	public String getGoodsNo() {
		return goodsNo;
	}
	
	public void setGoodsNo(String goodsNo) {
		this.goodsNo = goodsNo;
	}
	
	public Double getGoodsPrice() {
		return goodsPrice;
	}
	
	public void setGoodsPrice(Double goodsPrice) {
		this.goodsPrice = goodsPrice;
	}
	
	public Double getGoodsDiscount() {
		return goodsDiscount;
	}
	
	public void setGoodsDiscount(Double goodsDiscount) {
		this.goodsDiscount = goodsDiscount;
	}
	
	public Integer getDefaultPayDt() {
		return defaultPayDt;
	}
	
	public void setDefaultPayDt(Integer defaultPayDt) {
		this.defaultPayDt = defaultPayDt;
	}
	
	public String getSupplyNo() {
		return supplyNo;
	}
	
	public void setSupplyNo(String supplyNo) {
		this.supplyNo = supplyNo;
	}
}

