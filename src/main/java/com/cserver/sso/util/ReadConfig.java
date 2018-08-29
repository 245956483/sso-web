package com.cserver.sso.util;

import java.util.ResourceBundle;
/**
* @author： byy 
* @date : 2017年12月14日 下午5:32:40
* @Description：读取配置文件config.properties
*/
public class ReadConfig {
	private static ResourceBundle res = null;

	public static String getString(String key) {
		res = ResourceBundle.getBundle("config");
		try {
			if ("".equals(res.getString(key)) || res.getString(key) == null) {
				return "";
			} else {
				return res.getString(key);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "";
		}
	}

	public static String getString(String path, String key) {
		ResourceBundle res = ResourceBundle.getBundle(path);
		try {
			if ("".equals(res.getString(key)) || res.getString(key) == null) {
				return "";
			} else {
				return res.getString(key);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "";
		}
	}
}
