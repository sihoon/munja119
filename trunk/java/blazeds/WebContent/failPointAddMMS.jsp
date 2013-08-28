<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.m.member.UserInformationVO"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.common.VbyP"%>
<%@page import="com.common.db.PreparedExecuteQueryManager"%>
<%@page import="com.common.util.SLibrary"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.m.common.PointManager"%>
<%
	System.out.println(request.getHeader("referer"));
	System.out.println(request.getRemoteAddr());

	
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
		out.println("Accept: "+request.getRemoteAddr());
		
		if (!request.getRemoteAddr().equals("1.226.84.99")) throw new Exception("no url");
		
		out.println(SLibrary.getDateTimeString());
		workDay = SLibrary.diffOfDay(-2, "yyyy-MM-dd");
		out.println("WordDay : " +workDay);
		connSMS = VbyP.getDB("sms1");
		sql.append("SELECT ID, COUNT(*) as CNT FROM MMS_LOG WHERE REQDATE like ? AND FILE_CNT > 0 AND RSLT != '1000'  GROUP BY ID");
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
				mvo.setUser_id(SLibrary.IfNull(hm, "ID"));
				mvo.setPoint( Integer.toString( pm.getUserPoint( conn,  mvo.getUser_id() ) ));
				pm.insertUserPoint(conn, mvo, 47, SLibrary.intValue( SLibrary.IfNull(hm, "CNT") ) * PointManager.DEFULT_POINT*15);
				out.println(mvo.getUser_id()+"  "+ SLibrary.IfNull(hm, "CNT"));
			}
		}
		
	}catch(Exception e){
		out.println(e);
	}finally{
		
		if (connSMS != null) {
			try{connSMS.close();}catch(Exception e){}
		}
		
		if (conn != null) {
			try{conn.close();}catch(Exception e){}
		}
	}
	
%>