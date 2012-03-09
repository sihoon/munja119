<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.m.home.Home"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.m.member.SessionManagement"%>
<%@page import="com.m.member.UserInformationVO"%>
<%@page import="com.common.VbyP"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.common.util.SLibrary"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%

	String user_id = SLibrary.IfNull((String)session.getAttribute("user_id"));
	Connection conn = null;
	UserInformationVO vo = null;
	SessionManagement ses = null;
	Home home = null;
	String[] arrEmt = null;
	String[] arrCate = null;
	String gubun = SLibrary.IfNull( VbyP.getGET(request.getParameter("gubun")) );
	String cate = SLibrary.IfNull( VbyP.getGET(request.getParameter("cate")) );
	ArrayList<HashMap<String, String>> notihm = null;
	
	try {
		conn = VbyP.getDB();
		
		if ( SLibrary.isNull(gubun) ) gubun = "업종별문자";
		home = Home.getInstance();
		arrEmt = home.getMainEmt(conn, gubun, "%"+cate+"%", 0, 15);
		arrCate = home.getMainCate(conn, gubun);
		
		
		notihm = home.getNotices(conn);
		
		ses = new SessionManagement();
		if ( !SLibrary.IfNull( (String)session.getAttribute("user_id") ).equals("") )
			vo = ses.getUserInformation(conn, SLibrary.IfNull( (String)session.getAttribute("user_id") ));
	}catch (Exception e) {}
	finally {
		
		try {
			if ( conn != null )	conn.close();
		}catch(SQLException e) {
			VbyP.errorLog("getUserInformation >> conn.close() Exception!"); 
		}
		conn = null;
	}
	
%>
<script type="text/javascript">

	function logincheck() {
		var f = document.loginForm;
		if (!f.user_id.value) {
			alert("아이디를 입력하세요.");
			return;
		}else if (!f.user_pw.value) {
			alert("비밀번호를 입력하세요.");
			return;
		}else {
			f.submit();
		}
	}

</script>
<div id="main"><!--main Start-->
        <ul class="introduce"><!--소개-->
            <li class="intro1 ti">업계최저가격 10.7</li>
            <li class="intro2 ti">최대50만건 일괄발송</li>
            <li class="intro3 ti">장문문자발송가능</li>
            <li class="intro4 ti">이젠 스마트폰이다</li>
        </ul>
        <% if (vo == null) { %>
		<form name="loginForm" method="post" target="nobody" action="member/_login.jsp" >
		<fieldset id="login"><!-- 로그인 -->
            <legend>로그인</legend>
            <label class="idlabel ti" for="user_id">아이디</label><input type="text" id="user_id" name="user_id" />
            <label class="pwlabel ti" for="user_pw">비밀번호</label><input type="password" id="user_pw" name="user_pw" />
            <button class="loginBtn ti" onclick="logincheck()">로그인</button>
            <button class="joinBtn ti">회원가입</button>
            <button class="findBtn ti">아이디찾기</button>
        </fieldset>
        </form>
        <%
        } else {
        	%>
        <fieldset id="loginInfo"><!-- 로그인 -->
            <legend>로그인정보</legend>
            <span class="name"><%=vo.getUser_name() %></span> 님 안녕하세요.
           	<div><img src="images/usenum.gif" alt="사용가능건수" /> <span class="cnt"><%=SLibrary.addComma( vo.getPoint() ) %></span> <img src="images/cnt.gif" alt="건" /></div>
           	<img src="images/btn_cashbuy.gif" class="hand" alt="충전하기"  onclick="window.location.href='?content=billing'"/>
            <div class="function"><img src="images/edit.gif" class="hand" alt="정보수정"/> <img src="images/logout.gif" class="hand" alt="로그아웃" onclick="window.location.href='member/_logout.jsp'"/></div>
            <div class="cuponBox"><input type="text" name="cupon" class="cuponInput" />&nbsp;&nbsp;<img src="images/btn_coupon.gif" class="hand" alt="쿠폰등록" /></div>
        </fieldset>
        	<%
        }
        %>
        
        
        
        <div class="adBox">
	        <pre class="function ti">
	문자119에서 업체 최저 가격으로 간편하고 쉬운 문자서비스를 못보세요.
	일반문자 10.7원(부가세별도)
	장문문자 30원(부가세별도)
	포토문자 180원(부가세별도)
	
	예약발송기능 , 업계최저가격 10.7원
	중복번호 한번만 보내기 , 안정적인 문자발송 시스템
	대량문자 엑셀 등록 가능 , 90Byte까지 장문문자 발송 가능
	최대 20만건까지 일괄전송, 간편주소록 관리
	다양한MMS 포토문자 디자인, 카드/무통장 시스템
	        </pre>
	        <a class="smart ti" href="">스마트폰 멀티문자로 효율적으로 광고하세요.</a>
		</div>
        <div id="mobile"><!-- 핸드폰 Start-->
            <fieldset class="messageBox">
                <legend>메시지 입력</legend>
                <textarea></textarea>
                <button class="emoti ti">이모티콘</button>
                <button class="char ti">특수문자</button>
                <p class="byte"><b>20 /</b> 90 Byte</p>
                <a href="" class="image">사진첨부</a>
                <a href="" class="review">미리보기</a>
                <a href="" class="reset">다시쓰기</a>
                <button class="save ti">등록저장</button>
            </fieldset>
            <fieldset class="returnPhoneBox">
            	<legend>보낸사람</legend>
            	<label for="firstPhone" class="label">보낸사람</label>
            	<input type="text" name="returnPhone" />
            </fieldset>
            <fieldset class="phoneBox">
                <legend>받는사람</legend>
				<label for="firstPhone" class="phonelabel">받는사람</label>
                <button class="address ti">주소록</button>
                <button class="sent ti">최근발신</button>
                <ol class="listBox">
                    <li><input type="text" id="firstPhone"/><button>x</button></li>
                    <li><input type="text" /><button>x</button></li>
                    <li><input type="text" /><button>x</button></li>
                    <li><input type="text" /><button>x</button></li>
                    <li><input type="text" /><button>x</button></li>
                    <li><input type="text" /><button>x</button></li>
                    <li><input type="text" /><button>x</button></li>
                    <li><input type="text" /><button>x</button></li>
                    <li><input type="text" /><button>x</button></li>
                    <li><input type="text" /><button>x</button></li>
                </ol>
                <a href="" class="many">10건이상 보내기</a>
                <a href="" class="dup">중복번호제거</a>
            </fieldset>
            <fieldset class="sendBox">
                <legend>전송</legend>
                <input type="checkbox" name="reservation" id="reservation"/><label for="reservation">예약</label>
                <input type="checkbox" name="interval" id="interval"/><label for="interval">시간차발송</label>
                <button class="send ti">보내기</button>
                <button class="cancel">취소</button>
            </fieldset>
        </div><!-- 핸드폰 End-->
        

        <a id="cost" class="ti" href="">저렴하고 안정적인 문자서비스를 찾으십니까? 단가표 보기</a>

        <p id="custom" class="ti">Custom Center : 070-7510-8489, Fax: 031)970-8489</p>

        <fieldset id="emoticon">
            <ul class="title">
                <li class="<%=(gubun.equals("업종별문자"))?"businessover":"business" %>" onclick="window.location.href='?gubun=업종별문자'">업종별문자</li>
                <li class="<%=(gubun.equals("테마문자"))?"themaover":"thema" %>" onclick="window.location.href='?gubun=테마문자'">테마별문자</li>
