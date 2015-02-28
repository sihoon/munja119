
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>2차인증관련 공지</title>

<style type="text/css">
#a{text-decoration: none;}
#a:HOVER { text-decoration: underline;
}
</style>
<script type="text/javascript">
function setCookie( name, value, expiredays ){
	var todayDate = new Date();
		todayDate.setDate( todayDate.getDate() + expiredays );
		document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
} //setCookie() end

function cookie_end(){
	if(document.form_pop.input_chk.checked)
		setCookie("pop", "true", 1);
		self.close();
}//cookie_end() end

</script>
</head>
<body bgcolor= #252220 style="width: 275; height: 560;" >
<form name="form_pop">

<img src="images/certpopup.jpg"><p>

<div  style="margin-left: 500; width: 700;">
<input type="checkbox" id="chk" name="input_chk">
<label for="chk" ><font style="color: #FFFFFF" >이 창을 닫습니다.</font></label>
<a title="이 창을 닫습니다" href="javascript:cookie_end()">
<font style="color: #FFFFFF"><b>[닫기X]</b></font></a><p>
</div>
</form>
</body>