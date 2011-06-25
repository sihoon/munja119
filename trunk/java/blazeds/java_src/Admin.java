import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.common.VbyP;
import com.common.db.PreparedExecuteQueryManager;
import com.common.util.SLibrary;
import com.m.billing.BillingVO;
import com.m.common.BooleanAndDescriptionVO;
import com.m.common.PointManager;
import com.m.member.MemberVO;
import com.m.member.SessionManagement;
import com.m.member.UserInformationVO;

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
				rvo.setstrDescription("아이디가 없습니다.");
			}else if ( SLibrary.isNull(password) ) {
				rvo.setbResult(false);
				rvo.setstrDescription("비밀번호가 없습니다.");
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
		if (this.bAdminSession()) {
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
		VbyP.accessLog(getAdminSession()+" >> 회원리스트 요청");
		
		if (isLogin().getbResult()) {		
		
			try {
				
				conn = VbyP.getDB();
				
				
				if (getAdminSession() != null && !getAdminSession().equals("")) {
					
					
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
	
	public int updateMember(MemberVO mvo) {
		
		Connection conn = null;
		VbyP.accessLog(getAdminSession()+" >> 회원수정 요청"+mvo.getUser_id());
		int rslt = 0;
		
		if (isLogin().getbResult()) {		
		
			try {
				
				conn = VbyP.getDB();
				StringBuffer buf = new StringBuffer();
				buf.append(VbyP.getSQL("adminMemberUpdateLog"));
				PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
				pq.setPrepared( conn, buf.toString() );
				pq.setInt(1, mvo.getIdx());
				pq.setString(2, mvo.getUser_id());
				pq.executeUpdate();
				
				buf.setLength(0);
				buf.append( VbyP.getSQL("adminMemberUpdate") );
				pq.setPrepared( conn, buf.toString() );
				pq.setString(1, mvo.getUser_name());
				pq.setString(2, mvo.getJumin_no());
				pq.setString(3, mvo.getEmail());
				pq.setString(4, mvo.getPhone_return());
				pq.setString(5, mvo.getHp());
				pq.setString(6, mvo.getUnit_cost());
				pq.setString(7, mvo.getLine());
				pq.setString(8, mvo.getMemo());
				pq.setString(9, mvo.getTimeLogin());
				pq.setString(10, mvo.getTimeJoin());
				pq.setString(11, mvo.getLeaveYN());
				pq.setInt(12, mvo.getIdx());
				pq.setString(13, mvo.getUser_id());
				
				rslt = pq.executeUpdate();
					
			}catch (Exception e) {}	finally {			
				try { if ( conn != null ) conn.close();
				}catch(SQLException e) { VbyP.errorLog("getMember >> conn.close() Exception!"); }
			}
		}
		
		return rslt;
	}
	
	public int updateMemberPasswd(String user_id) {
		
		Connection conn = null;
		VbyP.accessLog(getAdminSession()+" >> 비밀번호 초기화 요청"+user_id);
		int rslt = 0;
		
		if (isLogin().getbResult()) {		
		
			try {
				
				conn = VbyP.getDB();
				StringBuffer buf = new StringBuffer();
				buf.append(VbyP.getSQL("adminMemberInitPasswd"));
				PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
				pq.setPrepared( conn, buf.toString() );
				pq.setString(1, VbyP.getValue("initPassword"));
				pq.setString(2, user_id);
				rslt = pq.executeUpdate();
				
				
					
			}catch (Exception e) {}	finally {			
				try { if ( conn != null ) conn.close();
				}catch(SQLException e) { VbyP.errorLog("updateMemberPasswd >> conn.close() Exception!"); }
			}
		}
		
		return rslt;
	}
	
	public List<HashMap<String, String>> getPoint() {

		
		Connection conn = null;
		ArrayList<HashMap<String, String>> al = new ArrayList<HashMap<String, String>>();
		VbyP.accessLog(getAdminSession()+" >> 포인트 리스트 요청");
		
		if (isLogin().getbResult()) {		
		
			try {
				conn = VbyP.getDB();
				if (getAdminSession() != null && !getAdminSession().equals("")) {
					
					
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
	
	public int setPoint(String user_id, int point) {
		
		Connection conn = null;
		VbyP.accessLog(getAdminSession()+" >> 포인트 수정 요청");
		
		SessionManagement sm = new SessionManagement();
		UserInformationVO mvo = null;
		
		int rslt = 0;
		
		if (isLogin().getbResult()) {		
			
			try {
				conn = VbyP.getDB();
				mvo = sm.getUserInformation(conn, user_id);
				
				PointManager pm = PointManager.getInstance();		
				rslt = pm.insertUserPoint(conn, mvo, 90, point * PointManager.DEFULT_POINT);
			}catch (Exception e) {}	finally {			
				try { if ( conn != null ) conn.close();
				}catch(SQLException e) { VbyP.errorLog("getMember >> conn.close() Exception!"); }
			}
		}
		return rslt;
	}
	
	public List<HashMap<String, String>> getPointLog() {

		
		Connection conn = null;
		ArrayList<HashMap<String, String>> al = new ArrayList<HashMap<String, String>>();
		VbyP.accessLog(getAdminSession()+" >> 포인트 로그 요청");
		
		if (isLogin().getbResult()) {		
		
			try {
				
				conn = VbyP.getDB();
				
				
				if (getAdminSession() != null && !getAdminSession().equals("")) {
					
					
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
		VbyP.accessLog(getAdminSession()+" >> 전송내역요청");
		
		if (isLogin().getbResult()) {		
		
			try {
				
				conn = VbyP.getDB();
				
				
				if (getAdminSession() != null && !getAdminSession().equals("")) {
					
					
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
				String user_id = getAdminSession();
				VbyP.accessLog(user_id+" >> 전송내역:"+fromDate+"~"+endDate+","+bReservation);
				
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
				VbyP.accessLog(getAdminSession()+" >> "+line+" 전송내역 상세보기:"+ Integer.toString(groupIndex));
				
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
	
	//Billing
	public List<HashMap<String, String>> getBilling() {

		
		Connection conn = null;
		ArrayList<HashMap<String, String>> al = new ArrayList<HashMap<String, String>>();
		VbyP.accessLog(getAdminSession()+" >> 결제 리스트 요청");
		
		if (isLogin().getbResult()) {		
		
			try {
				conn = VbyP.getDB();
				if (getAdminSession() != null && !getAdminSession().equals("")) {
					
					
					StringBuffer buf = new StringBuffer();

					buf.append( VbyP.getSQL("adminBillingList") );
							
					PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
					pq.setPrepared( conn, buf.toString() );
					
					
					al = pq.ExecuteQueryArrayList();
					
					
					return al;
				}
			}catch (Exception e) {}	finally {			
				try { if ( conn != null ) conn.close();
				}catch(SQLException e) { VbyP.errorLog("getBilling >> conn.close() Exception!"); }
			}
		}
		
		return al;
	}
	
	public int updateBilling(BillingVO bvo) {
		
		Connection conn = null;
		VbyP.accessLog(getAdminSession()+" >> 결제수정 요청"+bvo.getUser_id());
		int rslt = 0;
		
		if (isLogin().getbResult()) {		
		
			try {
				
				conn = VbyP.getDB();
				StringBuffer buf = new StringBuffer();
				buf.append(VbyP.getSQL("adminBillingUpdate"));

				PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
				pq.setPrepared( conn, buf.toString() );
				pq.setString(1, bvo.getMethod());
				pq.setInt(2, bvo.getAmount());
				pq.setString(3, bvo.getOrder_no());
				pq.setString(4, bvo.getUnit_cost());
				pq.setInt(5, bvo.getRemain_point());
				pq.setString(6, bvo.getMemo());
				pq.setString(7, bvo.getAdmin_id());
				pq.setString(8, bvo.getTimeWrite());
				pq.setInt(9, bvo.getIdx());
				pq.setString(10, bvo.getUser_id());
				
				rslt = pq.executeUpdate();
					
			}catch (Exception e) {}	finally {			
				try { if ( conn != null ) conn.close();
				}catch(SQLException e) { VbyP.errorLog("updateBilling >> conn.close() Exception!"); }
			}
		}
		
		return rslt;
	}
	public int deleteBilling(int idx) {
		
		Connection conn = null;
		VbyP.accessLog(getAdminSession()+" >> 결제정보 삭제 요청"+Integer.toString(idx));
		int rslt = 0;
		
		if (isLogin().getbResult()) {		
		
			try {
				
				conn = VbyP.getDB();
				StringBuffer buf = new StringBuffer();
				buf.append(VbyP.getSQL("adminBillingDelete"));
				PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
				pq.setPrepared( conn, buf.toString() );
				pq.setInt(1, idx);
				rslt = pq.executeUpdate();
				
			}catch (Exception e) {}	finally {			
				try { if ( conn != null ) conn.close();
				}catch(SQLException e) { VbyP.errorLog("deleteBilling >> conn.close() Exception!"); }
			}
		}
		
		return rslt;
	}
	
}