<!--                 <li class="popular" onclick="window.location.href='?gubun=업종별문자'">인기문자</li> -->
<!--                 <li class="poto">포토문자</li> -->
                <li class="more" onclick="window.location.href='?content=normal'">더보기</li>
            </ul>
            <div class="middle">
                <div class="subTitle"><%
                
            	if (arrCate != null) {
            		int catCnt = arrCate.length;
            		for (int c = 0; c < catCnt; c++) {
            	%>
                	<a href="?gubun=<%=gubun %>&cate=<%=arrCate[c] %>" class="<%=(arrCate[c].equals(cate))?"de":""%>"><%=arrCate[c] %></a>&nbsp;&nbsp;&nbsp;&nbsp;
                <%
                	}
                }
                %>
                </div>
                <div class="emtibox">
                    <textarea class="emti" readonly ><%=arrEmt[0] %></textarea>
                    <textarea class="emti" readonly><%=arrEmt[1] %></textarea>
                    <textarea class="emti" readonly><%=arrEmt[2] %></textarea>
                    <textarea class="emti" readonly><%=arrEmt[3] %></textarea>
                    <textarea class="emti" readonly><%=arrEmt[4] %></textarea>
                    <textarea class="emti" readonly><%=arrEmt[5] %></textarea>
                    <textarea class="emti" readonly><%=arrEmt[6] %></textarea>
                    <textarea class="emti" readonly><%=arrEmt[7] %></textarea>
                    <textarea class="emti" readonly><%=arrEmt[8] %></textarea>
                    <textarea class="emti" readonly><%=arrEmt[9] %></textarea>
                    <textarea class="emti" readonly><%=arrEmt[10] %></textarea>
                    <textarea class="emti" readonly><%=arrEmt[11] %></textarea>
                    <textarea class="emti" readonly><%=arrEmt[12] %></textarea>
                    <textarea class="emti" readonly><%=arrEmt[13] %></textarea>
                    <textarea class="emti" readonly><%=arrEmt[14] %></textarea>
                </div>
            </div>
        </fieldset>

        <a href="javascript:return false;" class="potomore" onclick="window.location.href='?content=photo'">더보기</a>
        <fieldset id="poto">
            <legend>인기포토문자</legend>
            <div class="potoBox">
                <img src="images/pro_ex.jpg" class="potoimg" alt="인기" />
                <img src="images/pro_ex.jpg" class="potoimg" alt="인기" />
                <img src="images/pro_ex.jpg" class="potoimg" alt="인기" />
                <img src="images/pro_ex.jpg" class="potoimg" alt="인기" />
                <img src="images/pro_ex.jpg" class="potoimg" alt="인기" />
                <img src="images/pro_ex.jpg" class="potoimg" alt="인기" />
                <img src="images/pro_ex.jpg" class="potoimg" alt="인기" style="margin-right:0px;" />
            </div>
            
        </fieldset>


        <fieldset id="noti">
            <legend>공지사항</legend>
            <a href="" class="more">more</a>
            <%
            	if (notihm != null) {
            		int size = notihm.size();
            		HashMap<String, String> hm = null;
            		for (int i = 0; i < size; i++) {
            			hm = notihm.get(i);
            			%>
            			<div class="content"><a href="" class="title"><%=SLibrary.IfNull(hm, "title") %></a><span class="notiDate"></span></div>
            			<%
            		}
            	}
            %>
        </fieldset>

        <a href="" class="bank">입금계좌</a>
        <a href="" class="product">상품소개</a>
        <div id="etc">
            <a href="" class="tax">세금계산서신청</a>
            <a href="" class="card">신용카드영수증출력</a>
            <a href="" class="faq">자주하는 질문</a>
            <a href="" class="mantoman">일대일문의</a>
        </div>
    </div><!--main End-->

