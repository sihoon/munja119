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
	
	var method = radioValue(f.method);
	var amount = radioValue(f.amount); 
	
}