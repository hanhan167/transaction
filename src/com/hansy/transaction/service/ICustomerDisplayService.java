package com.hansy.transaction.service;

import com.hansy.transaction.common.BusinessMap;
import com.hansy.transaction.model.bo.CustomerDisplay;

public interface ICustomerDisplayService {
  
	Integer addCd(CustomerDisplay customerDisplay);

	String findTelCd(CustomerDisplay cDisplay);
	
}
