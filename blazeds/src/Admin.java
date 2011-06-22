import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.common.VbyP;
import com.common.db.PreparedExecuteQueryManager;
import com.common.util.SLibrary;
import com.m.common.BooleanAndDescriptionVO;
import com.m.member.SessionManagement;
import flex.messaging.FlexContext;


public class Admin extends SessionManagement {

	public Admin() {}
	
	/*###############################
	#	Member						#
	###############################*/
	public BooleanAndDescriptionVO login(String user_id, String password) {

		Connection conn = null;
		BooleanAndDescriptionVO rvo = new BooleanAndDescriptionVO();
		
		try {
			
			conn = VbyP.getDB();
			if ( SLibrary.isNull(user_id) ) {
				rvo.setbResult(false);
				rvo.setstrDescription("사용자 아이디를 입력하세요.");
			}else if ( SLibrary.isNull(password) ) {
				rvo.setbResult(false);
				rvo.setstrDescription("비밀번호를 입력하세요.");
			}else {
				rvo = super.loginAdmin(conn, user_id, password);
			}
		}catch (Exception e) {}
		finally {
			
			try {
				if ( conn != null )
					conn.close();
			}catch(SQLException e) {
				VbyP.errorLog("login >> conn.close() Exception!"); 
			}
		}
		
		return rvo;
	}
	public BooleanAndDescriptionVO isLogin() {
		
		BooleanAndDescriptionVO rvo = new BooleanAndDescriptionVO();			
		if (this.bSession()) {
			VbyP.accessLog(getSession()+" >>"+FlexContext.getHttpRequest().getRemoteAddr()+" 로그인 되어있습니다.");
			rvo.setbResult(true);
			
		}
		else {
			rvo.setbResult(false);
			
		}
		
		return rvo;
	}
	
	public List<HashMap<String, String>> getMember() {

		
		Connection conn = null;
		ArrayList<HashMap<String, String>> al = new ArrayList<HashMap<String, String>>();
		VbyP.accessLog(getSession()+" >> 회원 요청");
		
		if (isLogin().getbResult()) {		
		
			try {
				
				conn = VbyP.getDB();
				
				
				if (getSession() != null && !getSession().equals("")) {
					
					
					StringBuffer buf = new StringBuffer();

					buf.append( VbyP.getSQL("memberList") );
							
					PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
					pq.setPrepared( conn, buf.toString() );
					
					
					al = pq.ExecuteQueryArrayList();
					
					
					return al;
				}
			}catch (Exception e) {}	finally {			
				try { if ( conn != null ) conn.close();
				}catch(SQLException e) { VbyP.errorLog("getMember >> conn.close() Exception!"); }
			}
		}
		
		return al;
	}
	
