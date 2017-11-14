
package com.hansy.transaction.common.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DateUtil {
	
	//日期增加某个天数返回时间
	public static String addDate(Calendar c,Integer num){
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
        c.add(Calendar.DAY_OF_MONTH, num);
        String result=sf.format(c.getTime());
        return result;
	}
	
	//根据传过来的字符串获取传过来的时间与当前时间差 单位为天
	public static Integer getDay(String param){
		SimpleDateFormat sf=new SimpleDateFormat("yyyy-MM-dd");
		Integer result=0;
		try {
			Date date=sf.parse(param);
			result=(int) Math.ceil((float)(date.getTime()-new Date().getTime())/(24*60*60*1000));
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	public static void main(String[] args) {
		System.out.println(getDay("2017-04-05"));
	}
}

