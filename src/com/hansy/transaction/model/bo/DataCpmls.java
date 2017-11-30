package com.hansy.transaction.model.bo;

import java.io.Serializable;
/**
 * 发布商品-查询筛选条件表
 * @author fj
 *
 */
public class DataCpmls implements Serializable {
	private String brand;	//产品品牌
	private String name;	//产品名称
	private String gg;	//产品规格
	private String code;	//产品代码
	private String pyname;	//产品规格详情
	public String getBrand() {
		return brand;
	}
	public void setBrand(String brand) {
		this.brand = brand;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getGg() {
		return gg;
	}
	public void setGg(String gg) {
		this.gg = gg;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getPyname() {
		return pyname;
	}
	public void setPyname(String pyname) {
		this.pyname = pyname;
	}
	
}
