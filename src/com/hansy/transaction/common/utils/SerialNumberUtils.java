
package com.hansy.transaction.common.utils;

import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.Date;

public class SerialNumberUtils {

	private static Integer SERIAL_NUMBER = 0; // 流水号格式

	private static SerialNumberUtils primaryGenerater = null;

	private static final int DEFAULT_AUTO_INCREMENT_NUM_LENGTH = 6;

	private SerialNumberUtils() {}

	/**
	 * 取得SerialNumberUtils的单例实现
	 * 
	 * @return
	 */
	public static SerialNumberUtils getInstance() {
		if (primaryGenerater == null) {
			synchronized (SerialNumberUtils.class) {
				if (primaryGenerater == null) {
					primaryGenerater = new SerialNumberUtils();
				}
			}
		}
		return primaryGenerater;
	}

	/**
	 * @description: 生成流水号,取当前时间+计数器循环
	 * @creator: roilat-D
	 * @createDate: 2016年5月30日 
	 */
	public synchronized String generateSerialNum() {
		return generateSerialNum(DEFAULT_AUTO_INCREMENT_NUM_LENGTH);
	}

	/**
	 * @description: 生成流水号,取当前时间+计数器循环
	 * @creator: roilat-D
	 * @createDate: 2016年5月30日 
	 */
	public synchronized String generateSerialNum(int i) {

		Date date = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
		i = (i > SerialNumberUtils.DEFAULT_AUTO_INCREMENT_NUM_LENGTH) ? DEFAULT_AUTO_INCREMENT_NUM_LENGTH : i;
		SERIAL_NUMBER = (SERIAL_NUMBER < 0) ? DEFAULT_AUTO_INCREMENT_NUM_LENGTH : SERIAL_NUMBER;//if i>10 or i<0;then i=10
		SERIAL_NUMBER = (SERIAL_NUMBER >= Math.pow(10, i)) ? 0 : SERIAL_NUMBER;
		String format = "%0" + i + "d";
		String id = formatter.format(date) + String.format(format, SERIAL_NUMBER++);
		return id;
	}


	public static void main(String[] args) {
		System.out.println(Long.toHexString(System.currentTimeMillis()));
		System.out.println(System.currentTimeMillis());
		System.out.println(Math.pow(10, 3) >= 1000);
		System.out.println(Math.pow(10, 3));
		System.out.println(SerialNumberUtils.getInstance().generateSerialNum(6));
		System.out.println(SerialNumberUtils.getInstance().generateSerialNum(15));
		System.out.println(SerialNumberUtils.getInstance().generateSerialNum(15));
		System.out.println(SerialNumberUtils.getInstance().generateSerialNum(15));
		System.out.println(new BigInteger("12345678901234567890").toString());
	}
}
