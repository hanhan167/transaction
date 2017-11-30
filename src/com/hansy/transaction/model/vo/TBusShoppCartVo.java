
package com.hansy.transaction.model.vo;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 购物车vo
 * TODO javadoc for com.hansy.transaction.model.vo.TBusShoppCart
 * @Copyright: 2017成都环赛信息技术有限公司 
 * @author: cj
 * @since: 2017年3月9日
 */
public class TBusShoppCartVo implements Serializable {

	/**
	 * Comment for <code>serialVersionUID</code>
	 */
	private static final long serialVersionUID = 2406400785519599039L;
	private String tableKey;			//主键
	private String custNo;				//客户编号
	private String custName;			//客户名称
	private String goodsNo;				//商品编号
	private String goodsName;			//商品名称
	private String supplyNo;			//供方编号
	private String supplyName;			//供方名称
	private String buyType;				//购买类型
	private Integer buyNum;				//购买数量
	private Double goodsPrice;		//商品价格
	private Integer defaultPayDt;		//默认交期
	private String channel;				//新增渠道
	private Date insertDate;			//新增时间
	private Date updateDate;			//更新时间
	
	public String getTableKey() {
		return tableKey;
	}
	
	public void setTableKey(String tableKey) {
		this.tableKey = tableKey;
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
	
	public String getSupplyNo() {
		return supplyNo;
	}
	
	public void setSupplyNo(String supplyNo) {
		this.supplyNo = supplyNo;
	}
	
	public String getSupplyName() {
		return supplyName;
	}
	
	public void setSupplyName(String supplyName) {
		this.supplyName = supplyName;
	}
	
	public String getBuyType() {
		return buyType;
	}
	
	public void setBuyType(String buyType) {
		this.buyType = buyType;
	}
	
	public Integer getBuyNum() {
		return buyNum;
	}
	
	public void setBuyNum(Integer buyNum) {
		this.buyNum = buyNum;
	}
	
	public Double getGoodsPrice() {
		return goodsPrice;
	}
	
	public void setGoodsPrice(Double goodsPrice) {
		this.goodsPrice = goodsPrice;
	}
	
	public Integer getDefaultPayDt() {
		return defaultPayDt;
	}
	
	public void setDefaultPayDt(Integer defaultPayDt) {
		this.defaultPayDt = defaultPayDt;
	}
	
	public String getChannel() {
		return channel;
	}
	
	public void setChannel(String channel) {
		this.channel = channel;
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

	@Override
	public String toString() {
		return "TBusShoppCart [tableKey=" + tableKey + ", custNo=" + custNo + ", custName=" + custName + ", goodsNo=" + goodsNo + ", goodsName=" + goodsName + ", supplyNo="
				+ supplyNo + ", supplyName=" + supplyName + ", buyType=" + buyType + ", buyNum=" + buyNum + ", goodsPrice=" + goodsPrice + ", defaultPayDt=" + defaultPayDt
				+ ", channel=" + channel + ", insertDate=" + insertDate + ", updateDate=" + updateDate + "]";
	}
}

