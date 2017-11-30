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
<link rel="stylesheet" type="text/css" href="frame/static/css/commodity.css"/>
<title>商品管理</title>
</head>
<body>

	<!--顶部-->
	<div class="head">
		<jsp:include page="head.jsp" flush="true"/>
	</div>

	<!-- 中间的内容 -->
	<div class="centre">
		<div class="content_left padding-right-40">
			<h1><img src="frame/static/img/guanli.png" />商品管理</h1>
			<h3>我的商品</h3>
			<ul>
				<li class="pitch"><a>所有商品</a></li>
				<li><a>已上架商品</a></li>
				<li><a>已下架商品</a></li>
				<li><a>商品销售</a></li>
			</ul>
			<h3>商品上架</h3>
			<ul>
				<li><a>发布商品</a></li>
				<!-- <li><a>商品折扣</a></li> -->
			</ul>
		</div>
		
		<div class="content_right"></div>
		<div class="clear"></div>
	</div>
	
	<!--底部-->
	<div class="base">
		 <jsp:include page="base.jsp" flush="true"/>
	</div>
	
</body>
</html>
<script type="text/javascript">
$(function(){
	$(".content_right").load("goods/toCommodityAll.do");
	$(".content_left>ul>li").click(function(){
		$(".content_left>ul>li").removeClass("pitch");
		$(this).addClass("pitch");
	});
	$(".content_left>ul>li:eq(0)").click(function(){
		$(".content_right").load("goods/toCommodityAll.do");
	});
	$(".content_left>ul>li:eq(1)").click(function(){
		$(".content_right").load("goods/toCommodityPutaway.do");
	});
	$(".content_left>ul>li:eq(2)").click(function(){
		$(".content_right").load("goods/toCommodityHalt.do");
	});
	$(".content_left>ul>li:eq(3)").click(function(){
		
	});
	$(".content_left>ul>li:eq(4)").click(function(){
		$(".content_right").load("goods/toPublishGoods.do");
	});
});
</script>