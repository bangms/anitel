$(document).ready(function(){
	$("#review_write_btn").click(function(){
       $("#wrtie_form").toggleClass("hidden");
    });	
	
	$("#ajax").click(function() {
		var form = $("#ajaxForm")[0];
		var formData = new FormData(form);
		
		$.ajax({
			url : "detailPro.jsp",
			entype: 'multipart/form-data',
			type : "POST",
			data:formData,
			dataType:'json',			
			contentType: false,
			processData: false,
			success: function (data) {
				// 전송 후 성공 시 실행 코드
				alert("등록되었습니다!");
				console.log(data);
			},
			error: function(request,status,error){
		        console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		      }
		});
		
	});
});