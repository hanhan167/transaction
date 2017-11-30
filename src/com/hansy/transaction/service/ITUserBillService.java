
package com.hansy.transaction.service;

import com.hansy.transaction.common.BusinessMap;
import com.hansy.transaction.model.vo.TUserBill;

public interface ITUserBillService {
	BusinessMap<Object> save(TUserBill tUserBill);
	BusinessMap<Object> delete(String orderNo);
	BusinessMap<Object> update(TUserBill tUserBill);
	BusinessMap<Object> getById(String id);
}

