<%@page import="com.common.util.SLibrary"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%
	String strContent = SLibrary.IfNull(request.getParameter("content"));
	String session_id = SLibrary.IfNull((String)session.getAttribute("user_id"));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7"/>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="Content-Script-Type" content="text/javascript" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>문자119 :: High Performance, Low Price  </title>
    <link type="text/css" rel="stylesheet" href="css/base.css?ver=1.0"/>
    <link type="text/css" rel="stylesheet" href="css/main.css?ver=1.2"/>
	<script type="text/javascript"  language="javascript" src="js/jquery-1.7.1.min.js?ver=1.0"></script>
	<script type="text/javascript"  language="javascript" src="js/common.js?ver=1.0"></script>
    
</head>

<body>
<iframe src="" id="nobody" name="nobody" frameborder="0" width="0" height="0" style="display:none"></iframe>
<div id="wrapper">
<div class="context">
	
    <div id="topSub"><!--top-sub-->
        <%if (SLibrary.isNull(session_id)) { %><a href="">로그인</a><%}else {%><a href="member/_logout.jsp">로그아웃</a><%} %> | 
        <%if (SLibrary.isNull(session_id)) { %><a href="?content=join">회원가입</a><%}else {%><a href="?content=modify">정보수정</a><%} %> | 
        <a href="?content=my">마이119</a> | 
        <img src="images/add.gif" style="cursor:pointer" onclick="_addFavorite('문자119','http://www.munja119.com')" />
    </div>

    <h1 id="logo" class="ti" onclick="window.location.href='?'" style="cursor:pointer">MUNJA119</h1>

    <div id="menu"><!--메뉴-->
        <a href="?content=normal" class="sms ti <%=(strContent.equals("normal"))?"over":""%>"  onfocus="this.blur();">단문문자보내기</a>
        <a href="?content=lms" class="lms ti <%=(strContent.equals("lms"))?"over":""%>" onfocus="this.blur();">장문문자보내기</a>
        <a href="?content=mms" class="mms ti <%=(strContent.equals("mms"))?"over":""%>" onfocus="this.blur();">포토(MMS)문자보내기</a>
        <a href="?content=billing" class="billing ti <%=(strContent.equals("billing"))?"over":""%>" onfocus="this.blur();">충전하기</a>
        <a href="?content=sent" class="sent ti <%=(strContent.equals("sent"))?"over":""%>" onfocus="this.blur();">전송내역</a>
        <a href="?content=excel" class="excel ti <%=(strContent.equals("excel"))?"over":""%>" onfocus="this.blur();">EXCEL/대량전송</a>
        <a href="?content=address" class="address ti <%=(strContent.equals("address"))?"over":""%>" onfocus="this.blur();">주소록관리</a>
    </div>
    
	<jsp:include page="body.jsp" flush="false"/>
	
	<div id="copyright">
	    <a href="?content=company" class="company">회사소개</a>
	    <a href="javascript:" onclick="openWindow('member/personal.html','p',715, 466)" class="personal">개인정보보호정책</a>
	    <a href="javascript:" onclick="openWindow('member/promise.html','p',715, 466)" class="use">이용약관</a>
	    <a href="javascript:" onclick="openWindow('member/spam.html','p',715, 466)" class="spam">광고스팸문자</a>
	    <div class="link">
	        <a href="" class="homeLink">HOME</a>
	        <a href="" class="topLink">Top</a>
	    </div>
	    <div class="copyRight">copy right</div>
	
	    <select class="family">
			<option>::::패밀리싸이트::::</option>
			<option>NS이스토어</option>
			<option>QXL</option>
		</select>
	</div>
    
</div>
<div id="sideBanner">배너</div>
</div>

<script type="text/javascript">
$(function() {
	$(window).scroll(function() {
		_top = $(document).scrollTop();
		setTimeout(function() {
			$('#sideBanner').stop().animate({ top: _top }, 5);
		}, 5);
	});
});
</script>
</body>
</html>