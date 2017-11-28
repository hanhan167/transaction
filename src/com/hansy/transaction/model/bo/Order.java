
package com.hansy.transaction.model.bo;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import com.hansy.transaction.model.vo.TBusOrderDetlVo;

/**
 * 订单
 * TODO javadoc for com.hansy.transaction.model.bo.Order
 * @Copyright: 2017成都环赛信息技术有限公司 
 * @author: cj
 * @since: 2017年3月10日
 */
public class Order implements Serializable {

	/**
	 * Comment for <code>serialVersionUID</code>
	 */
	private static final long serialVersionUID = 7249075466445319802L;
	private String orderNo;				//订单编号
	private String custName;			//客户名称
	private String custPhone;			//客户电话
	private Double goodsPrice;		//商品价格
	private String goodsName;			//商品名称
	private String orderType;			//订单类型
	private String	defaultPayDt;		//预期收货时间
	private String wishPayDt;			//期望到货时间
	private Date insertDate;			//提交时间
	private Integer goodsCount;			//商品数量
	private String address;				//收货详细地址
	private String addresseeName;		//收货人姓名
	private String addresseePhone;		//收货人联系方式
	private String applyName;			//供应商名称
	private String applyPhone;			//供应商电话号码
	private String custNo;
	private String orderStatus;			//订单状态
	private Double goodsDiscount;	//商品折扣
	private String goodsCode;			//商品代码
	private String goodsNo;
	private String updateCustType;//操作人(用来区分是谁操作的订单 )
	private List<TBusOrderDetlVo> list;	//订单跟踪信息
	private String orderStatusSel; 		//卖家是否删除
	private String tableKey;
	private String splitStatus;//拆分状态
	private String supperName;
	private String supperPhone;
	private String supplyNo;
	private String par;
	private String goodsMoney;
	private String brand;
	//更改部分
	private String lgtNums;	//物流号
	private String code;
	
	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	public String getGoodsMoney() {
		return goodsMoney;
	}

	public void setGoodsMoney(String goodsMoney) {
		this.goodsMoney = goodsMoney;
	}

	public String getPar() {
		return par;
	}

	public void setPar(String par) {
		this.par = par;
	}

	public String getSupperName() {
		return supperName;
	}

	public void setSupperName(String supperName) {
		this.supperName = supperName;
	}

	public String getSupperPhone() {
		return supperPhone;
	}

	public void setSupperPhone(String supperPhone) {
		this.supperPhone = supperPhone;
	}

	public String getSupplyNo() {
		return supplyNo;
	}

	public void setSupplyNo(String supplyNo) {
		this.supplyNo = supplyNo;
	}

	public String getSplitStatus() {
		return splitStatus;
	}

	public void setSplitStatus(String splitStatus) {
		this.splitStatus = splitStatus;
	}

	public String getTableKey() {
		return tableKey;
	}

	public void setTableKey(String tableKey) {
		this.tableKey = tableKey;
	}

	public String getOrderStatusSel() {
		return orderStatusSel;
	}

	public void setOrderStatusSel(String orderStatusSel) {
		this.orderStatusSel = orderStatusSel;
	}

	public String getOrderNo() {
		return orderNo;
	}
	
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	
	public String getCustName() {
		return custName;
	}
	
	public void setCustName(String custName) {
		this.custName = custName;
	}
	
	public String getCustPhone() {
		return custPhone;
	}
	
	public void setCustPhone(String custPhone) {
		this.custPhone = custPhone;
	}
	
	public Double getGoodsPrice() {
		return goodsPrice;
	}
	
	public void setGoodsPrice(Double goodsPrice) {
		this.goodsPrice = goodsPrice;
	}
	
	public String getGoodsName() {
		return goodsName;
	}
	
	public void setGoodsName(String goodsName) {
		this.goodsName = goodsName;
	}
	
	public String getOrderType() {
		return orderType;
	}
	
	public void setOrderType(String orderType) {
		this.orderType = orderType;
	}
	
	public String getDefaultPayDt() {
		return defaultPayDt;
	}
	
	public void setDefaultPayDt(String defaultPayDt) {
		this.defaultPayDt = defaultPayDt;
	}
	
	public String getWishPayDt() {
		return wishPayDt;
	}
	
	public void setWishPayDt(String wishPayDt) {
		this.wishPayDt = wishPayDt;
	}
	
	public Date getInsertDate() {
		return insertDate;
	}
	
	public void setInsertDate(Date insertDate) {
		this.insertDate = insertDate;
	}
	
	public Integer getGoodsCount() {
		return goodsCount;
	}
	
	public void setGoodsCount(Integer goodsCount) {
		this.goodsCount = goodsCount;
	}
	
	public String getAddress() {
		return address;
	}
	
	public void setAddress(String address) {
		this.address = address;
	}
	
	public String getAddresseeName() {
		return addresseeName;
	}
	
	public void setAddresseeName(String addresseeName) {
		this.addresseeName = addresseeName;
	}
	
	public String getAddresseePhone() {
		return addresseePhone;
	}
	
	public void setAddresseePhone(String addresseePhone) {
		this.addresseePhone = addresseePhone;
	}
	
	public String getApplyName() {
		return applyName;
	}
	
	public void setApplyName(String applyName) {
		this.applyName = applyName;
	}
	
	public String getApplyPhone() {
		return applyPhone;
	}
	
	public void setApplyPhone(String applyPhone) {
		this.applyPhone = applyPhone;
	}
	
	public String getOrderStatus() {
		return orderStatus;
	}
	
	public void setOrderStatus(String orderStatus) {
		this.orderStatus = orderStatus;
	}
	
	public Double getGoodsDiscount() {
		return goodsDiscount;
	}
	
	public void setGoodsDiscount(Double goodsDiscount) {
		this.goodsDiscount = goodsDiscount;
	}
	
	public String getGoodsCode() {
		return goodsCode;
	}
	
	public void setGoodsCode(String goodsCode) {
		this.goodsCode = goodsCode;
	}
	
	public List<TBusOrderDetlVo> getList() {
		return list;
	}
	
	public void setList(List<TBusOrderDetlVo> list) {
		this.list = list;
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

	public String getUpdateCustType() {
		return updateCustType;
	}

	public void setUpdateCustType(String updateCustType) {
		this.updateCustType = updateCustType;
	}
	
	public String getLgtNums() {
		return lgtNums;
	}

	public void setLgtNums(String lgtNums) {
		this.lgtNums = lgtNums;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
	
	
	
}

