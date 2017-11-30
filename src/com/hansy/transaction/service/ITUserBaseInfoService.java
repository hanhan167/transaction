package com.hansy.transaction.service;

import java.util.List;
import java.util.Map;

import com.hansy.transaction.common.BusinessMap;
import com.hansy.transaction.common.utils.Pager;
import com.hansy.transaction.model.bo.LoginUser;
import com.hansy.transaction.model.bo.TUserBaseInfoBo;
import com.hansy.transaction.model.vo.TUserBaseInfoVo;



public interface ITUserBaseInfoService {

	public static final String BEAN_ID = "ITUserBaseInfoService";
	
	public List<TUserBaseInfoVo>  selectUserBaseInfo(String userNo);

	/**
	 * 根据用户名和密码查询用户
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月10日 
	 * @modifier:
	 * @modifiedDate:
	 * @param user
	 * @return
	 */
	public BusinessMap<TUserBaseInfoBo> getUser(String custNo);
	
	
	/**
	 * 获取登录用的订单总数
	 * @param custNo
	 * @return
	 */
	public int getLoginUserOrderCount(Map<String, String> param);
	
	/*public Pager getMyOrderNoBill(Map<String, Object>map,Pager pager);*/
}
