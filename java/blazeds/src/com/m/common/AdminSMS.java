package com.m.common;

import java.sql.Connection;

public class AdminSMS {
	
	static AdminSMS asms = new AdminSMS();
	
	public static AdminSMS getInstance() {
		return asms;
	}
	private AdminSMS(){};
	
	public BooleanAndDescriptionVO sendAdmin(Connection conn , String message) {
		

		return null;
	}
	
	public BooleanAndDescriptionVO sendAdmin(String message) {
		
		return null;
	}
	
	
}
