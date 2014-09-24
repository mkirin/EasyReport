<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp-views/frame/pageInclude.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="keywords" content="reporting,web reporting,easy report,big data,data analysis" />
<meta name="description" content="A simple and easy to use Web Report System ." />
<title>EasyReport - a simple and easy to use Web Report System</title>
<%@ include file="/WEB-INF/jsp-views/frame/pageHeader.jsp"%>
<script type="text/javascript" src="<%=request.getContextPath()%>/static/report/js/easyreport.reporting.js?v=<%=Math.random()%>"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/static/plugins/codehighlight/codemirror.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/static/plugins/codehighlight/theme/rubyblue.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/static/plugins/codehighlight/addon/display/fullscreen.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/static/plugins/codehighlight/codemirror.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/static/plugins/codehighlight/mode/sql.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/static/plugins/codehighlight/addon/display/fullscreen.js"></script>
</head>
<body class="easyui-layout" style="text-align: left">
	<div region="west" split="true" title="报表列表" style="width: 250px; padding: 5px;">
		<ul id="reportingTree"></ul>
		<input type="hidden" id="copyNodeId" name="copyNodeId" value="0" />
	</div>
	<div region="center">
		<div id="tabs" class="easyui-tabs" fit="true" border="false" plain="true">
			<div id="reportingTab" title="报表配置" style="padding: 5px;">
				<div>
					<form id="reportingForm" method="post">
						<table cellpadding="0" class="formStyle" cellspacing="0" style="width: 99%;">
							<tr>
								<td class="text_r blueside" width="60">数据源:</td>
								<td><input id="reportingDsId" name="dsId" /></td>
								<td class="text_r blueside">布局形式:</td>
								<td><select id="reportingLayoutType" name="layoutType">
										<option value="1">横向布局</option>
										<option value="2">纵向布局</option>
								</select></td>
								<td class="text_r blueside">显示几天数据:</td>
								<td><input type="text" id="reportingDataRange" name="dataRange" value="7" /></td>
							</tr>
							<tr>
								<td class="text_r blueside">报表名称:</td>
								<td><input type="text" id="reportingName" name="name" style="width: 99%;" /></td>
								<td class="text_r blueside">状态:</td>
								<td><select id="reportingStatus" name="status">
										<option value="0">编辑</option>
										<option value="1">锁定</option>
										<option value="2">隐藏</option>
								</select></td>
								<td class="text_r blueside">显示顺序:</td>
								<td><input type="text" id="reportingSequence" name="sequence" value="100" /><input id="reportingId" type="hidden" name="id" value="0" />
									<input id="reportingAction" type="hidden" name="action" value="add" /><input type="hidden" id="reportingUid" name="uid" /> <input
									type="hidden" id="reportingPid" name="pid" value="0" /><input type="hidden" id="reportingIsChange" name="isChange" value="0" /></td>
							</tr>
							<tr>
								<td class="text_r blueside top">报表SQL:</td>
								<td id="reportingSqlTextTd" colspan="5"><textarea id="reportingSqlText" name="sqlText"></textarea></td>
							</tr>
							<tr>
								<td colspan="6" style="text-align: center;"><a href="javascript:void(0)" class="easyui-linkbutton" icon="icon-ok"
									onclick="javascript:Reporting.executeSql()">执行SQL</a>&nbsp;&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton"
									onclick="javascript:Reporting.viewSqlText()">预览SQL</a>&nbsp;&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton"
									onclick="javascript:Reporting.viewSqlHistory()">查看SQL历史记录</a>&nbsp;&nbsp;<a id="reportingNewBtn" href="javascript:void(0)"
									class="easyui-linkbutton" icon="icon-add" onclick="javascript:Reporting.save()">新增</a> &nbsp;&nbsp; <a id="reportingEditBtn"
									href="javascript:void(0)" class="easyui-linkbutton" icon="icon-edit" onclick="javascript:Reporting.save()">修改</a>&nbsp;&nbsp; <a
									id="reportingPreviewBtn" href="javascript:void(0)" class="easyui-linkbutton" icon="icon-preview"
									onclick="javascript:Reporting.previewInNewTab()">报表预览</a></td>
							</tr>
						</table>
					</form>
				</div>
				<div style="height: 74%;">
					<div id="sqlColumnGrid" title="SQL列配置"></div>
				</div>
			</div>
			<div id="reportingQueryParam" title="查询参数" style="padding: 5px;">
				<div>
					<form id="queryParamForm" method="post">
						<table cellpadding="0" class="formStyle" cellspacing="0" style="width: 99%;">
							<tr>
								<td class="text_r blueside" width="60">参数名:</td>
								<td><input id="queryParamName" name="name" type="text" /></td>
								<td class="text_r blueside">标题:</td>
								<td><input type="text" id="queryParamText" name="text" /></td>
							</tr>
							<tr>
								<td class="text_r blueside">默认值:</td>
								<td><input type="text" id="queryParamDefaultValue" name="defaultValue" /></td>
								<td class="text_r blueside">默认标题:</td>
								<td><input type="text" id="queryParamDefaultText" name="defaultText" /></td>
							</tr>
							<tr>
								<td class="text_r blueside top">表单控件:</td>
								<td><select id="queryParamFormElement" name="formElement">
										<option value="select">下拉框</option>
										<option value="selectMul">下拉框多选</option>
										<option value="checkbox">复选框</option>
										<option value="text">文本框</option>
								</select></td>
								<td class="text_r blueside">内容来源类型</td>
								<td><select id="queryParamOptionType" name="optionType">
										<option value="0">SQL语句</option>
										<option value="1">文本字符串</option>
										<option value="2">无内容</option>
								</select></td>
							</tr>
							<tr>
								<td class="text_r blueside top">控件内容:</td>
								<td colspan="3"><textarea id="queryParamSqlText" name="sqlText" style="width: 99%; height: 140px;"></textarea> </br>
									<p style="color: red; bold: true">注意：如为SQL则必须包含两列且列名必须为name与text.(eg:select col1 as name,col1 as text from
										table);如为文本字符串则格式为:name1,text1|name2,text2|...,如果name与text相同格式为：name1|name2|...</p> <input id="queryParamGridIndex" type="hidden" value="" /> <input
									type="hidden" id="jsonQueryParams" /><input id="queryParamReportId" type="hidden" value="0" /></td>
							</tr>
							<tr>
								<td colspan="4" style="text-align: center;"><a href="javascript:void(0)" class="easyui-linkbutton" icon="icon-add"
									onclick="javascript:Reporting.setQueryParam('add')">增加</a> &nbsp;&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton"
									icon="icon-edit" onclick="javascript:Reporting.setQueryParam('edit')">修改</a>&nbsp;&nbsp;<a href="javascript:void(0)"
									class="easyui-linkbutton" icon="icon-save" onclick="javascript:Reporting.saveQueryParam()">保存</a></td>
							</tr>
						</table>
					</form>
				</div>
				<div style="height: 74%;">
					<div id="queryParamGrid" title="查询参数列表"></div>
				</div>
			</div>
		</div>
	</div>
	<!-- 增加与修改树节点弹框  -->
	<div id="setTreeNodeDlg">
		<form id="setTreeNodeForm" method="post">
			<table cellpadding="0" class="formStyle" cellspacing="0" style="width: 99%; height: 99%">
				<tr id="setTreeNodeParentNodeNameTr">
					<td class="text_r blueside" width="60">父节点:</td>
					<td><label id="parentNodeName"></label></td>
				</tr>
				<tr id="setTreeNodeFlagTr">
					<td class="text_r blueside" width="60">节点类型:</td>
					<td><select id="setTreeNodeFlag" name="flag">
							<option value="0">树节点</option>
							<option value="1">报表节点</option>
					</select></td>
				</tr>
				<tr>
					<td class="text_r blueside" width="60">节点名称:</td>
					<td><input id="setTreeNodeName" name="name" class="easyui-validatebox" required="true" style="width: 99%;" /></td>
				</tr>
				<tr>
					<td class="text_r blueside" width="60">显示顺序:</td>
					<td><input type="text" id="setTreeNodeSequence" name="sequence" value="100" /><input id="hiddenFormId" type="hidden" /></td>
				</tr>
				<tr id="setTreeNodeHasChildTr">
					<td class="text_r blueside" width="60">子节点:</td>
					<td><select id="setTreeNodeHasChild" name="hasChild">
							<option value="0">无</option>
							<option value="1">有</option>
					</select></td>
				</tr>
				<tr id="setTreeNodeStatusTr">
					<td class="text_r blueside" width="60">状态:</td>
					<td><select id="setTreeNodeStatus" name="status">
							<option value="0">编辑</option>
							<option value="1">锁定</option>
							<option value="2">隐藏</option>
					</select></td>
				</tr>
				<tr>
					<td class="text_r blueside top">备注:</td>
					<td><textarea id="setTreeNodeComment" name="comment" style="width: 99%; height: 130px;"></textarea> <input id="treeNodeAction" type="hidden"
						name="action" value="add" /><input type="hidden" id="treeNodeId" name="id" value="0" /> <input type="hidden" id="treeNodePid" name="pid"
						value="0" /></td>
				</tr>
			</table>
		</form>
	</div>
	<!-- 查看报表SQL弹框  -->
	<div id="viewSqlTextDlg" title="查看报表SQL">
		<table cellpadding="0" class="formStyle" cellspacing="0" style="width: 99%; height: 99%">
			<tr>
				<td class="top"><textarea id="viewSqlText" name="sqlText" style="width: 99%; height: 99%;"></textarea></td>
			</tr>
		</table>
	</div>
	<!-- 查看报表SQL历史记录弹框  -->
	<div id="viewSqlTextHistoryDlg" title="查看报表SQL历史记录">
		<table cellpadding="0" class="formStyle" cellspacing="0" style="width: 99%; height: 99%">
			<tr>
				<td class="text_center blueside top" style="width: 300px;">版本历史</td>
				<td class="text_center blueside top">版本记录</td>
			</tr>
			<tr>
				<td class="top"><div id="viewSqlTextHistoryGrid"></div></td>
				<td class="top"><textarea id="viewSqlTextHistory" name="sqlText" style="width: 99%; height: 99%;"></textarea></td>
			</tr>
		</table>
	</div>
	<!-- 设置计算列表达式弹框  -->
	<div id="expressionSettingsDlg" title="设置表达式">
		<table cellpadding="0" class="formStyle" cellspacing="0" style="width: 99%; height: 99%">
			<tr>
				<td class="top"><textarea id="sqlColumnExpression" name="expression" style="width: 98%; height: 215px;"></textarea></td>
			</tr>
		</table>
	</div>
	<!-- 查找报表弹框  -->
	<div id="searchReportDlg" title="查找报表">
		<table cellpadding="0" class="formStyle" cellspacing="0" style="width: 99%; height: 99%">
			<tr>
				<td class="text_r blueside" width="60">选项:</td>
				<td><select id="searchReportFieldName" name="fieldName">
						<option value="name">名称</option>
						<option value="uid">代码</option>
						<option value="create_user">创建者</option>
				</select></td>
				<td class="text_r blueside">关键字:</td>
				<td><input type="text" id="searchReportKeyword" name="keyword" style="width: 98%;" /></td>
				<td colspan="2"><a href="javascript:void(0)" class="easyui-linkbutton" icon="icon-ok" onclick="javascript:Reporting.search();">查找</a></td>
			</tr>
			<tr class="top">
				<td id="searchReportGridTd" colspan="6"><div id="searchReportGrid" title="报表列表"></div></td>
			</tr>
		</table>
	</div>
	<!-- tree右键菜单  -->
	<div id="reportingTreeCtxMenu" class="easyui-menu" data-options="onClick:Reporting.treeContextMenu" style="width: 220px;">
		<div id="m-addRp" data-options="name:'addRp',iconCls:'icon-add'">新增报表</div>
		<div id="m-comment" data-options="name:'comment',iconCls:'icon-comment2'">设置节点</div>
		<div id="m-info" data-options="name:'info',iconCls:'icon-tip'">报表属性</div>
		<div class="menu-sep"></div>
		<div id="m-copy" data-options="name:'copy',iconCls:'icon-copy'">复制</div>
		<div id="m-paste" data-options="name:'paste',iconCls:'icon-paste',disabled:'true'">粘贴</div>
		<div id="m-search" data-options="name:'search',iconCls:'icon-search'">查找</div>
		<div class="menu-sep"></div>
		<div id="m-add" data-options="name:'add',iconCls:'icon-add'">新增节点</div>
		<div id="m-edit" data-options="name:'edit',iconCls:'icon-edit'">修改节点</div>
		<div id="m-remove" data-options="name:'remove',iconCls:'icon-remove'">删除节点</div>
		<div class="menu-sep"></div>
		<div id="m-refresh" data-options="name:'refresh',iconCls:'icon-reload'">刷新</div>
	</div>
	<!-- tabs右键菜单  -->
	<div id="tabCtxMenu" class="easyui-menu" data-options="onClick:Reporting.tabContextMenu" style="width: 220px;">
		<div id="m-current" data-options="name:'current',iconCls:'icon-cancel'">关闭当前页</div>
		<div id="m-others" data-options="name:'others',iconCls:''">关闭其他页</div>
		<div id="m-all" data-options="name:'all',iconCls:''">关闭所有页</div>
	</div>
</body>
</html>