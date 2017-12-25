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
    <link rel="stylesheet" type="text/css" href="frame/static/css/shop.css">
    <link rel="stylesheet" type="text/css" href="frame/static/css/invoice.css">
    <title>开发票</title>
</head>
<body>
		<div class="header">
		    <div class="header-box">
		        <div class="header-img fl"><img class="l-img" src="frame/static/picture/arrow-white.png"></div>
		        <div class="text-tit fl">开具发票</div>
		    </div>
		</div>
		<div class="mains" style="overflow: auto;bottom: 0">
		    <div class="address-infos">
		        <ul>
		            <li style="margin-top: 0">
		                <div class="check-texts fl">
		                    <span>开票类型</span>
		                </div>
		                <div class="r-invoice-btn fr">
		                    <div class="top-btns">
		                        <span class="onclick-span" >电子发票</span>
		                        <span style="float: right" >纸质发票</span>
		                    </div>
		                    <div class="down-infos"></div>
		                </div>
		                <div class="clear-box"></div>
		            </li>
		            <li>
		                <div class="check-texts fl">
		                    <span style="font-size: 0.87rem">发票类型</span>
		                </div>
		                <div class="oper-texts fr" style="position: relative;">
		                    <span style="color: #000000" id="itemsTexts">普通发票</span>
		                    <img class="oper-img" src="frame/static/picture/arrow.png">
		                    <select class="select-items">
		                        <option value="01">普通发票</option>
		                        <option value="02">增值税发票</option>
		                    </select>
		                </div>
		                <div class="clear-box"></div>
		            </li>
		            <li>
		                <div class="check-texts fl">
		                    <span style="font-size: 0.87rem">抬头类型</span>
		                </div>
		                <div class="oper-texts fr" style="position: relative;">
		                    <span style="color: #000000" id="itemsTexts1">个人</span>
		                    <img class="oper-img" src="frame/static/picture/arrow.png">
		                    <select class="select-items">
		                        <option value="001">个人</option>
		                        <option value="002">企业</option>
		                    </select>
		                </div>
		                <div class="clear-box"></div>
		            </li>
		        </ul>
		        <div class="li-tits">请填写发票详情（<span style="color: red;">*</span>为必填项）</div>
		        <ul id="details">
		            <li style="margin-top: 0">
		                <div class="check-texts fl">
		                <span style="color: red;" class="red">*</span>
		                    <span>单位名称</span>
		                </div>
		                <div class="oper-texts fr">
		                    <input type="text" name='companyName' placeholder="请输入单位全称">
		                </div>
		                <div class="clear-box"></div>
		            </li>
		            <li>
		                <div class="check-texts fl">
		                <span style="color: #ffffff;">*</span>
		                    <span>纳税人识别号</span>
		                </div>
		                <div class="oper-texts fr">
		                    <input type="text" name='billReceipt' placeholder="请输入识别号">
		                </div>
		                <div class="clear-box"></div>
		            </li>
		            <li style="height: auto">
		                <div class="check-texts fl">
		                <span style="color: #ffffff;">*</span>
		                    <span>注册地址</span>
		                </div>
		               <!--  <div class="address-area fr"> -->
		                <div class="oper-texts fr">
		                   <!--  <textarea rows="4" name='registerAddress' placeholder="请输入详细注册地址"></textarea> -->
		                    <input type="text" name='registerAddress' placeholder="请输入详细注册地址">
		                </div>
		                <div class="clear-box"></div>
		            </li>
		            <li>
		                <div class="check-texts fl">
		                <span style="color: #ffffff;">*</span>
		                    <span>注册电话</span>
		                </div>
		                <div class="oper-texts fr">
		                    <input type="text" name='registerPhone' placeholder="请输入手机号">
		                </div>
		                <div class="clear-box"></div>
		            </li>
		            <li>
		                <div class="check-texts fl">
		                <span style="color: #ffffff;">*</span>
		                    <span>开户银行</span>
		                </div>
		                <div class="oper-texts fr">
		                    <input type="text" name='openBand' placeholder="请输入开户银行名称">
		                </div>
		                <div class="clear-box"></div>
		            </li>
		            <li>
		                <div class="check-texts fl">
		                <span style="color: #ffffff;">*</span>
		                    <span>银行账户</span>
		                </div>
		                <div class="oper-texts fr">
		                    <input type="text" name='bandCard' placeholder="请输入开户银行账号">
		                </div>
		                <div class="clear-box"></div>
		            </li>
		
		        </ul>
		        <div class="li-tits">请填写收票邮箱</div>
		        <ul>
		            <li style="margin-top: 0">
		                <div class="check-texts fl">
		                <span style="color: red;">*</span>
		                    <span>收票人姓名</span>
		                </div>
		                <div class="oper-texts fr">
		                    <input type="text" name='billReceiveName' placeholder="请输入收票人姓名">
		                </div>
		                <div class="clear-box"></div>
		            </li>
		            <li>
		                <div class="check-texts fl">
		                <span style="color: red;">*</span>
		                    <span>收票人手机号</span>
		                </div>
		                <div class="oper-texts fr">
		                    <input type="text" name='billReceivePhone' placeholder="请输入收票人手机号">
		                </div>
		                <div class="clear-box"></div>
		            </li>
		            
		            
		            <li>
					<div class="check-texts fl">
						<span style="color: red;">*</span>
						<span>省</span>
					</div>
					<div class="oper-texts fr">
						<select name='input_province' id="input_province"
							style="width: 121px;"></select>
					</div>
					<div class="clear-box"></div>
					</li>
					<li>
						<div class="check-texts fl">
						<span style="color: red;">*</span>
							<span>市</span>
						</div>
						<div class="oper-texts fr">
							<select name="input_city" id="input_city" style="width: 121px;"></select>
						</div>
						<div class="clear-box"></div>
					</li>
					<li>
						<div class="check-texts fl">
						<span style="color: red;">*</span>
							<span>区</span>
						</div>
						<div class="oper-texts fr">
							<select name="input_area" id="input_area" style="width: 121px;"></select>
						</div>
						<div class="clear-box"></div>
					</li>
		            <li>
		                <div class="check-texts fl">
		                <span style="color: red;">*</span>
		                    <span>详细地址</span>
		                </div>
		                <div class="oper-texts fr">
		                    <!-- <textarea rows="4" name='billReceiveAddress' placeholder="请输入详细地址"></textarea> -->
		                     <input type="text" name='billReceiveAddress' placeholder="请输入详细地址">
		                </div>
		                <div class="clear-box"></div>
		            </li>
		             <li class="mail">
		                <div class="check-texts fl">
		                	<span style="color: red;" class="red">*</span>
		                    <span>收票人邮箱</span>
		                </div>
		                <div class="oper-texts fr">
		                    <input type="text" name='billReceiveMail' placeholder="请输入收票人邮箱">
		                </div>
		                <div class="clear-box"></div>
		            </li>
		        </ul>
		        <div class="submit-btn"><span>提交</span></div>
		    </div>
		</div>

