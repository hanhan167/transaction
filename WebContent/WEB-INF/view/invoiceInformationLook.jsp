<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML>
<html>
<head>
    <title>发票信息</title>
	<base href="<%=basePath %>"/>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" type="text/css" href="frame/static/css/commonality.css"/>
	<link rel="stylesheet" type="text/css" href="frame/layui/css/layui.css"/>
	<link rel="stylesheet" type="text/css" href="frame/static/css/backpanel.css"/>
	<style type="text/css">
	.fl{
		padding: 4px 0 3px 0;
	}
	#vat-inv-type0 img{
		text-align: center;
		display: block;
		margin: 60px auto;
	}
	#vat-inv-type0 h3{
		font-size: 24px;
		text-align: center;
		color: #333;
	}
	</style>
</head>
  
<body>

<div class="invoice-dialog">
	<div class="tab-con">
		<div class="form">
			<div class="steps">
				<div class="step vat-inv-type0 vat-inv-type1" id="vat-inv-type0">
					<img alt="" src="frame/static/img/fapiao.png">
					<h3>买家不需要发票</h3>
				</div>
				<div class="step vat-inv-type0 vat-inv-type1" id="vat-inv-type1" style="display: none;">
					<div class="item">
						<span class="label">单位名称：</span>
						<div class="fl">
							<span class='' id='companyName'></span>
						</div>
					</div>
					<div class="item">
						<span class="label">纳税人识别码：</span>
						<div class="fl">
							<span class='' id='billReceipt'></span>
						</div>
					</div>
					<div class="item">
						<span class="label">注册地址：</span>
						<div class="fl">
							<span class='' id='registerAddress'></span>
						</div>
					</div>
					<div class="item">
						<span class="label">注册电话：</span>
						<div class="fl">
							<span class='' id='registerPhone'></span>
						</div>
					</div>
					<div class="item">
						<span class="label">开户银行：</span>
						<div class="fl">
							<span class='' id='openBand'></span>
						</div>
					</div>
					<div class="item">
						<span class="label">银行账户：</span>
						<div class="fl">
							<span class='' id='bandCard'></span>
						</div>
					</div>
					<div class="item" id="name_div">
						<span class="label">收票人姓名：</span>
						<div class="fl">
							<span class="" id="billReceiveName"></span>
						</div>
					</div>
					<div class="item" id="call_div">
						<span class="label">收票人手机：</span>
						<div class="fl">
							<span class="" id="billReceivePhone"></span>
						</div>
					</div>
					<div class="item" id="call_div">
						<span class="label">收票人邮箱：</span>
						<div class="fl">
							<span class="" id="billReceiveMail"></span>
						</div>
					</div>
					<div class="item" id="address_div">
						<span class="label">详细地址：</span>
						<div class="fl">
							<span class="" id="billReceiveAddress"></span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</div>

</body>
<script type="text/javascript" src="frame/static/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript">
$(function(){
	var orderNo;
	var billMoney;
	var remark;
	var iframeSrc = $(window.parent.document).contents().find("iframe").attr("src");
	if (iframeSrc.indexOf("?") != -1) {
		var str = iframeSrc.substr(1);
		strs = (str.split("?"))[1];
		str = strs.split("&");
		orderNo = (str[0].split("="))[1];
	}
	$.ajax({
		url:'busOrder/getBillByOrderNo.do',
		type:"post",
		data:{
			"orderNo":orderNo,//订单编号
		},
		success:function(data){
			if(data.success){
				var list = data.obj.rows[0];
				if(list==undefined){
					
				}else{
					$("#vat-inv-type0").hide();
					$("#vat-inv-type1").show();
					$("#companyName").text(list.companyName);
					$("#billReceiveMail").text(list.billReceiveMail);
					$("#billReceivePhone").text(list.billReceivePhone);
					$("#billReceipt").text(list.billReceipt);
					$("#billReceivePhone").text(list.billReceivePhone);
					$("#billReceiveName").text(list.billReceiveName);
					$("#openBand").text(list.openBand);
					$("#bandCard").text(list.bandCard);
					$("#registerAddress").text(list.registerAddress);
					$("#registerPhone").text(list.registerPhone);
					$("#billReceiveAddress").text(list.billReceiveAddress);
				}
			}else{
				layer.open({
					 title: '错误信息'
					 ,content:data.msg
				}); 
			}
		}
	});
});
</script>
</html>
