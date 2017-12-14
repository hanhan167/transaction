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
<link rel="stylesheet" type="text/css" href="frame/static/css/commonality.css"/>
<link rel="stylesheet" type="text/css" href="frame/layui/css/layui.css"/>
<link rel="stylesheet" type="text/css" href="frame/static/css/indentIndent.css"/>
<title>买方订单</title>
<style type="text/css">
.uname{color: blue;}
.label{
	display: inline-block;
	text-align: right;
	width: 100px;
}
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
			<!-- 选项卡 -->
			<div class="head_tab">
				<ul>
					<li class="choice"><a>全部（<span id="all"></span>）</a></li>
					<li><a>待确认（<span id="confirmed"></span>）</a></li>
					<li><a>待付款（<span id="payment"></span>）</a></li>
					<li><a>待发货（<span id="readyShip"></span>）</a></li>
					<li><a>待收货（<span id="readCollect"></span>）</a></li>
					<li><a>完成（<span id="complete"></span>）</a></li>
					<li><a>已取消（<span id="cancel"></span>）</a></li>
				</ul>
				<!-- 搜索 -->
				<div style="float:right">
					<input type="text" placeholder="输入卖家昵称、电话或商品名称搜索订单">
					<a href="javascript:;"></a>
				</div>
				<div class="clear"></div>
			</div>
			<!-- 显示 -->
			<div class="show">
				<!-- 表头 -->
				<div class="header">
					<span class="buyerIndex_name">商品</span>
					<span class="indent_price">单价（元）</span>
					<span class="indent_quantity">数量</span>
					<span class="indent_aggregate">小计（元）</span>
					<span class="indent_type">类型</span>
					<span class="indent_operation">交易状态</span>
				</div>
				
				<!-- 内容 -->
				<div class="sheet">
					<!-- 内容显示 -->
					
				</div>
				<div id="demo"></div>
			</div>
		</div>
	</div> 
	<div id="goTop"></div>
	<!--底部-->
	<div class="base">
		 <jsp:include page="base.jsp" flush="true"/>
	</div>
	
</body>
</html>
<script type="text/javascript" src="frame/static/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="frame/layui/layui.js"></script>
<script type="text/javascript" src="frame/static/layer/layer.js"></script>
<script type="text/javascript" src="frame/static/js/company.js"></script>
<script type="text/javascript">
var curr;
$(function(){
	layui.config({
		 dir: 'frame/layui/' //layui.js 所在路径（注意，如果是script单独引入layui.js，无需设定该参数。），一般情况下可以无视
		 ,version: false //一般用于更新模块缓存，默认不开启。设为true即让浏览器不缓存。也可以设为一个固定的值，如：201610
		 ,debug: false //用于开启调试模式，默认false，如果设为true，则JS模块的节点会保留在页面
		 ,base: 'frame/layui/' //设定扩展的Layui模块的所在目录，一般用于外部模块扩展
	});
	count();
	curr=1;
	var pageNo = 1;
	var orderStatus = "";
	$(".head_tab>ul>li").click(function(){
		$(".head_tab>ul>li").removeClass("choice");
		$(this).addClass("choice");
	});
	/* if($("#loginName0").text()!=""){demo(curr);} */
	demo(curr);
	$(".head_tab>ul>li:eq(0)>a").click(function(){//全部
		demo(curr);
		orderStatus = "";
	});
	$(".head_tab>ul>li:eq(1)>a").click(function(){//待确认
		stateLook(curr,"090001");
		orderStatus = "090001";
	});
	$(".head_tab>ul>li:eq(2)>a").click(function(){//待付款
		stateLook(curr,"090003");
		orderStatus = "090003";
	});
	$(".head_tab>ul>li:eq(3)>a").click(function(){//待发货
		stateLook(curr,"090002");
		orderStatus = "090002";
	});
	$(".head_tab>ul>li:eq(4)>a").click(function(){//待收货
		stateLook(curr,"090004");
		orderStatus = "090004";
	});
	$(".head_tab>ul>li:eq(5)>a").click(function(){//完成
		stateLook(curr,"090005");
		orderStatus = "090005";
	});
	$(".head_tab>ul>li:eq(6)>a").click(function(){//已取消
		stateLook(curr,"090006");
		orderStatus = "090006";
	});
	//搜索
	$(".head_tab>div>a").click(function(){
		seek(pageNo,orderStatus);
	});
});

