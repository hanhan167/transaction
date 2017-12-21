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

	private int pageSize = 5;
	
	private List<T> rows;// 当前页中存放的记录,类型一般为List

	private int count;// 当前数量;

	private long total; // 总记录数

	private int pageNo = 1;// 要跳转到的页码
	
	public AllPager() {

	}

	public AllPager(List<T> rows, int count) {
		super();
		this.rows = rows;
		this.count = count;
	}

	
	public AllPager(List<T> rows, int count, long total, int pageNo) {
		//super();
		this.rows = rows;
		this.count = count;
		this.total = total;
		this.pageNo = pageNo;
	}

	public AllPager(int pageSize, List<T> rows, int count, long total,
			int pageNo) {
		//super();
		this.pageSize = pageSize;
		this.rows = rows;
		this.count = count;
		this.total = total;
		this.pageNo = pageNo;
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

	public long getTotal() {
		return total;
	}

	public void setTotal(long total) {
		this.total = total;
	}

	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	

}
