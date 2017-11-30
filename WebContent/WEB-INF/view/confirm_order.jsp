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
<title>订单确认</title>
<link rel="stylesheet" type="text/css" href="frame/static/css/shopping_cart.css"/> 
<link rel="stylesheet" type="text/css" href="frame/static/css/jcDate.css"/> 
<link rel="stylesheet" type="text/css" href="frame/static/css/site.css"/> 
<style type="text/css">
.addressTip-table{display: inline-table;padding: 6px}
.addressTip-table>li{
	display: table-row;
	height: 30px;
	line-height: 30px;
}
.addressTip-table>li>div{
	display: table-cell;
	padding:0px 8px;
	text-align: center;
}
.addressTip-table>li>div input{vertical-align: text-bottom;}
.addressTip-table>li a{display: none;}
.addressTip-table>li:HOVER a{display: inline;}
.uearname_checked{
	background: url("frame/static/img/selected-icon.png") no-repeat bottom right;
	border: 2px solid #e4393c;
    padding: 4px 10px;
}
.tit-txt{
	color:#666;
	font-size: 16px;
}
#addressTip a,#addressTip>ul+span{
	color: #005ea7;
}
#addressTip a:HOVER,#addressTip>ul+span:HOVER{
	color: #e4393c;
}
.default>span{
	background: #999;
	color: #fff;
	padding: 0px 4px;
}
.userName{width: 180px;}
.userPhone{width: 120px;}
.userAddress{width: 330px;}
</style>
</head>
<body>
	<!--顶部-->
	<div class="head">
		<jsp:include page="head.jsp" flush="true"/>
	</div>

	<!-- 中间的内容 -->
	<div class="centre">
		<div class="content">
			<div id="addressTip">
				<span class="tit-txt">确认收货地址</span>
				<a style="float:right;">使用新地址</a>
				<ul class="addressTip-table layui-table" lay-skin="line">
					
				</ul>
				<span>更多地址</span>
				<div></div>
			</div>
			
			<div class="header">
				<span class="buy_name">商品</span>
				<span class="buy_discount">折扣</span>
				<span class="buy_univalence">单价（元）</span>
				<span class="buy_amount">数量</span>
				<span class="buy_aggregate">小计（元）</span>
				<span class="buy_operate">类型</span>
			</div>
			<div id="sheet" class="sheet">
				
			</div>
			
			<div class="button_box">
				<button type="button" class="affirm_indent" id="createOrder">确认订单</button>
			</div>
		</div>
	</div> 
	
	<!--底部-->
	<div class="base">
		 <jsp:include page="base.jsp" flush="true"/>
	</div>
	
</body>

</html>
<script type="text/javascript" src="frame/static/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="frame/static/js/baiduTemplate.js"></script>
<script type="text/javascript" src="frame/static/js/jQuery-jcDate.js"></script>
<script type="text/javascript" src="frame/static/layer/layer.js"></script>
<script type="text/javascript" src="frame/static/js/pdata.js"></script>
<script type="text/javascript" src="frame/static/js/jquery.validate.min.js"></script>
<script type="text/javascript" src="frame/static/js/messages_zh.js"></script>
<script type="text/javascript" src="frame/static/js/additional-methods.js"></script>
<script type="text/javascript" src="frame/static/js/jquery.validate.method.extend.js"></script>
<script type="text/javascript" src="frame/static/js/company.js"></script>
<script id="bd_t1" type="text/template">
	
	<*for(var key in obj){*>
		<*var list = obj[key]*>
		<li>
			<div style="display:none">
				<input type="radio" name="operation" <*=list.status==1?"class='pitch' checked='checked'":""*>/>
				<input type="hidden" name="tableKey" value="<*=list.tableKey*>">
				<input type="hidden" name="area" value="<*=list.area*>">
				<input type="hidden" name="city" value="<*=list.city*>">
				<input type="hidden" name="province" value="<*=list.province*>">
			</div>
			<div class="userName"><*=list.userName*></div>
			<div class="userPhone"><*=list.userPhone*></div>
			<div class="userAddress"><*=list.userAddress*></div>
			<div style="width:80px" class="delete"><a>删除</a></div>
<*if(list.status == 0){*>
			<div style="width:80px" class="default"><a>设为默认</a></div>
<*}else{*>
			<div style="width:80px;" class="default"><span>默认地址</span></div>
<*}*>
			<div style="width:80px" class="update"><a>修改地址</a></div>
		</li>
	<*}*>
