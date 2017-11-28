package com.hansy.transaction.common.utils;

import java.io.Serializable;
import java.util.List;

/**
 * 非分页显示所有
 * 
 * @author Administrator
 * 
 * @param <T>
 */
public class AllPager<T> implements Serializable {

	private static final long serialVersionUID = -8448022758591249970L;

	private List<T> rows;// 当前页中存放的记录,类型一般为List

	private int count;// 当前数量;

	public AllPager() {

	}

	public AllPager(List<T> rows, int count) {
		super();
		this.rows = rows;
		this.count = count;
	}

	public List<T> getRows() {
		return rows;
	}

	public void setRows(List<T> rows) {
		this.rows = rows;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

}
