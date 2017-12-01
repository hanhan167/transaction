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
  <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>取消订单</title>
    <link rel="stylesheet" type="text/css" href="frame/static/css/cancelshop.css">
</head>
<body>
<div class="header">
    <div class="header-box">
        <div class="header-img fl"><img class="l-img goBackImg" src="frame/static/picture/arrow-white.png"></div>
        <div class="text-tit fl">取消订单</div>
    </div>
</div>
<div class="mains" style="background-color: #f3f3f3">
    <div class="cancel-box">
        <div class="cancel-tit">选择取消原因</div>
        <ul class="cancel-lis">
            <li>
                <div class="fl litexts">商品价格不符合预期</div>
                <div class="fr check-imgs"><img src="frame/static/picture/check-r.png"></div>
            </li>
            <li>
                <div class="fl litexts">协商取消订单</div>
                <div class="fr check-imgs"><img src="frame/static/picture/check-g.png"></div>
            </li>
            <li>
                <div class="fl litexts">交货期有问题</div>
                <div class="fr check-imgs"><img src="frame/static/picture/check-g.png"></div>
            </li>
            <li>
                <div class="fl litexts">商品质量问题</div>
                <div class="fr check-imgs"><img src="frame/static/picture/check-g.png"></div>
            </li>
            <li>
                <div class="fl litexts">其它原因</div>
                <div class="fr check-imgs"><img src="frame/static/picture/check-g.png"></div>
            </li>
        </ul>
        <div class="write-box">
            <textarea placeholder="填写其他原因" rows="4"></textarea>
        </div>
        <div class="buttns">
            <span class="goBack">我点错了</span>
            <span class="makeSure">确认订单</span>
        </div>

    </div>
</div>
</body>
<script type="text/javascript"
	src="frame/static/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="frame/static/layer/mobile/layer.js"></script>
<script>

var textVal;


function GetQueryString(name) {
	var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
	var r = window.location.search.substr(1).match(reg);
	if (r != null){
		return unescape(r[2]);
	}
	return null;
}

/*选择*/
$(".cancel-lis li").children(".check-imgs").click(function(){
	$(".cancel-lis li").children(".check-imgs").children().prop("src","frame/static/picture/check-g.png");
	$(this).children().prop("src","frame/static/picture/check-r.png");
	textVal = $(this).parent().children('.litexts').text();
});

/*退出*/
$(".goBack,.goBackImg").click(function(){
	location.href = "busOrder/toPage/buyerIndent_tabApp.do";
});

/*确认*/
$(".makeSure").click(function(){
	var orderNo = GetQueryString("orderNo");
	var orderType = GetQueryString("orderType");
	var tVal = $(".write-box").children().val();
	alert(textVal);
	$.ajax({
		url : 'busOrder/cancelOrder.do',
		data : {
			"orderNo" : orderNo,
			"dealType" : "cancel",
			"orderType" : orderType,
			"remark" :"【" + textVal
			+ "】" + tVal,
			"statusWay" : "0",
		},
		dataType : "json",
		type : 'post',
		success :  function(data) {
			if (data.success) {
				layer.open({
				 content:'操作成功',
				 time:2,
				 end:function(){
					 location.href = "busOrder/toPage/buyerIndent_tabApp.do";
					 //stateLook(curr, orde);
				 	}
				});
			} else {
				layer.open({
					title : '错误信息',
					content : data.msg
				});
			}
		}
	});
});

</script>
</html>