</script>
<script id="bd_t2" type="text/template">
<*
var supplyName = [];
				var tmp = [];
				var numerical = 0;
				var tmpguan = new Array();
				for(var i in shoppCart){
					supplyName.push(shoppCart[i].supplyName);
				}
				for(var i in supplyName){
					//该元素在tmp内部不存在才允许追加
					if(tmp.indexOf(supplyName[i])==-1){
						tmp.push(supplyName[i]);
					}
				}
				for(var i in tmp){
					tmpguan[i] = new Array();
					tmpguan[i].push(tmp[i]);
				}
				for(var i in tmp){
					for(var numerical in shoppCart){
						if(tmp[i] == shoppCart[numerical].supplyName){
							tmpguan[i].push(numerical);
						}
					}
				}
*>
	<*for(var key in tmp){*>
		<*var list = shoppCart[tmpguan[key][1]]*>
		
		<div class="moudle" id="<*=key*>">
			<div class="shop-info">
				<span class="margin-right-40 vertical-m"><*=list.supplyName*></span><span class="vertical-m utel"><*=list.supplyPhone*></span>
			</div>
<*for(var num = 1; num < tmpguan[key].length; num++){*>
<*var listDetail = shoppCart[tmpguan[key][num]]*>
			<!--商品信息-->
			
			<div class="message" id="<*=listDetail.tableKey*>"  data-supplyno="<*=listDetail.supplyNo*>">
				<input type="hidden" value="<*=listDetail.tableKey*>">
				<div class="buy_name">
					<p style="width:310px;" class="text-l margin-bottom-10 text-flow" title="<*=listDetail.goodsName*>"><*=listDetail.goodsName*></p>
					<p style="width:310px;" class="text-l text-flow" title="<*=listDetail.goodsCode*>"><*=listDetail.goodsCode*>-<*=listDetail.goodsNo*></p></div>
				
<div class="buy_discount"><*if(listDetail.goodsDiscount==10){*>
						无折扣
					<*}else{*>
						<*=listDetail.goodsDiscount*>
					<*}*></div>

				<div class="buy_univalence"><*=listDetail.goodsPrice.toFixed(2)*></div>
				<div class="buy_amount">
					<*=listDetail.buyNum*>
				</div>
				<div class="buy_aggregate"><*=(Math.round(listDetail.buyNum*listDetail.goodsPrice*listDetail.goodsDiscount)/10).toFixed(2)*></div>
				<div class="buy_operate">
					<label"><span class="vertical-m fs14 font-666 buytype" buytype="<*=listDetail.buyType*>"><*=listDetail.buyType==09001? "试刀" : "购买"*></span></label>
				</div>
			</div>
<*}*>
			<div class="date">
				<label>默认收货时间：<*=list.defaultPayDt*></label>
				<div class="text-bar-right margin-right-10">
					<label class="delivery_date">期望到货时间：</label>
					<input class="wishDate" readonly onclick="laydate()"/>
				</div>
				<div class="clear"></div>
			</div>
			<div class="remark">
				<label>备注：</label>
				<input type="text" class="input-remark"/>
			</div>
		</div>
	<*}*>
</script>

