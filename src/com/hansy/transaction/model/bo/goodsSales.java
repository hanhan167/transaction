
package com.hansy.transaction.model.bo;

import java.io.Serializable;


public class goodsSales implements Serializable {

	/**
	 * Comment for <code>serialVersionUID</code>
	 */
	private static final long serialVersionUID = -6847837240412217718L;
	private String goodsName;			//商品名称
	private String guige;				//商品规格
	private String goodsCount;			//销售总数量
	private String sales;				//总销售额
	
	public String getGoodsName() {
		return goodsName;
	}
	
	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}
	
	public String getGuige() {
		return guige;
	}
	
	public void setGuige(String guige) {
		this.guige = guige;
	}
	
	public String getGoodsCount() {
		return goodsCount;
	}
	
	public void setGoodsCount(String goodsCount) {
		this.goodsCount = goodsCount;
	}
	
	public String getSales() {
		return sales;
	}
	
	public void setSales(String sales) {
		this.sales = sales;
	}
}

