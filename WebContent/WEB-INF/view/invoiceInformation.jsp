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
</head>
  
<body>

<div class="invoice-dialog">
	<div class="tab-con">
  	  	<div  class="invoice-tips ftx-03 mt10 mb10">
  	  		<i></i>
  	  		<span class="tip-cont"> 我公司依法开具发票，如您购买的商品按税法规定属于不得从增值税销项税额中</span>
  	  		<span class="tip-cont ml30">如商品由第三方卖家销售，发票内容由其卖家决定，发票由卖家开具并寄出。</span>
  		</div>	
		<div class="form">
			<div class="steps">
				<ul class="invoice-status ml40 vat-inv-type0 vat-inv-type1">
           			<li class="fore curr">1.选择开票方式</li>
           			<li class="gap curr"></li>
           			<li class="fore">2.填写公司信息</li>
           			<li class="gap"></li>
           			<li class="fore">3.填写收票人信息</li>
         		</ul>
				<div class="step" id="vat-inv-type1">
					<div class="item">
            			<span class="label">开票方式：</span>
            			<div class="fl">
              				<div class="invoice-type-list">
                				<ul>
                  					<li class="invoice-item invoice-item-selected vat-inv-type0">订单完成后开票<b></b></li>
                 				</ul>
              				</div>
            			</div>
          			</div>
					<div class="item vat-inv-type0 vat-inv-type1">
						<span class="label">发票内容：</span>
						<div class="fl">
							<div class="invoice-list">
								<ul>
									<li class="invoice-item invoice-item-selected vat-inv-type0">产品明细<b></b></li>
								</ul>
							</div>
						</div>
					</div>				
          			<div class="item">
            			<span class="label">&nbsp;</span>
            			<div class="fl">
              				<span class="ftx-03">发票将在订单完成之后7-15个工作日寄出</span>
            			</div>
          			</div>
          			<div class="item vat-inv-type0 vat-inv-type1">
            			<span class="label">&nbsp;</span>
            			<div class="fl">
              				<div class="op-btns">
                				<a class="btn-9 next0">下一步</a>
                				<a class="btn-9 ml10" id="close">取消</a>
              				</div>
            			</div>
          			</div>
          		</div>
          		
				<div class="step hide vat-inv-type0 vat-inv-type1" id="vat-inv-type2">
					<div class="item">	
						<span class="label"><em class="required">*</em>单位名称：</span>
						<div class="fl">
							<input type="text" class="itxt itxt04 vat-step-1" name="companyName"/>
							<span class='' id=''></span>
						</div>
					</div>
					<div class="item" id="vat_code_div">
						<span class="label"><em class="required">*</em>纳税人识别码：</span>
						<div class="fl">
							<input type="text" class="itxt itxt04 vat-step-1" name="billReceipt"/>
							<span class='' id=''></span>
						</div>
					</div>
					<div class="item">
						<span class="label"><em class="required">*</em>注册地址：</span>
						<div class="fl">
							<input type="text" class="itxt itxt04 vat-step-1" name="registerAddress"/>
							<span class='' id=''></span>						
						</div>
					</div>
					<div class="item">					
						<span class="label"><em class="required">*</em>注册电话：</span>
						<div class="fl">
							<input type="text" class="itxt itxt04 vat-step-1" name="registerPhone"/>
							<span class='' id='registerPhone'></span>
						</div>
					</div>
					<div class="item">					
						<span class="label"><em class="required">*</em>开户银行：</span>
						<div class="fl">
							<input type="text" class="itxt itxt04 vat-step-1" name="openBand"/>
							<span class='' id=''></span>
						</div>
					</div>
					<div class="item">					
						<span class="label"><em class="required">*</em>银行账户：</span>
						<div class="fl">
							<input type="text" class="itxt itxt04 vat-step-1" name="bandCard"/>
							<span class='' id=''></span>
						</div>
					</div>
					<div class="item">
						<span class="label"></span>
						<div class="fl">
							<div class="op-btns">
								<input id="vat-btn-save" type="button" class="btn-9 next1" value="下一步" disabled="disabled"/>
								<input id="vat-btn-cancel" type="button" class="btn-9 ml10 prev0" value="返回"/>
							</div>
						</div>
					</div>
				</div>
				
				<div class="step hide vat-inv-type0 vat-inv-type1" id="vat-inv-type3">
					<div class="item">					
						<span class="label"><em class="required">*</em>收票人姓名：</span>
						<div class="fl">
							<input type="text" class="itxt itxt04" name="billReceiveName" maxLength="15"/>
							<span class=""  id=""></span>
						</div>
					</div>
					<div class="item">					
						<span class="label"><em class="required">*</em>收票人手机：</span>
						<div class="fl">
							<input type="text" class="itxt itxt04" name="billReceivePhone" maxLength="11"/>
							<span class=""  id="billReceivePhone"></span>
						</div>
					</div>
					<div class="item">					
						<span class="label"><em class="required">*</em>收票人邮箱：</span>
						<div class="fl">
							<input type="text" class="itxt itxt04" name="billReceiveMail" maxLength="20"/>
							<span class=""  id=""></span>
						</div>
					</div>
					<div class="item">					
						<span class="label"><em class="required">*</em>详细地址：</span>
						<div class="fl">
							<input type="text" class="itxt itxt04" name="billReceiveAddress" maxLength="40" />
							<span class=""  id=""></span>
						</div>
					</div>
					<div class="item">
						<span class="label"></span>
						<div class="fl">
							<div class="op-btns">
								<a class="btn-1" onclick="save_Invoice()" disabled="disabled">保存</a>
								<a class="btn-9 ml10 prev1">返回</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</div>

