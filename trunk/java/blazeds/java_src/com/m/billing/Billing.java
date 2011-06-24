package com.m.billing;

import java.sql.Connection;

import com.common.VbyP;
import com.common.db.PreparedExecuteQueryManager;
import com.common.util.SLibrary;

public class Billing {

	static Billing bill = new Billing();
	Billing(){}
	public static Billing getInstance(){
		return bill;
	}
	
	public int insert(Connection conn, BillingVO vo) {
		
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		pq.setPrepared( conn, VbyP.getSQL("insertBilling") );
		//user_id, method, amount, order_no, unit_cost, remain_point, pay_state,  timeWrite
		pq.setString(1, vo.getUser_id());
		pq.setString(2, vo.getMethod());
		pq.setInt(3, vo.getAmount());
		pq.setString(4, vo.getOrder_no());
		pq.setString(5, vo.getUnit_cost());
		pq.setInt(6, vo.getRemain_point());
		pq.setString(7, SLibrary.getDateTimeString("yyyy-MM-dd HH:mm:ss"));

		
		return pq.executeUpdate();
	}
}
