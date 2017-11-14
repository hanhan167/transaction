
package com.hansy.transaction.model.vo;

import java.util.List;

public class OrderList {
	private List<TBusOrderVo> oldtBusOrderVo;//拆分之前订单
	private List<TBusOrderVo> newtBusOrderVo;//新订单
	
	public List<TBusOrderVo> getOldtBusOrderVo() {
		return oldtBusOrderVo;
	}
	public void setOldtBusOrderVo(List<TBusOrderVo> oldtBusOrderVo) {
		this.oldtBusOrderVo = oldtBusOrderVo;
	}
	public List<TBusOrderVo> getNewtBusOrderVo() {
		return newtBusOrderVo;
	}
	public void setNewtBusOrderVo(List<TBusOrderVo> newtBusOrderVo) {
		this.newtBusOrderVo = newtBusOrderVo;
	}

}