<script type="text/javascript">
$(function(){
	function jiazai(){
		var choose = $(".addressTip-table").children("li").length;
		for(var i = 0; i < choose; i++){
			if($($(".addressTip-table li")[i]).find("input[type=radio]").attr("checked")){
				$($($(".addressTip-table li")[i]).children()[1]).addClass("uearname_checked");
				$($(".addressTip-table li")[i]).show();
			}else{
				$($(".addressTip-table li")[i]).children("div").removeClass("uearname_checked");
			}
		}
	}
	$(".addressTip-table").on("click","li>.userName",function(){
		$("input[type=radio]").attr("checked", false);
		$("input[type=radio]").removeClass("pitch");
		$(this).parent().children().children("input[type=radio]").attr("checked", true);
		$(this).parent().children().children("input[type=radio]").addClass("pitch");
		jiazai();
	});
	$("#addressTip>span").click(function(){
		if($(this).text() == "更多地址"){//显示
			$(".addressTip-table li").show();
			$(this).text("隐藏");
		}else{
			$(".addressTip-table li").hide();
			jiazai();
			$(this).text("更多地址");
		}
	});
	
	var clearHeight = 0;
	baidu.template.LEFT_DELIMITER='<*';
	baidu.template.RIGHT_DELIMITER='*>';
	//layui路径配置
	layui.config({
		 dir: 'frame/layui/' //layui.js 所在路径（注意，如果是script单独引入layui.js，无需设定该参数。），一般情况下可以无视
		 ,version: false //一般用于更新模块缓存，默认不开启。设为true即让浏览器不缓存。也可以设为一个固定的值，如：201610
		 ,debug: false //用于开启调试模式，默认false，如果设为true，则JS模块的节点会保留在页面
		 ,base: 'frame/layui/' //设定扩展的Layui模块的所在目录，一般用于外部模块扩展
	});
	/* 自定义的单选radio */
	$("#addressTip").on("click","input:radio[name=operation]",function(){
		$('input:radio[name="operation"]').removeClass("pitch");
		$('input:radio[name="operation"]:checked').addClass("pitch");
	});
	//添加新地址
	$("#addressTip>a").click(function(){
		layer.open({
			title: '添加地址',
			content:siteTemplate,
			btn:['确认','取消'],
			scrollbar:false,//不允许浏览器出现滚动条
			area:['520px','462px'],
			success:function(){siteAdd();},
			yes: function(){
				siteAdd_verification();
			}
		});
	});
	///设为默认
	$(".addressTip-table").on('click',".default",function(){
		var val = $(this).parent().find("[name=tableKey]").val();
		$.ajax({
			url:"busShoppCart/defaultAddress.do",
			data:{"tableKey":val},
			dataType:"json",
			type:"post",
			success:function(data){
				if(data.success){
					location.href="goods/toConfirmOrder.do";
				}else{
					layer.open({
						 title: '错误信息'
						 ,content:data.msg
					}); 
				}
			}
		});
	});
	//删除
	$(".addressTip-table").on('click',".delete",function(){
		var val = $(this).parent().find("[name=tableKey]").val();
		$.ajax({
			url:"busShoppCart/deleteSite.do",
			data:{"tableKey":val},
			dataType:"json",
			type:"post",
			success:function(data){
				if(data.success){
					location.href="goods/toConfirmOrder.do";
				}else{
					layer.open({
						 title: '错误信息'
						 ,content:data.msg
					}); 
				}
			}
		});
	});
	//修改地址
	$(".addressTip-table").on('click',".update",function(){
		var trMould = $(this).parent();
		layer.open({
			title: '修改地址',
			content: siteTemplate,
			btn:['确认','取消'],
			scrollbar:false,//不允许浏览器出现滚动条
			area:['520px','462px'],
			success:function(){
				siteUpdate(trMould);
			},
			yes: function(){
				var phone = $("[name=phone]").val();
				if(!(/^1[34578]\d{9}$/.test(phone))){ 
			        $("#billReceivePhone").text('手机号码有误');
			    }else{
			    	$("#billReceivePhone").text('');
			    	siteUpdate_verification();
			    }
			}
		});
	});
	/* //手机号验证
	$(document).on("blur","[name=phone]",function(){
		var phone = $(this).val();
		if(!(/^1[34578]\d{9}$/.test(phone))){ 
	        $("#billReceivePhone").text('手机号码有误');
	    }else{
	    	$("#billReceivePhone").text('');
	    	//siteUpdate_verification();
	    }
	}); */
	//确认订单
	$("#createOrder").click(function(){
		var orderArray=new Array();
		var address = $('input:radio[name="operation"]:checked').next().val();
		if(address==""||address==null){
			layer.msg('请先确认收货地址', {icon: 2});
			return;
		}
		$(".message").each(function(){
			var order={};
			order["supplyNo"] = $(this).attr("data-supplyno");;
			
			$(this).find(".buy_amount").each(function(){
				order["num"]=$(this).text();
			});
			$(this).find(".buytype").each(function(){
				order["type"]=$(this).attr("buytype");
			});
			$(this).parent().find(".wishDate").each(function(){
				order["wishDate"]=$(this).val();
			});
			$(this).parent().find(".input-remark").each(function(){
				order["remark"]=$(this).val();
			});
			$(this).find("input[type=hidden]").each(function(){
				order["tableKey"]=$(this).val();
			});
			order["address"]=address;
			orderArray.push(order);
			flag=1;
		});
		var array=JSON.stringify(orderArray);
		$.ajax({
			url:"busOrder/createOrder.do",
			data:{"orderArray":array},
			dataType:"json",
			type:"post",
			beforeSend: function(){
				$("#createOrder").attr("disabled","disabled");
			},
			success:function(data){
				if(data.success){
					layer.msg('订单生成成功', {
						  icon: 1,
						  time: 3000
						}, function(){
						  location.href="busOrder/toPage/buyerIndent_tab.do";
					});
				}else{
					layer.open({
						 title: '错误信息'
						 ,content:data.msg
					}); 
				}
			}
		}); 
	});
	
function GetQueryString(name){
     var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
     var r = window.location.search.substr(1).match(reg);
     if(r!=null)return  unescape(r[2]); return null;
}
	//收货地址
	$.ajax({
		url:"busShoppCart/getUserAddress.do",
		success:function(data){
			if (data.success) {
				var html1=baidu.template('bd_t1',data);
				$(".addressTip-table").append(html1);
				var choose = $(".addressTip-table").children("li").length;
				var vue = GetQueryString("vue");
				var liatDate = [];
				if(vue){
					$(".addressTip-table").children("li").css("dispaly","table-row;")
					for(var i = 0; i < choose; i++){
						liatDate.push(data.obj[i].insetDate);
						liatDate.sort();
					}
					var sumDate = liatDate[choose-1];
					for(var i = 0; i < choose; i++){
						if(data.obj[i].insetDate == sumDate){
							$($(".addressTip-table li")[i]).find("input[type=radio]").attr("checked","checked");
							$($($(".addressTip-table li")[i]).children()[1]).addClass("uearname_checked");
						}else{
							$($(".addressTip-table li")[i]).find("input[type=radio]").attr("checked",false);
							$($($(".addressTip-table li")[i]).children()[1]).removeClass("uearname_checked");
							$($(".addressTip-table li")[i]).hide();
						}
					}
				}
				for(var i = 0; i < choose; i++){
					if($($(".addressTip-table li")[i]).find("input[type=radio]").attr("checked")){
						$($($(".addressTip-table li")[i]).children()[1]).addClass("uearname_checked");
					}else{
						$($($(".addressTip-table li")[i]).children()[1]).removeClass("uearname_checked");
						$($(".addressTip-table li")[i]).hide();
					}
				}
			}else{
				layer.open({
					title: '错误信息'
					,content:data.msg
				});
			}
		 }
	});
	//获取商品信息
	$.ajax({
		url:"busShoppCart/getOrderList.do",
		success:function(data){
			if (data.success) {
				var html2=baidu.template('bd_t2',data.map);
				$("#sheet").append(html2);
			}else{
				layer.open({
					title: '错误信息'
					,content:data.msg
				});
			}
		 }
	});
});

