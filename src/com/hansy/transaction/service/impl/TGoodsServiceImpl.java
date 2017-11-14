
package com.hansy.transaction.service.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import com.hansy.transaction.common.BusinessMap;
import com.hansy.transaction.common.constants.GoodsConstants;
import com.hansy.transaction.common.utils.Pager;
import com.hansy.transaction.common.utils.StringUtil;
import com.hansy.transaction.model.bo.DataCatalogManage;
import com.hansy.transaction.model.bo.DataCp;
import com.hansy.transaction.model.bo.DataCpmls;
import com.hansy.transaction.model.bo.DataCpmlss;
import com.hansy.transaction.model.bo.DateCpmlsTypes;
import com.hansy.transaction.model.bo.GoodsAll;
import com.hansy.transaction.model.bo.GoodsDiscount;
import com.hansy.transaction.model.bo.UserGrades;
import com.hansy.transaction.model.bo.goodsSales;
import com.hansy.transaction.model.vo.TPubSupplyBrand;
import com.hansy.transaction.model.vo.TPubSupplyGoods;
import com.hansy.transaction.model.vo.TSysCodeInfo;
import com.hansy.transaction.service.ITGoodsService;
import com.hansy.transaction.service.base.BaseDao;

@Service
public class TGoodsServiceImpl extends BaseDao implements ITGoodsService {

	@Override
	public BusinessMap<Pager> getGoodsAll(Map param,Pager pager) {
		BusinessMap<Pager> bMap=new BusinessMap<>();
		List<GoodsAll> list=new ArrayList<>();
		try {
			list=getSqlMapClientTemplate().queryForList("goods.getGoodsAll",param, (pager.getPageNo()-1)*pager.getPageSize(), pager.getPageSize());
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("获取分页信息失败");
			e.printStackTrace();
			return bMap;
		}
		
		//获取总记录数
		int count=0;
		try {
			count=(int) getSqlMapClientTemplate().queryForObject("goods.getGoodsAllCount",param);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("获取总记录数失败");
			e.printStackTrace();
			return bMap;
		}
		pager.setTotal(count);
		pager.setRows(list);
		bMap.setInfoBody(pager);
		bMap.setIsSucc(true);
		return bMap;
	}

	@Override
	public BusinessMap<Object> goodsShelf(Map<String, Object> param) {
		BusinessMap<Object> bMap=new BusinessMap<>();
		try {
			getSqlMapClientTemplate().update("goods.goodsShelf",param);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("操作失败,请重试");
			e.printStackTrace();
			return bMap;
		}
		bMap.setIsSucc(true);
		return bMap;
	}

	@Override
	public BusinessMap<Object> getGoodsCodes() {
		BusinessMap<Object> bMap=new BusinessMap<>();
		List<GoodsAll> list=new ArrayList<>();
		try {
			list=getSqlMapClientTemplate().queryForList("goods.getGoodsCodes");
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("获取商品code失败，请刷新重试");
			e.printStackTrace();
			return bMap;
		}
		bMap.setInfoBody(list);
		bMap.setIsSucc(true);
		return bMap;
	}

	@Override
	public BusinessMap<Object> getGoodsNames(String goodsCode) {
		BusinessMap<Object> bMap=new BusinessMap<>();
		List<GoodsAll> list=new ArrayList<>();
		try {
			list=getSqlMapClientTemplate().queryForList("goods.getGoodsNames",goodsCode);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("获取商品名失败，请刷新重试");
			e.printStackTrace();
			return bMap;
		}
		bMap.setInfoBody(list);
		bMap.setIsSucc(true);
		return bMap;
	}

	@Override
	public BusinessMap<Object> getAllGrades() {
		BusinessMap<Object> bMap=new BusinessMap<Object>();
		List<UserGrades> list=new ArrayList<>();
		try {
			list=getSqlMapClientTemplate().queryForList("goods.getAllGrades");
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("获取等级信息失败，请刷新重试");
			e.printStackTrace();
			return bMap;
		}
		bMap.setInfoBody(list);
		bMap.setIsSucc(true);
		return bMap;
	}

