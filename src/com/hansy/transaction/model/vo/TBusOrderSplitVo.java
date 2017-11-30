
package com.hansy.transaction.model.vo;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 订单拆分信息vo
 * TODO javadoc for com.hansy.transaction.model.vo.TBusOrderSplit
 * @Copyright: 2017成都环赛信息技术有限公司 
 * @author: cj
 * @since: 2017年3月9日
 */
public class TBusOrderSplitVo implements Serializable {

	/**
	 * Comment for <code>serialVersionUID</code>
	 */
	private static final long serialVersionUID = -3217657071133767552L;
	private String splitNo;			//拆分编号
	private String orderNo;			//订单编号
	private String orderType;		//订单类型
	private String custNo;			//客户编号
	private String goodsNo;			//商品编号
	private String applyNo;			//供应商编号
	private Double goodsPrice;	//商品价格
	private String address;			//收货地址
	private Integer defaultPayDt;	//默认交期
	private Integer wishPayDt;		//期望交期
	private Double goodsDiscount;//商品折扣
	private String orderStatus;		//订单状态
	private Date insertDate;		//新增时间
	private Date updateDate;		//修改时间
	private String supplyNo;			//供应商编号
	private Integer goodsCount;			//商品数量
	private String tableKey;		//主键
	private String splitStatus;			//是否拆分
	private String status;				//状态
	private String orderStatusSel;  	//卖家删除
	private String updateCustsType;		//操作人类型
	private String Identifying;//标识
	
	public String getIdentifying() {
		return Identifying;
	}
	public void setIdentifying(String identifying) {
		Identifying = identifying;
	}
	public String getSplitNo() {
		return splitNo;
	}
	public void setSplitNo(String splitNo) {
		this.splitNo = splitNo;
	}
	public String getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	public String getOrderType() {
		return orderType;
	}
	public void setOrderType(String orderType) {
		this.orderType = orderType;
	}
	public String getCustNo() {
		return custNo;
	}
	public void setCustNo(String custNo) {
		this.custNo = custNo;
	}
	public String getGoodsNo() {
		return goodsNo;
	}
	public void setGoodsNo(String goodsNo) {
		this.goodsNo = goodsNo;
	}
	public String getApplyNo() {
		return applyNo;
	}
	public void setApplyNo(String applyNo) {
		this.applyNo = applyNo;
	}
	public Double getGoodsPrice() {
		return goodsPrice;
	}
	public void setGoodsPrice(Double goodsPrice) {
		this.goodsPrice = goodsPrice;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public Integer getDefaultPayDt() {
		return defaultPayDt;
	}
	public void setDefaultPayDt(Integer defaultPayDt) {
		this.defaultPayDt = defaultPayDt;
	}
	public Integer getWishPayDt() {
		return wishPayDt;
	}
	public void setWishPayDt(Integer wishPayDt) {
		this.wishPayDt = wishPayDt;
	}
	public Double getGoodsDiscount() {
		return goodsDiscount;
	}
	public void setGoodsDiscount(Double goodsDiscount) {
		this.goodsDiscount = goodsDiscount;
	}
	public String getOrderStatus() {
		return orderStatus;
	}
	public void setOrderStatus(String orderStatus) {
		this.orderStatus = orderStatus;
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
	public String getSupplyNo() {
		return supplyNo;
	}
	public void setSupplyNo(String supplyNo) {
		this.supplyNo = supplyNo;
	}
	
	public Integer getGoodsCount() {
		return goodsCount;
	}
	public void setGoodsCount(Integer goodsCount) {
		this.goodsCount = goodsCount;
	}
	public String getTableKey() {
		return tableKey;
	}
	public void setTableKey(String tableKey) {
		this.tableKey = tableKey;
	}
	public String getSplitStatus() {
		return splitStatus;
	}
	public void setSplitStatus(String splitStatus) {
		this.splitStatus = splitStatus;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getOrderStatusSel() {
		return orderStatusSel;
	}
	public void setOrderStatusSel(String orderStatusSel) {
		this.orderStatusSel = orderStatusSel;
	}
	public String getUpdateCustsType() {
		return updateCustsType;
	}
	public void setUpdateCustsType(String updateCustsType) {
		this.updateCustsType = updateCustsType;
	}
	@Override
	public String toString() {
		return "TBusOrderSplitVo [splitNo=" + splitNo + ", orderNo=" + orderNo + ", orderType=" + orderType
				+ ", custNo=" + custNo + ", goodsNo=" + goodsNo + ", applyNo=" + applyNo + ", goodsPrice=" + goodsPrice
				+ ", address=" + address + ", defaultPayDt=" + defaultPayDt + ", wishPayDt=" + wishPayDt
				+ ", goodsDiscount=" + goodsDiscount + ", orderStatus=" + orderStatus + ", insertDate=" + insertDate
				+ ", updateDate=" + updateDate + ", supplyNo=" + supplyNo + ", goodsCount=" + goodsCount + ", tableKey="
				+ tableKey + ", splitStatus=" + splitStatus + ", status=" + status + ", orderStatusSel="
				+ orderStatusSel + ", updateCustsType=" + updateCustsType + "]";
	}
	
}

