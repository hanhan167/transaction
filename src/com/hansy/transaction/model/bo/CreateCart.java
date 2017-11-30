
package com.hansy.transaction.model.bo;

import java.io.Serializable;


public class CreateCart implements Serializable {

	/**
	 * Comment for <code>serialVersionUID</code>
	 */
	private static final long serialVersionUID = 4673622160366789771L;
	private String goodsNo;
	private String goodsName;
	private String supplyNo;
	private String sypplyName;
	private Double goodsPrice;
	private Integer defaultPayDt;
	
	public String getGoodsNo() {
		return goodsNo;
	}
	
	public void setGoodsNo(String goodsNo) {
		this.goodsNo = goodsNo;
	}
	
	public String getGoodsName() {
		return goodsName;
	}
	
	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}
	
	public String getSupplyNo() {
		return supplyNo;
	}
	
	public void setSupplyNo(String supplyNo) {
		this.supplyNo = supplyNo;
	}
	
	public String getSypplyName() {
		return sypplyName;
	}
	
	public void setSypplyName(String sypplyName) {
		this.sypplyName = sypplyName;
	}
	
	public Double getGoodsPrice() {
		return goodsPrice;
	}
	
	public void setGoodsPrice(Double goodsPrice) {
		this.goodsPrice = goodsPrice;
	}
	
	public Integer getDefaultPayDt() {
		return defaultPayDt;
	}
	
	public void setDefaultPayDt(Integer defaultPayDt) {
		this.defaultPayDt = defaultPayDt;
	}
}

