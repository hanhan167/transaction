
package com.hansy.transaction.model.bo;

public class DataCatalogManage {
	private String id;
	private String busCode;
	private String chName;
	private String enCode;
	private String Grade;
	private String onLevel;
	public String getOnLevel() {
		return onLevel;
	}
	public void setOnLevel(String onLevel) {
		this.onLevel = onLevel;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getBusCode() {
		return busCode;
	}
	public void setBusCode(String busCode) {
		this.busCode = busCode;
	}
	public String getChName() {
		return chName;
	}
	public void setChName(String chName) {
		this.chName = chName;
	}
	public String getEnCode() {
		return enCode;
	}
	public void setEnCode(String enCode) {
		this.enCode = enCode;
	}
	public String getGrade() {
		return Grade;
	}
	public void setGrade(String grade) {
		Grade = grade;
	}
	@Override
	public String toString() {
		return "DataCatalogManage [id=" + id + ", busCode=" + busCode + ", chName=" + chName + ", enCode=" + enCode
				+ ", Grade=" + Grade + "]";
	}
	
}