	@Override
	public BusinessMap<Object> saveGoodsSupply(TPubSupplyGoods supplyGoods) {
		BusinessMap<Object> bMap=new BusinessMap<>();
		try {
			getSqlMapClientTemplate().insert("goods.saveGoodsSupply", supplyGoods);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("新增商品失败，请重试！");
			e.printStackTrace();
			return bMap;
		}
		bMap.setIsSucc(true);
		return bMap;
	}

	@Override
	public BusinessMap<Pager> goodsSales(Map<String, Object> param, Pager pager) {
		BusinessMap<Pager> bMap=new BusinessMap<>();
		List<goodsSales> list=new ArrayList<>();
		try {
			list=getSqlMapClientTemplate().queryForList("goods.goodsSales",param, (pager.getPageNo()-1)*pager.getPageSize(), pager.getPageSize());
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("获取分页信息失败");
			e.printStackTrace();
			return bMap;
		}
		
		//获取总记录数
		int count=0;
		try {
			count=(int) getSqlMapClientTemplate().queryForObject("goods.goodsSalesCount",param);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("获取总记录数失败");
			e.printStackTrace();
			return bMap;
		}
		pager.setTotal(count);
		pager.setRows(list);
		bMap.setInfoBody(pager);
		bMap.setIsSucc(true);
		return bMap;
	}

	@Override
	public BusinessMap<Object> getDiscountPrice(String tableKey,String custNo) {
		BusinessMap<Object> bMap=new BusinessMap<>();
		GoodsAll goodsAll=new GoodsAll();
		try {
			goodsAll=(GoodsAll) getSqlMapClientTemplate().queryForObject("goods.getPrice", tableKey);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("获取价格失败，请重试");
			e.printStackTrace();
			return bMap;
		}
		List<GoodsDiscount> list=new ArrayList<>();
		List<GoodsDiscount> list2=new ArrayList<>();
		Map<String, String> param=new HashMap<>();
		param.put("goodsNo", goodsAll.getCpdm());
		param.put("custNo",custNo);
		try {
			list=getSqlMapClientTemplate().queryForList("goodsDiscount.getDiscount", param);
			list2 = getSqlMapClientTemplate().queryForList("goodsDiscount.getDiscountAlls", param);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("获取折扣信息失败，请重试");
			e.printStackTrace();
			return bMap;
		}
		goodsAll.setList(list);
		goodsAll.setList2(list2);
		bMap.setInfoBody(goodsAll);
		bMap.setIsSucc(true);
		return bMap;
	}

	@Override
	public BusinessMap<Object> findIsExist(Map<String, String> param1) {
		BusinessMap<Object> bMap=new BusinessMap<>();
		Integer result=0;
		try {
			result=(Integer) getSqlMapClientTemplate().queryForObject("goods.findIsExist", param1);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("数据库异常,请刷新重试");
			e.printStackTrace();
			return bMap;
		}
		bMap.setIsSucc(true);
		bMap.setInfoBody(result);
		return bMap;
	}

	@Override
	public BusinessMap<Object> updatePrice(Map<String, String> param1) {
		BusinessMap<Object> bMap=new BusinessMap<>();
		try {
			getSqlMapClientTemplate().update("goods.updatePrice", param1);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("数据库异常,请刷新重试");
			e.printStackTrace();
			return bMap;
		}
		bMap.setIsSucc(true);
		return bMap;
	}

	@Override
	public BusinessMap<List<TSysCodeInfo>> getCutterType() {
		BusinessMap<List<TSysCodeInfo>> bMap=new BusinessMap<>();
		List<TSysCodeInfo> list=new ArrayList<>();
		try {
			list=getSqlMapClientTemplate().queryForList("goods.getCutterType");
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("获取分类信息失败,请刷新重试");
			e.printStackTrace();
			return bMap;
		}
		bMap.setInfoBody(list);
		bMap.setIsSucc(true);
		return bMap;
	}

