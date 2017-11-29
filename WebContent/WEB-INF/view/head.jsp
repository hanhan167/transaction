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
<link rel="stylesheet" type="text/css" href="frame/static/css/commonality.css" />
<link rel="stylesheet" type="text/css" href="frame/layui/css/layui.css" />
<link rel="stylesheet" type="text/css" href="frame/static/css/padding_and_marign.css"/>
<title>PORTAL_head</title>
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
#loginOut{
	display: none;
}
</style>
</head>
<body>
	
	<div class="content" id="head_content">
		<ul class="heads">
			<li><a target="_blank" href="sys/toCutter.do">首页</a></li>
			<li><a target="_blank" href="sys/toTech.do">技术平台</a></li>
		</ul>
		<ul id="loginOut">
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
			<li><a id="loginName0"></a>
				<!--个人信息概述-->
				<div class="personage_overview">
					<div id="first">
						<a class="portrait">
							<img src="frame/head_portrait/IMG_0338.jpg"/>
						</a>
						<h3 id="loginName1"></h3>
						<img id="grade_img" src="frame/static/img/grade.png"/>
						<a href="sys/loginOut.do" class="exit">退出</a>
					</div>
					<div id="second">
						<span>订单</span>
						<span id="second_num"></span>
					</div>
				</div>
			</li>
		</ul>
	</div>
	
</body>
</html>
<script type="text/javascript" src="frame/static/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="frame/static/layer/layer.js"></script>
<script type="text/javascript" src="frame/layui/layui.js"></script>
<script type="text/javascript" src="frame/static/js/company.js"></script>
<script type="text/javascript">
var gradeimg = {
		"grade001":"frame/static/img/grade1.png",
		"grade002":"frame/static/img/grade2.png",
		"grade003":"frame/static/img/grade3.png",
		"grade004":"frame/static/img/grade4.png"
		};
$(function() { 	
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
            	$("#loginName1").text(splitStr(data.obj.loginName,6)).attr("title",data.obj.loginName);
            	$("#grade_img").attr("src", gradeimg[gradeNo]);
            	$("#second_num").text(data.msg);
            	$("#loginOut p").text(data.map.goodsNo);
            	$("#loginOut").show();
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
var url = location.search; //获取url中"?"符后的字串
var oederId;
var trade_name;
if (url.indexOf("?") != -1) {    //判断是否有参数
	var str = url.substr(1); //从第一个字符开始 因为第0个是?号 获取所有除问号的所有符串
	strs = str.split("=");   //用等号进行分隔 （因为知道只有一个参数 所以直接用等号进分隔 如果有多个参数 要用&号分隔 再用等号进行分隔）
	oederId = strs[1];
}
	$("#loginName0").attr("href","sys/toInformation.do?custNo="+oederId);
	$(".portrait").attr("href","sys/toInformation.do?custNo="+oederId);
function toBuyer(){
	window.location.href="${basePath}busOrder/toPage/buyerIndent_tab.do";
}
function toSupply(){
	location.href="${basePath}busOrder/toPage/applyIndent_tab.do";
}
function toBuyerInvoic(){
	window.location.href="${basePath}goods/toInvoicMgt.do";
}
function toSupplyInvoic(){
	
}
</script>