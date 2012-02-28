<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	<p class="joinTitle ti">회원가입</p>
	<p class="joinsub1 ti">이용약관</p>
	<pre class="joinsub1Content"></pre>
	<div class="joincheck">
		<img src="images/member_img01.gif" />
		<input type="radio" name="sub1" id="sub1ok" /><label for="sub1ok">동의함</label>
		<input type="radio" name="sub1" id="sub1no" /><label for="sub1no">동의안함</label>
	</div>
	
	<p class="joinsub2 ti">개인정보 취급 방침</p>
	<pre class="joinsub2Content"></pre>
	<div class="joincheck">
		<img src="images/member_img01.gif" />
		<input type="radio" name="sub2" id="sub2ok" /><label for="sub2ok">동의함</label>
		<input type="radio" name="sub2" id="sub2no" /><label for="sub2no">동의안함</label>
	</div>
	
	<div class="confirmBox">
		<img src="images/btn_next.gif" onclick="window.location.href='?content=join2'" />&nbsp;&nbsp;&nbsp;
		<img src="images/btn_cancle.gif" onclick="window.location.href='?'" />
	</div>
</div>
<p id="free" class="ti">무료문자</p>
<a id="cost" class="ti" href="">저렴하고 안정적인 문자서비스를 찾으십니까? 단가표 보기</a>
<p id="custom" class="ti">Custom Center : 070-7510-8489, Fax: 031)970-8489</p>
