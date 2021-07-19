
	$(document).ready(function() {		
		var pet_num = $("#pet").val();
		

		$.fn.checkboxSelect = function(val) {
			if(!Array.isArray(val))
				val = [val];
			
			this.each(function() {
				var $this = $(this);
				var map = val.reduce(function(accu, v) {
					accu[v] = true;
					return accu;
				}, []);
				map[$this.val()] ? $this.attr('checked', true) : $this.attr('checked', false);
			});
			return this;
		};
		
		$.fn.radioSelect = function(val) {
			this.each(function() {
				var $this = $(this);
				
				if($this.val() == val) {
					$this.attr('checked', true);
				}
			});
			return this;
		};
		
		
		$("#pet").change(function() {
			pet_num = $(this).val();
			$.ajax({
				url : "petCheckPro.jsp",
				type : "POST",
				data : "pet_num=" + pet_num,
				dataType: "json",
				success : function(data){
					console.log(data.pet_etctype);
					$(":radio[name='pet_gender']").radioSelect(data.pet_gender);
					$(":radio[name='pet_operation']").radioSelect(data.pet_operation);
					
					$(":checkbox[name='pet_big']").checkboxSelect(data.pet_big);
					
					$("#pet_type").val(data.pet_type).prop("selected", true);
					if(data.pet_type == 2) {
						document.getElementById('pet_etctype').classList.replace('hidden', 'show');
					} else {
						document.getElementById('pet_etctype').classList.replace('show', 'hidden');
					}
											
					$("input[name=pet_etctype]").attr("value",data.pet_etctype);
					$("input[name=pet_name]").attr("value",data.pet_name);
					$("input[name=pet_age]").attr("value",data.pet_age);
				},
				error : function(request,status,error){
					        console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					      }		   
			});
			
		});
		
	});
	
