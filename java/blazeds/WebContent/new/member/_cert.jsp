<%@page import="com.m.common.BooleanAndDescriptionVO"%><%@page import="com.common.util.RandomString"%><%@page import="com.m.common.AdminSMS"%><%@page import="java.sql.SQLException"%><%@page import="com.common.db.PreparedExecuteQueryManager"%><%@page import="com.m.member.Join"%><%@page import="com.common.util.SLibrary"%><%@ page import="com.common.VbyP" %><%@ page import="java.sql.Connection" %><%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %><%

	String mode = VbyP.getPOST(request.getParameter("mode"));
	String value = VbyP.getPOST(request.getParameter("value"));
	String certNum = VbyP.getPOST(request.getParameter("certNum"));
	
	System.out.println(mode+"/"+value+"/"+certNum);
	Connection conn = null;
	AdminSMS asms = AdminSMS.getInstance();
	StringBuffer err = new StringBuffer();
	try {
		
		conn = VbyP.getDB();
		if ( SLibrary.isNull(mode) )	throw new Exception("필수 값이 없습니다.(mode)");
		else if ( SLibrary.isNull(value) ) throw new Exception("필수 값이 없습니다.(value)");
		else if ( conn == null ) throw new Exception("DB 연결 실패");
			
		if (mode.equals("send")) {
			
			RandomString rms = new RandomString();
			
			String num = rms.getString(5,"1");
			String message = num+"\n위 인증번호를 입력해 주세요.";
			String phone = value;
			String returnPhoneNumber = "16000816";
			System.out.println(message);
			BooleanAndDescriptionVO bavo = asms.sendAdmin(conn, message, phone, returnPhoneNumber);
			
			
			if (bavo.getbResult() == true) {
				System.out.println(phone+"_cert="+ num);
				session.setAttribute(phone+"_cert", num);
			} else {
				throw new Exception(bavo.getstrDescription());
			}
		} else if (mode.equals("cert")) {
			
			if (SLibrary.isNull(certNum)) throw new Exception("인증번호가 없습니다.");
			
			String sessionNum = session.getAttribute(value+"_cert").toString();
			System.out.println(certNum+"/"+sessionNum);
			if ( !certNum.equals(sessionNum) ) {
				//session.removeAttribute(value+"_cert");
				throw new Exception("잘못된 인증번호 입니다.");
			}
			else {
				session.setAttribute(value+"_cert", "ok");
				session.setAttribute("certOK", "OK");
			}
		} 
		
		
			
///

	}catch (Exception e) {
		//out.println(SLibrary.alertScript(e.getMessage(), ""));
		err.append(e.getMessage());
	}
	finally {
		
		try { if ( conn != null )	conn.close(); }catch(SQLException e) {	VbyP.errorLog("login >> conn.close() Exception!");}		
		conn = null;
		
		StringBuffer buf = new StringBuffer();	
		buf.append("{");
		if (err.length() <= 0) {
			buf.append("\"code\":\"0000\",\"msg\":\"ok\"");	
		} else {
			buf.append("\"code\":\"0001\",\"msg\":\""+err.toString()+"\"");
		}
		buf.append("}");
		
		out.println(buf.toString());
		
	}

	
%>
