
package com.hansy.transaction.model.vo;

import java.io.Serializable;
import java.util.Date;

public class TPubSupplyBrand implements Serializable{
	/**
	 * Comment for <code>serialVersionUID</code>
	 */
	private static final long serialVersionUID = 2661810056976890313L;
	private String tableKey;
	private String brandNo;
	private String brandName;
	private String custNo;
	private String status;
	private Date upDate1;
	private Date downDate;
	private Date insertDate;
	private Date updateDate;
	public String getTableKey() {
		return tableKey;
	}
	public void setTableKey(String tableKey) {
		this.tableKey = tableKey;
	}
	public String getBrandNo() {
		return brandNo;
	}
	public void setBrandNo(String brandNo) {
		this.brandNo = brandNo;
	}
	public String getBrandName() {
		return brandName;
	}
	public void setBrandName(String brandName) {
		this.brandName = brandName;
	}
	public String getCustNo() {
		return custNo;
	}
	public void setCustNo(String custNo) {
		this.custNo = custNo;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	public Date getUpDate1() {
		return upDate1;
	}
	public void setUpDate1(Date upDate1) {
		this.upDate1 = upDate1;
	}
	public Date getDownDate() {
		return downDate;
	}
	public void setDownDate(Date downDate) {
		this.downDate = downDate;
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
	
}

