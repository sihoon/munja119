<%@page import="com.m.member.UserInformationVO"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.common.VbyP"%>
<%@page import="com.common.db.PreparedExecuteQueryManager"%>
<%@page import="com.common.util.SLibrary"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.m.common.PointManager"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%

	StringBuffer sql = new StringBuffer();
	Connection conn = null;
	Connection connSMS = null;
	String workDay = "";
	PreparedExecuteQueryManager pq = new PreparedExecuteQueryManager();
	ArrayList<HashMap<String, String>> al = null;
	HashMap<String, String> hm = null;
	int count = 0;
	UserInformationVO mvo = null;
	
	String pointSql = "";
	
	try {
		workDay = SLibrary.diffOfDay(-2, "yyyy-MM-dd");
		connSMS = VbyP.getDB("sms1");
		sql.append("SELECT TR_ETC2, COUNT(*) as CNT FROM SC_LOG WHERE TR_SENDDATE like ? AND TR_RSLTSTAT != '06' GROUP BY TR_ETC2");
		pq.setPrepared(connSMS, sql.toString());
		pq.setString(1, workDay+"%");
		
		al = pq.ExecuteQueryArrayList();
		
		PointManager pm = PointManager.getInstance();	
		
		count = al.size();
		if (count > 0) {
			pointSql = "SELECT POINT FROM POINT WHERE USER_ID=?";
			conn = VbyP.getDB();
			for (int i = 0; i < count; i++) {
				hm = al.get(i);
				mvo = new UserInformationVO();
				mvo.setUser_id(SLibrary.IfNull(hm, "TR_ETC2"));
				mvo.setPoint( Integer.toString( pm.getUserPoint( conn,  mvo.getUser_id() ) ));
				pm.insertUserPoint(conn, mvo, 17, SLibrary.intValue( SLibrary.IfNull(hm, "CNT") ) * PointManager.DEFULT_POINT);
				out.println(mvo.getUser_id()+"  "+ SLibrary.IfNull(hm, "CNT"));
			}
		}
		
	}catch(Exception e){
		System.out.println(e);
	}finally{
		
		if (connSMS != null) {
			try{connSMS.close();}catch(Exception e){}
		}
		
		if (conn != null) {
			try{conn.close();}catch(Exception e){}
		}
	}
	
%>