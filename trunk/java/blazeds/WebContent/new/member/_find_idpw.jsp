<%@page import="com.m.common.PointManager"%>
<%@page import="com.m.member.JoinVO"%>
<%@page import="com.m.member.Join"%>
<%@page import="com.common.util.SLibrary"%>
<%@ page import="com.common.VbyP" %>
<%@ page import="java.sql.Connection" %>
<%@page import="com.m.common.AdminSMS"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %><%
	
//	String user_id = VbyP.getPOST(request.getParameter("join_id"));
// 	String id_ok = VbyP.getPOST(request.getParameter("id_ok"));
// 	String passwd1 = VbyP.getPOST(request.getParameter("passwd1"));
// 	String passwd2 = VbyP.getPOST(request.getParameter("passwd2"));
// 	String jumin1 = VbyP.getPOST(request.getParameter("jumin1"));
// 	String jumin2 = VbyP.getPOST(request.getParameter("jumin2"));

	String jumin1 = "######";
	String jumin2 = "#######";

// 	String user_name = VbyP.getPOST(request.getParameter("name"));
	String hp = VbyP.getPOST(request.getParameter("hp"));
//	String email = VbyP.getPOST(request.getParameter("email"));
	String idpw_gubun = VbyP.getPOST(request.getParameter("idpw_gubun"));
	
	VbyP.accessLog("아이디찾기 요청 완료>> " + request.getRemoteAddr() +" "+hp );

	try {
		Join join = new Join();
		
//		if ( SLibrary.isNull(user_name)) throw new Exception("이름이 없습니다.");
//		if ( SLibrary.isNull(email)) throw new Exception("이메일 주소가 없습니다.");
		if ( SLibrary.isNull(hp) ) throw new Exception("휴대폰번호가 없습니다.");
		
		JoinVO vo = new JoinVO();
//		vo.setName(user_name);
		vo.setHp(hp);
//		vo.setEmail(email);
		String rslt = "";

		//id찾기, pw찾기 분기
		if(idpw_gubun.equals("id")){
			rslt = join.getFindId(vo);
		}else if(idpw_gubun.equals("pw")){
			rslt = join.getFindPw(vo);
		}
		
		if (rslt.length() < 1) {
			out.println(SLibrary.alertScript("조회에 실패 하였습니다.", ""));
		}else {
			out.println(SLibrary.alertScript("회원님의 아이디/패스워드는 "+ rslt +" 입니다.\\r\\n\\r\\n로그인 후 사용하시기 바랍니다.", "parent.window.location.href='../';"));
					

			/*
			AdminSMS asms = AdminSMS.getInstance();
			
			Connection conn = null;
			conn = VbyP.getDB();
			
			String userMessage = "";
			
			//메세지 분기
			if(idpw_gubun.equals("id")){
				userMessage = "[munjazone]\r\n"
				+ "회원님의 아이디는 [" + rslt + "] 입니다.\r\n"
				+ "www.munjazone.com";
			}else if(idpw_gubun.equals("pw")){
				userMessage = "[munjazone]\r\n"
				+ "회원님의 패스워드는 [" + rslt + "] 입니다.\r\n"
				+ "www.munjazone.com";
			}
			
			if (!SLibrary.isNull( vo.getHp() )) {
				VbyP.accessLog(" >> 아이디/패스워드 찾기 문자 발송("+vo.getHp()+") : "+ userMessage);
				asms.sendAdmin(conn, userMessage , hp , "07077210002");
			}*/
		}
		
	} catch (Exception e) {
		VbyP.errorLog("member/_join.jsp ==> " + e.toString());
		out.println(SLibrary.alertScript(e.getMessage(), ""));
		System.out.println(e.toString());
	} finally {}
	
%>
