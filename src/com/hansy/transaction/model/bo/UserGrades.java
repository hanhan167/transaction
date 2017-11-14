
package com.hansy.transaction.model.bo;

import java.io.Serializable;

/**
 * 等级信息
 * TODO javadoc for com.hansy.transaction.model.bo.UserGrades
 * @Copyright: 2017成都环赛信息技术有限公司 
 * @author: cj
 * @since: 2017年3月27日
 */
public class UserGrades implements Serializable {

	/**
	 * Comment for <code>serialVersionUID</code>
	 */
	private static final long serialVersionUID = -1056384698064796186L;
	private String gradesName;			//等级名
	private String gradesNo;				//等级编号
	
	public String getGradesName() {
		return gradesName;
	}
	
	public void setGradesName(String gradesName) {
		this.gradesName = gradesName;
	}
	
	public String getGradesNo() {
		return gradesNo;
	}
	
	public void setGradesNo(String gradesNo) {
		this.gradesNo = gradesNo;
	}
}

