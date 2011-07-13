package com.m;
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
				rvo.setstrDescription("로그인 실패.");
			}else if ( SLibrary.isNull(password) ) {
				rvo.setbResult(false);
				rvo.setstrDescription("로그인 실패.");
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
		VbyP.accessLog(getAdminSession()+" >> 회원 리스트");
		
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
		VbyP.accessLog(getAdminSession()+" >> 회원 수정"+mvo.getUser_id());
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
		VbyP.accessLog(getAdminSession()+" >> 회원 비밀번호 초기화 "+user_id);
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
	
	public int deleteMember(String user_id) {
		
		Connection conn = null;
		VbyP.accessLog(getAdminSession()+" >> 회원 삭제 "+user_id);
		int rslt = 0;
		
		if (isLogin().getbResult()) {		
		
			try {
				
				conn = VbyP.getDB();
				StringBuffer buf = new StringBuffer();
				buf.append(VbyP.getSQL("adminMemberDelete"));
				PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
				pq.setPrepared( conn, buf.toString() );
				pq.setString(1, user_id);
				rslt = pq.executeUpdate();
				
				buf.setLength(0);
				buf.append(VbyP.getSQL("adminPointDelete"));
				pq.setPrepared( conn, buf.toString() );
				pq.setString(1, user_id);
				rslt = pq.executeUpdate();
				
				
					
			}catch (Exception e) {}	finally {			
				try { if ( conn != null ) conn.close();
				}catch(SQLException e) { VbyP.errorLog("deleteMember >> conn.close() Exception!"); }
			}
		}
		
		return rslt;
	}
	
	public List<HashMap<String, String>> getPoint() {

		
		Connection conn = null;
		ArrayList<HashMap<String, String>> al = new ArrayList<HashMap<String, String>>();
		VbyP.accessLog(getAdminSession()+" >> 포인트 리스트");
		
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
		VbyP.accessLog(getAdminSession()+" >> 포인트 설정");
		
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
		VbyP.accessLog(getAdminSession()+" >> 로인트 로그 리스트");
		
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
		VbyP.accessLog(getAdminSession()+" >> 전송내역");
		
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
				VbyP.accessLog(user_id+" >> 상세내역:"+fromDate+"~"+endDate+","+bReservation);
				
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
				VbyP.accessLog(getAdminSession()+" >> "+line+" 전송내역:"+ Integer.toString(groupIndex));
				
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
		VbyP.accessLog(getAdminSession()+" >> 결제내역");
		
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
		VbyP.accessLog(getAdminSession()+" >> 결제 수정"+bvo.getUser_id());
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
		VbyP.accessLog(getAdminSession()+" >> 결제 삭제"+Integer.toString(idx));
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
	
	public List<HashMap<String, String>> getCashList() {

		Connection conn = null;
		ArrayList<HashMap<String, String>> al = new ArrayList<HashMap<String, String>>();
		VbyP.accessLog(getAdminSession()+" >> 무통장입금 예약");
		
		if (isLogin().getbResult()) {		
		
			try {
				conn = VbyP.getDB();
				if (getAdminSession() != null && !getAdminSession().equals("")) {
					
					
					StringBuffer buf = new StringBuffer();

					buf.append( VbyP.getSQL("adminCashList") );
							
					PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
					pq.setPrepared( conn, buf.toString() );
					
					
					al = pq.ExecuteQueryArrayList();
					
					
					return al;
				}
			}catch (Exception e) {}	finally {			
				try { if ( conn != null ) conn.close();
				}catch(SQLException e) { VbyP.errorLog("getCashList >> conn.close() Exception!"); }
			}
		}
		
		return al;
	}
	
	public int deleteCash(int idx) {
		
		Connection conn = null;
		VbyP.accessLog(getAdminSession()+" >> 무통장 예약 삭제"+Integer.toString(idx));
		int rslt = 0;
		
		if (isLogin().getbResult()) {		
		
			try {
				
				conn = VbyP.getDB();
				StringBuffer buf = new StringBuffer();
				buf.append(VbyP.getSQL("adminCashDelete"));
				PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
				pq.setPrepared( conn, buf.toString() );
				pq.setInt(1, idx);
				rslt = pq.executeUpdate();
				
			}catch (Exception e) {}	finally {			
				try { if ( conn != null ) conn.close();
				}catch(SQLException e) { VbyP.errorLog("deleteCash >> conn.close() Exception!"); }
			}
		}
		
		return rslt;
	}
	
	
	public String[] getEmoti(int page, String category) {
		

		Connection conn = null;
		ArrayList<HashMap<String, String>> al = null;
		String [] arr = null;
		
		int alCount = 0;
		
		int count = 20;
		int from = 0;
		
		try {
			
			conn = VbyP.getDB();
			
			if (page == 0) page = 1;
			from = count * (page -1);
			
			VbyP.accessLog(" >>  관리자 이모티콘 요청("+category+") "+Integer.toString(from));
			
			StringBuffer buf = new StringBuffer();
			buf.append(VbyP.getSQL("adminEmoticon"));
			PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
			pq.setPrepared( conn, buf.toString() );
			pq.setString(1, category);
			pq.setInt(2, from);
			pq.setInt(3, count);
			
			al = pq.ExecuteQueryArrayList();
			alCount = al.size();
			HashMap<String, String> hm = null;
			arr = new String[alCount];
			
			for (int i = 0; i < alCount; i++) {
				hm = al.get(i);
				arr[i] = SLibrary.padL(hm.get("idx"),7, "0")+hm.get("msg");
			}
			
			
		}catch (Exception e) {}	finally {			
			try { if ( conn != null ) conn.close();
			}catch(SQLException e) { VbyP.errorLog("getEmoti >> conn.close() Exception!"); }
		}
		
		return arr;
	}
	
	
	public void updateEmoti(int idx, String msg) {
		
		Connection conn = null;
		VbyP.accessLog(getAdminSession()+" >> 이모티콘 업데이트 "+Integer.toString(idx));
		
		if (isLogin().getbResult()) {		
		
			try {
				
				conn = VbyP.getDB();
				StringBuffer buf = new StringBuffer();
				buf.append(VbyP.getSQL("adminEmoticonUpdate"));
				PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
				pq.setPrepared( conn, buf.toString() );
				pq.setString(1, msg);
				pq.setInt(2, idx);
				pq.executeUpdate();
				
			}catch (Exception e) {}	finally {			
				try { if ( conn != null ) conn.close();
				}catch(SQLException e) { VbyP.errorLog("updateEmoti >> conn.close() Exception!"); }
			}
		}
		
	}
	
	public void deleteEmoti(int idx) {
		
		Connection conn = null;
		VbyP.accessLog(getAdminSession()+" >> 이모티콘 삭제 "+Integer.toString(idx));
		
		if (isLogin().getbResult()) {		
		
			try {
				
				conn = VbyP.getDB();
				StringBuffer buf = new StringBuffer();
				buf.append(VbyP.getSQL("adminEmoticonDelete"));
				PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
				pq.setPrepared( conn, buf.toString() );
				pq.setInt(1, idx);
				pq.executeUpdate();
				
			}catch (Exception e) {}	finally {			
				try { if ( conn != null ) conn.close();
				}catch(SQLException e) { VbyP.errorLog("deleteEmoti >> conn.close() Exception!"); }
			}
		}
		
	}
	
	public void addEmoti(String cate, String msg) {
		
		Connection conn = null;
		VbyP.accessLog(getAdminSession()+" >> 이모티콘 추가 "+cate+" "+msg);
		
		if (isLogin().getbResult()) {		
		
			try {
				
				conn = VbyP.getDB();
				StringBuffer buf = new StringBuffer();
				buf.append(VbyP.getSQL("adminEmoticonInsert"));
				PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
				pq.setPrepared( conn, buf.toString() );
				pq.setString(1, cate);
				pq.setString(2, msg);
				pq.executeUpdate();
				
			}catch (Exception e) {}	finally {			
				try { if ( conn != null ) conn.close();
				}catch(SQLException e) { VbyP.errorLog("addEmoti >> conn.close() Exception!"); }
			}
		}
		
	}
}
