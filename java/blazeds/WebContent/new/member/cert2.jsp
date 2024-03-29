<%@page import="java.sql.SQLException"%>
<%@page import="com.m.member.SessionManagement"%>
<%@page import="com.m.member.UserInformationVO"%>
<%@page import="com.m.point.PointHistory"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.common.VbyP"%>
<%@page import="com.common.util.SLibrary"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%


String user_id = SLibrary.IfNull((String)session.getAttribute("user_id"));
Connection conn = null;
UserInformationVO vo = null;
SessionManagement ses = null;

ArrayList<HashMap<String, String>> jvo = null; //12.19

try {
	conn = VbyP.getDB();
	
	ses = new SessionManagement();
	if ( !SLibrary.IfNull( (String)session.getAttribute("user_id") ).equals("") )
		vo = ses.getUserInformation(conn, SLibrary.IfNull( (String)session.getAttribute("user_id") ));
		
	
	
	PointHistory ph = PointHistory.getInstance();
	jvo = ph.getSubPhone(conn, vo.getUser_id());
	
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
<form name="loginForm" method="post" target="nobody" action="member/_login.jsp" >
<fieldset id="login" >
    <legend>로그인</legend>
    <label class="idlabel ti" for="user_id">아이디</label><input type="text" id="user_id" name="user_id" value="" />
    <label class="pwlabel ti" for="user_pw">비밀번호</label><input type="password" id="user_pw" name="user_pw" />
    <button class="loginBtn ti" onclick="logincheck()">로그인</button>
    <button class="joinBtn ti">회원가입</button>
    <button class="findBtn ti">아이디찾기</button>
</fieldset>
</form>
<% } else { %>
<fieldset id="loginInfo">
    <legend>로그인정보</legend>
    <p><span class="name"><%=vo.getUser_name() %></span> 님 안녕하세요.</p>
   	<div><img src="images/usenum.gif" />&nbsp;<span class="cnt"><%=SLibrary.addComma( vo.getPoint() ) %></span><img src="images/cnt.gif" /></div>
   	<img src="images/btn_cashbuy.gif" class="hand" alt="충전하기" onclick="window.location.href='?content=billing'" />
    <div class="function"><img src="images/edit.gif" class="hand" alt="정보수정"/>&nbsp;<img src="images/logout.gif" onclick="window.location.href='member/_logout.jsp'" class="hand" alt="로그아웃" /></div>
    <!--<div class="cuponBox"><input type="text" name="cupon" class="cuponInput" />&nbsp;&nbsp;<img src="images/btn_coupon.gif" class="hand" alt="쿠폰등록" /></div> -->
</fieldset>
<% }%>
<form name="form" method="post">
<div id="joinBox">
	<p class="joinAd ti">업계최저가격 문자서비스</p>
	<table><tr><td><img alt="2차인증" src="images/cert2.JPG"/></td></tr></table>
	<table class="inputTable" cellpadding="0" cellspacing="0" border="0">
	
	
		<tr><td class="t">핸드폰</td><td class="c"><input type="text" name="hp" class="txt" value=""/>
		<img alt="인증번호요청" src="images/certreqst.jpg" onclick="javascript:checkListNum2('<%=vo.getHp()%>', '<%=jvo%>'); return false;"/>&nbsp;
		<img alt="재전송" src="images/certresend.jpg" onclick="javascript:checkListNum2('<%=vo.getHp()%>', '<%=jvo%>'); return false;"/>
		<tr><td class="t">인증번호</td><td class="c"><input type="text" name="hpCert" class="txt" value=""/>
		
		<img alt="인증번호확인" src="images/certreqok.jpg" onclick="checkCertLogin();"/>&nbsp;
		<img alt="취소" src="images/certcancel.jpg" onclick="window.location.href='?content='"/>&nbsp;
		
		
		<tr>
			<td class="c" colspan="2">
				<span><img alt="인증안내문구" src="images/certguid.jpg" ></span>
			</td>
		</tr>
	</table>
	<div class="confirmBox">
	<!-- 
		<img src="images/btn_qaregist.gif" onclick="check_modify()" />&nbsp;&nbsp;&nbsp;
		<img src="images/btn_cancle.gif" onclick="window.location.href='?'" />
	 -->
	</div>
</div>
</form>
<a id="cost" class="ti" href="">저렴하고 안정적인 문자서비스를 찾으십니까? 단가표 보기</a>
<p id="custom" class="ti">Custom Center : 070-7510-8489, Fax: 031)970-8489</p>
<script type="text/javascript" src="js/member.js"></script>
<script type="text/javascript">

alert("보안 강화를 위해 2차 인증이 필요합니다.");
function checkListNum2(memNum, memLNum){
	/* alert(memLNum);
	alert(memNum); */
	var frm = document.form;
	var inputPNum = frm.hp.value; 
	inputPNum = inputPNum.replace(/-/gi,"");

	if(inputPNum==null || inputPNum==""){
		alert("핸드폰번호를 입력해주세요.");
		return;
	}
	if (memNum == inputPNum) {
	//alert("master");
		sendCertLogin();
		return;
	}
	if(memLNum == "[]"){
		alert("회원정보의 핸드폰번호와 입력하신 핸드폰번호가 일치하지 않습니다.\n고객센터로 문의해주시기 바랍니다.");
		return;
	}
	if (12 > memLNum.length) return;
	for (var i = 11; i < memLNum.length; i += 24) {
		var memPNum = memLNum.substring(i,11+i); 
		//alert("번호?="+memPNum); //12.19
		if(memPNum == inputPNum){ //받아온 번호 == 입력한 번호인 경우
			sendCertLogin();
			return;
		}
	}	
	alert("회원정보의 핸드폰번호와 입력하신 핸드폰번호가 일치하지 않습니다.\n고객센터로 문의해주시기 바랍니다.");
	return;
} 




/*  
function checkPNum(memPNum){
	var frm = document.form;
	var inputPNum = frm.hp.value;
	inputPNum = inputPNum.replace(/-/gi,"");
	if(memPNum == inputPNum){
		//alert("aa");
		sendCertLogin();
	}else{
		if(inputPNum==null || inputPNum==""){
			alert("핸드폰번호를 입력해주세요.");
		}else{
			alert("회원정보의 핸드폰번호와 입력하신 핸드폰번호가 일치하지 않습니다.\n고객센터로 문의해주시기 바랍니다.");
			return;
		}
	}
} */
 

</script>
