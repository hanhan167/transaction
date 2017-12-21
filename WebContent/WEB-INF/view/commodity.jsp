<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
request.setAttribute("basePath", basePath);
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath %>"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="frame/static/css/layui.css" />
<link rel="stylesheet" type="text/css" href="frame/static/css/main.css" />
<link rel="stylesheet" type="text/css" href="frame/static/css/commonality.css" />
<link rel="stylesheet" type="text/css" href="frame/static/css/padding_and_marign.css"/>
<link rel="stylesheet" type="text/css" href="frame/static/layer/skin/default/layer.css"/>
<title>商品管理</title>
<style type="text/css">
#loginOut p{
	position: absolute;
    left: -10px;
    top: 3px;
    color: #fff;
    background-color: orange;
    height: 14px;
    line-height: 14px;
    text-align: center;
    padding: 0 3px;
    border-radius: 6px;
    font-size: 12px;
}
.heads{
	float: left;
}
ul.heads>li{
	float: left;
    line-height: 48px;
    text-align: center;
    width: 80px;
}
ul.heads>li>a{
	color: #FFFFFF;
	width: 60px;
    height: 48px;
    display: block;
    float: left;
    font-family: "宋体";
}
</style>
</head>
<body>
	<div class="content" id="head_content" style="background-color:black;width: 100%;height: 45px;">
		<div style="width: 990px;height:45px;margin:0 auto;">
			<ul class="heads">
				<li><a href="sys/toCutter.do">首页</a></li>
				<li><a href="sys/toTech.do">技术平台</a></li>
			</ul>
			<ul id="loginOut" style="position: relative;left:0">
				<li>
					<a>发票管理</a>
					<ul>
						<li onclick="toBuyerInvoic()" id="buyerInvoic">买方发票</li>
						
						<li onclick="toSupplyInvoic()" id="supplyInvoic">卖方发票</li>
					</ul>
				</li>
				<li id="goods"><a href="goods/toCommodity.do">商品管理</a></li>
				<li>
					<a>我的订单</a>
					<ul>
						<li onclick="toBuyer()" id="buyerLi">购买订单</li>
						<li onclick="toSupply()" id="supplyLi">出售订单</li>
					</ul>
				</li>
				<li><a href="busShoppCart/toShoppCart.do">购物车</a><p></p></li>
				<li><a href="sys/toInformation.do" id="loginName0"></a>
					<div class="personage_overview">
						<div id="first">
							<a href="sys/toInformation.do" class="portrait">
								<img id="grade_img" src="frame/head_portrait/IMG_0338.jpg"/>
							</a>
							<h3 id="loginName1"></h3>
							<img id="grade_img1" src="frame/static/img/grade.png"/>
							<a href="sys/loginOut.do" class="exit">退出</a>
						</div>
						<div id="second">
							<span>订单</span>
							<span id="ddListcost">0</span>
						</div>
					</div>
				</li>
			</ul>
		</div>
	</div>
	
	<div class="content-shop">			
		<!--选项卡-->
		<div class="tar">
			<span class="layui-breadcrumb" lay-separator="|">
	 			<a><span class="buttonCss">所有商品</span></a>
				<a><span class="buttonCss">商品销售</span></a>
				<a id="publishGoods"><span class="buttonCss">发布商品</span></a>
				<input id="changeTar" value="" type="hidden"/>
			</span>
		</div>
		<div class="nav left">
			<input type="hidden" id="gType" value="卡尺"><!-- 默认卡尺类 -->
			<ul class="layui-nav layui-nav-tree" lay-filter="test" id="menu">				
				<li id="bg">
					<span>通用量具类</span>
				</li>
			</ul>
		</div>
		<div id="form_div" class="from left">
			<iframe class="Iframe" id="iFrame" src="" width="1050px" style=" min-height: 570px;" scrolling="auto"></iframe>
		</div>
		<div class="clear"></div>
	</div>
</body>
<script src="frame/layui/layui.js"></script>
 
<script type="text/javascript" src="frame/static/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="frame/static/layer/layer.js"></script>
<script type="text/javascript" src="frame/static/js/company.js"></script>
<script type="text/javascript" src="frame/static/js/switchNav.js"></script>
<script> 
var gradeimg = {
		"grade001":"frame/static/img/grade1.png",
		"grade002":"frame/static/img/grade2.png",
		"grade003":"frame/static/img/grade3.png",
		"grade004":"frame/static/img/grade4.png"
		};

layui.use(['jquery', 'element'], function() {
	var $ = layui.jquery,
		element = layui.element();
	$('.buttonCss').on('click', function() {
		$(this).css({ background: '#03A1A4', color: 'white' }).parent().siblings('a').children().css({ background: '#eeeeee', color: 'black' });
		$("#changeTar").val($(this).text());
	});
	//监听导航点击
	element.on('nav(demo)', function(elem) {
		layer.msg(elem.text());
	});
});

layui.use('form', function() {
	var $ = layui.jquery,
	form = layui.form();
	//全选
	form.on('checkbox(allChoose)', function(data) {
		var child = $(data.elem).parents('table').find('tbody input[type="checkbox"]');
		child.each(function(index, item) {
			item.checked = data.elem.checked;
		});
		form.render('checkbox');
	});
});
		
$(function(){							
	$('#menu').on('click','.navChange',function(){
		$(this).css({backgroundColor:'rgb(226, 223, 223)',color:'white'}).parent().siblings('li').children().css({backgroundColor:'white',color:'#888888'});
		$("#gType").val($(this).attr("goodstype"));
		if($("#changeTar").val()=='发布商品'){
			$("#iFrame").attr("src","goods/toPublishGoods.do");
		}else if($("#changeTar").val()=='商品销售'){
			$("#iFrame").attr("src","goods/toPubCommodity.do");
		}else{
			$("#iFrame").attr("src","goods/toCommodityAll.do");
		}
	});				

	//判断是否登录
	$.ajax({
        url: "sys/isType.do",
        type: "post",
        success: function (data) {
            if(data.success){
            	var gradeNo = data.obj.gradeNo;
            	if(data.obj.userType=='buyer'){
            		$("#supplyLi").css({"display":"none"});
            		$("#goods").css({"display":"none"});
            	}
            	$("#loginName0").text(splitStr(data.obj.loginName,4)).attr("title",data.obj.loginName);
            	$("#loginName1").text(splitStr(data.obj.loginName,8)).attr("title",data.obj.loginName);
            	
            	$("#grade_img1").attr("src", gradeimg[gradeNo]);
            	$("#loginOut p").text(data.map.goodsNo);
            	$("#ddListcost").text(data.msg);
            }
        }
    });
	function overview_left(num){
		var left1 = $("#loginOut li:eq(3)").offset().left-num;
		$(".personage_overview").css("left",left1);
	}
	$("#loginOut li:eq(3)").mouseenter(function(){
		overview_left(200);
	});
});
var view = {
	alert:function(){
		layer.open({
			type: 2,
			title: false,
			resize:false,
			scrollbar:false,//不允许浏览器出现滚动条
			area:['520px','462px'],
			content:['sys/toUserPage.do','no']
		});
	}
}
function toBuyer(){window.location.href="${basePath}busOrder/buyerIndentTab.do";}
function toSupply(){location.href="${basePath}busOrder/supplyIndentTab.do";}
function toBuyerInvoic(){
	window.location.href="${basePath}goods/toInvoicMgt.do";
}
function toSupplyInvoic(){
	window.location.href="${basePath}goods/toSupplyInvoicMgt.do";
}
</script>