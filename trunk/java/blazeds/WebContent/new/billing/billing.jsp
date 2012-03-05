<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<fieldset id="login"  style="padding:9px 16px;">
    <legend>로그인</legend>
    <label class="idlabel ti" for="user_id">아이디</label><input type="text" id="user_id" name="user_id" />
    <label class="pwlabel ti" for="user_pw">비밀번호</label><input type="text" id="user_pw" name="user_pw" />
    <button class="loginBtn ti">로그인</button>
    <button class="joinBtn ti">회원가입</button>
    <button class="findBtn ti">아이디찾기</button>
</fieldset>
<p id="billingTitle" class="ti">충전하기</p>

<div id="billingBox" >
	<h2 class="txtMethod">결제 수단</h2>
	<p class="selMethod">
		<input type="radio" id="card" name="method" value="card" /><label for="card">신용카드</label>&nbsp;&nbsp;
		<input type="radio" id="online" name="method" value="online" /><label for="online">계좌이체</label>&nbsp;&nbsp;
		<input type="radio" id="mobile" name="method" value="mobile" /><label for="mobile">휴대폰</label>&nbsp;&nbsp;
		<input type="radio" id="cash" name="method" value="cash" /><label for="cash">무통장입금</label>
	</p>
	<h2 class="txtAmount">결제 금액</h2>
	<table width="721" border="0" cellpadding="0" cellspacing="0">
		<tr><td colspan="4" class="title">&nbsp;</td></tr>
		<tr>
			<td width="70"><input type="radio" name="amount" value="5000" /></td>
			<td width="210">5,000원</td>
			<td width="220">417건/포인트</td>
			<td>12원/건</td>
		</tr>
		<tr>
			<td><input type="radio" name="amount" value="5000" /></td>
			<td>5,000원</td>
			<td>417건/포인트</td>
			<td>12원/건</td>
		</tr>
		<tr>
			<td><input type="radio" name="amount" value="5000" /></td>
			<td>5,000원</td>
			<td>417건/포인트</td>
			<td>12원/건</td>
		</tr>
		<tr>
			<td><input type="radio" name="amount" value="5000" /></td>
			<td>5,000원</td>
			<td>417건/포인트</td>
			<td>12원/건</td>
		</tr>
		<tr><td colspan="4" style="border:none;height:80px;"><img src="images/btn_payment.gif" /></td></tr>
	</table>
</div>

<p id="free" class="ti">무료문자</p>
<a id="cost" class="ti" href="">저렴하고 안정적인 문자서비스를 찾으십니까? 단가표 보기</a>
<p id="custom" class="ti">Custom Center : 070-7510-8489, Fax: 031)970-8489</p>