	@Override
	public BusinessMap<List<String>> getMyGoodsCode(Map<String, String> param) {
		BusinessMap<List<String>> bMap=new BusinessMap<>();
		List<String> list=new ArrayList<>();
		try {
			list=getSqlMapClientTemplate().queryForList("goods.getMyGoodsCode",param);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("获取分类信息失败,请刷新重试");
			e.printStackTrace();
			return bMap;
		}
		bMap.setIsSucc(true);
		bMap.setInfoBody(list);
		return bMap;
	}

	@Override
	public BusinessMap<List<Object>> getGoodsSearch(HashMap<String, Object> param) {
		BusinessMap<List<Object>> bMap=new BusinessMap<>();
		List<Object> list=new ArrayList<>();
		try {
			List<Object> lists=getSqlMapClientTemplate().queryForList("goods.getGoodsSearch",param);
			if(param.containsKey("codes")){
				Map<String, Object> map = new HashMap<String, Object>();
				for (Object obj : lists) {
					DateCpmlsTypes c = (DateCpmlsTypes)obj;
					map.put(c.getCode(), c);
				}
				list.add(map);
			}else{
				list = lists;
			}
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("获取商品分类查询条件信息失败,请刷新重试");
			e.printStackTrace();
			return bMap;
		}
		bMap.setIsSucc(true);
		bMap.setInfoBody(list);
		return bMap;
	}
	
	
	@Override
	public BusinessMap<List<GoodsAll>> getByGoodsCode(String goodsCode) {
		BusinessMap<List<GoodsAll>> bMap=new BusinessMap<>();
		List<GoodsAll> list=new ArrayList<>();
		try {
			list=getSqlMapClientTemplate().queryForList("goods.getByGoodsCode",goodsCode);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("获取分类信息失败,请刷新重试");
			e.printStackTrace();
			return bMap;
		}
		bMap.setIsSucc(true);
		bMap.setInfoBody(list);
		return bMap;
	}

	@Override
	public BusinessMap<List<GoodsAll>> getGoodsByType(String type) {
		BusinessMap<List<GoodsAll>> bMap=new BusinessMap<>();
		List<GoodsAll> list=new ArrayList<>();
		try {
			list=getSqlMapClientTemplate().queryForList("goods.getGoodsByType",type);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("获取商品信息失败,请刷新重试");
			e.printStackTrace();
			return bMap;
		}
		bMap.setIsSucc(true);
		bMap.setInfoBody(list);
		return bMap;
	}

	@Override
	public BusinessMap<List<String>> getGoodsBrand(String type) {
		BusinessMap<List<String>> bMap=new BusinessMap<>();
		List<String> list=new ArrayList<>();
		try {
			list=getSqlMapClientTemplate().queryForList("goods.getGoodsBrand",type);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("获取商品信息失败,请刷新重试");
			e.printStackTrace();
			return bMap;
		}
		bMap.setIsSucc(true);
		bMap.setInfoBody(list);
		return bMap;
	}

	@Override
	public BusinessMap<List<DataCpmls>> getGoodsInfo(String brand) {
		BusinessMap<List<DataCpmls>> bMap=new BusinessMap<>();
		List<DataCpmls> list=new ArrayList<>();
		try {
			list=getSqlMapClientTemplate().queryForList("goods.getGoodsInfo",brand);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("获取商品信息失败,请刷新重试");
			e.printStackTrace();
			return bMap;
		}
		bMap.setIsSucc(true);
		bMap.setInfoBody(list);
		return bMap;
	}

