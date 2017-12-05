
package com.hansy.transaction.model.vo;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 订单信息vo
 * TODO javadoc for com.hansy.transaction.model.vo.TBusOrder
 * @Copyright: 2017成都环赛信息技术有限公司 
 * @author: cj
 * @since: 2017年3月9日
 */
public class TBusOrderVo implements Serializable {

	/**
	 * Comment for <code>serialVersionUID</code>
	 */
	private static final long serialVersionUID = -7059447000911124092L;
	private String orderNo;				//订单编号
	private String orderType;			//订单类型
	private String splitStatus;			//是否拆分
	private String custNo;				//客户编号
	private String goodsNo;				//商品编号
	private Double goodsPrice;		//商品价格
	private Double goodsDiscount;	//商品折扣
	private String address;				//收货地址
	private Integer defaultPayDt;		//默认交期(天)
	private Integer wishPayDt;			//期望交期(天)
	private String orderStatus;			//订单状态
	private Date insertDate;			//新增时间
	private Date updateDate;			//修改时间
	private String supplyNo;			//供应商编号
	private Integer goodsCount;			//商品数量
	private String status;				//状态
	private String tableKey;
	private String orderStatusSel;  	//卖家删除
	private String updateCustsType;		//操作人类型
	private String identifying;			//标识
	private String upOrderNo;			//上级订单编号
	private String updateCustType;		//操作人类型
	private Double goodsMoney;//商品总价格
	private String remark;
	private String lgtNums;	//物流号
	private String invoicStatus;//开票状态  000:未开票  001:已开票
	
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Double getGoodsMoney() {
		return goodsMoney;
	}

	public void setGoodsMoney(Double goodsMoney) {
		this.goodsMoney = goodsMoney;
	}

	public String getUpdateCustType() {
		return updateCustType;
	}

	public void setUpdateCustType(String updateCustType) {
		this.updateCustType = updateCustType;
	}

	public String getUpOrderNo() {
		return upOrderNo;
	}

	public void setUpOrderNo(String upOrderNo) {
		this.upOrderNo = upOrderNo;
	}

	public String getIdentifying() {
		return identifying;
	}

	public void setIdentifying(String identifying) {
		this.identifying = identifying;
	}

	public String getUpdateCustsType() {
		return updateCustsType;
	}

	public void setUpdateCustsType(String updateCustsType) {
		this.updateCustsType = updateCustsType;
	}

	public String getOrderStatusSel() {
		return orderStatusSel;
	}

	public void setOrderStatusSel(String orderStatusSel) {
		this.orderStatusSel = orderStatusSel;
	}

	public String getTableKey() {
		return tableKey;
	}

	public void setTableKey(String tableKey) {
		this.tableKey = tableKey;
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
	
	public String getSplitStatus() {
		return splitStatus;
	}
	
	public void setSplitStatus(String splitStatus) {
		this.splitStatus = splitStatus;
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
	
	public Double getGoodsPrice() {
		return goodsPrice;
	}
	
	public void setGoodsPrice(Double goodsPrice) {
		this.goodsPrice = goodsPrice;
	}
	
	public Double getGoodsDiscount() {
		return goodsDiscount;
	}
	
	public void setGoodsDiscount(Double goodsDiscount) {
		this.goodsDiscount = goodsDiscount;
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
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	public String getLgtNums() {
		return lgtNums;
	}

	public void setLgtNums(String lgtNums) {
		this.lgtNums = lgtNums;
	}

	public String getInvoicStatus() {
		return invoicStatus;
	}

	public void setInvoicStatus(String invoicStatus) {
		this.invoicStatus = invoicStatus;
	}

	@Override
	public String toString() {
		return "TBusOrderVo [orderNo=" + orderNo + ", orderType=" + orderType
				+ ", splitStatus=" + splitStatus + ", custNo=" + custNo
				+ ", goodsNo=" + goodsNo + ", goodsPrice=" + goodsPrice
				+ ", goodsDiscount=" + goodsDiscount + ", address=" + address
				+ ", defaultPayDt=" + defaultPayDt + ", wishPayDt=" + wishPayDt
				+ ", orderStatus=" + orderStatus + ", insertDate=" + insertDate
				+ ", updateDate=" + updateDate + ", supplyNo=" + supplyNo
				+ ", goodsCount=" + goodsCount + ", status=" + status
				+ ", tableKey=" + tableKey + ", orderStatusSel="
				+ orderStatusSel + ", updateCustsType=" + updateCustsType
				+ ", identifying=" + identifying + ", upOrderNo=" + upOrderNo
				+ ", updateCustType=" + updateCustType + ", goodsMoney="
				+ goodsMoney + ", remark=" + remark + ", lgtNums=" + lgtNums
				+ ", invoicStatus=" + invoicStatus + "]";
	}
	
	
}

