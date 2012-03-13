<%@page import="java.sql.SQLException"%>
<%@page import="com.common.VbyP"%>
<%@page import="com.m.member.SessionManagement"%>
<%@page import="com.m.member.UserInformationVO"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.common.util.SLibrary"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%

String user_id = SLibrary.IfNull((String)session.getAttribute("user_id"));
Connection conn = null;
UserInformationVO vo = null;
SessionManagement ses = null;

try {
	conn = VbyP.getDB();
	
	ses = new SessionManagement();
	if ( !SLibrary.IfNull( (String)session.getAttribute("user_id") ).equals("") )
		vo = ses.getUserInformation(conn, SLibrary.IfNull( (String)session.getAttribute("user_id") ));
}catch (Exception e) {}
finally {
	
	try {
		if ( conn != null )	conn.close();
	}catch(SQLException e) {
		VbyP.errorLog("billing.jsp >> conn.close() Exception!"); 
	}
	conn = null;
}

%>

<% if (vo == null) { %>
<fieldset id="login"  style="padding:9px 16px;">
    <legend>로그인</legend>
    <label class="idlabel ti" for="user_id">아이디</label><input type="text" id="user_id" name="user_id" />
    <label class="pwlabel ti" for="user_pw">비밀번호</label><input type="text" id="user_pw" name="user_pw" />
    <button class="loginBtn ti">로그인</button>
    <button class="joinBtn ti">회원가입</button>
    <button class="findBtn ti">아이디찾기</button>
</fieldset>
<% } else { %>
<fieldset id="loginInfo">
    <legend>로그인정보</legend>
    <p><span class="name"><%=vo.getUser_name() %></span> 님 안녕하세요.</p>
   	<div><img src="images/usenum.gif" />&nbsp;<span class="cnt"><%=SLibrary.addComma( vo.getPoint() ) %></span><img src="images/cnt.gif" /></div>
   	<img src="images/btn_cashbuy.gif" class="hand" alt="충전하기" onclick="window.location.href='?content=billing'" />
    <div class="function"><img src="images/edit.gif" class="hand" alt="정보수정"/>&nbsp;<img src="images/logout.gif" onclick="window.location.href='member/_logout.jsp'" class="hand" alt="로그아웃" /></div>
    <div class="cuponBox"><input type="text" name="cupon" class="cuponInput" />&nbsp;&nbsp;<img src="images/btn_coupon.gif" class="hand" alt="쿠폰등록" /></div>
</fieldset>
<% }%>

<form name="formBilling" target="nobody" mehtod="post" action="billing/payreq.jsp" >
	<input type="hidden" name="smethod" value="" />
	<input type="hidden" name="amount" value="" />
</form>

