<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@include file="/pages/system/base.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta HTTP-EQUIV="pragma" CONTENT="no-cache"> 
	<meta HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate"> 
	<meta HTTP-EQUIV="expires" CONTENT="0"> 
	<title>学生成绩管理系统</title>
	
</head>
<body  class="easyui-layout">

<!-- 顶部-->
	<div region="north" border="false" title="" style="BACKGROUND: #A8D7E9;padding: 1px; overflow: hidden;">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td align="left" style="vertical-align: text-bottom"><font>学生成绩管理系统</font>
				</td>
				<td align="right" nowrap>
				<table border="0" cellpadding="0" cellspacing="0">
					<tr style="height: 25px;" align="right">
						<td style="" colspan="2">
						<div style="float: right;"><input type="hidden" name='id' value="${userId}">
						<div style="float: left; line-height: 25px; margin-left: 70px;"><span style="color: #386780">当前用户:</span> <span style="color: #FFFFFF">${username }</span>&nbsp;&nbsp;&nbsp;&nbsp; <span
							style="color:#FFFFFF;cursor:pointer" onclick="editUser()">个人信息</span><span style="color: #FFFFFF;margin:20px;cursor: pointer;" onclick="exit('loginController.do?logout','确定退出该系统吗 ?');">注销</span></div>
						</div>
						</div>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
	</div>
	
	<div data-options="region:'west',split:true,title:'导航菜单'" style="width:150px;padding:10px;">
		<ul id="subMenus" class="easyui-tree" 
			data-options="url:'loginController.do?getTreeMenu',
						method:'get',animate:true,
						onClick: function(node){
							openTab(node.text, node.attributes.href);
						}">
		</ul>
	</div>

	<div data-options="region:'center'">
		<div id="main-tabs" class="easyui-tabs" data-options="fit:true,border:false,plain:true">
			<div class="easyui-tab" title="首页" href="loginController.do?home" style="overflow: hidden;"></div>
		</div>
	</div>
	<div id="dlgupdate" class="easyui-dialog" data-options="modal:true" title="数据参数" style="width: 400px; height: 400px;" closed="true" buttons="#dlg-buttonsupdate">
	<form method="post" id="fmupdate">
			<table cellpadding="5">
				<tr>
					<td><input type="hidden" name="id" /><input type="hidden" name="flag"></td>
				</tr>
	    		<tr>
	    			<td>用户名:</td>
	    			<td><input class="easyui-textbox" type="text" disabled="disabled" name="username" maxlength="10"  ></input></td>
	    		</tr>
	    		<tr id="tr1">
	    			<td>密码:</td>
	    			<td><input class="easyui-textbox" validtype="safepass" type="password" id="password" name="password" maxlength="20" required="true" missingMessage="密码必须填写"></input></td>
	    		</tr>
	    		<tr id="tr2">
	    			<td>重复密码:</td>
	    			<td><input class="easyui-textbox" validtype="passwordEqual(this.val,'password')" type="password" name="password2" required="true" missingMessage="重复密码必须填写"></input></td>
	    		</tr>
	    		<tr>
	    			<td>真实姓名:</td>
	    			<td><input class="easyui-textbox" maxlength="10" type="text" name="realName"  ></input></td>
	    		</tr>
	    		<tr>
	    			<td>电子邮件:</td>
	    			<td><input class="easyui-textbox" validtype="email" maxlength="30" type="text" name="email" ></input></td>
	    		</tr>
	    		<tr>
	    			<td>电话:</td>
	    			<td><input class="easyui-textbox" type="text" name="phone" validtype="mobile" ></input></td>
	    		</tr>
	    		<tr>
	    			<td>职务:</td>
	    			<td><input class="easyui-textbox" type="text" name="position" ></input></td>
	    		</tr>
	    		<tr>
	    			<td>职务说明:</td>
	    			<td><input class="easyui-textbox" type="text" name="positonDesc" ></input></td>
	    		</tr>
	    		<tr>
	    			<td>状态:</td>
	    			<td><input id="certType" type="radio" name="status" class="easyui-validatebox" checked="checked" value="1"><label>正常</label></input>
            			<input id="certType" type="radio" name="status" class="easyui-validatebox" value="2"><label>禁用</label></td>
	    		</tr>
	    	</table>
		</form>
	</div>
	<div id="dlg-buttonsupdate">
		<a href="#" class="easyui-linkbutton  save" onclick="updateUser()" iconCls="icon-ok">保存</a> 
		<a href="#" class="easyui-linkbutton cancel" onclick="javascript:$('#dlgupdate').dialog('close')" iconCls="icon-cancel">取消</a>
	</div>
</div>
</body>
	<script type="text/javascript">
		function openTab(title, url) {
			if("/" != url){
				var mainTabs = $("#main-tabs");
				if (mainTabs.tabs('exists', title)) {
					mainTabs.tabs('select', title);
					var iframeContext = mainTabs.tabs('getTab', title).find("iframe");
					if(iframeContext){
						iframeContext[0].src = url
					} 
				} else {
					mainTabs.tabs('add', {
						title : title,
						content : createFrame(url),
						closable : true
					});
				}
			}
		}
		function createFrame(url) {
			var s = '<iframe name="mainFrame" scrolling="auto" frameborder="no" border="0" marginwidth="0" marginheight="0"  allowtransparency="yes" src="'
					+ url + '" style="width:100%;height:99%;"></iframe>';
			return s;
		}
		
		function editUser(){
				$.ajax({
					url : 'userController.do?queryRole',
					type : 'post',
					async:false,
					data : {
						id : $('[name="id"]').val()
					},
					cache : false,
					success : function(result) {
						if (result.success){
							$('#fmupdate').form('clear');
							$('#fmupdate').form('load',result.obj);
							$('.easyui-combobox').combobox("setValues",result.obj.roleId);
							$('#dlgupdate').dialog('open').dialog('setTitle','编辑');
						} else {
							$.messager.show({	
								title: '提示信息',
								msg: result.msg
							});
						}
					}
				});
		}
		function updateUser(){
			$('#fmupdate').form('submit',{
				url: 'userController.do?update',
				onSubmit: function(){
					$('[name="flag"]').val('true');
					return $(this).form('validate');
				},
				success: function(res){
					var result = JSON.parse(res);
					if (result.success){
						$('#dlgupdate').dialog('close');		
						$('#dg').datagrid('reload');	
						$.messager.show({
							title: '提示信息',
							msg: result.msg
						});
					} else {
						$.messager.show({
							title: '提示信息',
							msg: result.msg
						});
					}
				}
			});
		}
	</script>
</html>