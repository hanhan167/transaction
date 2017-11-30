
package com.hansy.transaction.model.vo;

import java.io.Serializable;
import java.util.Date;

/**
 * 订单状态跟踪实体
 * TODO javadoc for com.hansy.transaction.model.vo.TBusOrderDetl
 * @Copyright: 2017成都环赛信息技术有限公司 
 * @author: cj
 * @since: 2017年3月9日
 */
public class TBusOrderDetlVo implements Serializable {

	/**
	 * Comment for <code>serialVersionUID</code>
	 */
	private static final long serialVersionUID = -4193305075117559282L;
	private String tableKey;		//主键
	private String orderNo;			//主订单编号
	private String orderType;		//订单类型
	private String userNo;			//用户编号
	private String goodsNo;			//商品编号
	private String status;		//状态
	private String remark;			//描述
	private Date insertDate;		//新增时间
	private Date updateDate;		//修改时间
	
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
	
	public String getUserNo() {
		return userNo;
	}
	
	public void setUserNo(String userNo) {
		this.userNo = userNo;
	}
	
	public String getGoodsNo() {
		return goodsNo;
	}
	
	public void setGoodsNo(String goodsNo) {
		this.goodsNo = goodsNo;
	}
	
	public String getStatus() {
		return status;
	}
	
	public void setStatus(String status) {
		this.status = status;
	}
	
	public String getRemark() {
		return remark;
	}
	
	public void setRemark(String remark) {
		this.remark = remark;
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