<p id="billingTitle" class="ti">충전하기</p>
<form name="form" method="post" >
<div id="billingBox" >
	<h2 class="txtMethod">결제 수단</h2>
	<p class="selMethod">
		<input type="radio" id="card" name="method" value="card" onclick="billingMethod()" checked /><label for="card">신용카드</label>&nbsp;&nbsp;
		<input type="radio" id="online" name="method" value="online" onclick="billingMethod()" /><label for="online">계좌이체</label>&nbsp;&nbsp;
		<input type="radio" id="mobile" name="method" value="mobile" onclick="billingMethod()" /><label for="mobile">휴대폰</label>&nbsp;&nbsp;
		<input type="radio" id="cash" name="method" value="cash" onclick="billingMethod()" /><label for="cash">무통장입금</label>
	</p>
	<h2 class="txtAmount">결제 금액</h2>
	<table width="721" border="0" cellpadding="0" cellspacing="0">
		<tr><td colspan="4" class="title">&nbsp;</td></tr>
		<tr onclick="" onmouseover="this.style.backgroundColor='#fff0f0'" onmouseout="this.style.backgroundColor='#ffffff'">
			<td width="70"><input type="radio" name="amount" value="5000" /></td>
			<td width="210">5,000원</td>
			<td width="220">417건/포인트</td>
			<td>12원/건</td>
		</tr>
		<tr onmouseover="this.style.backgroundColor='#fff0f0'" onmouseout="this.style.backgroundColor='#ffffff'">
			<td><input type="radio" name="amount" value="10000" /></td>
			<td>10,000원</td>
			<td>833건/포인트</td>
			<td>12원/건</td>
		</tr>
		<tr onmouseover="this.style.backgroundColor='#fff0f0'" onmouseout="this.style.backgroundColor='#ffffff'">
			<td><input type="radio" name="amount" value="30000" checked /></td>
			<td>30,000원</td>
			<td>2,500건/포인트</td>
			<td>12원/건</td>
		</tr>
		<tr onmouseover="this.style.backgroundColor='#fff0f0'" onmouseout="this.style.backgroundColor='#ffffff'">
			<td><input type="radio" name="amount" value="50000" /></td>
			<td>50,000원</td>
			<td>4,167건/포인트</td>
			<td>12원/건</td>
		</tr>
		<tr onmouseover="this.style.backgroundColor='#fff0f0'" onmouseout="this.style.backgroundColor='#ffffff'">
			<td><input type="radio" name="amount" value="100000" /></td>
			<td>100,000원</td>
			<td>8,333건/포인트</td>
			<td>12원/건</td>
		</tr>
		<tr onmouseover="this.style.backgroundColor='#fff0f0'" onmouseout="this.style.backgroundColor='#ffffff'">
			<td><input type="radio" name="amount" value="300000" /></td>
			<td>300,000원</td>
			<td>25,000건/포인트</td>
			<td>12원/건</td>
		</tr>
		<tr onmouseover="this.style.backgroundColor='#fff0f0'" onmouseout="this.style.backgroundColor='#ffffff'">
			<td><input type="radio" name="amount" value="500000" /></td>
			<td>500,000원</td>
			<td>41,667건/포인트</td>
			<td>12원/건</td>
		</tr>
		<tr onmouseover="this.style.backgroundColor='#fff0f0'" onmouseout="this.style.backgroundColor='#ffffff'">
			<td><input type="radio" name="amount" value="1000000" /></td>
			<td>1,000,000원</td>
			<td>86,957건/포인트</td>
			<td>11.5원/건</td>
		</tr>
		<tr onmouseover="this.style.backgroundColor='#fff0f0'" onmouseout="this.style.backgroundColor='#ffffff'">
			<td><input type="radio" name="amount" value="3000000" /></td>
			<td>3,000,000원</td>
			<td>272,727건/포인트</td>
			<td>11원/건</td>
		</tr>
		<tr onmouseover="this.style.backgroundColor='#fff0f0'" onmouseout="this.style.backgroundColor='#ffffff'">
			<td><input type="radio" name="amount" value="5000000" /></td>
			<td>5,000,000원</td>
			<td>467,290건/포인트</td>
			<td>10.7원/건</td>
		</tr>
		<tr id="cashBox" style="display:none;">
			<td colspan="4" style="border:none;height:150px;text-align:left;">
				
				<p>계좌선택</p>
				<ul>
					<li><input type="radio" name="cash" id="cash1" value="국민 - 최유진 517101-01-253003" /><label for="cash1">국민 - 최유진 517101-01-253003</label></li>
					<li><input type="radio" name="cash" id="cash2" value="농협 - 최유진 302-0270-9608-11" /><label for="cash2">농협 - 최유진 302-0270-9608-11</label></li>
					<li><input type="radio" name="cash" id="cash3" value="신한 - 최유진 110-304-851796" /><label for="cash3">신한 - 최유진 110-304-851796</label></li>
					<li><input type="radio" name="cash" id="cash4" value="우리 - 최유진 191-420251-02-001" /><label for="cash4">우리 - 최유진 191-420251-02-001</label></li>
				</ul>
				<div style="width:100%;text-align:center;margin:10px 0px">
				입금자명 <input type="text" name="cashName" /> 으로 <button>예약하기</button>
				</div>
			</td>
		</tr>
		<tr id="etcBox"><td colspan="4" style="border:none;height:80px;"><img src="images/btn_payment.gif" style="cursor:pointer" onclick="billingCheck()" /></td></tr>
	</table>
</div>
</form>
<p id="free" class="ti">무료문자</p>
<a id="cost" class="ti" href="">저렴하고 안정적인 문자서비스를 찾으십니까? 단가표 보기</a>
<p id="custom" class="ti">Custom Center : 070-7510-8489, Fax: 031)970-8489</p>

