<%@page import="javax.tools.JavaFileManager.Location"%>
<%@page import="java.security.MessageDigest"%>
<%@page import="com.m.billing.Billing"%>
<%@page import="com.common.util.Paging"%>
<%@page import="com.m.point.PointHistory"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.m.member.SessionManagement"%>
<%@page import="com.m.member.UserInformationVO"%>

<%@page import="com.m.common.PointManager"%>
<%@page import="com.m.member.JoinVO"%>
<%@page import="com.m.member.Join"%>
<%@page import="com.common.util.SLibrary"%>
<%@ page import="com.common.VbyP" %>
<%@ page import="java.sql.Connection" %>
<%@page import="com.m.common.AdminSMS"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!-- _join.jsp 참고한 페이지 -->


<%
Connection conn = null;


String addid = SLibrary.IfNull((String)session.getAttribute("user_id"));
System.out.println(addid+"===addid");

VbyP.accessLog("sessionID?==============???????==== "+addid ); // 아이디 넘어오는지 로그에서 확인.

String delnum = VbyP.getPOST(request.getParameter("delnum"));

VbyP.accessLog("==============delnum==== "+delnum );

	try{
			conn = VbyP.getDB();
			System.out.println(conn);
			PointHistory PH = PointHistory.getInstance();
			//PointHistory PH = new PointHistory();
			System.out.println(PH);
			PH.deletesubphone(conn, delnum);
		
			response.sendRedirect("http://www.munja119.com/new/index.jsp?content=my");
			
	}catch(Exception ex){
		VbyP.errorLog("mySubNumAdd.jsp ==> " + ex.toString());
		out.println(SLibrary.alertScript(ex.getMessage(), ""));
		System.out.println(ex.toString());
		
		
	} finally{}
	
%>