	public List<HashMap<String, String>> getPoint() {

		
		Connection conn = null;
		ArrayList<HashMap<String, String>> al = new ArrayList<HashMap<String, String>>();
		VbyP.accessLog(getSession()+" >> 포인트 요청");
		
		if (isLogin().getbResult()) {		
		
			try {
				
				conn = VbyP.getDB();
				
				
				if (getSession() != null && !getSession().equals("")) {
					
					
					StringBuffer buf = new StringBuffer();

					buf.append( VbyP.getSQL("pointList") );
							
					PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
					pq.setPrepared( conn, buf.toString() );
					
					
					al = pq.ExecuteQueryArrayList();
					
					
					return al;
				}
			}catch (Exception e) {}	finally {			
				try { if ( conn != null ) conn.close();
				}catch(SQLException e) { VbyP.errorLog("getMember >> conn.close() Exception!"); }
			}
		}
		
		return al;
	}
	public List<HashMap<String, String>> getPointLog() {

		
		Connection conn = null;
		ArrayList<HashMap<String, String>> al = new ArrayList<HashMap<String, String>>();
		VbyP.accessLog(getSession()+" >> 포인트로그 요청");
		
		if (isLogin().getbResult()) {		
		
			try {
				
				conn = VbyP.getDB();
				
				
				if (getSession() != null && !getSession().equals("")) {
					
					
					StringBuffer buf = new StringBuffer();

					buf.append( VbyP.getSQL("pointLogList") );
							
					PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
					pq.setPrepared( conn, buf.toString() );
					
					
					al = pq.ExecuteQueryArrayList();
					
					
					return al;
				}
			}catch (Exception e) {}	finally {			
				try { if ( conn != null ) conn.close();
				}catch(SQLException e) { VbyP.errorLog("getMember >> conn.close() Exception!"); }
			}
		}
		
		return al;
	}
	public List<HashMap<String, String>> getSentLog() {

		
		Connection conn = null;
		ArrayList<HashMap<String, String>> al = new ArrayList<HashMap<String, String>>();
		VbyP.accessLog(getSession()+" >> 포인트로그 요청");
		
		if (isLogin().getbResult()) {		
		
			try {
				
				conn = VbyP.getDB();
				
				
				if (getSession() != null && !getSession().equals("")) {
					
					
					StringBuffer buf = new StringBuffer();

					buf.append( VbyP.getSQL("pointLogList") );
							
					PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
					pq.setPrepared( conn, buf.toString() );
					
					
					al = pq.ExecuteQueryArrayList();
					
					
					return al;
				}
			}catch (Exception e) {}	finally {			
				try { if ( conn != null ) conn.close();
				}catch(SQLException e) { VbyP.errorLog("getMember >> conn.close() Exception!"); }
			}
		}
		
		return al;
	}
	
	public List<HashMap<String, String>> getSentGroupList( String fromDate, String endDate, boolean bReservation) {

		
		Connection conn = null;
		ArrayList<HashMap<String, String>> al = new ArrayList<HashMap<String, String>>();
		
		if (isLogin().getbResult()) {		
		
			try {
				
				conn = VbyP.getDB();
				String user_id = getSession();
				VbyP.accessLog(user_id+" >> 전송내역 그룹 요청 :"+fromDate+"~"+endDate+","+bReservation);
				
				if (user_id != null && !user_id.equals("")) {
					
					
					StringBuffer buf = new StringBuffer();
					buf.append( (!bReservation)?VbyP.getSQL("adminSelectSentLog"):VbyP.getSQL("adminSelectSentLogRes") );
							
					PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
					pq.setPrepared( conn, buf.toString() );
					pq.setString(1, fromDate+" 00:00:00");
					pq.setString(2, endDate+" 23:59:59");
					
					
					al = pq.ExecuteQueryArrayList();

				}
			}catch (Exception e) {}	finally {			
				try { if ( conn != null ) conn.close();
				}catch(SQLException e) { VbyP.errorLog("getSentGroupList >> conn.close() Exception!"); }
			}
		}
		
		return al;
	}
	
	public List<HashMap<String, String>> getSentList( String user_id, int groupIndex, String line) {

		
		Connection connSMS = null;
		ArrayList<HashMap<String, String>> al = new ArrayList<HashMap<String, String>>();
		
		if (isLogin().getbResult()) {		
		
			try {
				
				connSMS = VbyP.getDB(line);
				VbyP.accessLog(getSession()+" >> "+line+" 전송내역 요청 :"+ Integer.toString(groupIndex));
				
				if (user_id != null && !user_id.equals("")) {
							
					PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
					pq.setPrepared( connSMS, VbyP.getSQL("selectSentData") );
					pq.setString(1, user_id);
					pq.setString(2, Integer.toString(groupIndex));
					pq.setString(3, user_id);
					pq.setString(4, Integer.toString(groupIndex));
					
					
					al = pq.ExecuteQueryArrayList();

				}
			}catch (Exception e) {}	finally {			
				try { if ( connSMS != null ) connSMS.close();
				}catch(SQLException e) { VbyP.errorLog("getSentList >> conn.close() Exception!"); }
			}
		}
		
		return al;
	}
}
