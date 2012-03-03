<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7"/>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="Content-Script-Type" content="text/javascript" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title> new 119 </title>
    <link type="text/css" rel="stylesheet" href="css/base.css?ver=1.0"/>
    <link type="text/css" rel="stylesheet" href="css/main.css?ver=1.2"/>

    
</head>

<body>

<div class="context">
	
    <div id="topSub"><!--top-sub-->
        <a href="">로그인</a> | <a href="?content=join">회원가입</a> | <a href="">마이119</a> | <a href="">고객센터</a> | <img src="images/add.gif" />
    </div>

    <h1 id="logo" class="ti" onclick="window.location.href='?'" style="cursor:pointer">MUNJA119</h1>

    <div id="menu"><!--메뉴-->
        <a href="?content=normal" class="sms ti">일반문자보내기</a>
        <a href="?content=mms" class="lmsmms ti">장문/포토보내기</a>
        <a href="?content=billing" class="billing ti">충전하기</a>
        <a href="?content=sent" class="sent ti">전송내역</a>
        <a href="?content=excel" class="excel ti">EXCEL/대량전송</a>
        <a href="?content=address" class="address ti">주소록관리</a>
    </div>
    
	<jsp:include page="body.jsp" flush="false"/>
	
	<div id="copyright">
	    <a href="" class="company">회사소개</a>
	    <a href="" class="personal">개인정보보호정책</a>
	    <a href="" class="use">이용약관</a>
	    <a href="" class="spam">광고스팸문자</a>
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
</body>
</html>
