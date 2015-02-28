package com.m.common;

import java.sql.Connection;
import java.sql.SQLException;

import com.common.VbyP;
import com.common.db.PreparedExecuteQueryManager;
import com.common.util.SLibrary;
import com.m.billing.BillingVO;
import com.m.member.UserInformationVO;

public class PointManager {
	
	public static final int DEFULT_POINT=1;
	public static final int FOREIGN_POINT=12;
	public static final int DEFULT_UNIT_COST=10;
	public static final int DEFULT_UNIT_COST_LMS=30;
	public static final int DEFULT_UNIT_COST_MMS=100;
	public static final int DEFULT_UNIT_COST_FOREIGN=120;
	static PointManager pm = new PointManager();
	
	
	
	public static PointManager getInstance() {
		return pm;
	}
	private PointManager(){};
	
	public int initPoint(String user_id, int cnt) {
		
		Connection conn = null;
		int count = 0;

		try {
			conn = VbyP.getDB();
			PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
			pq.setPrepared( conn, VbyP.getSQL("initPoint") );
			pq.setString(1, user_id);
			pq.setInt(2, cnt);
			count = pq.executeUpdate();
			
			
			
		}catch(Exception e) {}
		finally {
			try {
				if ( conn != null )
					conn.close();
			}catch(SQLException e) {
				VbyP.errorLog("initPoint >> conn.close() Exception!"); 
			}
		}
		
		return count;
	}
	
	public int getUserPoint(Connection conn, String user_id) {
		
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		pq.setPrepared( conn, VbyP.getSQL("userPoint") );
		pq.setString(1, user_id);
		
		return pq.ExecuteQueryNum();
	}
	

	public int getUserPointLms(Connection conn, String user_id) {
		
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		pq.setPrepared( conn, VbyP.getSQL("userPointLms") );
		pq.setString(1, user_id);
		
		return pq.ExecuteQueryNum();
	}
	
	public int getUserPointMms(Connection conn, String user_id) {
		
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		pq.setPrepared( conn, VbyP.getSQL("userPointMms") );
		pq.setString(1, user_id);
		
		return pq.ExecuteQueryNum();
	}
	
	public int insertUserPoint(Connection conn, UserInformationVO mvo, int code, int point ) {
		
		System.out.println(mvo.getUser_id() + " insertUserPoint->"+ Integer.toString(code)+ "/ " +Integer.toString(point));
		int pcount = insertPointLog(conn, mvo, code, point);
		System.out.println(mvo.getUser_id() + " pointLog->"+ Integer.toString(pcount));
		if ( pcount == 1 ) {
			pcount = insertPoint(conn, mvo.getUser_id(), code, point);
			System.out.println(mvo.getUser_id() + "point->"+ Integer.toString(pcount));
			return pcount;
		}
		else
			return 0;
	}

	public int insertUserPoint(Connection conn, String user_id, int code, int point, String pay_type, String memo ) {
		
		if ( insertPointLog(conn, user_id, code, point, pay_type, memo) == 1 )
			return insertPoint(conn, user_id, code, point, memo);
		else
			return 0;
	}

