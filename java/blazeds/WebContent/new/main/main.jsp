<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="main"><!--main Start-->
        <ul class="introduce"><!--소개-->
            <li class="intro1 ti">업계최저가격 10.7</li>
            <li class="intro2 ti">최대50만건 일괄발송</li>
            <li class="intro3 ti">장문문자발송가능</li>
            <li class="intro4 ti">이젠 스마트폰이다</li>
        </ul>

        <fieldset id="login"><!-- 로그인 -->
            <legend>로그인</legend>
            <label class="idlabel ti" for="user_id">아이디</label><input type="text" id="user_id" name="user_id" />
            <label class="pwlabel ti" for="user_pw">비밀번호</label><input type="text" id="user_pw" name="user_pw" />
            <button class="loginBtn ti">로그인</button>
            <button class="joinBtn ti">회원가입</button>
            <button class="findBtn ti">아이디찾기</button>
        </fieldset>
        
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
                <li class="business">업종별문자</li>
                <li class="thema">테마별문자</li>
                <li class="popular">인기문자</li>
                <li class="poto">포토문자</li>
                <li class="more">더보기</li>
            </ul>
            <div class="middle">
                <div class="subTitle">
                    <a href="" class="pre">이전</a>
                    <a href="">감사</a>
                    <a href="">계절</a>
                    <a href="">공지/안내</a>
                    <a href="">기념</a>
                    <a href="">날씨</a>
                    <a href="">명언/감동</a>
                    <a href="">모임</a>
                    <a href="">부고/조의</a>
                    <a href="">사과/화해</a>
                    <a href="">사랑/고백</a>
                    <a href="">시즌/안부</a>
                    <a href="" class="next">다음</a>
                </div>
                <div class="emtibox">
                    <pre class="emti">   ///// 
 (( > < b 
에취! ∑ \") 
  (☞☜) 
환절기감기조심!</pre>
                    <pre class="emti">ㄸㅓㄴㅏ고ㅍㅏ
☆┏━━┓♥☆ 
┏┛□□┗┓♥ 
┗⊙━━⊙┛==3 
ㄱrㅊiㄱrㄲr♡</pre>
                    <pre class="emti">갑자기추워진날씨
♧ )) ♧ 따뜻한
┃(( *┣┓차한잔
┃* ♠┣┛마시고
┗━━┛힘내</pre>
                    <pre class="emti">이모티콘</pre>
                    <pre class="emti">이모티콘</pre>
                    <pre class="emti">이모티콘</pre>
                    <pre class="emti">이모티콘</pre>
                    <pre class="emti">이모티콘</pre>
                    <pre class="emti">이모티콘</pre>
                    <pre class="emti">이모티콘</pre>
                    <pre class="emti">이모티콘</pre>
                    <pre class="emti">이모티콘</pre>
                    <pre class="emti">이모티콘</pre>
                    <pre class="emti">이모티콘</pre>
                    <pre class="emti">이모티콘</pre>
                </div>
            </div>
        </fieldset>

        <a href="" class="potomore">더보기</a>
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
            <div class="content"><a href="" class="title">공지사항입니다.</a><span class="notiDate">2012-01-02</span></div>
            <div class="content"><a href="" class="title">공지사항입니다.</a><span class="notiDate">2012-01-02</span></div>
            <div class="content"><a href="" class="title">공지사항입니다.</a><span class="notiDate">2012-01-02</span></div>
            <div class="content"><a href="" class="title">공지사항입니다.</a><span class="notiDate">2012-01-02</span></div>
            <div class="content"><a href="" class="title">공지사항입니다.</a><span class="notiDate">2012-01-02</span></div>
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