	@Override
	public BusinessMap<Pager> getCommodityAlls(Map<String, Object> param, Pager pager) {
		BusinessMap<Pager> bMap=new BusinessMap<>();
		List<GoodsAll> list=new ArrayList<>();
		try {
			list=getSqlMapClientTemplate().queryForList("goods.getCommodityAlls",param, (pager.getPageNo()-1)*pager.getPageSize(), pager.getPageSize());
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("获取分页信息失败");
			e.printStackTrace();
			return bMap;
		}
		
		//获取总记录数
		int count=0;
		try {
			count=(int) getSqlMapClientTemplate().queryForObject("goods.getCommodityCount",param);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("获取总记录数失败");
			e.printStackTrace();
			return bMap;
		}
		pager.setTotal(count);
		pager.setRows(list);
		bMap.setInfoBody(pager);
		bMap.setIsSucc(true);
		return bMap;
	}

	@Override
	public BusinessMap<Object> saveGoodsSupplys(TPubSupplyGoods supplyGoods) {
		BusinessMap<Object> bMap=new BusinessMap<>();
		try {
			getSqlMapClientTemplate().insert("goods.saveGoodsSupplys", supplyGoods);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("发布商品失败，请重试！");
			e.printStackTrace();
			return bMap;
		}
		bMap.setIsSucc(true);
		return bMap;
	}

	@Override
	public BusinessMap<Object> puhlishChecked(HashMap<String, Object> param) {
		BusinessMap<Object> bMap=new BusinessMap<>();
		String custNo = param.get("custNo")+"";
		String defaultPayDt = param.get("defaultPayDt")+"";//默认交期
		String minkc = param.get("minkc")+"";//最小起订量
		String orderIncrement = param.get("orderIncrement")+"";//订购递增量
//		HashMap<String, Object> grade = (HashMap<String, Object>)param.get("grade");
//		Object obj = param.get("grade");
		String grade001 = param.get("grade[grade001]")+"";//会员1折扣
		String grade002 = param.get("grade[grade002]")+"";//会员2折扣
		String grade003 = param.get("grade[grade003]")+"";//会员3折扣
		String grade004 = param.get("grade[grade004]")+"";//会员4折扣
		String checkId = param.get("checkId")+"";//选择的商品ID
		String checkIdArray[] = null;
		String checkIds = "";
		if(!StringUtil.isEmpty(checkId)){
			checkIdArray = checkId.split(",");
			for(int i = 0; i < checkIdArray.length; i++){
				checkIds += "'" + checkIdArray[i] + "',";
			}
			checkIds = checkIds.substring(0, checkIds.length()-1);
		}else{
			checkIds = "''";
		}
		Map<String, Object> saveParam = new HashMap<String, Object>();
		saveParam.put("defaultPayDt", "'"+defaultPayDt+"'");
		saveParam.put("minkc", "'"+minkc+"'");
		saveParam.put("orderIncrement", "'"+orderIncrement+"'");
		saveParam.put("grade001", grade001);
		saveParam.put("grade002", grade002);
		saveParam.put("grade003", grade003);
		saveParam.put("grade004", grade004);
		saveParam.put("checkIds", checkIds);
		saveParam.put("custNo", "'"+custNo+"'");
		try {
			getSqlMapClientTemplate().insert("goods.insertPublishChecked", saveParam);
			getSqlMapClientTemplate().insert("goods.insertgoodsDiscountChecked", saveParam);
		} catch (Exception e) {
			try {
				getSqlMapClientTemplate().getDataSource().getConnection().rollback();
			} catch (SQLException e1) {
				System.out.println("事物回滚失败！");
				e1.printStackTrace();
			}
			bMap.setIsSucc(false);
			bMap.setMsg("发布商品失败，请重试！");
			e.printStackTrace();
			return bMap;
		}
		bMap.setIsSucc(true);
		return bMap;
	}

