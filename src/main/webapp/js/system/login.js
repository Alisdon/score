$(document).ready(function() {
	onfocus();
	$('#login').click(function(e) {
		submitform();
	});
});
function onfocus(){
	$("#username").focus();
}


//回车登录
$(document).keydown(function(e){
	if(e.keyCode == 13) {
		submitform();
	}
});

function submitform(){
	$("#errormsg").text("");
	if($("#username").val() == ""){
		$("#errormsg").text("请输入用户名！");
		return false;
	}
	if($("#password").val() == ""){
		$("#errormsg").text("请输入密码！");
		return false;
	}
	
	
	var actionurl = $('form').attr('action');
	var checkurl = $('form').attr('check');
	var username = "username="+$("#username").val();
	var password = "password="+$("#password").val();
	var formData = username+"&"+password;
	
	$.ajax({
		async : false,
		cache : false,
		type : 'POST',
		url : checkurl,// 请求的action路径
		data : formData,
		error : function() {// 请求失败处理函数
		},
		success : function(d) {
			if (d.success) {
				window.location.href = actionurl;
			}else{
				$("#errormsg").text(d.msg);
			}
		}
	});
}