function seek(pageNo,orderStatus){
	var query = $(".head_tab>div>input").val();
	$.ajax({
		url:'busOrder/getBuyerOrders.do',
		type:"post",
		data:{"query":query,pageNo:pageNo,orderStatus:orderStatus},
		beforeSend:function(){
			$(".sheet").html("获取数据中");
		},
		success:function(data){
			//搜索结果的显示
			if(data.success){
				display(data,"",query);
			}else{
				layer.open({
					 title: '错误信息'
					 ,content:data.msg
				}); 
			}
		}
	});
}

function demo(curr){
	$.ajax({
		url:'busOrder/getBuyerOrders.do',
		data:{pageNo:curr||1},
		success:function(data){
			if(data.success){
				display(data,"","");
			}else{
				layer.open({
					 title: '错误信息'
					 ,content:data.msg
				}); 
			}
		}
	});
}
function stateLook(curr,orderStatus){
	$.ajax({
		url:'busOrder/getBuyerOrders.do',
		data:{pageNo:curr||1,orderStatus:orderStatus},
		success:function(data){
			if(data.success){
				display(data,orderStatus,"");
			}else{
				layer.open({
					 title: '错误信息'
					 ,content:data.msg
				}); 
			}
		}
	});
}
function display(data,orderStatus,query){
	$(".sheet").empty();
	var Row = data.obj;
    var supplyName = [];
	var tmp = [];
	var tmpguan = new Array();
	for(var i in Row.rows){
		supplyName.push(Row.rows[i].orderNo);
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
		for(var numerical in Row.rows){
			if(tmp[i] == Row.rows[numerical].orderNo){
				tmpguan[i].push(numerical);
			}
		}
	}
	var content = "";
	if(data.obj.count == 0){
		content+="<div class='moudleNull'>";
		content+="没有相应的订单";
		content+="</div>";
	}
	for(var i in tmpguan){
		var tradeStus=getOrderStus(Row.rows[tmpguan[i][1]].orderStatus,Row.rows[tmpguan[i][1]].updateCustType);
		var quantity = 0;
		var price = parseInt(0);
		content+="<div class='moudle'>";
		content+="<div class='line'>";
		content+="<span class='uname' onclick='vendor(\""+Row.rows[tmpguan[i][1]].supplyNo+"\")'>卖家："+Row.rows[tmpguan[i][1]].supperName+"</span>";
		content+="<span class='utel'>"+Row.rows[tmpguan[i][1]].applyPhone+"</span>";
		content+="<span class='udate right'>提交时间："+new Date(Row.rows[tmpguan[i][1]].insertDate).Format("yyyy-MM-dd hh:mm:ss")+"</span>";
		content+="<span class='uindent right'>订单编号："+Row.rows[tmpguan[i][1]].orderNo+"</span>";
		content+="</div>";
		for(var num = 1; num < tmpguan[i].length; num++){
			content+="<div class='message' data-brand='"+Row.rows[tmpguan[i][num]].goodsCode+"'>";
			content+="<div class='buyerIndex_name'><p title='"+Row.rows[tmpguan[i][num]].goodsName+"'>"+(Row.rows[tmpguan[i][num]].goodsName!=null?Row.rows[tmpguan[i][num]].goodsName:'')+"</p>";
			content+="<p title='"+Row.rows[tmpguan[i][num]].par+"'>"+(Row.rows[tmpguan[i][num]].par!=null?Row.rows[tmpguan[i][num]].par:'')+"</p></div>";
			content+="<div class='indent_price'><span class='fs14 vertical-m'>"+Row.rows[tmpguan[i][num]].goodsPrice.toFixed(2)+"</span><br/>";
			if (Row.rows[tmpguan[i][num]].goodsDiscount==10) {
				content+="<span class='fs12 vertical-m'>无折扣</span></div>";
			} else {
				content+="<span class='fs12 vertical-m'>"+Row.rows[tmpguan[i][num]].goodsDiscount+"折</span></div>";
			}
        	quantity+=Row.rows[tmpguan[i][num]].goodsCount;
        	price += parseInt(Row.rows[tmpguan[i][num]].goodsMoney);
       	  	content+="<div class='indent_quantity'>"+Row.rows[tmpguan[i][num]].goodsCount+"</div>";
       	  	content+="<div class='indent_aggregate'>"+parseInt(Row.rows[tmpguan[i][num]].goodsMoney).toFixed(2)+"</div>";
       	  	content+="<div class='indent_type'>"+(Row.rows[tmpguan[i][num]].orderType=='091001'?'试刀':'购买')+"</div>";
       	  	content+="<div class='indent_operation'><p class='fs14 margin-bottom-5'>"+tradeStus+"</p><a href='javascript:;' style='display:none;' class='fs12 margin-bottom-5'>订单详情</a><a style='display:none;' href='javascript:;' class='fs12'>查看物流</a></div>";
       	  	content+="</div>";
      	  	}
      	  	content+="<div class='row'>";
      	  	content+="<span class='font-888'>期望到货时间："+Row.rows[tmpguan[i][1]].wishPayDt+"</span>";
      	  	content+="<span class='delivery_date font-888'>预期收货时间："+Row.rows[tmpguan[i][1]].defaultPayDt+"</span>";
      	  	content+="</div>";
      	  	content+="<div class='remark'>";
      	  	content+="<label>备注：</label><div class='left'>";
	  		for(var j=0;j<data.map[Row.rows[tmpguan[i][1]].orderNo].length;j++){
				if((j+1)%2!=0){
					content+="<span>"+new Date(data.map[Row.rows[tmpguan[i][1]].orderNo][j].insertDate).Format("yyyy-MM-dd hh:mm:ss")+" "+(data.map[Row.rows[tmpguan[i][1]].orderNo][j].status==1?'客户状态':'供方状态')+"："+tradeStus+" "+(data.map[Row.rows[tmpguan[i][1]].orderNo][j].status==1?'客户备注':'供方备注')+"："+(data.map[Row.rows[tmpguan[i][1]].orderNo][j].remark!=null?data.map[Row.rows[tmpguan[i][1]].orderNo][j].remark:'')+"</span><br>";
				}else{
					content+="<span>"+new Date(data.map[Row.rows[tmpguan[i][1]].orderNo][j].insertDate).Format("yyyy-MM-dd hh:mm:ss")+" "+(data.map[Row.rows[tmpguan[i][1]].orderNo][j].status==0?'客户状态':'供方状态')+"："+tradeStus+" "+(data.map[Row.rows[tmpguan[i][1]].orderNo][j].status==0?'客户备注':'供方备注')+"："+(data.map[Row.rows[tmpguan[i][1]].orderNo][j].remark!=null?data.map[Row.rows[tmpguan[i][1]].orderNo][j].remark:'')+"</span><br>";
				}
			}
      	  	if(Row.rows[tmpguan[i][1]].orderStatus==090005||Row.rows[tmpguan[i][1]].orderStatus==090002||Row.rows[tmpguan[i][1]].orderStatus==090001){
      	  	}else{
      			content+="<input type='text' maxlength='150'/>"; 
      	  	}
      	  	content+="</div><div class='clear'><input type='hidden' value="+Row.rows[tmpguan[i][1]].orderStatus+"></div></div>";
      	  	if(Row.rows[tmpguan[i][1]].orderStatus=='090001'){
      	  		content+="<div class='row text-bar-right'>";
      	  		content+="<span>总计：<em>￥"+price+"</em></span>";
      	  		content+="<button type='button' class='affirm_indent' onclick=cancelOrder(\'"+Row.rows[tmpguan[i][1]].orderNo+"\',\'"+Row.rows[tmpguan[i][1]].orderType+"\',this)>取消订单</button>";
      	  		content+="</div>";
      	  	}else if(Row.rows[tmpguan[i][1]].orderStatus=='090003'){
      			content+="<div class='row text-bar-right' data-supplyNo="+Row.rows[tmpguan[i][1]].supplyNo+">";
      	  	  	content+="<span>总计：<em>￥"+price+"</em></span>";
      		  	content+="<button type='button' class='cancel_indent' onclick=cancelOrder(\'"+Row.rows[tmpguan[i][1]].orderNo+"\',\'"+Row.rows[tmpguan[i][1]].orderType+"\',this)>取消订单</button>";
      		  	content+="<button type='button' class='affirm_indent' onclick=invoice(\'"+Row.rows[tmpguan[i][1]].orderNo+"\',"+price+",this)>确认付款</button>";
      		  	content+="</div>";
      	  	}else if(Row.rows[tmpguan[i][1]].orderStatus=='090004'){
      		 	content+="<div class='row text-bar-right'>";
      	  	  	content+="<span>总计：<em>￥"+price+"</em></span>";
      		  	content+="<button type='button' class='affirm_indent' onclick=operatorOrder(\'"+Row.rows[tmpguan[i][1]].orderNo+"\',this)>确认收货</button>";
      		  	content+="</div>";
      	  	}else if(Row.rows[tmpguan[i][1]].orderStatus=='090006'){
      	  		content+="<div class='row text-bar-right'>";
      	  		content+="<span>总计：<em>￥"+price+"</em></span>";
      	  		content+="<button type='button' class='cancel_indent' onclick=againPurchase('"+Row.rows[tmpguan[i][1]].orderNo+"','"+Row.rows[tmpguan[i][1]].supplyNo+"',this)>继续购买</button>";
      	  		content+="<button type='button' class='affirm_indent' onclick=deleteOrder(\'"+Row.rows[tmpguan[i][1]].orderNo+"',this\)>删除订单</button>";
      	  		content+="</div>";
      		}
      	  else if(Row.rows[tmpguan[i][1]].orderStatus=='090005'){
    	  		content+="<div class='row text-bar-right'>";
    	  		content+="<span>总计：<em>￥"+price+"</em></span>";
    	  		content+="<button type='button' class='cancel_indent' onclick=againPurchase('"+Row.rows[tmpguan[i][1]].orderNo+"','"+Row.rows[tmpguan[i][1]].supplyNo+"',this)>再次购买</button>";
    	  		content+="</div>";
    		}
		content+="</div>";
	}
	$(".sheet").append(content);
	
	var totalPage=Math.ceil(eval(data.obj.total/data.obj.pageSize));
    //显示分页
    layui.use(['laypage', 'layer'], function(){
		var laypage = layui.laypage;
		var layer = layui.layer;
		laypage({
			cont: 'demo', //容器。值支持id名、原生dom对象，jquery对象。【如该容器为】：<div id="page1"></div>
		      pages: totalPage, //通过后台拿到的总页数
		      curr: data.obj.pageNo || 1, //当前页
		      skin: '#03A1A4',
		  	  groups:5,
		  	  prev:"<",
		  	  next:">",
		      jump: function(obj, first){ //触发分页后的回调
		      	if(!first){ //点击跳页触发函数自身，并传递当前页：obj.curr
		        	if((orderStatus=="")&&(query=="")){
		        		demo(obj.curr);
		        	}else if(query!=""){
		        		seek(obj.curr,orderStatus);
		        	}else{
		        		stateLook(obj.curr,orderStatus);
		        	}
		        }
		      }
		});
	});
}
function count(){
	$.ajax({
		url:'busOrder/getBuyerOrderCount.do',
		success:function(data){
			$("#payment").text(data.obj.payment);
			$("#readCollect").text(data.obj.readCollect);
			$("#complete").text(data.obj.complete);
			$("#all").text(data.obj.all);
			$("#cancel").text(data.obj.cancel);
			$("#confirmed").text(data.obj.sure);
			$("#readyShip").text(data.obj.post);
		}
	});
}
function getOrderStus(orderStatus,userType){
	var tradeStus;
	if(orderStatus==090005){
		tradeStus='客户订单完成';
	}else if(orderStatus==090001){
		tradeStus='供方待确认';
	}else if(orderStatus==090002){
		tradeStus='供方待发货';
	}else if(orderStatus==090003){
		tradeStus='客户待付款';
	}else if(orderStatus==090004){
		tradeStus='客户待收货';
	}else if(orderStatus==090006){
		if("00010003"==userType){//供方
			tradeStus='供方订单已取消';
		}else{//买方
			tradeStus='客户订单已取消';
		}
	}
	return tradeStus;
}
/* //填写发票信息
function invoiceInformation(orderNo,price,remark){
	layer.open({
		title: '发票信息',
		type:2,
		content:'busOrder/borderBill.do?orderNo='+orderNo+'&billMoney='+price+'&remark='+remark,
		area: ['800px', '600px'],
	});
} */

