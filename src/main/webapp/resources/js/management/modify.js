$(function() {
	$("#listManagement").click(function() {
		location.href = "list?management="+$("input[name='management']").val();
	})
	
	/* $("#cancelUpdate").click(function() {
		var managementId = Number($("input[name='departmentId']").val());
		location.href = "read?management="+$("input[name='management']").val()+"&managementId="+managementId;
	}) */
	
	$("#updateEquipmentForm").submit(function() {
		var result = confirm("수정하시겠습니까?");
		
		if(result == false) {
			return false;
		}
	})
})