	public int insertUserPointBilling(Connection conn, UserInformationVO mvo, int code, int point, int point_lms, int point_mms ) {
		
		System.out.println(">>>>>>>>>>>point:"+point+",point_lms:"+point_lms+",point_mms:"+point_mms);
		// 
		
		// point_log 테이블에 입력할 차감,충전될 포인트 계산
		int logpoint = point - Integer.parseInt(mvo.getPoint());
		int logpointLms = 0;
		int logpointMms = 0;
		double tmpAmt = 0;
		double tmpPntLms = 0;
		double tmpPntMms = 0;
		
		double mUnitCost = mvo.getUnit_cost()==null?0:mvo.getUnit_cost();
		double mUnitCostLms = mvo.getUnit_cost_lms()==null?0:mvo.getUnit_cost_lms();
		double mUnitCostMms = mvo.getUnit_cost_mms()==null?0:mvo.getUnit_cost_mms();
		
		String pntLms = mvo.getPoint_lms()==null?"0":mvo.getPoint_lms();
		String pntMms = mvo.getPoint_mms()==null?"0":mvo.getPoint_mms();
		
		// 개별단가 0인 경우 기본단가 읽기
		if(mUnitCost <= 0){
			mUnitCost = this.DEFULT_UNIT_COST; //기본단가
		}
		if(mUnitCostLms <= 0){
			mUnitCostLms = this.DEFULT_UNIT_COST_LMS; //기본단가
		}
		if(mUnitCostMms <= 0){
			mUnitCostMms = this.DEFULT_UNIT_COST_MMS; //기본단가
		}

		// point_lms 값 안넘어오는 경우 계산(cron으로 돌아가는 소스엔 point 값만 있음)
		if( point_lms <= 0 ){
			tmpPntLms = SLibrary.intValue( SLibrary.fmtBy.format( Math.round( ( point * mUnitCost ) / mUnitCostLms ) ) ); // ( 넘어온 sms건수 * sms 단가 ) / lms 단가 = lms 포인트
			point_lms = (int) tmpPntLms;
		}
		// point_mms 값 안넘어오는 경우 계산(cron으로 돌아가는 소스엔 point 값만 있음)
		if( point_mms <= 0 ){
			tmpPntMms = SLibrary.intValue( SLibrary.fmtBy.format( Math.round( ( point * mUnitCost ) / mUnitCostMms ) ) ); // ( 넘어온 sms건수 * sms 단가 ) / mms 단가 = mms 포인트
			point_mms = (int) tmpPntMms;
		}
		

		// point_log 입력 시작
		
		// 남은 sms 포인트를 금액환산
		tmpAmt = Integer.parseInt(mvo.getPoint()) * mUnitCost; // 잔여포인트 * sms 단가
		
		// lms 잔여포인트 입력된적 있는지 체크
		if( Integer.parseInt(pntLms) > 0 ){
			logpointLms = point_lms - Integer.parseInt(pntLms); // 차감,충전후 lms 남은건수 - lms 잔여포인트 
		}else{
			logpointLms = point_lms - SLibrary.intValue( SLibrary.fmtBy.format( Math.round(   tmpAmt / mUnitCostLms   ) ) ); // 넘어온 lms건수 - (환산금액 / lms 단가)
		}

		// mms 잔여포인트 입력된적 있는지 체크
		if( Integer.parseInt(pntMms) > 0 ){
			logpointMms = point_mms - Integer.parseInt(pntMms); // 차감,충전후 mms 남은건수 - mms 잔여포인트
		}else{
			logpointMms = point_mms - (SLibrary.intValue( SLibrary.fmtBy.format( Math.round(   tmpAmt / mUnitCostMms   ) )) ); // 넘어온 mms건수 - (환산금액 / mms 단가)
		}

		System.out.println(mvo.getUser_id() + " insertUserPoint->"+ Integer.toString(code)+ "/ " +Integer.toString(point));
		System.out.println(" >>>>>>>>>>>> logpoint:"+ logpoint+ "/ logpoint_lms:" + logpointLms +"/ logpoint_mms:" + logpointMms);
		
		// point_log 테이블 입력
		int pcount = insertPointLogBilling(conn, mvo, code, logpoint, logpointLms, logpointMms);
		
		System.out.println(mvo.getUser_id() + " pointLog->"+ Integer.toString(pcount));
		
		if ( pcount == 1 ) {

			// point 테이블 입력
			pcount = insertPointBilling(conn, mvo.getUser_id(), code, point, point_lms, point_mms);
			
			System.out.println(mvo.getUser_id() + "point->"+ Integer.toString(pcount));
			System.out.println(" >>>>>>>>>>>> point:"+ point+ "/ point_lms:" + point_lms +"/ point_mms:" + point_mms);
			
			return pcount;
		}
		else
			return 0;
	}
		
	private int insertPoint(Connection conn, String user_id, int code, int point) {
		
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		pq.setPrepared( conn, VbyP.getSQL("insertPoint") );
		pq.setInt(1, point);
		pq.setString(2, SLibrary.getDateTimeString("yyyy-MM-dd HH:mm:ss") );
		pq.setString(3, user_id);
		
		return pq.executeUpdate();
	}
	
