
package com.hansy.transaction.service;

import java.util.Map;

import com.hansy.transaction.common.BusinessMap;
import com.hansy.transaction.model.vo.TBusAddress;

public interface ITBusAddressService {
	BusinessMap<Object> add(Map<String, Object> param);
	BusinessMap<Object> delete(String tableKey);
	BusinessMap<Object> update(TBusAddress addressVo);
	TBusAddress getByTableKey(String tableKey);
	BusinessMap<Object> add1(Map<String, Object> param);
}