//新增地址
var siteTemplate = '<div class="moban">';
siteTemplate = siteTemplate + '<form method="post" id="site_add" onsubmit="return false">';
siteTemplate = siteTemplate + '<div id="">';
siteTemplate = siteTemplate + '<label>省:</label>';
siteTemplate = siteTemplate + '<select name="input_province" id="input_province" class="form-control">';
siteTemplate = siteTemplate + '</select>';
siteTemplate = siteTemplate + '<label>市:</label>';
siteTemplate = siteTemplate + '<select name="input_city" id="input_city" class="form-control">';
siteTemplate = siteTemplate + '</select>';
siteTemplate = siteTemplate + '<label>区:</label>';
siteTemplate = siteTemplate + '<select name="input_area" id="input_area" class="form-control">';
siteTemplate = siteTemplate + '</select>';
siteTemplate = siteTemplate + '</div>';
siteTemplate = siteTemplate + '<div id="">';
siteTemplate = siteTemplate + '<label>详细地址：</label>';
siteTemplate = siteTemplate + '<textarea name="dizhi"></textarea>';
siteTemplate = siteTemplate + '<span></span>';
siteTemplate = siteTemplate + '</div>';
siteTemplate = siteTemplate + '<div id="">';
siteTemplate = siteTemplate + '<label>收货人：</label>';
siteTemplate = siteTemplate + '<input type="text" name="consignee"/>';
siteTemplate = siteTemplate + '<span></span>';
siteTemplate = siteTemplate + '</div>';
siteTemplate = siteTemplate + '<div id="">';
siteTemplate = siteTemplate + '<label>手机号：</label>';
siteTemplate = siteTemplate + '<input type="tel" name="phone" maxLength="11"/>';
siteTemplate = siteTemplate + '<span id="billReceivePhone"></span>';
siteTemplate = siteTemplate + '</div>';
siteTemplate = siteTemplate + '<input type="hidden" name="tableKey"/>';
siteTemplate = siteTemplate + '</form>';
siteTemplate = siteTemplate + '</div>';