</body>
</html>
<script type="text/javascript" src="frame/static/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="frame/static/layer/mobile/layer.js"></script>
<script type="text/javascript" src="frame/static/js/pdata.js"></script>
<script type="text/javascript">
var billNatrue = "1";//电子发票
var billType = "01";//普通发票
var billTitle = "001";//个人发票
siteAdd();
	 //返回
	 $(".header-img").click(function(){
		 location.href="busShoppCart/toOpenTicketTable.do";    	
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
					$("#input_province").val(data.obj.billProvince);//省
					$("#input_province").change();
					$("#input_city").val(data.obj.billCity);//市
					$("#input_city").change();
					$("#input_area").val(data.obj.billArea);//区
				}
			}
	});
	$(".address-infos ul:eq(2)").children().not(".mail").hide();
	$(".top-btns").children().click(function(){
		$(".top-btns").children().removeClass("onclick-span");
		$(this).addClass("onclick-span");
		if($(this).text() == "纸质发票"){
			$(".address-infos ul:eq(2)").children().not(".mail").show();
			$(".address-infos ul:eq(2)").children().filter(".mail").hide();
			$(".li-tits:eq(1)").text('请填写收票地址');
			billNatrue = "02";
			
			$("#details").next().next().children().filter(".mail").each(function(){
				$(this).children().eq("0").children().eq("0").removeClass("red");
			});
			$("#details").next().next().children().not(".mail").each(function(){
				$(this).children().eq("0").children().eq("0").addClass("red");
			});
		}else{
			$(".address-infos ul:eq(2)").children().not(".mail").hide();
			$(".address-infos ul:eq(2)").children().filter(".mail").show();
			$(".li-tits:eq(1)").text('请填写收票邮箱');
			billNatrue = "01";
			
			$("#details").next().next().children().not(".mail").each(function(){
				$(this).children().eq("0").children().eq("0").removeClass("red");
			});
			$("#details").next().next().children().filter(".mail").each(function(){
				$(this).children().eq("0").children().eq("0").addClass("red");
			});
		}
	});
	//普通、增值
	$(".select-items:eq(0)").change(function(){
		$("#itemsTexts").text($(".select-items:eq(0) option:selected").text());
		billType = $(".select-items:eq(0) option:selected").val();
		if(billType =="01"){
			$(".select-items:eq(1)").prev().show();
			$(".select-items:eq(1)").removeAttr("disabled");
			$("#itemsTexts1").text("个人");
			$(".select-items:eq(1) option:selected").val("001");
			billTitle = "001";
			//分配必选项
			$("#details li").each(function(){
				$(this).children().eq("0").children().eq("0").css("color","#ffffff");
				$(this).children().eq("0").children().eq("0").removeClass("red");
			});
			$("#details>li:eq(0)>div:eq(0)>span:eq(0)").css("color","red");
			$("#details>li:eq(0)>div:eq(0)>span:eq(0)").addClass("red");
			
			//个人、公司
			$(".select-items:eq(1)").change(function(){
				$("#itemsTexts1").text($(".select-items:eq(1) option:selected").text());
				billTitle = $(".select-items:eq(1) option:selected").val();
				//分配必选项
				if(billTitle == "001"){
					$("#details li").each(function(){
						$(this).children().eq("0").children().eq("0").css("color","#ffffff");
						$(this).children().eq("0").children().eq("0").removeClass("red");
					});
					$("#details>li:eq(0)>div:eq(0)>span:eq(0)").css("color","red");
				}else{
					$("#details li").each(function(){
						$(this).children().eq("0").children().eq("0").css("color","#ffffff");
						$(this).children().eq("0").children().eq("0").removeClass("red");
					});
					$("#details>li:eq(0)>div:eq(0)>span:eq(0)").css("color","red");
					$("#details>li:eq(0)>div:eq(0)>span:eq(0)").addClass("red");
					$("#details>li:eq(1)>div:eq(0)>span:eq(0)").css("color","red");
					$("#details>li:eq(1)>div:eq(0)>span:eq(0)").addClass("red");
				}
			});
		}else{
			$(".select-items:eq(1)").prev().hide();
			$(".select-items:eq(1)").attr("disabled","disabled");
			$("#itemsTexts1").text("企业");
			billTitle = "002";
			//分配必选项
			$("#details li").each(function(){
				$(this).children().eq("0").children().eq("0").css("color","red");
				$(this).children().eq("0").children().eq("0").addClass("red");
			});
			
		}
	});
	//检验表单
	function checkout(){
		var flag = true;
		$(".red").each(function(){
			var value = $(this).parent().next().children().val();
			if(value.trim() == "" ){
				flag = false;
			}
		});
		return flag;
	}
	
	//索取发票
	$(".submit-btn").click(function(){
		if(!checkout()){
			layer.open({
				content:'必填项不能为空',
				time:1.5,
			});
			return;
		}
		var orderStr = GetQueryString("orderNoArr");
		var orderNoArr = orderStr.split(",");
		var input_provinceVal = $("#input_province").val();
		var input_cityVal = $("#input_city").val();
		var input_areaVal = $("#input_area").val();
		$.ajax({
    		url:'busOrder/saveBill.do',
    		type:"post",
	    	dataType: "json", 
	    	async : false,
	        cache : false,
	        traditional: true,
    		data:{
    			 orderNoArr:orderNoArr,//订单编号
	    		"billNatrue":billNatrue,//发票状态 "1":"电子发票",  "2":"纸质发票"
	    		"billType":billType,//发票类型:01普通发票,02增值税发票
	    		"billTitle":billTitle,//发票抬头 1个人  2.公司
	    		"billReceipt":$("[name='billReceipt']").val(),//纳税人识别号
	    		"billContent":"产品明细",//发票内容
	    		"billReceivePhone":$("[name='billReceivePhone']").val(),//收票人手机号
	    		"billReceiveAddress":$("[name='billReceiveAddress']").val(),//收票人地址
	    		"billStatus":$("[name='billStatus']").val(),//发票状态
	    		"companyName":$("[name='companyName']").val(),//单位名称
	    		"registerAddress":$("[name='registerAddress']").val(),//单位注册地址
	    		"registerPhone":$("[name='registerPhone']").val(),//单位注册手机号码
	    		"openBand":$("[name='openBand']").val(),//开户行
	    		"bandCard":$("[name='bandCard']").val(),//银行卡
	    		"billReceiveName":$("[name='billReceiveName']").val(),//收票人姓名
	    		"billReceiveMail":$("[name='billReceiveMail']").val(),//收票人邮箱
	    		"billProvince":input_provinceVal,//省
				"billCity":input_cityVal,//市
				"billArea":input_areaVal,//区
	    	},
    		success:function(data){
    			if(data.success){
    				layer.open({
    					content:'操作成功',
    					time:1.5,
    					end:function(){
    						window.location.href="busShoppCart/toOpenTicketTable.do";    						
    					}
    				});
    			}else{
    				layer.open({
    					 title: '错误信息'
    					 ,content:data.msg
    					 ,time:2,
    				}); 
    			}
    		}
    	});
	});
	
	function GetQueryString(name) {
		var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
		var r = window.location.search.substr(1).match(reg);
		if (r != null)
			return unescape(r[2]);
		return null;
	}
	
	function siteAdd() {
		var html = "<option value=''>== 请选择 ==</option>";
		$("#input_city").append(html);
		$("#input_area").append(html);
		$
				.each(
						pdata,
						function(idx, item) {
							if (parseInt(item.level) == 0) {
								html += "<option value='" + item.names + "' exid='" + item.code + "'>"
										+ item.names + "</option>";
							}
						});
		$("#input_province").append(html);
		$("#input_province")
				.change(
						function() {
							if ($(this).val() == "")
								return;
							$("#input_city option").remove();
							$("#input_area option").remove();
							var code = $(this).find("option:selected").attr(
									"exid");
							code = code.substring(0, 2);
							var html = "<option value=''>== 请选择 ==</option>";
							$("#input_area").append(html);
							$
									.each(
											pdata,
											function(idx, item) {
												if (parseInt(item.level) == 1
														&& code == item.code
																.substring(0, 2)) {
													html += "<option value='" + item.names + "' exid='" + item.code + "'>"
															+ item.names
															+ "</option>";
												}
											});
							$("#input_city").append(html);
						});
		$("#input_city")
				.change(
						function() {
							if ($(this).val() == "")
								return;
							$("#input_area option").remove();
							var code = $(this).find("option:selected").attr(
									"exid");
							code = code.substring(0, 4);
							var html = "<option value=''>== 请选择 ==</option>";
							$
									.each(
											pdata,
											function(idx, item) {
												if (parseInt(item.level) == 2
														&& code == item.code
																.substring(0, 4)) {
													html += "<option value='" + item.names + "' exid='" + item.code + "'>"
															+ item.names
															+ "</option>";
												}
											});
							$("#input_area").append(html);
						});
		//绑定
		$("#input_province").val("北京市");
		$("#input_province").change();
		$("#input_city").val("市辖区");
		$("#input_city").change();
		$("#input_area").val("东城区");
	}
</script>
