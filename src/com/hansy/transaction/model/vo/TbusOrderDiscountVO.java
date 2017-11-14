
package com.hansy.transaction.model.vo;

public class TbusOrderDiscountVO {
	private String classId;//规格
	private String dsMinkc;//最小起订数量
	private String orderIncrement;//递增量
	private String defaultPayDat;//默认交期
	private String discountRate1;//1等级对应的值
	private String discountRate2;//2等级对应的值
	private String discountRate3;//3等级对应的值
	private String discountRate4;//4等级对应的值
	
	public String getDiscountRate1() {
		return discountRate1;
	}
	public void setDiscountRate1(String discountRate1) {
		this.discountRate1 = discountRate1;
	}
	public String getDiscountRate2() {
		return discountRate2;
	}
	public void setDiscountRate2(String discountRate2) {
		this.discountRate2 = discountRate2;
	}
	public String getDiscountRate3() {
		return discountRate3;
	}
	public void setDiscountRate3(String discountRate3) {
		this.discountRate3 = discountRate3;
	}
	public String getDiscountRate4() {
		return discountRate4;
	}
	public void setDiscountRate4(String discountRate4) {
		this.discountRate4 = discountRate4;
	}
	public String getClassId() {
		return classId;
	}
	public void setClassId(String classId) {
		this.classId = classId;
	}
	public String getDsMinkc() {
		return dsMinkc;
	}
	public void setDsMinkc(String dsMinkc) {
		this.dsMinkc = dsMinkc;
	}
	public String getOrderIncrement() {
		return orderIncrement;
	}
	public void setOrderIncrement(String orderIncrement) {
		this.orderIncrement = orderIncrement;
	}
	public String getDefaultPayDat() {
		return defaultPayDat;
	}
	public void setDefaultPayDat(String defaultPayDat) {
		this.defaultPayDat = defaultPayDat;
	}
	
}