	private int insertPointBilling(Connection conn, String user_id, int code, int point, int point_lms, int point_mms) {
		
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		pq.setPrepared( conn, VbyP.getSQL("insertPointBilling") );
		pq.setInt(1, point);
		pq.setInt(2, point_lms);
		pq.setInt(3, point_mms);
		pq.setString(4, SLibrary.getDateTimeString("yyyy-MM-dd HH:mm:ss") );
		pq.setString(5, user_id);
		
		return pq.executeUpdate();
	}
	
	private int insertPointLog(Connection conn, UserInformationVO mvo, int code, int point) {
		
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		pq.setPrepared( conn, VbyP.getSQL("insertPointLog") );
		pq.setString(1, mvo.getUser_id());
		pq.setInt(2, point);
		pq.setString(3, SLibrary.addTwoSizeNumber(code));
		pq.setString(4, pointMemoFactory(code, point));
		pq.setString(5, SLibrary.getDateTimeString("yyyy-MM-dd HH:mm:ss") );
		pq.setInt(6, SLibrary.intValue(mvo.getPoint()));
		pq.setInt(7, SLibrary.intValue(mvo.getPoint())+point);
		
		return pq.executeUpdate();
	}
	
	
	private int insertPointLogBilling(Connection conn, UserInformationVO mvo, int code, int point, int point_lms, int point_mms) {
		
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		pq.setPrepared( conn, VbyP.getSQL("insertPointLogBilling") );
		pq.setString(1, mvo.getUser_id());
		pq.setInt(2, point);
		pq.setInt(3, point_lms);
		pq.setInt(4, point_mms);
		pq.setString(5, SLibrary.addTwoSizeNumber(code));
		pq.setString(6, pointMemoFactory(code, point));
		pq.setString(7, SLibrary.getDateTimeString("yyyy-MM-dd HH:mm:ss") );
		pq.setInt(8, SLibrary.intValue(mvo.getPoint()));
		pq.setInt(9, SLibrary.intValue(mvo.getPoint())+point);
		
		return pq.executeUpdate();
	}
	
	private int insertPoint(Connection conn, String user_id, int code, int point, String memo) {
		
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		pq.setPrepared( conn, VbyP.getSQL("insertPoint") );
		pq.setInt(1, point);
		pq.setString(2, SLibrary.getDateTimeString("yyyy-MM-dd HH:mm:ss") );
		pq.setString(3, user_id);
		return pq.executeUpdate();
	}
	
	private int insertPointLog(Connection conn, String user_id, int code, int point, String pay_type, String memo) {
		
		createPointLogTable(conn);
		
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		pq.setPrepared( conn, SLibrary.messageFormat( VbyP.getSQL("insertPointLog"), new Object[]{SLibrary.getDateTimeString("yyyyMM")}) );
		pq.setString(1, user_id);
		pq.setString(2, pay_type);
		pq.setString(3, SLibrary.addTwoSizeNumber(code));
		pq.setString(4, memo);
		pq.setInt(5, point);
		pq.setInt(6, Integer.parseInt( SLibrary.getUnixtimeStringSecond() ) );
		
		return pq.executeUpdate();
	}
	
	private void createPointLogTable(Connection conn) {
		
		String logTable = "point_log_"+SLibrary.getDateTimeString("yyyyMM");
		PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
		pq.setPrepared( conn, VbyP.getSQL("isPointLogTable") );
		pq.setString(1, logTable);
		
		if ( pq.ExecuteQueryString() == null ) {
			
			pq.setPrepared( conn, SLibrary.messageFormat( VbyP.getSQL("createPointLogTable"), new Object[]{logTable}) );
			int rslt = pq.executeUpdate();
			
			if (rslt == 1)
				VbyP.accessLog("create Table ....."+logTable);
		}
	}
	
	private String pointMemoFactory(int code, int point) {
		
		return VbyP.getValue("point_code_"+SLibrary.addTwoSizeNumber(code) ) + SLibrary.fmtBy.format( point/DEFULT_POINT ) ;
	}
}
