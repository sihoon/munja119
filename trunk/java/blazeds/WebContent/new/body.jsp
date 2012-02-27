<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.common.util.SLibrary"%>

<%  
	String strContent = SLibrary.IfNull(request.getParameter("content"));
	String strMode = SLibrary.IfNull(request.getParameter("mode"));
	String includeURL = "main/main.jsp";
	
	String session_id = SLibrary.IfNull((String)session.getAttribute("user_id"));
	 
	if ( SLibrary.isNull(strContent) )  includeURL = "main/main.jsp";
	else {
		if ( strContent.equals("send") ) 			includeURL = "send/send.jsp";
		else if ( strContent.equals("sent") ) 		includeURL = "sent/sent.jsp";
	}
%>

<jsp:include page="<%=includeURL%>" flush="false" />
