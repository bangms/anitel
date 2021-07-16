$(document).ready(function(){
	$("#review_write_btn").click(function(){
       $("#wrtie_form").toggleClass("hidden");
    });	
	
	$("#ajax").click(function() {
		var form = $("#ajaxForm")[0];
		var formData = new FormData(form);
		
		$.ajax({
			url : "detailAddReview.jsp",
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
	
	$(".review tr#review_article").click(function(){
		var board_num = $(this).children(".board_num").val();
		
		$.ajax({
			url : "detailReadContent.jsp",
			type : "POST",
			data : "board_num=" + board_num,
			dataType: "json",
			success : function(data){
					var list = 
						"<table  border ='1' rules='none'>"+
							"<tr>"+
								"<td>"+data.reg_date+"</td>"+
							"</tr>"+
							"<tr>"+
								"<td>"+data.ctt+"</td>"+
							"</tr>"+
							"<tr>"+
								"<td>"+data.img+"</td>"+
							"</tr>"+
							"<tr>"+
								"<td>제목 : "+data.subject+"</td>"+
							"</tr>"+
							"<tr>"+
								"<td>"+data.id+"</td>"+
							"</tr>"+
						"</table>";
					$("#rs").empty();
					$("#rs").append(list);
					$("#rs").show();	
			},
			error : function(request,status,error){
				        console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				      }
		   
		});
	});
	
	
});