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
<link rel="stylesheet" type="text/css" href="frame/static/css/layui.css" />
<link rel="stylesheet" type="text/css" href="frame/static/css/commodityAll.css"/>
<link rel="stylesheet" type="text/css" href="frame/static/css/padding_and_marign.css"/>
<link rel="stylesheet" type="text/css" href="frame/static/layer/skin/default/layer.css"/>
<title>商品管理-发布商品</title>
<style>
html {
overflow-x:hidden;
}
#fiflterCommodity input,.commodityCheckSell input{
	display:inherit !important;
}
.right-top {
    height: auto;
    margin: 0 auto;
    width: 100%;
    color: #666666;
    font-size: 14px;
}
.right-top .items .items-tit {
    text-align: center;
       padding-left: 10px;
}
.fl {
    float: left;
}	
.right-top .items span {
    display: inline-block;
    padding: 0 10px;
}
.right-top .items span:hover {
    color: #b1191a;
    cursor: pointer;
}
.items>label{
	width: 66px;
    /* text-align: center; */
	color: #666;
    display: inline-block;
    padding-left: 10px;
}
.items>input{
	padding:3px;
}
.items>a{
	height: 20px;
    width: 20px;
    display: inline-block;
    background: url(frame/static/img/search.png) no-repeat;
    margin: 5px;
    background-size: 20px;
    vertical-align: middle;
}
.table_row_cell{
	float: left;
	width: 200px;
	margin-bottom: 10px;
}
#shop_select{
	height: 82px;
    overflow: hidden;
}
#div_select{
	float: right;
    margin-right: 20px;
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
	<div id="shop_select">
		
	</div>
	<br />
	<button id="sreach_c" style="display: none;" class="layui-btn layui-btn-small sreaching">搜索</button>
	<div class="formSell">
		<div class="layui-form">
			<table id="fiflterCommodity" class="layui-table">
				<!-- 数据填充 -->
				<tr>
					<th>
						<span class="vertical-m margin-left-10">产品代码</span>
					</th>
					<th>产品规格</th>
					<th>库存</th>
					<th>状态</th>
					<th>最小起订量</th>
					<th>价格</th>
					<th>客户等级</th>
					<th>操作</th>
				</tr>
			</table>
		</div>
	</div>
	
	<div class="commodityCheck" style="margin-top: 24px;">
		<div class="commodityCheckAll"></div>
		<input class="left" style="height:59px;" type="checkbox"  id="allchecked">
		<span class="font-888 margin-left-5 left">全选</span>
		
		<div id="conuntPage" class="margin-left-15 left"></div>
		<div id="demo3" class="right"></div>
	</div>
	
	<!-- <div class="layui-form">
		<div class="commoditySellCheck">
			<div class="commodityCheckSell">
				<div class="left">
					<input class="margin-left-15 left" style="height:59px;" type="checkbox"  id="allchecked">
					<span class="font-888 margin-left-5">全选</span>
					<span id="totalPage" class="font-888 margin-left-5"></span>
				</div>
				<div id="pages" class="right"></div>
				<div class="clear"></div>
			</div>
		</div>
	</div> -->
	
	<div class="allRevise" style="width: 100%;background-color: white;">
		<p id="comfirmSet">
			<span>批量设置：</span>
		</p>
		
			<div class="table_row_cell margin-left-25" >
				<label class="Revise leftMove">默认交期：</label>
				<input type="text" id="defaultPayDt" name="defaultPayDt" class="comfirm" value="10" />
			</div>
			<div class="table_row_cell">
				<label class="Revise leftMove">最小起订：</label>
				<input type="text" id="minkc" name="minkc" class="comfirm" value="1000" />
			</div>
			<div class="table_row_cell">
				<label class="Revise leftMove">订购递增：</label>
				<input type="text" id="orderIncrement" name="orderIncrement" class="comfirm" value="1000" />
			</div>
		<div style="clear:both;"></div>
		<div class="margin-bottom-10">
			<span class="Revise leftMove">会员折扣：</span>
			<label class="Revise leftMove">一级</label>
			<input type="text" id="grade001" name="grade001" class="comfirm onethis" value="10" />
			<label class="Revise leftMove">二级</label>
			<input type="text" id="grade002" name="grade002" class="comfirm onethis" value="10" />
			<label class="Revise leftMove">三级</label>
			<input type="text" id="grade003" name="grade003" class="comfirm onethis" value="10" />
			<label class="Revise leftMove">四级</label>
			<input type="text" id="grade004" name="grade004" class="comfirm onethis" value="10" />
		</div>
	</div>

	<div class="comfirmRelease">
		<button id="comfirmPublish" class="layui-btn release">确认发布</button>
	</div>
	
</body>
<script type="text/javascript" src="frame/static/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="frame/layui/layui.js"></script>
<script type="text/javascript" src="frame/static/js/commodityPublish.js"></script>
<script type="text/javascript" src="frame/static/layer/layer.js"></script>