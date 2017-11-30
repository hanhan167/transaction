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
<title>商品管理-商品折扣</title>
<link rel="stylesheet" type="text/css" href="frame/static/css/commonality.css"/>
<link rel="stylesheet" type="text/css" href="frame/layui/css/layui.css"/>
<link rel="stylesheet" type="text/css" href="frame/static/css/commodity.css"/>
</head>
<body>

	<h4>修改商品价格与折扣信息</h4>
	<title>商品：不锈钢车削用PVD涂层硬质合金材料</title>
	<form action="" method="post" onsubmit="return false">
		<label>商品等级一：</label>
		<input type="number" />折
		<label>商品等级二：</label>
		<input type="number" />折
		<label>商品等级三：</label>
		<input type="number" />折
		<label>商品等级四：</label>
		<input type="number" />折
		<input type="button" value="确认上传" class="add_discount" />
		<input type="submit" value="确定修改" class="affirm" />
	</form>
	
</body>
</html>
<script type="text/javascript" src="frame/static/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="frame/static/layui/layui.js"></script>
<script type="text/javascript" src="frame/static/js/company.js"></script>
<script type="text/javascript">

</script>