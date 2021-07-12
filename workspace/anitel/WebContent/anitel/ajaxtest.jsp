<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
<script
  src="https://code.jquery.com/jquery-3.5.1.min.js"
  integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0="
  crossorigin="anonymous"></script>
<script>
$(function() {
    $('#checkJson').on('click', () => {
        const jsonStr = '{"member":[{"name":"김공","age":26,"nick":"kimball"},'
        + '{"name":"이불","age":21,"nick":"FireLee"}]}'
        console.log(jsonStr)
        const jsonInfo = JSON.parse(jsonStr)

        let output = '회원 정보<hr>'

        for(const i in jsonInfo.member) {
            output += '이름 : ' + jsonInfo.member[i].name + '<br>'
            output += '나이 : ' + jsonInfo.member[i].age + '<br>'
            output += '별명 : ' + jsonInfo.member[i].nick + '<hr>'
        }

        $('#output').html(output)
    })
})
</script>
</html>