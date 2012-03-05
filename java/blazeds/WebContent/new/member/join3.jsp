<%@page import="com.common.util.SLibrary"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%

if(!SLibrary.IfNull( (String)session.getAttribute("munja119JoinStep") ).equals("step1@Session")) {
	session.removeAttribute("munja119JoinStep");
	out.println(SLibrary.alertScript("잘못된 접근 입니다.", "window.location.href='/';"));
	return;
}
request.getSession().setAttribute("munja119JoinStep","step2@Session");
%>
<script type="text/javascript" src="js/member.js"></script>
<fieldset id="login"><!-- 로그인 -->
    <legend>로그인</legend>
    <label class="idlabel ti" for="user_id">아이디</label><input type="text" id="user_id" name="user_id" />
    <label class="pwlabel ti" for="user_pw">비밀번호</label><input type="text" id="user_pw" name="user_pw" />
    <button class="loginBtn ti">로그인</button>
    <button class="joinBtn ti">회원가입</button>
    <button class="findBtn ti">아이디찾기</button>
</fieldset>
<div id="joinBox">
	<p class="joinAd ti">업계최저가격 문자서비스</p>
	<p class="join2Title ti">정보입력</p>
	<table class="inputTable" cellpadding="0" cellspacing="0" border="0">
		<tr>
			<td class="t">아이디</td>
			<td class="c">
				<input type="text" name="id" class="txt" value=""/>
				<img src="images/btn_idconfirm.gif" /> <span>영, 숫자조합 (4~12자)</span>
			</td>
		</tr>
		<tr><td class="t">비밀번호</td><td class="c"><input type="text" name="pw" class="txt" value=""/> <span>영, 숫자조합 (4~12자)</span></td></tr>
		<tr><td class="t">비밀번호확인</td><td class="c"><input type="text" name="repw" class="txt" value=""/> <span>비밀번호를 다시 한번 입력해 주세요.</span></td></tr>
		<tr><td class="t">핸드폰</td><td class="c"><input type="text" name="hp" class="txt" value=""/></td></tr>
		<tr><td class="t">이메일</td><td class="c"><input type="text" name="email" class="txt" value=""/> <span>메일수신이 가능한 이메일주소</span></td></tr>
		<tr><td class="t">메일수신여부</td>
			<td class="c"><input type="radio" name="emailok" id="emailok" /><label for="emailok">예</label>
		<input type="radio" name="emailok" id="emailno" /><label for="emailno">아니오</label> &nbsp;&nbsp;<span>이벤트, 제품 정보, 주문정보 등에 대한 메일링 서비스</span></td></tr>
		<tr><td class="t">SMS 수신여부</td>
			<td class="c"><input type="radio" name="smsok" id="smsok" /><label for="smsok">예</label>
		<input type="radio" name="smsok" id="smsno" /><label for="smsno">아니오</label> &nbsp;&nbsp;<span>이벤트, 제품 정보, 주문정보 등에 대한 메일링 서비스</span></td></tr>
	</table>
	<div class="confirmBox">
		<img src="images/btn_member.gif" onclick="window.location.href='?content=join3'" />&nbsp;&nbsp;&nbsp;
		<img src="images/btn_cancle.gif" onclick="window.location.href='?'" />
	</div>
</div>
<p id="free" class="ti">무료문자</p>
<a id="cost" class="ti" href="">저렴하고 안정적인 문자서비스를 찾으십니까? 단가표 보기</a>
<p id="custom" class="ti">Custom Center : 070-7510-8489, Fax: 031)970-8489</p>
