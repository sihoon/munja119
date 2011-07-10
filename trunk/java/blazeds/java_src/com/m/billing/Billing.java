package com.m.billing;

import java.sql.Connection;

import com.common.VbyP;
import com.common.db.PreparedExecuteQueryManager;
import com.common.util.SLibrary;
import com.m.common.BooleanAndDescriptionVO;
import com.m.common.PointManager;
import com.m.member.SessionManagement;
import com.m.member.UserInformationVO;

public class Billing {

	static Billing bill = new Billing();
	Billing(){}
	public static Billing getInstance(){
		return bill;
	}
	
	public BooleanAndDescriptionVO setCash(Connection conn, String user_id, String account, String amount, String method, String reqName) {
		
		BooleanAndDescriptionVO rvo = new BooleanAndDescriptionVO();
		rvo.setbResult(false);
		int rslt = 0;
		
		
		try {
			
			
			VbyP.accessLog(" >> 무통장 입금 요청 "+ user_id +" , "+ account+" , "+ amount+" , "+ method+" , "+reqName);
			
			PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
			pq.setPrepared( conn, VbyP.getSQL("insertCash") );
			pq.setString(1, user_id);
			pq.setString(2, account);
			pq.setInt(3, SLibrary.intValue(amount));
			pq.setString(4, method);
			pq.setString(5, reqName);
			pq.setString(6, SLibrary.getDateTimeString());
						
			rslt =  pq.executeUpdate();
			
			if ( rslt < 1)
				throw new Exception("무통장 등록에 실패 하였습니다.");
			
			rvo.setbResult(true);
			
		}catch (Exception e) {
			
			rvo.setbResult(false);
			rvo.setstrDescription(e.getMessage());
			
		}
		return rvo;
	}
	
	public BooleanAndDescriptionVO setBilling( Connection conn, BillingVO bvo) {
		
		BooleanAndDescriptionVO rvo = new BooleanAndDescriptionVO();
		rvo.setbResult(false);
		UserInformationVO uvo = null;
		int point = 0;
		int rslt = 0;
		
		
		try {
			String user_id = bvo.getUser_id();
			if (user_id == null || user_id.equals("")) throw new Exception("로그인 되어 있지 않습니다.");
			if (conn == null) throw new Exception("DB연결이 되어 있지 않습니다.");
			
			
			VbyP.accessLog(" >> 결제등록 요청 "+ user_id +" , "+ Integer.toString(bvo.getAmount())+" , "+ bvo.getMethod());
			
			uvo = new SessionManagement().getUserInformation(conn, bvo.getUser_id());
			
			if (bvo.getAmount() == ( 2000+( 2000 *0.1 ) ) ) point = 100;
			else if (bvo.getAmount() == ( 5700+( 5700 *0.1 ) ) ) point = 300;
			else if (bvo.getAmount() == ( 9000+( 9000 *0.1 ) ) ) point = 500;
			else if (bvo.getAmount() == ( 17000+( 17000 *0.1 ) ) ) point = 1000;
			else if (bvo.getAmount() == ( 24600+( 24600 *0.1 ) ) ) point = 1500;
			else if (bvo.getAmount() == ( 46500+( 46500 *0.1 ) ) ) point = 3000;
			else if (bvo.getAmount() == ( 74000+( 74000 *0.1 ) ) ) point = 5000;
			else if (bvo.getAmount() == ( 139000+( 139000 *0.1 ) ) ) point = 10000;
			else if (bvo.getAmount() == ( 260000+( 260000 *0.1 ) ) ) point = 20000;
			else if (bvo.getAmount() == ( 375000+( 375000 *0.1 ) ) ) point = 30000;
			else if (bvo.getAmount() == ( 600000+( 600000 *0.1 ) ) ) point = 50000;
			else if (bvo.getAmount() == ( 1150000+( 1150000 *0.1 ) ) ) point = 100000;
			else if (bvo.getAmount() == ( 3300000+( 3300000 *0.1 ) ) ) point = 300000;
			else if (bvo.getAmount() == ( 5350000+( 5350000 *0.1 ) ) ) point = 500000;
			else point = SLibrary.intValue( SLibrary.fmtBy.format( Math.ceil(bvo.getAmount()/uvo.getUnit_cost()) ) );
			
			bvo.setPoint(point);
			bvo.setRemain_point( SLibrary.intValue(uvo.getPoint())+point);
			bvo.setTimeWrite(SLibrary.getDateTimeString("yyyy-MM-dd HH:mm:ss"));
			bvo.setUnit_cost(Integer.toString(uvo.getUnit_cost()));
			
			if ( bill.insert(conn, bvo) < 1)
				throw new Exception("결제 등록에 실패 하였습니다.");
			
			
			PointManager pm = PointManager.getInstance();
			rslt = pm.insertUserPoint(conn, uvo, 03, point * PointManager.DEFULT_POINT);
			if (rslt != 1)
				throw new Exception("건수 충전에 실패 하였습니다.");

			rvo.setbResult(true);
			
		}catch (Exception e) {
			
			rvo.setbResult(false);
			rvo.setstrDescription(e.getMessage());
			
		}
		return rvo;
	}
	
	private int insert(Connection conn, BillingVO vo) {
		
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		pq.setPrepared( conn, VbyP.getSQL("insertBilling") );
		pq.setString(1, vo.getUser_id());
		pq.setString(2, vo.getMethod());
		pq.setInt(3, vo.getAmount());
		pq.setString(4, vo.getOrder_no());
		pq.setString(5, vo.getUnit_cost());
		pq.setInt(6, vo.getPoint());
		pq.setInt(7, vo.getRemain_point());
		pq.setString(8, SLibrary.getDateTimeString("yyyy-MM-dd HH:mm:ss"));

		
		return pq.executeUpdate();
	}
}
