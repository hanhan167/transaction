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
<link rel="stylesheet" type="text/css" href="frame/static/css/commonality.css" />
<link rel="stylesheet" type="text/css" href="frame/static/css/indentIndent.css"/>
<title>供方订单-拆分</title>
<style type="text/css">
.clear{clear:both;}
.box{
	padding: 30px 0;
}
.content h2{
	color: #333;
    font-size: 18px;
    font-weight: 600;
}
#box_left,#box_right{
	float: left;
	width: 460px;
}
#box_right{
	float: right;
}
#box_right li span:nth-of-type(2),
#box_right li span:nth-of-type(4){
	border: 1px solid #c2c2c2;
    width: 18px;
    height: 18px;
    text-align: center
}
#box_right li span:nth-of-type(3){width: 40px;text-align: center;}
.box h3{
	background-color: #fff;
    color: #03a2a3;
    font-size: 18px;
    font-weight: 600;
    height: 40px;
    line-height: 40px;
    padding: 0 0 0 20px;
}
.box dd{
	border-bottom: 1px solid #bfbfbf;
	display: inline-block;
	text-align: center;
    margin-top: 10px;
    background: #fff;
    height: 40px;
    line-height: 40px;
    font-size: 14px;
    color: #666;
}
.centre ul{
	min-height: 200px;
    background: #fff;
}
.centre ul>li{
	border-bottom: 1px solid #bfbfbf;
	cursor:pointer;
	color: #333;
	height: 39px;
	line-height: 40px;
}
ul>li>span{
	display: inline-block;
	text-align: center;
	white-space: nowrap;
    text-overflow: ellipsis;
    overflow: hidden;
}
#notarize{
	margin: 20px 0;
}
#notarize table{
	background:#fff;
 	border-collapse: collapse;
    border: 1px solid #e6e6e6;
	width: 100%;
    margin: 25px auto;
    text-align: center;
}
#notarize table td,
#notarize table th{
	border: 1px solid #e6e6e6;
	height: 30px;
}
#new_indent,#verify{
	float: right;
	margin-top: 20px;
}
.li_background{
	background: #eee;
}
.box>div>em{
	display: inline-block;
	text-align: center;
}
#botton_right,#botton_left{
	width: 40px;
	height: 30px;
	display: inline-block;
	background-size: 100% 100%;
	position: relative;
    left: 15px;
}
#botton_left{
	background: url("frame/static/img/left.png") no-repeat;
	top: 120px;
}
#botton_right{
	background: url("frame/static/img/right.png") no-repeat;
	top:100px;
}
.nummber{
	vertical-align: middle;
    line-height: 20px;
    position: relative;
    top: -15px
}
#yuanying{
	height: 30px;
	line-height: 30px;
}
#yuanying input{
	height: 30px;
	line-height: 30px;
	width:200px;
	padding:0 5px;
}
</style>
</head>
<body>
	
	<!--顶部-->
	<div class="head">
		<jsp:include page="head.jsp" flush="true"/>
	</div>
	<!--内容-->
	<div class="centre">
		<div class="content">
			<h2>拆分订单</h2>
			<div class="box">
				<!-- 左 -->
				<div id="box_left">
					<h3>原有订单</h3>
					<dd style="width: 360px">商品名称</dd><dd style="width: 100px">商品数量</dd>
					<ul></ul>
					<div class="clear"></div>
				</div>
				<!-- 右 -->
				<div id="box_right">
					<h3>订单编辑</h3>
					<dd style="width: 360px">商品名称</dd><dd style="width: 100px">商品数量</dd>
					<ul></ul>
					<div class="clear"></div>
				</div>
				<div id="botton_right"></div>
				<div id="botton_left"></div>
				<div class="clear"></div>
				<button id="new_indent" class="cancel_indent">生成新订单</button>
				<div class="clear"></div>
			</div>
			<hr />
			<!-- 已确认的订单 -->
			<div id="notarize">
				<h2>生成新订单</h2>
			</div>
			<!-- <label id="yuanying">拆单原因<input type="text" maxlength='150'></label> -->
			<button id="verify" class="affirm_indent">确认</button>
		</div>
	</div>
	<!--底部-->
	<div class="base">
		 <jsp:include page="base.jsp" flush="true"/>
	</div>
	
