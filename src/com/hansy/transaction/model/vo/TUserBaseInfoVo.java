package com.hansy.transaction.model.vo;

import java.util.Date;

public class TUserBaseInfoVo {

	private String userNo;//			varchar2(32)	n			�û����
	private String userLoginName;//	varchar2(32)	y			
	private String userName;//		varchar2(100)	y			�û����
	private String userType;//		varchar2(8)	y			�û�����
	private String userRole;//		varchar2(8)	y			
	private String userPwd;//		varchar2(32)	y			�û�����
	private String custNo;//			varchar2(32)	y			
	private String custName;//		varchar2(100)	y			
	private String userAlias;//		varchar2(100)	y			�ǳ�
	private String userPhone;//		number	y			�ֻ����
	private String userEmail;//		varchar2(100)	y			����
	private String superUserNo;//		varchar2(32)	y			�Ƽ���
	private Date insertDate;//		date	y			ע��ʱ��
	private Date updateDate;//		date	y			����ʱ��
	
	public String getUserNo() {
		return userNo;
	}
	
	public void setUserNo(String userNo) {
		this.userNo = userNo;
	}
	
	public String getUserLoginName() {
		return userLoginName;
	}
	
	public void setUserLoginName(String userLoginName) {
		this.userLoginName = userLoginName;
	}
	
	public String getUserName() {
		return userName;
	}
	
	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	public String getUserType() {
		return userType;
	}
	
	public void setUserType(String userType) {
		this.userType = userType;
	}
	
	public String getUserRole() {
		return userRole;
	}
	
	public void setUserRole(String userRole) {
		this.userRole = userRole;
	}
	
	public String getUserPwd() {
		return userPwd;
	}
	
	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}
	
	public String getCustNo() {
		return custNo;
	}
	
	public void setCustNo(String custNo) {
		this.custNo = custNo;
	}
	
	public String getCustName() {
		return custName;
	}
	
	public void setCustName(String custName) {
		this.custName = custName;
	}
	
	public String getUserAlias() {
		return userAlias;
	}
	
	public void setUserAlias(String userAlias) {
		this.userAlias = userAlias;
	}
	
	public String getUserPhone() {
		return userPhone;
	}
	
	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}
	
	public String getUserEmail() {
		return userEmail;
	}
	
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	
	public String getSuperUserNo() {
		return superUserNo;
	}
	
	public void setSuperUserNo(String superUserNo) {
		this.superUserNo = superUserNo;
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
