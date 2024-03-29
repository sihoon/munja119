<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.common.util.SLibrary"%>

<%  
	String strContent = SLibrary.IfNull(request.getParameter("content"));
	String strMode = SLibrary.IfNull(request.getParameter("mode"));
	String includeURL = "main/main.jsp";
	
	String session_id = SLibrary.IfNull((String)session.getAttribute("user_id"));

	//추가인증 여부 체크 - 2014.12.14
	String session_certOK = SLibrary.IfNull((String)session.getAttribute("certOK"));
	//System.out.println("session_id:"+session_id+",session_certOK:"+session_certOK);
		
	if( (!(SLibrary.isNull(session_id)) && SLibrary.isNull(session_certOK)) ){
		if(strContent.equals("cert2")){
			includeURL = "member/cert2.jsp";
		}else{
			//user_id 세션 삭제
			session.removeAttribute("user_id");
			session.removeAttribute("certOK");
		}
	}
	
	if ( SLibrary.isNull(strContent) )  includeURL = "main/main.jsp";
	else {
		if ( strContent.equals("join") ) 			includeURL = "member/join.jsp";
		else if ( strContent.equals("join2") ) 		includeURL = "member/join2.jsp";
		else if ( strContent.equals("join3") ) 		includeURL = "member/join3.jsp";
		else if ( strContent.equals("normal") ) 		includeURL = "normal/normal.jsp";
		else if ( strContent.equals("lms") ) 		includeURL = "lms/lms.jsp";
		else if ( strContent.equals("mms") ) 		includeURL = "mms/mms.jsp";
		else if ( strContent.equals("billing") ) 		includeURL = "billing/billing.jsp";
		else if ( strContent.equals("sent") ) 		includeURL = "sent/sent.jsp";
		else if ( strContent.equals("excel") ) 		includeURL = "excel/excel.jsp";
		else if ( strContent.equals("address") ) 		includeURL = "address/address.jsp";
		else if ( strContent.equals("company") ) 		includeURL = "company/company.jsp";
		else if ( strContent.equals("my") ) 		includeURL = "my/my.jsp";
		else if ( strContent.equals("notic") ) 		includeURL = "custom/notic.jsp";
		else if ( strContent.equals("modify") ) 		includeURL = "member/modify.jsp";
		else if ( strContent.equals("qna") ) 		includeURL = "custom/qna.jsp";
		else if ( strContent.equals("faq") ) 		includeURL = "custom/faq.jsp";
		else if ( strContent.equals("foreign") ) 		includeURL = "foreign/foreign.jsp";
		
		out.println("<div style=\"width:100%;height:26px;background:url('images/topbg.png') 0 0 repeat-x;\"></div>");
	}
%>

<jsp:include page="<%=includeURL%>" flush="false" />