function invoice(orderNo, price, element) {
	var remark;
	$(element).parent().parent().find("input[type='text']").each(
			function() {
				remark = $(this).val();
			});
	var supplyNo = $(element).parent().attr("data-supplyno");
	$
			.ajax({
				url : 'busOrder/getUserSupplyDetail.do',
				type : "post",
				data : {
					"supplyNo" : supplyNo
				},
				success : function(data) {
					if (data.success) {
						$
						.ajax({
							url : 'busOrder/orderOperator.do',
							type : 'post',
							data : {
								"remark" : remark,
								"orderNo" : orderNo
							},
							success : function(data) {
								if (data.success) {
									layer
											.msg(
													'操作成功',
													{
														icon : 1,
														time : 2000
													},
													function() {
														stateLook(
																curr,
																"090003");
														orderStatus = "090003";
														//location.reload();
														count();
													});
								} else {
									layer
											.open({
												title : '错误信息',
												content : data.msg
											});
								}
							}
						});
				/* 		layer
								.open({
									title : '供方帐号信息',
									content : "<div style='font-size:16px;line-height:26px;'><span class='label'>"
											+ data.obj.baseAcctOrg
											+ "：</span>"
											+ data.obj.baseAcctNo
											+ "</div>"
											+ "<div style='font-size:16px;line-height:26px;'><span class='label'>开户户名：</span>"
											+ data.obj.baseAcctName
											+ "</div>",
									btn : [ "填写发票信息", "不需要发票", "取消" ],
									area : [ '340px', '260px' ],
									yes : function() {
										layer.close(layer.index);
										invoiceInformation(orderNo, price,
												remark);
									},
									btn2 : function() {
									
									}
								}); */
					}
				}
			});
	/*  */
}
//确认收货
function operatorOrder(orderNo,element){
	var remark;
	$(element).parent().parent().find("input[type='text']").each(function(){
		remark=$(this).val();
	});
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
					stateLook(curr,"090004");
					orderStatus = "090004";
					count();
				});
			}else{
				layer.open({
					 title: '错误信息'
					 ,content:data.msg
				}); 
			}
		}
	});
};
//删除订单
function deleteOrder(orderNo,element){
	var orde = $(element).parent().prev().find(".clear>input").val();
	layer.open({
		title: '提示信息'
		,content:"是否删除已选中的订单?"
		,btn:['确认','取消']
		,yes: function(index, layero){
			layer.close(index);
			$.ajax({
				url:'busOrder/deleteOrder.do',
				data:{"orderNo":orderNo,"type":"1"},
				type:'post',
				success:function(data){
					if(data.success){
						count();
						layer.msg('操作成功', {
							icon: 1,
							time: 2000
						}, function(){
							stateLook(curr,orde);
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
		,btn2: function(index, layero){
			layer.close(index);
		}
  		,closeBtn: 0
	});
};
function vendor(val){location.href="/portal/commercial_particulars.jsp?key="+val;}
//取消订单
function cancelOrder(orderNo,orderType,element){
	var orde = $(element).parent().prev().find(".clear>input").val();
	layer.open({
		title: '提示信息'
		,content:"是否取消已选中的订单?<br/><select class='cause'><option>协商取消订单</option><option>交期时间有问题</option><option>商品价格不符合预期</option><option>其他</option></select>"
			+"<input class='cause' placeholder='请输入取消的原因' maxlength='150'>"
		,btn:['确认','取消']
		,yes: function(index, layero){
			layer.close(index);
			$.ajax({
				url:'busOrder/cancelOrder.do',
				data:{
					"orderNo":orderNo,
					"dealType":"cancel",
					"orderType":orderType,
					"remark":$("select option:selected").text()+""+$("input.cause").val(),
					"statusWay":"0",
				},
				dataType:"json",
				type:'post',
				success:function(data){
					if(data.success){
						count();
						layer.msg('操作成功', {
							icon: 1,
							time: 2000
						}, function(){
							stateLook(curr,orde);
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
		,btn2: function(index, layero){
			layer.close(index); 
		}
		,closeBtn: 0
	});
}
//再次购买
function againPurchase(Row,supplyNo,element){
	var brands = "";
	$(element).parents(".moudle").find(".message").each(function(){
		brands += $(this).attr("data-brand")+",";
	});
	$.ajax({
		url:"busShoppCart/buyAgain.do",
		data:{
			"orderNo":Row,
			"brand":brands,
			"supplyNo":supplyNo
		},
		type:"post",
		success:function(data){
			if(data.success){
				layer.open({
					 title: ''
					 ,content:data.msg
				}); 
				location.href="busShoppCart/toShoppCart.do";
			}else{
				layer.open({
					 title: '错误信息'
					 ,content:data.msg
				}); 
			} 
		}
	});
}
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

//返回到顶部
$(window).scroll(function(){
	if($(this).scrollTop() > 300){
		$("#goTop").show();
	}else{
		$("#goTop").hide();
	}
});
$("#goTop").click(function(){
	$("body,html").stop().animate({"scrollTop":0+"px"},300);
});	


</script>
