
package com.hansy.transaction.common.constants;
public class OrderConstants {
	public static final String orderStatusComplete="090005";		//订单状态已完成
	public static final String orderStatusNoneConfirmed="090001";	//卖方待确认
	public static final String orderStatusReadyShip="090002";		//卖方待发货
	public static final String orderStatusNonePayment="090003";		//买方待付款
	public static final String orderStatusReadCollect="090004";		//买方待收货
	public static final String orderTypeTrial="091001";				//订单类型试刀
	public static final String orderTypeBuy="091002";				//订单类型购买
	public static final String orderTypeNor="1";						//订单状态正常
	public static final String orderTypeDel="0";						//订单状态删除(买方删除)
	public static final String orderTypeNormal="1";						//订单状态正常
	public static final String orderTypeDelete="0";						//订单状态删除(卖方删除)
	public static final String orderSplitYes="1";					//订单拆分是
	public static final String orderSplitNo="0";						//订单拆分no
	public static final String orderDetailCust="1";					//订单跟踪客户
	public static final String orderDetailSupply="0";				//订单跟踪供方
	public static final String orderTypeCancel="090006";			//供方订单已取消
	public static final String buyOrderTypeCancel="090007";			//订单买方已取消
	public static final String orderSplitYes2="2";		//子订单的状态标记为2
}

