package com.hansy.transaction.model.bo;

public class SupplyLimitPrice {
		
	private String tableKey;//主键
	private String supplyName;//供应商名称
	private Double limitPrice;//下限金额
	private Integer billArriveDate;//发票到达时间
	private String custNo;//custNo和用户表关联
	
	public String getTableKey() {
		return tableKey;
	}
	public void setTableKey(String tableKey) {
		this.tableKey = tableKey;
	}
	
	public Integer getBillArriveDate() {
		return billArriveDate;
	}
	public void setBillArriveDate(Integer billArriveDate) {
		this.billArriveDate = billArriveDate;
	}
	public String getSupplyName() {
		return supplyName;
	}
	public void setSupplyName(String supplyName) {
		this.supplyName = supplyName;
	}
	public Double getLimitPrice() {
		return limitPrice;
	}
	public void setLimitPrice(Double limitPrice) {
		this.limitPrice = limitPrice;
	}
	public String getCustNo() {
		return custNo;
	}
	public void setCustNo(String custNo) {
		this.custNo = custNo;
	}
	
	
}