Date.prototype.Format = function (fmt) { //author: meizz 
    var o = {
        "M+": this.getMonth() + 1, //月份 
        "d+": this.getDate(), //日 
        "h+": this.getHours(), //小时 
        "m+": this.getMinutes(), //分 
        "s+": this.getSeconds(), //秒 
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
        "S": this.getMilliseconds() //毫秒 
    };
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
}

function siteAdd() {
	var html = "<option value=''>== 请选择 ==</option>";
	$("#input_city").append(html);
	$("#input_area").append(html);
	$.each(pdata,function(idx,item){
		if (parseInt(item.level) == 0) {
			html += "<option value='" + item.names + "' exid='" + item.code + "'>" + item.names + "</option>";
		}
	});
	$("#input_province").append(html);
	$("#input_province").change(function(){
		if ($(this).val() == "") return;
		$("#input_city option").remove(); $("#input_area option").remove();
		var code = $(this).find("option:selected").attr("exid"); code = code.substring(0,2);
		var html = "<option value=''>== 请选择 ==</option>"; $("#input_area").append(html);
		$.each(pdata,function(idx,item){
			if (parseInt(item.level) == 1 && code == item.code.substring(0,2)) {
   				html += "<option value='" + item.names + "' exid='" + item.code + "'>" + item.names + "</option>";
   			}
		});
		$("#input_city").append(html);		
	});
	$("#input_city").change(function(){
		if ($(this).val() == "") return;
		$("#input_area option").remove();
		var code = $(this).find("option:selected").attr("exid"); code = code.substring(0,4);
		var html = "<option value=''>== 请选择 ==</option>";
		$.each(pdata,function(idx,item){
			if (parseInt(item.level) == 2 && code == item.code.substring(0,4)) {
   				html += "<option value='" + item.names + "' exid='" + item.code + "'>" + item.names + "</option>";
   			}
		});
		$("#input_area").append(html);		
	});
	//绑定
	$("#input_province").val("北京市");$("#input_province").change();
	$("#input_city").val("市辖区");$("#input_city").change();
	$("#input_area").val("东城区");
};
function siteAdd_verification(){
	var province=$("[name='input_province']").val();
	var city=$("[name='input_city']").val();
	var area=$("[name='input_area']").val();
	var postCode=$("[name='youbian']").val();
	var address=$("[name='dizhi']").val();
	var addresseeName=$("[name='consignee']").val();
	var telephone=$("[name='phone']").val();
	console.log(2)
	
	if(!(/^1[34578]\d{9}$/.test(telephone))){ 
        $("#billReceivePhone").text('手机号码有误');
    }else{
    	$("#billReceivePhone").text('');
		$.ajax({
			url:"busShoppCart/addSite.do",
			data:{
				"province":province,
				"city":city,
				"area":area,
				"postCode":postCode,
				"address":address,
				"addresseeName":addresseeName,
				"telephone":telephone
			},
			type:"post",
			success : function(data){         		
				if(data.success){
					//location.reload();
					location.href="goods/toConfirmOrder.do?vue=true";
				}else{
					layer.open({
						title: '错误信息'
						,content:data.msg
					}); 
				}
			}
		}); 
    }
}
//修改
function siteUpdate(mou){
	var html = "<option value=''>== 请选择 ==</option>"; $("#input_city").append(html); $("#input_area").append(html);
	$.each(pdata,function(idx,item){
		if (parseInt(item.level) == 0) {
			html += "<option value='" + item.names + "' exid='" + item.code + "'>" + item.names + "</option>";
		}
	});
	$("#input_province").append(html);
	$("#input_province").change(function(){
		if ($(this).val() == "") return;
		$("#input_city option").remove(); 
		$("#input_area option").remove();
		var code = $(this).find("option:selected").attr("exid"); code = code.substring(0,2);
		var html = "<option value=''>== 请选择 ==</option>"; $("#input_area").append(html);
		$.each(pdata,function(idx,item){
			if (parseInt(item.level) == 1 && code == item.code.substring(0,2)) {
   				html += "<option value='" + item.names + "' exid='" + item.code + "'>" + item.names + "</option>";
   			}
		});
		$("#input_city").append(html);
	});

	$("#input_city").change(function(){
		if ($(this).val() == "") return;
		$("#input_area option").remove();
		var code = $(this).find("option:selected").attr("exid"); code = code.substring(0,4);
		var html = "<option value=''>== 请选择 ==</option>";
		$.each(pdata,function(idx,item){
			if (parseInt(item.level) == 2 && code == item.code.substring(0,4)) {
   				html += "<option value='" + item.names + "' exid='" + item.code + "'>" + item.names + "</option>";
   			}
		});
		$("#input_area").append(html);		
	});
	//绑定
	$("#input_province").val(mou.children("div:eq(0)").children("[name=province]").val());$("#input_province").change();
	$("#input_city").val(mou.children("div:eq(0)").children("[name=city]").val());$("#input_city").change();
	$("#input_area").val(mou.children("div:eq(0)").children("[name=area]").val());
	$("[name=tableKey]").val(mou.children("div:eq(0)").children("[name=tableKey]").val());
	$("input[name=phone]").val(mou.children("div:eq(2)").text());
	$("input[name=consignee]").val(mou.children("div:eq(1)").text());
	$("[name=dizhi]").val(mou.children("div:eq(3)").text());
}
function siteUpdate_verification(){
	var province=$("[name='input_province']").val();
	var city=$("[name='input_city']").val();
	var area=$("[name='input_area']").val();
	var postCode=$("[name='youbian']").val();
	var address=$("[name='dizhi']").val();
	var addresseeName=$("[name='consignee']").val();
	var telephone=$("[name='phone']").val();
	var tableKey=$("[name='tableKey']").val();
	
	$.ajax({
		url:"busShoppCart/addSite.do",
		data:{"tableKey":tableKey,"province":province,"city":city,"area":area,"postCode":postCode,"address":address,"addresseeName":addresseeName,"telephone":telephone},
		type:"post",
         success : function(data){         		
			if(!data.success){
				layer.open({
					title: '错误信息'
					,content:data.msg
				}); 
			}else{
				location.reload();
			}
         }
	});
}
</script>