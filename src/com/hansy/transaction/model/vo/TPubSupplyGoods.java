
package com.hansy.transaction.model.vo;

import java.io.Serializable;
/**
 * 商品供方关系
 * TODO javadoc for com.hansy.transaction.model.vo.TPubSupplyGoods
 * @Copyright: 2017成都环赛信息技术有限公司 
 * @author: cj
 * @since: 2017年3月17日
 */
import java.util.Date;
public class TPubSupplyGoods implements Serializable {
	/**
	 * Comment for <code>serialVersionUID</code>
	 */
	private static final long serialVersionUID = -1271881459972632797L;
	private String tableKey;			//主键
	private String goodsNo;				//商品独立代码
	private String goodsName;			//商品规格名称
	private String custNo;				//供方id
	private String upDate;				//上架时间
	private String downDate;			//下架时间
	private Integer defaultPayDt;		//默认交期
	private Date insertDate;			//新增时间
	private Date updateDate;			//更新时间
	private String status;				//是否上架
	private String goodsPrice;			//商品价格
	private Integer minkc;				//最小起订量
	private Integer orderIncrement;		//订购递增量
	private String goodsCode;			//产品类代码
	
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

	public String getGoodsCode() {
		return goodsCode;
	}

	public void setGoodsCode(String goodsCode) {
		this.goodsCode = goodsCode;
	}

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
	
	public String getGoodsName() {
		return goodsName;
	}
	
	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}
	
	public String getCustNo() {
		return custNo;
	}
	
	public void setCustNo(String custNo) {
		this.custNo = custNo;
	}
	
	public String getUpDate() {
		return upDate;
	}
	
	public void setUpDate(String upDate) {
		this.upDate = upDate;
	}
	
	public String getDownDate() {
		return downDate;
	}
	
	public void setDownDate(String downDate) {
		this.downDate = downDate;
	}
	
	public Integer getDefaultPayDt() {
		return defaultPayDt;
	}
	
	public void setDefaultPayDt(Integer defaultPayDt) {
		this.defaultPayDt = defaultPayDt;
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
	
	public String getStatus() {
		return status;
	}
	
	public void setStatus(String status) {
		this.status = status;
	}
	
	public String getGoodsPrice() {
		return goodsPrice;
	}
	
	public void setGoodsPrice(String goodsPrice) {
		this.goodsPrice = goodsPrice;
	}
}

