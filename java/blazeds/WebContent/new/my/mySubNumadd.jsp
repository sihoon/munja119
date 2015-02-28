
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

String sname = VbyP.getPOST(request.getParameter("sname"));
String subphone = VbyP.getPOST(request.getParameter("subphone"));  // join.jsp에서 넘어오는 값들 받기



	try{
	
		PointHistory PH = new PointHistory();
		JoinVO vo = new JoinVO();
		
		vo.setAddid(addid);
		vo.setSname(sname);
		vo.setSubphone(subphone);
		
		VbyP.accessLog("mysubnum.jsp==============???????==== "+vo.getSname() );
		
		int addok = PH.insertsubphone(vo);
		
		if (addok <1){
			out.println(SLibrary.alertScript("등록에 실패 하였습니다.", ""));
		}else{
			out.println(SLibrary.alertScript("추가 인증 전화번호가 등록되었습니다.", ""));
			response.sendRedirect("http://www.munja119.com/new/index.jsp?content=my");
		}
		
	
			
	}catch(Exception ex){
		VbyP.errorLog("mySubNumAdd.jsp ==> " + ex.toString());
		out.println(SLibrary.alertScript(ex.getMessage(), ""));
		System.out.println(ex.toString());
		
		
	} finally{}
	
%>