<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>Login</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
<link href="css/login/style.css" rel='stylesheet' type='text/css' />
 <script type="text/javascript" src="plug-in/jquery/jquery-1.11.2.min.js"></script>
 <script type="text/javascript" src="js/system/login.js"></script>
</head>
<body>
<script>$(document).ready(function(c) {
	$('.close').on('click', function(c){
		$('.login-form').fadeOut('slow', function(c){
	  		$('.login-form').remove();
		});
	});	  
});
</script>
<div id="login-form-wrap">
<div class="login-form-wrap">
	<h1>学生成绩管理系统</h1>
	<div class="login-form">
		<form action="loginController.do?doLogin" method="post" check="loginController.do?doCheck" >
			<input type="text"  id="username" name="username"  placeholder="用户名" >
			<input type="password"  id="password" name="password" placeholder="密码">
	        		<br/>
	        		<div id="errormsg" style="color: red"></div>
	        		<input id="login" type="button" style="width:100%" value="登陆">
		</form>
	</div>
</div>
</div>
</body>
</html>