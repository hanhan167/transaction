
package com.hansy.transaction.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.hansy.transaction.common.BusinessMap;
import com.hansy.transaction.common.utils.Pager;
import com.hansy.transaction.model.bo.DataCatalogManage;
import com.hansy.transaction.model.bo.DataCp;
import com.hansy.transaction.model.bo.DataCpmls;
import com.hansy.transaction.model.bo.DataCpmlss;
import com.hansy.transaction.model.bo.GoodsAll;
import com.hansy.transaction.model.vo.TPubSupplyBrand;
import com.hansy.transaction.model.vo.TPubSupplyGoods;
import com.hansy.transaction.model.vo.TSysCodeInfo;

public interface ITGoodsService {

	/**
	 * 获取所有的商品
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月17日 
	 * @modifier:
	 * @modifiedDate:
	 * @param custNo
	 * @return
	 */
	BusinessMap<Pager> getGoodsAll(Map param,Pager pager);

	/**
	 * 
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月20日 
	 * @modifier:
	 * @modifiedDate:
	 * @param tableKey
	 * @return
	 */
	BusinessMap<Object> goodsShelf(Map<String, Object> param);

	/**
	 * 获取所有的商品代码
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月24日 
	 * @modifier:
	 * @modifiedDate:
	 * @return
	 */
	BusinessMap<Object> getGoodsCodes();

	/**
	 * 获取商品名
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月24日 
	 * @modifier:
	 * @modifiedDate:
	 * @param goodsCode
	 * @return
	 */
	BusinessMap<Object> getGoodsNames(String goodsCode);

	/**
	 * 获取所有的等级
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月27日 
	 * @modifier:
	 * @modifiedDate:
	 * @return
	 */
	BusinessMap<Object> getAllGrades();

	/**
	 * 保存商品用户关系表
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月27日 
	 * @modifier:
	 * @modifiedDate:
	 * @param supplyGoods
	 * @return
	 */
	BusinessMap<Object> saveGoodsSupply(TPubSupplyGoods supplyGoods);

	/**
	 * 获取商品销售信息
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月27日 
	 * @modifier:
	 * @modifiedDate:
	 * @param param
	 * @param pager
	 * @return
	 */
	BusinessMap<Pager> goodsSales(Map<String, Object> param, Pager pager);

	/**
	 * 获取商品价格和折扣
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月28日 
	 * @modifier:
	 * @modifiedDate:
	 * @param tableKey
	 * @return
	 */
	BusinessMap<Object> getDiscountPrice(String tableKey,String custNo);

	/**
	 * 判断该商品是否存在
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月29日 
	 * @modifier:
	 * @modifiedDate:
	 * @param param1
	 * @return
	 */
	BusinessMap<Object> findIsExist(Map<String, String> param1);

	/**
	 * 修改价格
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年3月29日 
	 * @modifier:
	 * @modifiedDate:
	 * @param param1
	 * @return
	 */
	BusinessMap<Object> updatePrice(Map<String, String> param1);
	/**
	 * 获取刀具类型菜单
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年4月7日 
	 * @modifier:
	 * @modifiedDate:
	 * @return
	 */
	BusinessMap<List<TSysCodeInfo>> getCutterType();

	/**
	 * 获取当前用户所有goodsCode
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年4月11日 
	 * @modifier:
	 * @modifiedDate:
	 * @param custNo
	 * @return
	 */
	BusinessMap<List<String>> getMyGoodsCode(Map<String, String> param);

	/**
	 * 根据goodsCode获取商品规格和tableKey
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年4月11日 
	 * @modifier:
	 * @modifiedDate:
	 * @param goodsCode
	 * @return
	 */
	BusinessMap<List<GoodsAll>> getByGoodsCode(String goodsCode);

	/**
	 * 根据类型获取商品
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年4月13日 
	 * @modifier:
	 * @modifiedDate:
	 * @param type
	 * @return
	 */
	BusinessMap<List<GoodsAll>> getGoodsByType(String type);

	/**
	 * 发布商品—根据产品类型获取产品品牌
	 * @description: TODO
	 * @creator: fj
	 * @createDate: 2017年4月26日 
	 * @modifier:
	 * @modifiedDate:
	 * @param type
	 * @return
	 */
	BusinessMap<List<String>> getGoodsBrand(String type);

	/**
	 * 发布商品—根据产品品牌获取其他查询条件的信息
	 * @description: TODO
	 * @creator: fj
	 * @createDate: 2017年4月26日 
	 * @modifier:
	 * @modifiedDate:
	 * @param type
	 * @return
	 */
	BusinessMap<List<DataCpmls>> getGoodsInfo(String brand);
	
	/**
	 * 发布商品—根据提供的查询条件查询商品信息
	 * @description: TODO
	 * @creator: fj
	 * @createDate: 2017年4月26日 
	 * @modifier:
	 * @modifiedDate:
	 * @param type
	 * @return
	 */
	BusinessMap<Pager> getCommodityAlls(Map<String, Object> param, Pager pager);
	
	/**
	 * 发布商品—新增商品
	 * @description: TODO
	 * @creator: fj
	 * @createDate: 2017年4月27日 
	 * @modifier:
	 * @modifiedDate:
	 * @param supplyGoods
	 * @return
	 */
	BusinessMap<Object> saveGoodsSupplys(TPubSupplyGoods supplyGoods);

	/**
	 * 获取商品管理-商品查询条件
	 * @param code
	 * @return
	 */
	BusinessMap<List<Object>> getGoodsSearch(HashMap<String, Object> param);
	
	
	/**
	 * 根据选择的产品发布
	 * @param param
	 * @return
	 */
	BusinessMap<Object> puhlishChecked(HashMap<String, Object> param);

	
	/**
	 * 根据筛选条件发布所有符合条件的产品
	 * @param param
	 * @return
	 */
	BusinessMap<Object> puhlishAll(HashMap<String, Object> param);
	
	/**
	 * 根据主键修改商品状态
	 * @param param
	 * @return
	 */
	BusinessMap<Object> startAndEnd(String tableKey);
	List<TPubSupplyBrand> getTopMenu1(Map<String, String>map);//最上边的菜单
	List<TPubSupplyBrand> getTopMenu2(Map<String, String>map);//最上边的菜单
	List<DataCatalogManage> getLeftMenu(String custNo);//左边的刀具菜单
	List<DataCatalogManage> getLeftMenuNum(String custNo);//左边的数控的菜单
	List<TPubSupplyBrand> getTopMenu(Map<String, String>map);//最上边的菜单
	List<DataCatalogManage>getByGrade(Map<String, String>map);//管他呢
	List<DataCatalogManage>getByGradeAndBrand(Map<String, String>map);//管他呢
	List<DataCpmlss> getDataCpmlss(Map<String, String> map);			//根据规格查询分类
	Pager<DataCp>getDataCpmlss1(Map<String, String> map,Pager<DataCp> pager);//根据规格查询到的分类再查询出详情
	DataCp getGoodDetal(HashMap<String, Object> param);
	Pager<DataCp>getByGuiGe(Map<String, String> map,Pager<DataCp> pager);//发布商品的中间部分规格
	Pager<DataCp>getDataCpmlss2(Map<String, String> map,Pager<DataCp> pager);//根据规格查询到的分类再查询出详情
	
	BusinessMap<Object> updateDis(Map<String, String>map);
	
	DataCp getDataCpmlss11(String code);//在再次够买的时候需要查询到当前商品所用到的品牌
}

