package com.m.home;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;

import com.common.VbyP;
import com.common.db.PreparedExecuteQueryManager;


public class Home {
	
	static Home hm = new Home();
	
	public static Home getInstance() {
		return hm;
	}
	
	private Home(){};
	
	public ArrayList<HashMap<String, String>> getNotices(Connection conn) {
		
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		pq.setPrepared( conn, VbyP.getSQL("selectNotices") );
		
		ArrayList<HashMap<String, String>> al = new ArrayList<HashMap<String, String>>();
		al = pq.ExecuteQueryArrayList();
		return al;

	}
}
