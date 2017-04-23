package com.etc.cms.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 操作日期的工具类 String Date的相互转换
 * @author 庄加建
 * @version V1.0
 * 修改时间 3.16
 */
public class DateUtil {
	
	
	public static void main(String[] args) {
		System.out.println(DateTime2String(new Date()));
	}
	

	public static String Date2String(Date date){	
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		return sdf.format(date);
	}
	
	public static Date String2Date(String dateStr){
		Date date=null;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		try {
			 sdf.parse(dateStr);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return date;
	}
	
	public static String DateTime2String(Date date){
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return sdf.format(date);
	
	}
}
