package com.hansy.transaction.model.bo;

import java.io.Serializable;



/**
 * 客户显示表(只用于显示)
 *
 * @author Administrator
 *
 */

public class CustomerDisplay implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -5624689978341951489L;
	/* 用户登录表 t_user_base_info */

	private String userNo;// 编号(用户登录表)
	private String userName;// 名称(用户登录表)
	private String salesMan;// 业务员(用户登录表)
	private String PriceLevel;// 销售价(用户登录表)
	private Integer lineOfCredit;// 信用额度(用户登录表)
	private String primaryContact;// 联系人(用户登录表)
	private String personPosition;// 职位(用户登录表)
	private String userEmail;// 邮箱(用户登录表) 发票信息表
	private String remarks;// 备注(用户登录表)
	private String userStatus;// 状态(用户登录表)
	/* 地址表 t_user_address */
	private String address;// （收货）地址（地址表）
	private String invoiceAddress;// 发票地址（地址表） 发票信息表
	private String city;// 城市（地址表）
	private String postCode;// 邮编（地址表）
	private Long telephone;// 电话(用户登录表,地址表)
	private String status;// 使用状态
	private String netAddress;// 网址

	// 关联字段
	private String conntNums;// 与user_info表的主键关联
	/**
	 * 供应商
	 */
	private String faxes;// 传真
	private String userBank;// 用户行       发票信息表
	private String bankAcctnum;// 账号   发票信息表
	private String tfn;// 税号  发票信息表
	
	
	
	public CustomerDisplay(String userNo, String userName, String salesMan,
			String priceLevel, Integer lineOfCredit, String primaryContact,
			String personPosition, String userEmail, String remarks,
			String userStatus, String address, String invoiceAddress,
			String city, String postCode, Long telephone, String status,
			String netAddress, String conntNums, String faxes, String userBank,
			String bankAcctnum, String tfn) {
		super();
		this.userNo = userNo;
		this.userName = userName;
		this.salesMan = salesMan;
		PriceLevel = priceLevel;
		this.lineOfCredit = lineOfCredit;
		this.primaryContact = primaryContact;
		this.personPosition = personPosition;
		this.userEmail = userEmail;
		this.remarks = remarks;
		this.userStatus = userStatus;
		this.address = address;
		this.invoiceAddress = invoiceAddress;
		this.city = city;
		this.postCode = postCode;
		this.telephone = telephone;
		this.status = status;
		this.netAddress = netAddress;
		this.conntNums = conntNums;
		this.faxes = faxes;
		this.userBank = userBank;
		this.bankAcctnum = bankAcctnum;
		this.tfn = tfn;
	}

	public CustomerDisplay() {
		//super();
	}

	public String getUserNo() {
		return userNo;
	}

	public void setUserNo(String userNo) {
		this.userNo = userNo;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getSalesMan() {
		return salesMan;
	}

	public void setSalesMan(String salesMan) {
		this.salesMan = salesMan;
	}

	public String getPriceLevel() {
		return PriceLevel;
	}

	public void setPriceLevel(String priceLevel) {
		PriceLevel = priceLevel;
	}

	public Integer getLineOfCredit() {
		return lineOfCredit;
	}

	public void setLineOfCredit(Integer lineOfCredit) {
		this.lineOfCredit = lineOfCredit;
	}

	public String getPrimaryContact() {
		return primaryContact;
	}

	public void setPrimaryContact(String primaryContact) {
		this.primaryContact = primaryContact;
	}

	public String getPersonPosition() {
		return personPosition;
	}

	public void setPersonPosition(String personPosition) {
		this.personPosition = personPosition;
	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getUserStatus() {
		return userStatus;
	}

	public void setUserStatus(String userStatus) {
		this.userStatus = userStatus;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getInvoiceAddress() {
		return invoiceAddress;
	}

	public void setInvoiceAddress(String invoiceAddress) {
		this.invoiceAddress = invoiceAddress;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getPostCode() {
		return postCode;
	}

	public void setPostCode(String postCode) {
		this.postCode = postCode;
	}

	public Long getTelephone() {
		return telephone;
	}

	public void setTelephone(Long telephone) {
		this.telephone = telephone;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getNetAddress() {
		return netAddress;
	}

	public void setNetAddress(String netAddress) {
		this.netAddress = netAddress;
	}

	public String getConntNums() {
		return conntNums;
	}

	public void setConntNums(String conntNums) {
		this.conntNums = conntNums;
	}

	public String getFaxes() {
		return faxes;
	}

	public void setFaxes(String faxes) {
		this.faxes = faxes;
	}

	public String getUserBank() {
		return userBank;
	}

	public void setUserBank(String userBank) {
		this.userBank = userBank;
	}

	public String getBankAcctnum() {
		return bankAcctnum;
	}

	public void setBankAcctnum(String bankAcctnum) {
		this.bankAcctnum = bankAcctnum;
	}

	public String getTfn() {
		return tfn;
	}

	public void setTfn(String tfn) {
		this.tfn = tfn;
	}

	@Override
	public String toString() {
		return "CustomerDisplay [userNo=" + userNo + ", userName=" + userName
				+ ", salesMan=" + salesMan + ", PriceLevel=" + PriceLevel
				+ ", lineOfCredit=" + lineOfCredit + ", primaryContact="
				+ primaryContact + ", personPosition=" + personPosition
				+ ", userEmail=" + userEmail + ", remarks=" + remarks
				+ ", userStatus=" + userStatus + ", address=" + address
				+ ", invoiceAddress=" + invoiceAddress + ", city=" + city
				+ ", postCode=" + postCode + ", telephone=" + telephone
				+ ", status=" + status + ", netAddress=" + netAddress
				+ ", conntNums=" + conntNums + ", faxes=" + faxes
				+ ", userBank=" + userBank + ", bankAcctnum=" + bankAcctnum
				+ ", tfn=" + tfn + "]";
	}



}
