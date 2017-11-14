<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath %>"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="frame/layui/css/layui.css" />
<link rel="stylesheet" type="text/css" href="frame/static/css/commodityAll.css"/>
<link rel="stylesheet" type="text/css" href="frame/static/layer/skin/default/layer.css"/>
<title>商品管理-所有商品</title>
<style type="text/css">
#shop_select{
	height: 82px;
    overflow: hidden;
}
#div_select{
	float: right;
    margin-right: 20px;
}
.update_discount label{
	width: 100px;
    display: inline-block;
    text-align: right;
}
</style>
</head>
<body>
	<div class="Screening"> 
		<div id="right_top" class="right-top">
			
		</div>
		<div class="items">
			<label>搜索</label><input>
			<a href="javascript:;"></a>
		</div>
	</div>
	<input type="hidden" id="brand" name="brand"/>
	<input type="hidden" id="gg" name="gg"/>
	<input type="hidden" id="pyname" name="pyname"/>
	<input type="hidden" id="other" name="other"/>
	<br />
	<div id="shop_select"></div>
	<br />
	<div class="layui-form">
		<table class="layui-table">
			<colgroup>
				<col width="120">
				<col width="120">
				<col width="220">
				<col width="100">
				<col width="70">
				<col width="90">
				<col width="50">
				<col width="70">
				<col width="80">
				<!-- <col width="110">
				<col width="85"> -->
				<col>
			</colgroup>
			<tr>
				<th id="thColor">
					<div class="iconMove">
						<input type="checkbox" name="" lay-skin="primary" id="allchecked">产品代码
					</div>
				</th>
				<th id="thColor">品牌标识符</th>
				<th id="thColor">产品规格</th>
				<th id="thColor">库存</th>
				<th id="thColor">启停状态</th>
				<th id="thColor">最小起订量</th>
				<th id="thColor">价格</th>
				<th id="thColor">客户等级</th>
				<!-- <th id="thColor">默认交期</th>
				<th id="thColor">默认订购递增量</th> -->
				<th id="thColor">操作</th>
			</tr>
		</table>
	</div>
	<div class="commodityDetail">
		
	</div>
	<div class="commodityCheck" style="margin-top: 54px;">
		<div class="commodityCheckAll"></div>
		<div id="conuntPage" class="left"></div>
		<div id="demo3" class="right"></div>
	</div>
</body>
<script type="text/javascript" src="frame/static/js/jquery-1.11.1.min.js"></script>
<script src="frame/layui/layui.js" type="text/javascript"></script>
<script type="text/javascript" src="frame/static/js/commodityAll.js"></script>
<script type="text/javascript" src="frame/static/layer/layer.js"></script>
