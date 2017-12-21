package com.hansy.transaction.common.utils;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Random;
import java.util.UUID;


/**
 * 
 * @author cj
 * @time 2016-11-30
 */
public class UUIDUtil {
	private static Integer SERIAL_NUMBER = 0; // 流水号格式

	private static final int DEFAULT_AUTO_INCREMENT_NUM_LENGTH = 6;
	
	
	/**
	 * 获取String类型UUID
	 * @return
	 */
	public static String getStrUUID(){
		return UUID.randomUUID().toString();
	}
	/**
	 * 获取UUID类型UUID
	 * @return
	 */
	public static UUID getUUID(){
		return UUID.randomUUID();
	}
	/**
	 * 获取去掉"-"的UUID
	 * @return
	 */
	public static String getParseUUID(){
		return UUID.randomUUID().toString().replace("-", "");
	}
	
	/**
	 * 随机生成strlength长度的数字字符串
	 * @description: TODO
	 * @creator: cj
	 * @createDate: 2017年2月23日 
	 * @modifier:
	 * @modifiedDate:
	 * @param strLength
	 * @return
	 */
	 public static String getFixLength(int strLength){
	        StringBuffer sb = new StringBuffer();
	        String str = "0123456789";
	        Random r = new Random();
	        for(int i=0;i<strLength;i++){
	            int num = r.nextInt(str.length());
	            sb.append(str.charAt(num));
	        }
	        return sb.toString();
	 } 
	 
	 /**
		 * @description: 生成流水号,取当前时间+计数器循环
		 * @creator: roilat-D
		 * @createDate: 201年11月17日 
		 * @param: i 后缀的个数
		 */
		public static synchronized String generateSerialNum(int i) {

			Date date = new Date();
			SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
			i = (i > UUIDUtil.DEFAULT_AUTO_INCREMENT_NUM_LENGTH) ? DEFAULT_AUTO_INCREMENT_NUM_LENGTH : i;
			SERIAL_NUMBER = (SERIAL_NUMBER < 0) ? DEFAULT_AUTO_INCREMENT_NUM_LENGTH : SERIAL_NUMBER;//if i>10 or i<0;then i=10
			SERIAL_NUMBER = (SERIAL_NUMBER >= Math.pow(10, i)) ? 0 : SERIAL_NUMBER;
			String format = "%0" + i + "d";
			String id = formatter.format(date) + String.format(format, SERIAL_NUMBER++);
			return id;
		}
	
	 /**
	  * 根据时间获取时间字符串用作userNo
	  * @description: TODO
	  * @creator: cj
	  * @createDate: 2017年2月27日 
	  * @modifier:
	  * @modifiedDate:
	  * @param date
	  * @return
	  */
	 public static String getDateString(Date date){
		SimpleDateFormat sFormat=new SimpleDateFormat("YYYYMMdHms");
		return sFormat.format(date).toString();
	 }
	 
	public static void main(String[] args) {
		System.out.println(UUIDUtil.generateSerialNum(5));
	}
	
	//map集合比较--判断发票金额
	public static boolean compare(List<Object> list, int i){
		for (int j = 0; j < list.size(); j++) {
			if(i == (int) list.get(j)){
				return true;
			}
		}
		return false;
	}
}
