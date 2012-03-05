function juminValidate(jumin) {
	var tab = [2, 3, 4, 5, 6, 7, 8, 9, 2, 3, 4, 5];
	var num = new Array();
	num[0] = jumin.substring(0,1);
	num[1] = jumin.substring(1,2);
	num[2] = jumin.substring(2,3);
	num[3] = jumin.substring(3,4);
	num[4] = jumin.substring(4,5);
	num[5] = jumin.substring(5,6);
	num[6] = jumin.substring(6,7);
	num[7] = jumin.substring(7,8);
	num[8] = jumin.substring(8,9);
	num[9] = jumin.substring(9,10);
	num[10] = jumin.substring(10,11);
	num[11] = jumin.substring(11,12);
	num[12] = jumin.substring(12,13);

	var sum = 0;
	
	for(var i = 0; i < 12; i++) { 
		sum += num[i] * tab[i];
	}

	return ((11-(sum % 11)) % 10 == num[12])? true:false;

}

function check1() {

	if (!document.getElementById("sub1ok").checked) {
		alert("이용약관에 동의 하세요.");
		return false;
	}
	
	if (!document.getElementById("sub2ok").checked) {
		alert("개인정보보호방침에 동의 하세요.");
		return false;
	}
	
	window.location.href='?content=join2';
}

function check2() {
	var f = document.form;
	
	if (!f.name.value) { alert("이름을 입력하세요."); f.name.focus(); return false; }
	if (!f.jumin1.value) { alert("주민등록번호를 입력 하세요."); f.jumin1.focus(); return false; }
	if (!f.jumin2.value) { alert("주민등록번호를 입력 하세요."); f.jumin2.focus(); return false; }
	
	if ( !juminValidate( f.jumin1.value + f.jumin2.value ) ) {
		alert("잘못된 주민등록 번호 입니다.");
		f.jumin1.focus();
		return false;
	}
	f.submit();
}