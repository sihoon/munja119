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
	String[] arrEmtlms = null;
	String[] arrCatelms = null;
	ArrayList<HashMap<String, String>> arrMms = null;
	String[] arrMmsCate = null;
	String gubun = SLibrary.IfNull(request.getParameter("gubun") );
	String cate = SLibrary.IfNull( request.getParameter("cate") );

	String url = "gubun="+gubun+"&cate="+cate;
	
	String gubunlms = SLibrary.IfNull( request.getParameter("gubunlms") );
	String catelms = SLibrary.IfNull( request.getParameter("catelms") );
	String urllms = "gubunlms="+gubunlms+"&catelms="+catelms;
	
	String mmscate = SLibrary.IfNull( request.getParameter("mmscate") );
	String urlmms = "mmscate="+mmscate;
	ArrayList<HashMap<String, String>> notihm = null;
	
	try {
		conn = VbyP.getDB();
		
		if ( SLibrary.isNull(gubun) ) gubun = "테마문자";
		if ( SLibrary.isNull(gubunlms) ) gubunlms = "테마문자";
		home = Home.getInstance();
	
		arrEmt = home.getMainEmt(conn, gubun, "%"+cate+"%", 0, 15);
		arrCate = home.getMainCate(conn, gubun);
		
		arrEmtlms = home.getMainLMS(conn, gubunlms, "%"+catelms+"%", 0, 10);
		arrCatelms = home.getMainCateLMS(conn, gubunlms);
		
		
		
		arrMmsCate = home.getMainMmsCate(conn, "%%");
		arrMms = home.getMainMms(conn, "%%", "%"+mmscate+"%", 0, 5);
		
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
            <li class="intro1 ti">업계최저가격 10</li>
            <li class="intro2 ti">최대50만건 일괄발송</li>
            <li class="intro3 ti">장문문자발송가능</li>
            <li class="intro4 ti">이젠 스마트폰이다</li>
        </ul>
        
		<div id="flashContent" style="display:none;border:1px solid red;"></div>
		<img id="installImage" src="images/install.jpg" style="display:none;clear:both;" usemap="#map_install" />
		<map name="map_install">
			<area shape="rect" coords="470,255,580,280" href="flash.html" alt="다운로드 페이지 이동" />
		</map>
		<script type="text/javascript" src="flexlib/swfobject.js"></script>
		<script type="text/javascript" src="main/main.js"></script>

		<p class="mainsmstitle ti">단문문자</p>
        <fieldset id="emoticon">
            <ul class="title">
				<li class="<%=(gubun.equals("테마문자"))?"themaover":"thema" %>" onclick="window.location.href='?gubun=테마문자<%="&"+urllms+"&"+urlmms%>'">테마별문자</li>
                <li class="<%=(gubun.equals("업종별문자"))?"businessover":"business" %>" onclick="window.location.href='?gubun=업종별문자<%="&"+urllms+"&"+urlmms%>'">업종별문자</li>
                
                <li class="more" onclick="window.location.href='?content=normal'">더보기</li>
            </ul>
            <div class="middle">
                <div class="subTitle"><%
                String[] arr = null;
        		String label = "";
        		String style = " style='font-size:12px;' ";
        		
            	if (arrCate != null) {
            		int catCnt = arrCate.length;
            		
            		for (int c = 0; c < catCnt; c++) {
            			arr = arrCate[c].split("_");
            			label = arr[arr.length-1];
            			if (arr.length > 1) continue;
            	%>
                	<a href="?gubun=<%=gubun %>&cate=<%=label %><%="&"+urllms+"&"+urlmms%>" class="<%=(label.equals(cate))?"de":""%>" <%=style %>><%=label %></a>&nbsp;&nbsp;&nbsp;&nbsp;
                <%
                	}
                }
                %>
                </div>
                <div class="emtibox">
                    <textarea class="emti" onclick="setMsg(this.value)" readonly><%=arrEmt[0] %></textarea>
                    <textarea class="emti" onclick="setMsg(this.value)" readonly><%=arrEmt[1] %></textarea>
                    <textarea class="emti" onclick="setMsg(this.value)" readonly><%=arrEmt[2] %></textarea>
                    <textarea class="emti" onclick="setMsg(this.value)" readonly><%=arrEmt[3] %></textarea>
                    <textarea class="emti" onclick="setMsg(this.value)" readonly><%=arrEmt[4] %></textarea>
                    <textarea class="emti" onclick="setMsg(this.value)" readonly><%=arrEmt[5] %></textarea>
                    <textarea class="emti" onclick="setMsg(this.value)" readonly><%=arrEmt[6] %></textarea>
                    <textarea class="emti" onclick="setMsg(this.value)" readonly><%=arrEmt[7] %></textarea>
                    <textarea class="emti" onclick="setMsg(this.value)" readonly><%=arrEmt[8] %></textarea>
                    <textarea class="emti" onclick="setMsg(this.value)" readonly><%=arrEmt[9] %></textarea>
                    <textarea class="emti" onclick="setMsg(this.value)" readonly><%=arrEmt[10] %></textarea>
                    <textarea class="emti" onclick="setMsg(this.value)" readonly><%=arrEmt[11] %></textarea>
                    <textarea class="emti" onclick="setMsg(this.value)" readonly><%=arrEmt[12] %></textarea>
                    <textarea class="emti" onclick="setMsg(this.value)" readonly><%=arrEmt[13] %></textarea>
                    <textarea class="emti" onclick="setMsg(this.value)" readonly><%=arrEmt[14] %></textarea>
                </div>
            </div>
        </fieldset>
        <p class="mainlmstitle ti">장문문자</p>
        <fieldset id="emoticon">
            <ul class="title">
                <li class="<%=(gubunlms.equals("테마문자"))?"themaover":"thema" %>" onclick="window.location.href='?gubunlms=테마문자<%="&"+url+"&"+urlmms%>'">테마별문자</li>
				<li class="<%=(gubunlms.equals("업종별문자"))?"businessover":"business" %>" onclick="window.location.href='?gubunlms=업종별문자<%="&"+url+"&"+urlmms%>'">업종별문자</li>
                <li class="more" onclick="window.location.href='?content=lms'">더보기</li>
            </ul>
            <div class="middle">
               <div class="subTitle"><%
                
            	if (arrCatelms != null) {
            		int catCnt = arrCatelms.length;
            		for (int c = 0; c < catCnt; c++) {
            			
            			arr = arrCatelms[c].split("_");
            			label = arr[arr.length-1];
            			if (arr.length > 1) continue;
            	%>
                	<a href="?gubunlms=<%=gubunlms %>&catelms=<%=label %>" class="<%=(label.equals(cate))?"de":""%>" <%=style %>><%=label %></a>&nbsp;&nbsp;&nbsp;&nbsp;
                <%
                	}
                }
                %>
                </div>
                <div class="emtibox">
                    <textarea class="emtiLms" onclick="setMsg(this.value)" readonly ><%=arrEmtlms[0] %></textarea>
                    <textarea class="emtiLms" onclick="setMsg(this.value)" readonly><%=arrEmtlms[1] %></textarea>
                    <textarea class="emtiLms" onclick="setMsg(this.value)" readonly><%=arrEmtlms[2] %></textarea>
                    <textarea class="emtiLms" onclick="setMsg(this.value)" readonly><%=arrEmtlms[3] %></textarea>
                    <textarea class="emtiLms" onclick="setMsg(this.value)" readonly><%=arrEmtlms[4] %></textarea><p style="height:10px"></p>
                    <textarea class="emtiLms" onclick="setMsg(this.value)" readonly><%=arrEmtlms[5] %></textarea>
                    <textarea class="emtiLms" onclick="setMsg(this.value)" readonly><%=arrEmtlms[6] %></textarea>
                    <textarea class="emtiLms" onclick="setMsg(this.value)" readonly><%=arrEmtlms[7] %></textarea>
                    <textarea class="emtiLms" onclick="setMsg(this.value)" readonly><%=arrEmtlms[8] %></textarea>
                    <textarea class="emtiLms" onclick="setMsg(this.value)" readonly><%=arrEmtlms[9] %></textarea>
                </div>
            </div>
        </fieldset>
		
        <a href="javascript:return false;" class="potomore" onclick="window.location.href='?content=mms'">더보기</a>
        <fieldset id="poto">
            <legend>인기포토문자</legend>
            <div class="potoBox">
            	<div class="subTitle"><%
                
            	if (arrMmsCate != null) {
            		int catCnt = arrMmsCate.length;
            		for (int c = 0; c < catCnt; c++) {
            			
            			arr = arrMmsCate[c].split("_");
            			label = arr[arr.length-1];
            			if (arr.length > 1) continue;
            	%>
                	<a href="?gubunmms=&mmscate=<%=label %>" class="<%=(label.equals(cate))?"de":""%>" <%=style %>><%=label %></a>&nbsp;&nbsp;&nbsp;&nbsp;
                <%
                	}
                }
                %>
                </div>
            <% 
            	if (arrMms != null && arrMms.size() > 0) {
            		HashMap<String, String> hm = null;
            		for (int m = 0; m < arrMms.size(); m++) {
            			hm = arrMms.get(m);
            			if (hm != null && !SLibrary.isNull( SLibrary.IfNull(hm, "msg") )) {
            		%><div style="float:left;width:180px;text-align:center;">
							<img onclick="setPhoto('<%= SLibrary.IfNull(hm, "msg") %>')" src="<%= SLibrary.IfNull(hm, "msg") %>" class="potoimg" style="display:block;width:176px;height:144px;cursor:pointer" <%= m == (arrMms.size() -1) ? "style='margin-right:0px;'" : "" %> />
            				<p style="width:180px;overflow:hidden;height:20px;font-size:12px;" ><%= SLibrary.IfNull(hm, "title") %></p>
						</div><%
            			}
            		}
            	}
            %>
            </div>
        </fieldset>


        <fieldset id="noti">
            <legend>공지사항</legend>
            <a href="?content=notic" class="more">more</a>
            <%
            	if (notihm != null) {
            		int size = notihm.size();
            		HashMap<String, String> hm = null;
            		for (int i = 0; i < size; i++) {
            			hm = notihm.get(i);
            			%>
            			<div class="content"><a href="?content=notic&idx=<%=SLibrary.IfNull(hm, "idx") %>" class="title" <%=style%>><%=SLibrary.IfNull(hm, "title") %></a><span class="notiDate"></span></div>
            			<%
            		}
            	}
            %>
        </fieldset>

        <a href="" class="bank">입금계좌</a>
        <a href="" class="product">상품소개</a>
        <div id="etc">
            <a href="?content=my" class="tax">세금계산서신청</a>
            <a href="?content=my" class="card">신용카드영수증출력</a>
            <a href="?content=faq" class="faq">자주하는 질문</a>
            <a href="?content=qna" class="mantoman">일대일문의</a>
        </div>
    </div><!--main End-->
	<!--<div id="pop" style="width:500px;height:660px;display:block;position:absolute;top:10px;left:0px;margin:0 auto;overflow:hidden;border:1px solid #666;">
		<div style="width:500px;height:20px;background-color:#666;padding:5px 0px;text-align:left;cursor:point;color:#FFF" onclick="document.getElementById('pop').style.display='none'">&nbsp;&nbsp;공지사항</div>
		<img src="/new/images/pop.jpg" style="display:block;" width="500" height="598" />
		<div style="width:500px;height:20px;background-color:#666;padding:5px 0px;text-align:right;cursor:point;color:#FFF" onclick="document.getElementById('pop').style.display='none'">닫기&nbsp;&nbsp;</div>
	</div>-->
	<!---->
    <script type="text/javascript" >
function setMsg(msg) {
	
	var flex = document.getElementById("Mainflex");
	flex.phoneFlexFunction("setMessage", msg);
}
function setPhoto(msg) {
	
	var flex = document.getElementById("Mainflex");
	flex.phoneFlexFunction("setPhoto", msg);
}
</script>

