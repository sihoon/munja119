function openWindow(url, id, width, height)
{
	var w = window.open(url,id,"width="+width+" height="+height+",resizeable=no , scrollbars=no");
	w.focus();
	return false;
}

function radioValue(obj) {
	
	var rslt = "";
	for( var i = 0; i < obj.length; i++){
		if(obj[i].checked) rslt = obj[i].value;
	}

	return rslt;
}

function billingMethod() {
	
	var f = document.form;
	var rslt = radioValue(f.method);

	if (rslt == "cash") {
		document.getElementById("cashBox").style.display = "block";
		document.getElementById("etcBox").style.display = "none";
	}else {
		document.getElementById("cashBox").style.display = "none";
		document.getElementById("etcBox").style.display = "block";
	}
}

function billingCheck() {

	var f = document.form;
	var method = radioValue(f.method);
	var amount = radioValue(f.amount);
	if (method=="") {
		alert("결제방식이 없습니다.");
		return;
	}
	
	if (amount == "") {
		alert("결제금액이 없습니다.");
		return;
	}
	
	document.formBilling.smethod.value = method;
	document.formBilling.amount.value = amount;
	document.formBilling.submit();
	
}

function taxWindow(idx) {
	
	return openWindow("my/tax.jsp?idx="+idx,"tax",400,500);
}

function checkTax() {
	var f = document.form;
	if (!f.comp_name.value) {
		alert("회사명을 입력하세요.");
		f.comp_name.focus();
	}else if (!f.comp_no.value) {
		alert("사업자번호를 입력하세요.");
		f.comp_no.focus();
	}else if (!f.name.value) {
		alert("이름을 입력하세요.");
		f.name.focus();
	}else if (!f.addr.value) {
		alert("주소를 입력하세요.");
		f.addr.focus();
	}else if (!f.upte.value) {
		alert("업태를 입력하세요.");
		f.upte.focus();
	}else if (!f.upjong.value) {
		alert("업종을 입력하세요.");
		f.upjong.focus();
	}else if (!f.email.value) {
		alert("이메일을 입력하세요.");
		f.email.focus();
	} else {
		f.submit();
	}
}

function cardWindow(idx) {
	return openWindow("my/card.jsp?idx="+idx,"card",200,200);
}

function visible(obj) {
	if (obj.style.display == "none") obj.style.display = "block";
	else obj.style.display = "none";
}