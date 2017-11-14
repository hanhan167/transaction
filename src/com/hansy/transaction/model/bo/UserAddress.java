
package com.hansy.transaction.model.bo;

import java.io.Serializable;
import java.util.Date;

/**
 * 用户收货地址
 * TODO javadoc for com.hansy.transaction.model.bo.UserAddress
 * @Copyright: 2017成都环赛信息技术有限公司 
 * @author: cj
 * @since: 2017年3月16日
 */
public class UserAddress implements Serializable {
	/**
	 * Comment for <code>serialVersionUID</code>
	 */
	private static final long serialVersionUID = 2268052159804933407L;
	private String tableKey;			//收货地址主键
	private String userPhone;			//收货人电话
	private String userName;			//收货人姓名
	private String userAddress;			//收货人详细地址
	private String status;				//默认状态
	private String province;			//省份
	private String city;				//市
	private String area;				//县
	private String postCode;      		//邮编
	private Date insetDate;
	private Date updateDate;
	
	
	public Date getInsetDate() {
		return insetDate;
	}

	public void setInsetDate(Date insetDate) {
		this.insetDate = insetDate;
	}

	public Date getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	public String getPostCode() {
		return postCode;
	}

	public void setPostCode(String postCode) {
		this.postCode = postCode;
	}

	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	public String getTableKey() {
		return tableKey;
	}
	
	public void setTableKey(String tableKey) {
		this.tableKey = tableKey;
	}
	
	public String getUserPhone() {
		return userPhone;
	}
	
	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}
	
	public String getUserName() {
		return userName;
	}
	
	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	public String getUserAddress() {
		return userAddress;
	}
	
	public void setUserAddress(String userAddress) {
		this.userAddress = userAddress;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
}