	@Override
	public BusinessMap<Object> puhlishAll(HashMap<String, Object> param) {
		BusinessMap<Object> bMap=new BusinessMap<>();
		String custNo = param.get("custNo")+"";
		String gg = param.get("gg")+"";
//		String code = param.get("code")+"";
		String pyname = param.get("pyname")+"";
		String defaultPayDt = param.get("defaultPayDt")+"";//默认交期
		String minkc = param.get("minkc")+"";//最小起订量
		String orderIncrement = param.get("orderIncrement")+"";//订购递增量
//		Map<String, Object> grade = (Map<String, Object>)param.get("grade");
		String checkId = param.get("codes")+"";//选择的商品ID
		String checkIdArray[] = null;
		String codes = "";
		if(!StringUtil.isEmpty(checkId)){
			checkIdArray = checkId.split(",");
			for(int i = 0; i < checkIdArray.length; i++){
				codes += "'" + checkIdArray[i] + "',";
			}
			codes = codes.substring(0, codes.length()-1);
		}else{
			codes = "''";
		}
		
		String grade001 = param.get("grade[grade001]")+"";//会员1折扣
		String grade002 = param.get("grade[grade002]")+"";//会员2折扣
		String grade003 = param.get("grade[grade003]")+"";//会员3折扣
		String grade004 = param.get("grade[grade004]")+"";//会员4折扣
	/*	if(!StringUtil.isEmpty(gg)){
			code = code+gg;
			if(!StringUtil.isEmpty(pyname)){
				code = code + pyname;
			}
		}else{
			if(!StringUtil.isEmpty(pyname)){
				code = code +"%"+ pyname;
			}
		}*/
		Map<String, Object> saveParam = new HashMap<String, Object>();
		saveParam.put("defaultPayDt", defaultPayDt);
		saveParam.put("minkc", minkc);
		saveParam.put("orderIncrement", orderIncrement);
		saveParam.put("grade001", grade001);
		saveParam.put("grade002", grade002);
		saveParam.put("grade003", grade003);
		saveParam.put("grade004", grade004);
		saveParam.put("codes", codes);
		saveParam.put("custNo", custNo);
		try {
			getSqlMapClientTemplate().insert("goods.insertPublishAll", saveParam);
			getSqlMapClientTemplate().insert("goods.insertgoodsDiscountAll", saveParam);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("发布商品失败，请重试！");
			e.printStackTrace();
			return bMap;
		}
		bMap.setIsSucc(true);
		return bMap;
	}

	@Override
	public BusinessMap<Object> startAndEnd(String tableKey) {
		BusinessMap<Object> bMap=new BusinessMap<>();
		Integer status = (Integer)getSqlMapClientTemplate().queryForObject("goods.getPubSupplyGoodsStatus", tableKey);
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("tableKey", tableKey);
		if(GoodsConstants.goodsShelfHalt.equals(status+"")){
			param.put("downDate", new Date());
			param.put("status", Integer.valueOf(GoodsConstants.goodsShelfHalted));
		}else{
			param.put("downDate", null);
			param.put("upDate", new Date());
			param.put("status", Integer.valueOf(GoodsConstants.goodsShelfHalt));
		}
		
		try {
			getSqlMapClientTemplate().update("goods.updateSupplyGoodsStatus", param);
		} catch (DataAccessException e) {
			bMap.setIsSucc(false);
			bMap.setMsg("商品修改状态失败，请重试！");
			e.printStackTrace();
			return bMap;
		}
		bMap.setIsSucc(true);
		return bMap;
	}
	@Override
	public List<DataCatalogManage> getLeftMenu(String custNo) {
		List<DataCatalogManage>list=getSqlMapClientTemplate().queryForList("goods.getLeftMenuAndVoltage",custNo);
		
		return list;
	}
	@Override
	public List<TPubSupplyBrand> getTopMenu(Map<String, String> map) {
		List<TPubSupplyBrand>list=getSqlMapClientTemplate().queryForList("goods.getTopMenu",map);
		return list;
	}
	@Override
	public List<TPubSupplyBrand> getTopMenu1(Map<String, String> map) {
		List<TPubSupplyBrand>list=getSqlMapClientTemplate().queryForList("goods.getTopMenu1",map);
		return list;
	}
	@Override
	public List<TPubSupplyBrand> getTopMenu2(Map<String, String> map) {
		List<TPubSupplyBrand>list=getSqlMapClientTemplate().queryForList("goods.getTopMenu2",map);
		return list;
	}
	@Override
	public List<DataCatalogManage> getLeftMenuNum(String custNo) {
		List<DataCatalogManage>list=getSqlMapClientTemplate().queryForList("goods.getLeftMenuAndVoltageNum",custNo);
		
		return list;
	}

