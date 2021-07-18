	
//공백확인 함수
function checkExistData(value, dataName) {
    if (value == "") {
        alert(dataName + " 입력해주세요!");
        return false;
    }
    return true;
}

function checkUserName(user_name) {
	if (!checkExistData(user_name, "이름을"))
	    return false;
	var nameRegExp = /^[가-힣]{2,5}$/;
		if (!nameRegExp.test(user_name)) {
		    alert("이름은 2~5자 사이의 한글만 가능합니다.");
		    return false;
		}
		return true; //확인이 완료되었을 때
}

function checkEmail(user_email) {
    if (!checkExistData(user_email, "이메일을"))
        return false;
    var emailRegExp = /^[A-Za-z0-9_]+[A-Za-z0-9]*[@]{1}[A-Za-z0-9]+[A-Za-z0-9]*[.]{1}[A-Za-z]{1,3}$/;
    if (!emailRegExp.test(user_email)) {
        alert("이메일 형식이 올바르지 않습니다!");
        return false;
    }
    return true; //확인이 완료되었을 때
}

function checkPhone(user_phone) {
    if (!checkExistData(user_phone, "1전화번호를"))
        return false;
    var phoneRegExp = /^\d{2,3}-\d{3,4}-\d{4}$/;
    if (!phoneRegExp.test(user_phone)) {
        alert("1전화번호는 숫자만 가능합니다!");
        return false;
    }
    return true; //확인이 완료되었을 때
}
