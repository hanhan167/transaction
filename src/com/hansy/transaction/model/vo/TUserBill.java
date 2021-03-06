
package com.hansy.transaction.model.vo;

import java.util.Date;

/**
 * 客户发票信息表
 * @author Administrator
 *
 */
public class TUserBill {
	private String custNo;//商户编号
	private String billType;//发票类型:01普通发票,02增值税发票
	private String billTitle;//发票抬头,001个人，002公司
	private String billReceipt;//纳税人识别号
	private String billContent;//发票内容
	private String billReceivePhone;//收票人手机号
	private String billReceiveAddress;//收票人邮箱
	private String billStatus;//发票状态
	private Date insertDate;//新增时间
	private	Date updateDate;//修改时间
	private Double billMoney;//发票总金额
	private String	companyName;//单位名称
	private String	registerAddress;//单位注册地址
	private String	registerPhone;//单位注册手机号码
	private String	openBand;//开户行
	private String  bandCard;//银行卡
	private String	billReceiveName;//收票人姓名
	private String billReceiveMail;//收票人邮箱
	private Date startTime;
	private Date endTime;
	private String billNatrue;//发票状态 "0":"电子发票","1":"纸质发票"
	private String billProvince;//省
	private String billCity;//市
	private String billArea;//区
	
	public String getCustNo() {
		return custNo;
	}
	public void setCustNo(String custNo) {
		this.custNo = custNo;
	}
	public String getBillType() {
		return billType;
	}
	public void setBillType(String billType) {
		this.billType = billType;
	}
	public String getBillTitle() {
		return billTitle;
	}
	public void setBillTitle(String billTitle) {
		this.billTitle = billTitle;
	}
	public String getBillReceipt() {
		return billReceipt;
	}
	public void setBillReceipt(String billReceipt) {
		this.billReceipt = billReceipt;
	}
	public String getBillContent() {
		return billContent;
	}
	public void setBillContent(String billContent) {
		this.billContent = billContent;
	}
	public String getBillReceivePhone() {
		return billReceivePhone;
	}
	public void setBillReceivePhone(String billReceivePhone) {
		this.billReceivePhone = billReceivePhone;
	}
	public String getBillReceiveAddress() {
		return billReceiveAddress;
	}
	public void setBillReceiveAddress(String billReceiveAddress) {
		this.billReceiveAddress = billReceiveAddress;
	}
	public String getBillStatus() {
		return billStatus;
	}
	public void setBillStatus(String billStatus) {
		this.billStatus = billStatus;
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
	public Double getBillMoney() {
		return billMoney;
	}
	public void setBillMoney(Double billMoney) {
		this.billMoney = billMoney;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getRegisterAddress() {
		return registerAddress;
	}
	public void setRegisterAddress(String registerAddress) {
		this.registerAddress = registerAddress;
	}
	public String getRegisterPhone() {
		return registerPhone;
	}
	public void setRegisterPhone(String registerPhone) {
		this.registerPhone = registerPhone;
	}
	public String getOpenBand() {
		return openBand;
	}
	public void setOpenBand(String openBand) {
		this.openBand = openBand;
	}
	public String getBandCard() {
		return bandCard;
	}
	public void setBandCard(String bandCard) {
		this.bandCard = bandCard;
	}
	public String getBillReceiveName() {
		return billReceiveName;
	}
	public void setBillReceiveName(String billReceiveName) {
		this.billReceiveName = billReceiveName;
	}
	public String getBillReceiveMail() {
		return billReceiveMail;
	}
	public void setBillReceiveMail(String billReceiveMail) {
		this.billReceiveMail = billReceiveMail;
	}
	public Date getStartTime() {
		return startTime;
	}
	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}
	public Date getEndTime() {
		return endTime;
	}
	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
	
	public String getBillNatrue() {
		return billNatrue;
	}
	public void setBillNatrue(String billNatrue) {
		this.billNatrue = billNatrue;
	}
	
	public String getBillProvince() {
		return billProvince;
	}
	public void setBillProvince(String billProvince) {
		this.billProvince = billProvince;
	}
	public String getBillCity() {
		return billCity;
	}
	public void setBillCity(String billCity) {
		this.billCity = billCity;
	}
	public String getBillArea() {
		return billArea;
	}
	public void setBillArea(String billArea) {
		this.billArea = billArea;
	}
	
	@Override
	public String toString() {
		return "TUserBill [custNo=" + custNo + ", billType=" + billType
				+ ", billTitle=" + billTitle + ", billReceipt=" + billReceipt
				+ ", billContent=" + billContent + ", billReceivePhone="
				+ billReceivePhone + ", billReceiveAddress="
				+ billReceiveAddress + ", billStatus=" + billStatus
				+ ", insertDate=" + insertDate + ", updateDate=" + updateDate
				+ ", billMoney=" + billMoney + ", companyName=" + companyName
				+ ", registerAddress=" + registerAddress + ", registerPhone="
				+ registerPhone + ", openBand=" + openBand + ", bandCard="
				+ bandCard + ", billReceiveName=" + billReceiveName
				+ ", billReceiveMail=" + billReceiveMail + ", startTime="
				+ startTime + ", endTime=" + endTime + ", billNatrue="
				+ billNatrue + ", billProvince=" + billProvince + ", billCity="
				+ billCity + ", billArea=" + billArea + "]";
	}

	
	
	
}

