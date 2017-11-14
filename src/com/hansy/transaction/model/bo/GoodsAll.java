
package com.hansy.transaction.model.bo;

import java.io.Serializable;
import java.util.List;

import com.hansy.transaction.model.vo.TPubGoodsDiscount;


public class GoodsAll implements Serializable {

	/**
	 * Comment for <code>serialVersionUID</code>
	 */
	private static final long serialVersionUID = 171056782424323754L;
	private String id = "";
	private String tableKey = "";				//主键
	private String goodsName = "";				//商品名
	private String guige = "";					//商品规格
	private String goodsPrice = "";				//商品价格
	private String goodsCode = "";				//商品类代码
	private String goodsStatus = "";				//是否启用禁用
	private String cpdm = "";					//商品独立编号
	private String kc = "";						//库存
	private Integer minkc = 0;					//最小起订量
	private Integer orderIncrement = 0;			//订购递增量
	private Integer defaultPayDt = 0;			//默认交期
	private List<GoodsDiscount> list;		//商品折扣 	
	private String zh ="";
	private List<GoodsDiscount>list2;
	
	

	public List<GoodsDiscount> getList2() {
		return list2;
	}

	public void setList2(List<GoodsDiscount> list2) {
		this.list2 = list2;
	}

	public String getZh() {
		return zh;
	}

	public void setZh(String zh) {
		this.zh = zh;
	}

	public String getTableKey() {
		return tableKey;
	}
	
	public void setTableKey(String tableKey) {
		this.tableKey = tableKey;
	}
	
	public String getGoodsName() {
		return goodsName;
	}
	
	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}
	
	public String getGuige() {
		return guige;
	}
	
	public void setGuige(String guige) {
		this.guige = guige;
	}
	
	public String getGoodsPrice() {
		return goodsPrice;
	}
	
	public void setGoodsPrice(String goodsPrice) {
		this.goodsPrice = goodsPrice;
	}
	
	public String getGoodsCode() {
		return goodsCode;
	}
	
	public void setGoodsCode(String goodsCode) {
		this.goodsCode = goodsCode;
	}
	
	public String getGoodsStatus() {
		return goodsStatus;
	}
	
	public void setGoodsStatus(String goodsStatus) {
		this.goodsStatus = goodsStatus;
	}
	
	public String getCpdm() {
		return cpdm;
	}
	
	public void setCpdm(String cpdm) {
		this.cpdm = cpdm;
	}
	
	public String getKc() {
		return kc;
	}
	
	public void setKc(String kc) {
		this.kc = kc;
	}
	
	public Integer getMinkc() {
		return minkc;
	}
	
	public void setMinkc(Integer minkc) {
		this.minkc = minkc;
	}
	
	public Integer getOrderIncrement() {
		return orderIncrement;
	}
	
	public void setOrderIncrement(Integer orderIncrement) {
		this.orderIncrement = orderIncrement;
	}
	
	public Integer getDefaultPayDt() {
		return defaultPayDt;
	}
	
	public void setDefaultPayDt(Integer defaultPayDt) {
		this.defaultPayDt = defaultPayDt;
	}
	
	public List<GoodsDiscount> getList() {
		return list;
	}
	
	public void setList(List<GoodsDiscount> list) {
		this.list = list;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	
}