</body>
<script type="text/javascript" src="frame/static/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="frame/static/layer/layer.js"></script>
<script type="text/javascript">
$(function(){
	$(".next0").click(function(){
		$(".invoice-status").children("li.gap.curr").next().addClass("curr");
		$(".invoice-status").children("li.gap.curr").next().next().addClass("curr");
		$("#vat-inv-type1").hide();
		$("#vat-inv-type2").show();
	});
	$(".next1").click(function(){
		$(".invoice-status").children("li.gap.curr").next().addClass("curr");
		$("#vat-inv-type2").hide();
		$("#vat-inv-type3").show();
	});
	$(".prev0").click(function(){
		$($(".invoice-status").children("li.gap.curr")[1]).removeClass("curr");
		$($(".invoice-status").children("li.fore.curr")[1]).removeClass("curr");
		$("#vat-inv-type1").show();
		$("#vat-inv-type2").hide();
	});
	$(".prev1").click(function(){
		$($(".invoice-status").children("li.fore.curr")[2]).removeClass("curr");
		$("#vat-inv-type3").hide();
		$("#vat-inv-type2").show();
	});
	$("#close").click(function(){
		var index = parent.layer.getFrameIndex(window.name);
		parent.layer.close(index);
	});
	$("[name='billReceivePhone']").blur(function(){
		var phone = $("[name='billReceivePhone']").val();
		if(!(/^1[34578]\d{9}$/.test(phone))){ 
	        $("#billReceivePhone").text('手机号码有误');
	        return false;
	    }else{
	    	$("#billReceivePhone").text('');
	    }
	});
	$(".item>.fl>input").blur(function(){
		if($(this).val().length==0){
			$(this).siblings("span").text("此项信息必填");
		}else{
			$(this).siblings("span").text("");
		}
	});
	$("#vat-inv-type2>.item>.fl>input").blur(function(){
		var inputLength = $("#vat-inv-type2>.item>.fl>input").length;
		var current = false;
		for(var i=0;i<inputLength;i++){
			if($($("#vat-inv-type2>.item>.fl>input")[i]).val().length==0){
				current = false;
				break;
			}else{
				current = true;
			}
		}
		if(current){
			document.getElementById("vat-btn-save").disabled = false;
		}else{
			document.getElementById("vat-btn-save").disabled = true;
		}
	});
	$("#vat-inv-type3>.item>.fl>input").blur(function(){
		var inputLength = $("#vat-inv-type2>.item>.fl>input").length;
		var current = false;
		for(var i=0;i<inputLength;i++){
			if($($("#vat-inv-type2>.item>.fl>input")[i]).val().length==0){
				current = false;
				break;
			}else{
				current = true;
			}
		}
		if(current){
			$(".btn-1").attr('disabled',false);
		}else{
			$(".btn-1").attr('disabled',true);
		}
	});
	$.ajax({
		url:'busOrder/getByIds.do',
		type:"post",
		success:function(data){
			if(data.success&&data.obj!=null){
				$("[name='billReceipt']").val(data.obj.billReceipt);//纳税人识别号
				$("[name='billReceivePhone']").val(data.obj.billReceivePhone);//收票人手机号
				$("[name='billReceiveAddress']").val(data.obj.billReceiveAddress);//收票人地址
				$("[name='billStatus']").val(data.obj.billStatus);//发票状态
				$("[name='companyName']").val(data.obj.companyName);//单位名称
				$("[name='registerAddress']").val(data.obj.registerAddress);//单位注册地址
				$("[name='registerPhone']").val(data.obj.registerPhone);//单位注册手机号码
				$("[name='openBand']").val(data.obj.openBand);//开户行
				$("[name='bandCard']").val(data.obj.bandCard);//银行卡
				$("[name='billReceiveName']").val(data.obj.billReceiveName);//收票人姓名
				$("[name='billReceiveMail']").val(data.obj.billReceiveMail);//收票人邮箱
			}
		}
	});
	$(".next0").click(function(){
		var inputLength = $("#vat-inv-type2>.item>.fl>input").length;
		var current = false;
		for(var i=0;i<inputLength;i++){
			if($($("#vat-inv-type2>.item>.fl>input")[i]).val().length==0){
				current = false;
				break;
			}else{
				current = true;
			}
		}
		if(current){
			document.getElementById("vat-btn-save").disabled = false;
		}else{
			document.getElementById("vat-btn-save").disabled = true;
		}
	});
	$(".next1").click(function(){
		var inputLength = $("#vat-inv-type2>.item>.fl>input").length;
		var current = false;
		for(var i=0;i<inputLength;i++){
			if($($("#vat-inv-type2>.item>.fl>input")[i]).val().length==0){
				current = false;
				break;
			}else{
				current = true;
			}
		}
		if(current){
			$(".btn-1").attr('disabled',false);
		}else{
			$(".btn-1").attr('disabled',true);
		}
	});
});
var dataSuccess;
//保存
function save_Invoice(){
	var orderNo;
	var billMoney;
	var remark;
	var iframeSrc = $(window.parent.document).contents().find("iframe").attr("src");
	alert(iframeSrc);
	if (iframeSrc.indexOf("?") != -1) {
		var str = iframeSrc.substr(1);
		strs = (str.split("?"))[1];
		str = strs.split("&");
		orderNo = (str[0].split("="))[1];
		billMoney = (str[1].split("="))[1];
		remark = (str[2].split("="))[1];
	}
	$.ajax({
		url:'busOrder/save.do',
		type:"post",
		data:{
			"orderNo":orderNo,//订单编号
			"billType":"3",//发票类型 1.普通发票 2.电子发票 3.增票
			"billTitle":"2",//发票抬头 1个人  2.公司
			"billReceipt":$("[name='billReceipt']").val(),//纳税人识别号
			"billContent":"产品明细",//发票内容
			"billReceivePhone":$("[name='billReceivePhone']").val(),//收票人手机号
			"billReceiveAddress":$("[name='billReceiveAddress']").val(),//收票人地址
			"billStatus":$("[name='billStatus']").val(),//发票状态
			"billMoney":billMoney, //发票总金额
			"companyName":$("[name='companyName']").val(),//单位名称
			"registerAddress":$("[name='registerAddress']").val(),//单位注册地址
			"registerPhone":$("[name='registerPhone']").val(),//单位注册手机号码
			"openBand":$("[name='openBand']").val(),//开户行
			"bandCard":$("[name='bandCard']").val(),//银行卡
			"billReceiveName":$("[name='billReceiveName']").val(),//收票人姓名
			"billReceiveMail":$("[name='billReceiveMail']").val(),//收票人邮箱
		},
		success:function(data){
			dataSuccess = data.success;
			if(data.success){
				$.ajax({
					url:'busOrder/orderOperator.do',
					type:'post',
					data:{"remark":remark,"orderNo":orderNo},
					success:function(data){
						if(data.success){
							layer.msg('操作成功', {
								icon: 1,
								time: 2000
							}, function(){
								window.top.location.reload();
							});
						}else{
							layer.open({
								 title: '错误信息'
								 ,content:data.msg
							}); 
						}
					}
				});
			}else{
				layer.open({
					 title: '错误信息'
					 ,content:data.msg
				}); 
			}
		}
	});
}
</script>
</html>
