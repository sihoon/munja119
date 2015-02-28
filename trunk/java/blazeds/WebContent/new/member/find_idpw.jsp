<%@page import="com.common.VbyP"%>
<%@page import="com.common.util.SLibrary"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%

String name = VbyP.getPOST(request.getParameter("name"));
String jumin1 = VbyP.getPOST(request.getParameter("jumin1"));
String jumin2 = VbyP.getPOST(request.getParameter("jumin2"));

try {
// 	if (SLibrary.isNull(name)) throw new Exception("이름이 없습니다.");
// 	if (SLibrary.isNull(jumin1)) throw new Exception("주민등록번호가 없습니다.");
// 	if (SLibrary.isNull(jumin2)) throw new Exception("주민등록번호가 없습니다.");


%>
<form name="form" method="post" target="nobody" action="member/_find_idpw.jsp">
<fieldset id="login"><!-- 로그인 -->
    <legend>로그인</legend>
    <label class="idlabel ti" for="user_id">아이디</label><input type="text" id="user_id" name="user_id" />
    <label class="pwlabel ti" for="user_pw">비밀번호</label><input type="text" id="user_pw" name="user_pw" />
    <button class="loginBtn ti">로그인</button>
    <button class="joinBtn ti">회원가입</button>
    <button class="findBtn ti" onclick="window.location.href='?content=findidpw'">아이디찾기</button>
</fieldset>
<div id="findIdPwBox">
	<p class="findIdPwAd ti">업계최저가격 문자서비스</p>
	<p class="findIdPwTitle ti">정보입력</p>
	<table class="inputTable" cellpadding="0" cellspacing="0" border="0">
		<!-- <tr><td class="t">이름</td><td class="c"><input type="text" name="name" class="txt" value=""/></td></tr> -->
		<!-- <tr><td class="t">핸드폰</td><td class="c"><input type="text" name="hp" class="txt" value=""/></td></tr> -->
		<!-- <tr><td class="t">이메일</td><td class="c"><input type="text" name="email" class="txt" value=""/></td></tr> -->
		<tr>
			<td><input type="button" value="아이디찾기" onclick="window.location.href='?content=findid'"/></td>
			<td><input type="button" value="패스워드찾기" onclick="window.location.href='?content=findpw'"/></td>
		</tr>
	</table>
	<div class="confirmBox">
		<img src="images/btn_member.gif" onclick="check_findidpw()" />&nbsp;&nbsp;&nbsp;
		<img src="images/btn_cancle.gif" onclick="window.location.href='?'" />
	</div>
</div>
</form>
<a id="cost" class="ti" href="">저렴하고 안정적인 문자서비스를 찾으십니까? 단가표 보기</a>
<p id="custom" class="ti">Custom Center : 070-7510-8489, Fax: 031)970-8489</p>
<script type="text/javascript" src="js/member.js"></script>
<%
}catch(Exception e) {
	out.println(SLibrary.alertScript(e.getMessage(), "window.location.href='/';"));
}
%>
