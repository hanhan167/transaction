
package com.hansy.transaction.model.vo;

import java.io.Serializable;

/**
 * 码值表
 * TODO javadoc for com.hansy.transaction.model.vo.TSysCodeInfo
 * @Copyright: 2017成都环赛信息技术有限公司 
 * @author: cj
 * @since: 2017年4月7日
 */
public class TSysCodeInfo implements Serializable {

	/**
	 * Comment for <code>serialVersionUID</code>
	 */
	private static final long serialVersionUID = -3380052788822258341L;
	private String codeInfoId;		//码值id
	private String codeTypeId;		//类型id
	private String codeInfoName;	//码值名称
	private String codeInfoValue;	//码值
	private Integer state;			//状态
	public String getCodeInfoId() {
		return codeInfoId;
	}
	
	public void setCodeInfoId(String codeInfoId) {
		this.codeInfoId = codeInfoId;
	}
	
	public String getCodeTypeId() {
		return codeTypeId;
	}
	
	public void setCodeTypeId(String codeTypeId) {
		this.codeTypeId = codeTypeId;
	}
	
	public String getCodeInfoName() {
		return codeInfoName;
	}
	
	public void setCodeInfoName(String codeInfoName) {
		this.codeInfoName = codeInfoName;
	}
	
	public String getCodeInfoValue() {
		return codeInfoValue;
	}
	
	public void setCodeInfoValue(String codeInfoValue) {
		this.codeInfoValue = codeInfoValue;
	}
	
	public Integer getState() {
		return state;
	}
	
	public void setState(Integer state) {
		this.state = state;
	}
}

