
package com.hansy.transaction.model.vo;

import java.io.Serializable;
import java.util.Date;

/**
 * 商品折扣
 * TODO javadoc for com.hansy.transaction.model.vo.TPubGoodsDiscount
 * @Copyright: 2017成都环赛信息技术有限公司 
 * @author: cj
 * @since: 2017年3月16日
 */
public class TPubGoodsDiscount implements Serializable {
	/**
	 * Comment for <code>serialVersionUID</code>
	 */
	private static final long serialVersionUID = 5833579145010540561L;
	private String tableKey;				//主键
	private String goodsNo;					//商品编号
	private String custNo;					//供方id
	private String discountObject;			//折扣对象
	private String discountRate;			//折扣率
	private Date insertDate;				//新增时间
	private Date updateDate;				//更新时间
	private String discountStatus;			//状态
	
	public String getTableKey() {
		return tableKey;
	}
	
	public void setTableKey(String tableKey) {
		this.tableKey = tableKey;
	}
	
	public String getGoodsNo() {
		return goodsNo;
	}
	
	public void setGoodsNo(String goodsNo) {
		this.goodsNo = goodsNo;
	}
	
	public String getCustNo() {
		return custNo;
	}
	
	public void setCustNo(String custNo) {
		this.custNo = custNo;
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
	
	public String getDiscountStatus() {
		return discountStatus;
	}
	
	public void setDiscountStatus(String discountStatus) {
		this.discountStatus = discountStatus;
	}
}

