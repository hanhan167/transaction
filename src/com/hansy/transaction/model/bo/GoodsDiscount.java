
package com.hansy.transaction.model.bo;

import java.io.Serializable;


public class GoodsDiscount implements Serializable {

	/**
	 * Comment for <code>serialVersionUID</code>
	 */
	private static final long serialVersionUID = -848817098023153685L;
	private String tableKey;			//主键
	private String discountObject;		//折扣对象
	private String discountRate;		//折扣率
	private String discountStatus;		//折扣状态
	private String gradeNo;			//折扣编号
	
	public String getTableKey() {
		return tableKey;
	}
	
	public void setTableKey(String tableKey) {
		this.tableKey = tableKey;
	}
	
	public String getDiscountObject() {
		return discountObject;
	}
	
	public void setDiscountObject(String discountObject) {
		this.discountObject = discountObject;
	}
	
	public String getDiscountRate() {
		return discountRate;
	}
	
	public void setDiscountRate(String discountRate) {
		this.discountRate = discountRate;
	}
	
	public String getDiscountStatus() {
		return discountStatus;
	}
	
	public void setDiscountStatus(String discountStatus) {
		this.discountStatus = discountStatus;
	}

	
	public String getGradeNo() {
		return gradeNo;
	}

	
	public void setGradeNo(String gradeNo) {
		this.gradeNo = gradeNo;
	}
}