</body>
</html>
<script type="text/javascript" src="frame/static/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="frame/static/layer/layer.js"></script>
<script type="text/javascript" src="frame/static/js/baiduTemplate.js"></script>
<script type="text/javascript" src="frame/static/js/company.js"></script>
<script id="bd_t1" type="text/template">
<*for(var i in obj){*>
<*var list = obj[i]*>
<li>
	<span style="width:360px" title="<*=list.goodsName*><*=list.goodsCode*>-<*=list.goodsNo*>"><*=list.goodsName*><*=list.goodsCode*>-<*=list.goodsNo*></span>
	<span style="width:100px;"><*=list.goodsCount*></span>
	<input type="hidden" class="goodsNo" value=<*=list.goodsNo*>>
	<input type="hidden" class="orderNo" value=<*=list.orderNo*>>
	<input type="hidden" class="tableKey" value=<*=list.tableKey*>>
</li>
<*}*>
</script>
<script type="text/javascript">
function buttonImg(){
	if($("#box_left li.li_background").length==1){
		$("#botton_right").css({"background":"url(frame/static/img/right_clik.png) no-repeat"});
	}else{
		$("#botton_right").css({"background":"url(frame/static/img/right.png) no-repeat"});
	}
	if($("#box_right li.li_background").length==1){
		$("#botton_left").css({"background":"url(frame/static/img/left_clik.png) no-repeat"});
	}else{
		$("#botton_left").css({"background":"url(frame/static/img/left.png) no-repeat"});
	}
}
$(function(){
	var url = location.search; //获取url中"?"符后的字串
	var oederId;
	var trade_name;
	if (url.indexOf("?") != -1) {    //判断是否有参数
		var str = url.substr(1); //从第一个字符开始 因为第0个是?号 获取所有除问号的所有符串
		strs = str.split("=");   //用等号进行分隔 （因为知道只有一个参数 所以直接用等号进分隔 如果有多个参数 要用&号分隔 再用等号进行分隔）
		oederId = strs[1];
	}
	$.ajax({
		url:"busOrder/getById.do",
		data:{"orderNo":oederId},
		datatype:"json",
		beforeSend:function(){
			$(".sheet").html("获取数据中");
		},
		success:function(data){
			if(data.success){
				var concount=baidu.template('bd_t1',data);
				$("#box_left>ul").html(concount);
				trade_name = data.obj;
			}else{
				layer.open({
					title: '错误信息'
					,content:data.msg
				});
			}
		}
	});
	$("#box_left").on("click","li",function(){
		$("li").removeClass("li_background");
		$(this).addClass("li_background");
		buttonImg();
	});
	$("#box_right").on("click","li",function(){
		$("li").removeClass("li_background");
		$(this).addClass("li_background");
		buttonImg();
	});
	//向右添加
	$("#botton_right").click(function(){
		var left_li = $("#box_left").find("li");
		var this_text = $($("#box_left>ul>li.li_background").children("span")[0]).text();
		var this_goods = $("#box_left>ul>li.li_background").children(".goodsNo").val();
		var this_order = $("#box_left>ul>li.li_background").children(".orderNo").val();
		var this_key = $("#box_left>ul>li.li_background").children(".tableKey").val();
		
		$($("#box_left>ul>li.li_background").children("span")[1]).text($($("#box_left>ul>li.li_background").children("span")[1]).text()-1);
		if($($("#box_left>ul>li.li_background").children("span")[1]).text() == 0){
			$("#box_left>ul>li.li_background").remove();
		}
		var basis = 0;
		var right_ul = $("#box_right>ul").children("li").length;
		for(var i=0;i<right_ul;i++){
			var li_text = $($($("#box_right>ul>li")[i]).children("span")[0]).text();
			if(this_text == li_text){
				basis = 1;
				break;
			}
		}
		if((basis == 0)&&(this_text!="")){//0mei 1//you
			var html = '<li><span style="width:360px" title="'+this_text+'">'+this_text+'</span><span class="nummber subtract" style="margin-left: 10px;">-</span><span class="shuzi">1</span><span class="nummber add">+</span>';
			html += '<input type="hidden" class="goodsNo" value='+this_goods+'>';
			html += '<input type="hidden" class="orderNo" value='+this_order+'>';
			html += '<input type="hidden" class="tableKey" value='+this_key+'>';
			html += '</li>';
			$("#box_right>ul").append(html);
		}else{
			for(var i=0;i<right_ul;i++){
				var li_text = $($($("#box_right>ul>li")[i]).children("span")[0]).text();
				if(this_text == li_text){
					var li_num = $($($("#box_right>ul>li")[i]).children("span")[2]).text();
					$($($("#box_right>ul>li")[i]).children("span")[2]).text(parseInt(li_num)+1);
				}
			}
		}
		buttonImg();
	});
	//向左添加
	$("#botton_left").click(function(){
		var left_li = $("#box_right").find("li");
		var this_text = $($("#box_right>ul>li.li_background").children("span")[0]).text();
		var this_goods = $("#box_right>ul>li.li_background").children(".goodsNo").val();
		var this_order = $("#box_right>ul>li.li_background").children(".orderNo").val();
		var this_key = $("#box_right>ul>li.li_background").children(".tableKey").val();
		var num=$($("#box_right>ul>li.li_background").children("span")[2]).text();
		$($("#box_right>ul>li.li_background").children("span")[2]).text(parseInt(num)-1);
		if($($("#box_right>ul>li.li_background").children("span")[2]).text() == 0){
			$("#box_right>ul>li.li_background").remove();
		}
		var basis = 0;
		var right_ul = $("#box_left>ul").children("li").length;
		for(var i=0;i<right_ul;i++){
			var li_text = $($($("#box_left>ul>li")[i]).children("span")[0]).text();
			if(this_text == li_text){
				basis = 1;
				break;
			}
		}
		if((basis == 0)&&(this_text!="")){//0mei 1//you
			var html = '<li><span style="width:360px" title="'+this_text+'">'+this_text+'</span><span style="width:100px">1</span>';
			html += '<input type="hidden" class="goodsNo" value='+this_goods+'>';
			html += '<input type="hidden" class="orderNo" value='+this_order+'>';
			html += '<input type="hidden" class="tableKey" value='+this_key+'>';
			html += '</li>';
			$("#box_left>ul").append(html);
		}else{
			for(var i=0;i<right_ul;i++){
				var li_text = $($($("#box_left>ul>li")[i]).children("span")[0]).text();
				if(this_text == li_text){
					var li_num = $($($("#box_left>ul>li")[i]).children("span")[1]).text();
					$($($("#box_left>ul>li")[i]).children("span")[1]).text(parseInt(li_num)+1);
				}
			}
		}
		buttonImg();
	});
	$("#box_right>ul").on("click","li>span.shuzi",function(){
		var click_num = $(this);
		layer.open({
			title: '数量修改',
			type:'1',
			area: ['300px', '200px'],
			content:'<label></label><input class="num" value='+$(this).text()+'>',
			btn:['确认','取消'],
			yes: function(){
				var this_text = click_num.parent().children("span:eq(0)").text();
				var right_ul = $("#box_left>ul").children("li").length;
				//2017-09-12
				var li_right = click_num.text();
				
				for(var i=0;i<right_ul;i++){
					var li_text = $($($("#box_left>ul>li")[i]).children("span")[0]).text();
					if(this_text == li_text){
						var li_left = $($($("#box_left>ul>li")[i]).children("span")[1]).text();
						/* var li_right = $($($("#box_right>ul>li")[i]).children("span")[2]).text(); */
						var li_num = parseInt(li_left) + parseInt(li_right);
						if((li_num-$(".num").val())>0){
							$($($("#box_left>ul>li")[i]).children("span")[1]).text(li_num - $(".num").val());
							click_num.text($(".num").val());
						}else if((li_num-$(".num").val())==0){
							click_num.text($(".num").val());
							$($("#box_left>ul>li")[i]).remove();
						}
					}
				}
				layer.closeAll();
			}
		});
	});
	//减
	$("#box_right").on("click",".subtract",function(){
		var num = $(this).next().text();
		var this_text = $(this).parent().children("span:eq(0)").text();
		var right_ul = $("#box_left>ul").children("li").length;
		var basis = 0;
		for(var i=0;i<right_ul;i++){
			var li_text = $($($("#box_left>ul>li")[i]).children("span")[0]).text();
			if(this_text == li_text){
				basis = 1;
				break;
			}
		}
		if(basis == 0){//0mei 1//you
			var this_goods = $(this).children(".goodsNo").val();
			var this_order = $(this).children(".orderNo").val();
			var this_key = $(this).children(".tableKey").val();
			var html = '<li><span style="width:360px" title="'+this_text+'">'+this_text+'</span><span style="width:100px">1</span>';
			html += '<input type="hidden" class="goodsNo" value='+this_goods+'>';
			html += '<input type="hidden" class="orderNo" value='+this_order+'>';
			html += '<input type="hidden" class="tableKey" value='+this_key+'>';
			html += '</li>';
			$("#box_left>ul").append(html);
		}else{
			for(var i=0;i<right_ul;i++){
				var li_text = $($($("#box_left>ul>li")[i]).children("span")[0]).text();
				if(this_text == li_text){
					var li_num = $($($("#box_left>ul>li")[i]).children("span")[1]).text();
					$($($("#box_left>ul>li")[i]).children("span")[1]).text(parseInt(li_num)+1);
				}
			}
		}
		$(this).next().text(parseInt(num)-1);
		if(num<=1){$(this).parent().remove();}
	});
	//加
	$("#box_right").on("click",".add",function(){
		var num = $(this).prev().text();
		var this_text = $(this).parent().children("span:eq(0)").text();
		var right_ul = $("#box_right>ul").children("li").length;
		for(var i=0;i<right_ul;i++){
			var li_text = $($($("#box_left>ul>li")[i]).children("span")[0]).text();
			var aaa = $($($("#box_left>ul").children("li")[i]).children("span")[1]).text();
			if((aaa>0)&&(li_text == this_text)){
				$($($("#box_left>ul").children("li")[i]).children("span")[1]).text(parseInt(aaa)-1);
				$(this).prev().text(parseInt(num)+1);
			}
			var left_li = $($($("#box_left>ul").children("li")[i]).children("span")[1]).text();
			if(left_li == 0){$($("#box_left>ul").children("li")[i]).remove();}
		}
	});
	//生成新订单
	var ul_nummber=1;
	$("#new_indent").click(function(){
		var right_ul_li = $("#box_right>ul").children("li");
		if(right_ul_li.length>0){
			var right_ul = '';
			right_ul+='<tr><th colspan="2" align="left" style="padding-left:20px;color: #03a2a3;">新订单'+ul_nummber+':</th></tr>';
			ul_nummber++;
			right_ul+='<tr><th>商品名称</th><th>商品数量</th></tr>';
			for(var i=0;i<right_ul_li.length;i++){
				var this_goods = $($("#box_right>ul").children("li")[i]).children(".goodsNo").val();
				var this_order = $($("#box_right>ul").children("li")[i]).children(".orderNo").val();
				var this_key = $($("#box_right>ul").children("li")[i]).children(".tableKey").val();
				right_ul+='<tr><td style="width:80%">'+$($($("#box_right>ul").children("li")[i]).children("span")[0]).html()+'</td>';
				right_ul+='<td>'+$($($("#box_right>ul").children("li")[i]).children("span")[2]).html()+'</td>';
				right_ul += '<input type="hidden" class="goodsNo" value='+this_goods+'>';
				right_ul += '<input type="hidden" class="orderNo" value='+this_order+'>';
				right_ul += '<input type="hidden" class="tableKey" value='+this_key+'>';
				right_ul+='</tr>';
			}
			var new_html = '<table>'+right_ul+'</table><label class="yuanying">拆单原因<input type="text" maxlength="150"></label>';
			$("#notarize").append(new_html);
			$("#box_right>ul").empty();
		}
	});
	//确认拆分的订单
	$("#verify").click(function(){
		var remark = $("#yuanying input").val();
		var oldtBusOrderVo = trade_name;
		var oldtBusOrderVo = [];
		for(var i=0;i<trade_name.length;i++){
			oldtBus={
				"goodsNo":trade_name[i].goodsNo,
				"orderNo":trade_name[i].orderNo,
				"tableKey":trade_name[i].tableKey
			};
			oldtBusOrderVo.push(oldtBus);
		}
		var newtBusOrderVo = [];
		var num = 0;
		for(var i=0;i<$("#notarize").children("table").length;i++){
			for(var j=2;j<$($("#notarize").children("table")[i]).find("tr").length;j++){
				newtBus={
					"goodsCount":$($($($("#notarize").children("table")[i]).find("tr")[j]).children("td")[1]).text(),
					"identifying":num,
					"goodsNo":$($($("#notarize").children("table")[i]).find("tr")[j]).children(".goodsNo").val(),
					"tableKey":$($($("#notarize").children("table")[i]).find("tr")[j]).children(".tableKey").val(),
					"remark":$($("#notarize").children(".yuanying")[i]).children("input").val(),
				};
				newtBusOrderVo.push(newtBus);
			}
			num++;
		}
		var order = {};
		order.oldtBusOrderVo = oldtBusOrderVo;
		order.newtBusOrderVo = newtBusOrderVo;
		//order.remark = remark;
		var left_li = $("#box_left ul").children("li").length;
		var right_li = $("#box_right ul").children("li").length;
		if((left_li == 0)&&(right_li == 0)){
			layer.open({
				title: '确认信息',
				type:'1',
				area: ['300px', '200px'],
				content:'<div style="text-align: center;margin: 40px 0;">确认要拆单吗？</div>',
				btn:['确认','取消'],
				yes: function(){
					$.ajax({
						url:"busOrder/orderSplit.do",
						type:"post",
						contentType : "application/json; charset=utf-8",
						data:JSON.stringify(order),
						datatype:"json",
						beforeSend: function(){
							index1 = layer.load(1, {
								shade: [0.2,'#fff'] //0.1透明度的白色背景
							});
						},
						success:function(data){
							if(data.success){
								location.href="/transaction/busOrder/toPage/applyIndent_tab.do";
							}else{
								layer.open({
									title: '错误信息'
									,content:data.msg
								}); 
							}
						}
					});
				}
			});
			
		}else{
			layer.open({
				title: '错误信息'
				,content:'有商品未处理'
			}); 
		}
	});
});

baidu.template.LEFT_DELIMITER='<*';
baidu.template.RIGHT_DELIMITER='*>';
</script>