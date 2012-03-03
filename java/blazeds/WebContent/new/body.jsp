<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.common.util.SLibrary"%>

<%  
	String strContent = SLibrary.IfNull(request.getParameter("content"));
	String strMode = SLibrary.IfNull(request.getParameter("mode"));
	String includeURL = "main/main.jsp";
	
	String session_id = SLibrary.IfNull((String)session.getAttribute("user_id"));
	 
	if ( SLibrary.isNull(strContent) )  includeURL = "main/main.jsp";
	else {
		if ( strContent.equals("join") ) 			includeURL = "member/join.jsp";
		else if ( strContent.equals("join2") ) 		includeURL = "member/join2.jsp";
		else if ( strContent.equals("join3") ) 		includeURL = "member/join3.jsp";
		else if ( strContent.equals("normal") ) 		includeURL = "normal/normal.jsp";
		else if ( strContent.equals("photo") ) 		includeURL = "photo/photo.jsp";
		else if ( strContent.equals("billing") ) 		includeURL = "billing/billing.jsp";
		else if ( strContent.equals("sent") ) 		includeURL = "sent/sent.jsp";
		else if ( strContent.equals("excel") ) 		includeURL = "excel/excel.jsp";
		else if ( strContent.equals("address") ) 		includeURL = "address/address.jsp";
		
		out.println("<div style=\"width:100%;height:26px;background:url('images/topbg.png') 0 0 repeat-x;\"></div>");
	}
%>

<jsp:include page="<%=includeURL%>" flush="false" />