	@Override
	public List<DataCatalogManage> getByGrade(Map<String, String> map) {
		List<DataCatalogManage>list=getSqlMapClientTemplate().queryForList("goods.getByGrade",map);
		return list;
	}
	@Override
	public List<DataCatalogManage> getByGradeAndBrand(Map<String, String> map) {
		List<DataCatalogManage>list=getSqlMapClientTemplate().queryForList("goods.getByGradeAndBrand",map);
		return list;
	}
	@Override
	public List<DataCpmlss> getDataCpmlss(Map<String, String> map) {
		List<DataCpmlss>list=getSqlMapClientTemplate().queryForList("goods.getDataCpmlss",map);
		return list;
	}
	@Override
	public Pager<DataCp> getDataCpmlss1(Map<String, String> map,Pager<DataCp> pager) {
		List<DataCp>list = getSqlMapClientTemplate().queryForList("goods.getDataCpmlss1",map,(pager.getPageNo()-1)*pager.getPageSize(), pager.getPageSize());
		pager.setRows(list);
		int count = (int) getSqlMapClientTemplate().queryForObject("goods.getDataCpmlss1Total",map);
		pager.setTotal(count);
		return pager;
	}
	@Override
	public DataCp getGoodDetal(HashMap<String, Object> param) {
		BusinessMap<DataCp> bMap=new BusinessMap<>();
		List<DataCp>list=getSqlMapClientTemplate().queryForList("goods.getGoodsCodes",param);
		return list.size()>0?list.get(0):null;
	}

	@Override
	public Pager<DataCp> getByGuiGe(Map<String, String> map, Pager<DataCp> pager) {
		List<DataCp>list = getSqlMapClientTemplate().queryForList("goods.getByGuiGe",map,(pager.getPageNo()-1)*pager.getPageSize(), pager.getPageSize());
		pager.setRows(list);
		int count = (int) getSqlMapClientTemplate().queryForObject("goods.getByGuiGeTotal",map);
		pager.setTotal(count);
		return pager;
	}

	@Override
	public Pager<DataCp> getDataCpmlss2(Map<String, String> map, Pager<DataCp> pager) {
		List<DataCp>list = getSqlMapClientTemplate().queryForList("goods.getDataCpmlss2",map,(pager.getPageNo()-1)*pager.getPageSize(), pager.getPageSize());
		pager.setRows(list);
		int count = (int) getSqlMapClientTemplate().queryForObject("goods.getDataCpmlss2Total",map);
		pager.setTotal(count);
		return pager;
	}

	@Override
	public BusinessMap<Object> updateDis(Map<String, String> map) {
		BusinessMap bMap=new BusinessMap<>();
		try {
			getSqlMapClientTemplate().update("goods.updateDis", map);
		} catch (Exception e) {
			bMap.setIsSucc(false);
			bMap.setMsg("折扣信息更新异常，请重试");
			e.printStackTrace();
			return bMap;
		}
		bMap.setIsSucc(true);
		return bMap;
	}

	@Override
	public DataCp getDataCpmlss11(String code) {
		BusinessMap<DataCp> bMap=new BusinessMap<>();
		List<DataCp>list=getSqlMapClientTemplate().queryForList("goods.getDataCpmlss11",code);
		return list.size()>0?list.get(0):null;
	}

}

