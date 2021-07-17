
	$(document).ready(function() {
		var pet_num = $("#pet").val();
		 
		$("#pet").change(function() {
			pet_num = $(this).val();
			$.ajax({
				url : "petCheckPro.jsp",
				type : "POST",
				data : "pet_num=" + pet_num,
				dataType: "json",
				success : function(data){
					$("input[name=pet_name]").attr("value",data.pet_name);
					$("input[name=pet_type]").attr("value",data.pet_type);
					$("input[name=pet_gender]").attr("value",data.pet_gender);
					$("input[name=pet_age]").attr("value",data.pet_age);
					$("input[name=pet_big]").attr("value",data.pet_big);
					$("input[name=pet_operation]").attr("value",data.pet_operation);
				},
				error : function(request,status,error){
					        console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					      }		   
			});
			
		});
			 
	});
	
