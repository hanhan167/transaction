
package com.hansy.transaction.model.vo;

import java.io.Serializable;
import java.util.Date;


public class TBusTrialVo implements Serializable {

	/**
	 * Comment for <code>serialVersionUID</code>
	 */
	private static final long serialVersionUID = -5089580392578390217L;
	private String orderNo;			//订单编号
	private String orderType;		//订单类型
	private String custNo;			//用户编号
	private String goodsNo;			//商品编号
	private String onTrialResult;	//试刀结果
	private Date insertDate;		//新增时间
	private Date updateDate;		//修改时间
	
	public String getOrderNo() {
		return orderNo;
	}
	
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	
	public String getOrderType() {
		return orderType;
	}
	
	public void setOrderType(String orderType) {
		this.orderType = orderType;
	}
	
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
	
	public String getOnTrialResult() {
		return onTrialResult;
	}
	
	public void setOnTrialResult(String onTrialResult) {
		this.onTrialResult = onTrialResult;
	}
	
	public Date getInsertDate() {
		return insertDate;
	}
	
	public void setInsertDate(Date insertDate) {
		this.insertDate = insertDate;
	}
	
	public Date getUpdateDate() {
		return updateDate;
	}
	
	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	@Override
	public String toString() {
		return "TBusTrialVo [orderNo=" + orderNo + ", orderType=" + orderType + ", custNo=" + custNo + ", goodsNo=" + goodsNo + ", onTrialResult=" + onTrialResult + ", insertDate="
				+ insertDate + ", updateDate=" + updateDate + "]";
	}
}

