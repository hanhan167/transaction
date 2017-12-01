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


<title>供方订单</title>
</head>
<body>

	<!--顶部-->
	<div class="head">
		<jsp:include page="head.jsp" flush="true"/>
	</div>
	<!-- 中间的内容 -->
	<div class="centre">
		<div class="content">
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
				<div class="clear"></div>
				<!-- 搜索 -->
				<div style="float:right">
					<input type="text" placeholder="输入买家昵称、电话或商品名称搜索订单">
					<a href="javascript:;"></a>
				</div>
				<div class="clear"></div>
				
			</div>
			<div class="show">
				<!-- 表头 -->
				<div class="header">
					<span class="indent_name">商品</span>
					<span class="indent_price">单价（元）</span>
					<span class="indent_quantity">数量</span>
					<span class="indent_aggregate">小计（元）</span>
					<span class="indent_type">类型</span>
					<span class="indent_operation">交易状态</span>
				</div>
				<!-- 内容 -->
				<div class="sheet">
				</div>
				<!-- 分页 -->
				<div id="demo"></div>
			</div>
		</div>
	</div>
	<!-- 底部  -->
	<div class="base">
		 <jsp:include page="base.jsp" flush="true"/>
	</div>
	
</body>
</html>	
<script type="text/javascript" src="frame/static/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="frame/layui/layui.js"></script>
<script type="text/javascript" src="frame/static/js/company.js"></script>
<script type="text/javascript">
$(function(){
	
	var curr=1;
	var pageNo = 1;
	var orderStatus = "";
	count();
	$(".head_tab li").click(function(){
		$(".head_tab li").removeClass("choice");
		$(this).addClass("choice");
	});
	//$(".show").load("busOrder/toPage/applyIndent_all.do");
	demo(curr);
	$(".head_tab>ul>li:eq(0)>a").click(function(){//全部
		//$(".show").load("busOrder/toPage/applyIndent_all.do");
		demo(curr);
		orderStatus = "";
	});
	$(".head_tab>ul>li:eq(1)>a").click(function(){//待确认
		//$(".show").load("busOrder/toPage/applyIndent_noneConfirmed.do");
		stateLook(curr,"090001");
		orderStatus = "090001";
	});
	$(".head_tab>ul>li:eq(2)>a").click(function(){		//待付款
		//$(".show").load("busOrder/toPage/applyIndent_Sure.do");
		stateLook(curr,"090003");
		orderStatus = "090003";
	});
	$(".head_tab>ul>li:eq(3)>a").click(function(){//待发货
		//$(".show").load("busOrder/toPage/applyIndent_readyShip.do");
		stateLook(curr,"090002");
		orderStatus = "090002";
	});
	$(".head_tab>ul>li:eq(4)>a").click(function(){		//待收货
		//$(".show").load("busOrder/toPage/applyIndent_Post.do");
		stateLook(curr,"090004");
		orderStatus = "090004";
	});
	$(".head_tab>ul>li:eq(5)>a").click(function(){//完成
		//$(".show").load("busOrder/toPage/applyIndent_complete.do");
		stateLook(curr,"090005");
		orderStatus = "090005";
	});
	$(".head_tab>ul>li:eq(6)>a").click(function(){//已取消
		//$(".show").load("busOrder/toPage/applyIndent_cancel.do");
		stateLook(curr,"090006");
		orderStatus = "090006";
	});
	//订单搜索
	$(".head_tab>div>a").click(function(){
		seek(pageNo,orderStatus);
	});

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
	//编辑折扣
	$(".sheet").on("click",".input_price",function(){
		var nu = $(this).siblings(".indent_quantity").text();
		var price = $(this).text();//总价格
		var oldprice = $(this).children(".fs14").text();//单价
		var str = $(this).children(".fs12").text();//折扣
		if(str=="无折扣"){
			var discount = 10;
		}else{
			var discount = str.substring(0,str.length-1);
		}
		var compile_modle = '';
		compile_modle = compile_modle + '<div><label>商品折扣<input type="number" min="0" max="10" id = "update1" class="discount_update" value='+discount+'></label><span></span></div>';
		var order_from = $(this).parent().parent().find(".uindent").text().split("：")[1];
		var tableKey = $(this).children("input").val();
		var splitStatus = $(this).siblings(".indent_name").children("input").val();
		var befored = layer.open({
			title:'修改价格或折扣',
			content: compile_modle,
			btn:['确认','取消'],
			scrollbar:false,//不允许浏览器出现滚动条
			resize:false,
			area:['360px','260px'],
			yes:function(){
				if($('.discount_update').val()>10||$('.discount_update').val()<0){
					layer.msg('折扣不能大于10');
				}else{
					var goodsPrice = $('.price_update').val();//价格
					var goodsDiscount1 = $('.discount_update').val();//折扣
					var orderNo = order_from;
					var goodsnum = nu;
					 $.ajax({
						url:'busOrder/changeOrder.do',
						data:{
							"orderNo":orderNo,
							"goodsPrice":oldprice,
							"goodsDiscount":goodsDiscount1,
							"tableKey":tableKey,
							"splitStatus":splitStatus,
							"goodsCount":goodsnum,
							"goodsMoney":"",
						},
						success:function(data){
							layer.close(befored);
					  		if(data.success){
					  			stateLook(curr,"090001");
								orderStatus = "090001";
								count();
					  		}else{
					  			layer.open({
									title: '错误信息'
									,content:data.msg
								}); 
					  		}
					  	}
					}); 
				}
			},
			success:function(){
				$("#update").blur(function(){
					var goodsDiscount;
					if((oldprice*nu)<($("#update").val())){
						$("#update").val(oldprice*nu);
						 goodsDiscount = ((($("#update").val())/nu/oldprice)*10).toFixed(1);
						  $("#update1").val(goodsDiscount);	
					}else{
						 goodsDiscount = ((($("#update").val())/nu/oldprice)*10).toFixed(1);
						  $("#update1").val(goodsDiscount);	
					}
					
				});
				$("#update1").blur(function(){
					var goodPrice;
					if( $("#update1").val()>10|| $("#update1").val()==10){
						  $("#update1").val(10);
						  goodPrice=(oldprice*nu).toFixed(2);
					}else{
						if($("#update1").val()=='无折扣'){
							goodPrice=(oldprice*nu).toFixed(2);
						}else{
							goodPrice = (oldprice*nu*($("#update1").val()*0.1)).toFixed(2);
						}
					}
					  $("#update").val(goodPrice);
			});
			}
		});
	});
	//编辑价格
	$(".sheet").on("click",".input_aggregate",function(){
		var nu = $(this).siblings(".indent_quantity").text();
		var price = $(this).text();
		var oldprice = $(this).siblings(".indent_price").children(".fs14").text();
		var str = $(this).siblings(".indent_price").children(".fs12").text();
		if(str=="无折扣"){
			var discount = 10;
		}else{
			var discount = str.substring(0,str.length-1);
		}
		var compile_modle = '<div><label>商品价格<input type="number" id = "update" class="price_update" value='+price+'></label><span></span></div>';
		//compile_modle = compile_modle + '<div><label>商品折扣<input type="number" min="0" max="10" id = "update1" class="discount_update" value='+discount+'></label><span></span></div>';
		var order_from = $(this).parent().parent().find(".uindent").text().split("：")[1];
		var tableKey = $(this).siblings(".indent_price").children("input").val();
		var splitStatus = $(this).siblings(".indent_name").children("input").val();
		layer.open({
			title:'修改价格或折扣',
			content: compile_modle,
			btn:['确认','取消'],
			scrollbar:false,//不允许浏览器出现滚动条
			resize:false,
			area:['360px','260px'],
			yes:function(){
				if($('.discount_update').val()>10||$('.discount_update').val()<0){
					layer.msg('折扣不能大于10');
				}else{
					var goodsPrice = $('.price_update').val();//价格
					//var goodsDiscount1 = $('.discount_update').val();//折扣
					var orderNo = order_from;
					var goodsnum = nu;
					 $.ajax({
						url:'busOrder/changeOrder.do',
						data:{
							"orderNo":orderNo,
							"goodsPrice":oldprice,
							"goodsDiscount":"",
							"tableKey":tableKey,
							"splitStatus":splitStatus,
							"goodsCount":goodsnum,
							"goodsMoney":goodsPrice,
						},
						success:function(data){
					  		if(data.success){
					  			stateLook(curr,"090001");
								orderStatus = "090001";
								count();
					  		}else{
					  			layer.open({
									title: '错误信息'
									,content:data.msg
								}); 
					  		}
					  	}
					}); 
				}
			},
			success:function(){
				$("#update").blur(function(){
					var goodsDiscount;
					if((oldprice*nu)<($("#update").val())){
						$("#update").val(oldprice*nu);
						 goodsDiscount = ((($("#update").val())/nu/oldprice)*10).toFixed(1);
						  $("#update1").val(goodsDiscount);	
					}else{
						 goodsDiscount = ((($("#update").val())/nu/oldprice)*10).toFixed(1);
						  $("#update1").val(goodsDiscount);	
					}
					
				});
				$("#update1").blur(function(){
					var goodPrice;
					if( $("#update1").val()>10|| $("#update1").val()==10){
						  $("#update1").val(10);
						  goodPrice=(oldprice*nu).toFixed(2);
					}else{
						if($("#update1").val()=='无折扣'){
							goodPrice=(oldprice*nu).toFixed(2);
						}else{
							goodPrice = (oldprice*nu*($("#update1").val()*0.1)).toFixed(2);
						}
					}
					  $("#update").val(goodPrice);
			});
			}
		});
	});
});
function seek(pageNo,orderStatus){
	var query = $(".head_tab>div>input").val();
	$.ajax({
		url:'busOrder/getSupplyOrders.do',
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
		url:'busOrder/getSupplyOrders.do',
		data:{pageNo:curr||1},
		beforeSend:function(){
			$(".sheet").html("获取数据中");
		},
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
		url:'busOrder/getSupplyOrders.do',
		data:{pageNo:curr||1,orderStatus:orderStatus},
		beforeSend:function(){
			$(".sheet").html("获取数据中");
		},
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
//显示
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
	if(data.obj.count==0){
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
	  	content+="<span class='uname'>买家："+Row.rows[tmpguan[i][1]].custName+"</span>";
	  	content+="<span class='utel'>"+Row.rows[tmpguan[i][1]].custPhone+"</span>";
	  	content+="<div class='float-bar-right'>";
	  	content+="<span class='ugenre'>"+Row.rows[tmpguan[i][1]].orderType+"</span>";
	  	content+="<span class='uindent'>订单编号："+Row.rows[tmpguan[i][1]].orderNo+"</span>";
	  	content+="<span class='udate'>提交时间："+new Date(Row.rows[tmpguan[i][1]].insertDate).Format("yyyy-MM-dd hh:mm:ss")+"</span>";
	  	content+="</div>";/* div.text-bar-right */
	  	content+="</div>";/* div.line */
		for(var num = 1; num < tmpguan[i].length; num++){
	       	content+="<div class='message'>";
	       	content+="<div class='indent_name'><input type='hidden' value="+Row.rows[tmpguan[i][num]].splitStatus+"><p title='"+Row.rows[tmpguan[i][num]].goodsName+"'>"+(Row.rows[tmpguan[i][num]].goodsName!=null ? Row.rows[tmpguan[i][num]].goodsName : '')+"</p>";
	       	content+="<p title='"+Row.rows[tmpguan[i][num]].par+"'>"+(Row.rows[tmpguan[i][num]].par!=null?Row.rows[tmpguan[i][num]].par:'')+"</p></div>";
	       	if(Row.rows[tmpguan[i][1]].orderStatus=='090001'){
	        	content+="<div class='indent_price input_price'><input type='hidden' value="+Row.rows[tmpguan[i][num]].tableKey+"><span class='fs14 vertical-m'>"+Row.rows[tmpguan[i][num]].goodsPrice+"</span><br/>";
	        	if(Row.rows[tmpguan[i][num]].goodsDiscount==10){
	        		content+="<span class='fs12 vertical-m' style='color:blue'>无折扣</span></div>";
	        	}else{
	        	  	content+="<span class='fs12 vertical-m' style='color:blue'>"+Row.rows[tmpguan[i][num]].goodsDiscount+"折</span></div>";
	        	}
	        }else{
	        	content+="<div class='indent_price'><input type='hidden' value="+Row.rows[tmpguan[i][num]].tableKey+"><span class='fs14 vertical-m'>"+Row.rows[tmpguan[i][num]].goodsPrice+"</span><br/>";
	        	if(Row.rows[tmpguan[i][num]].goodsDiscount==10){
	        		content+="<span class='fs12 vertical-m'>无折扣</span></div>";
	        	}else{
	        	  	content+="<span class='fs12 vertical-m'>"+(Row.rows[tmpguan[i][num]].goodsDiscount)+"折</span></div>";
	        	}
	        }
	       	content+="<div class='indent_quantity'>"+Row.rows[tmpguan[i][num]].goodsCount+"</div>";
	       	quantity+=Row.rows[tmpguan[i][num]].goodsCount;
	       	price += parseFloat(Row.rows[tmpguan[i][num]].goodsMoney);
	       	if(Row.rows[tmpguan[i][1]].orderStatus=='090001'){
	       		content+="<div class='indent_aggregate input_aggregate'>"+parseFloat(Row.rows[tmpguan[i][num]].goodsMoney).toFixed(2)+"</div>";
	       	}else{
	       		content+="<div class='indent_aggregate'>"+parseFloat(Row.rows[tmpguan[i][num]].goodsMoney).toFixed(2)+"</div>";
	       	}
	       	content+="<div class='indent_type'>"+ (Row.rows[tmpguan[i][num]].orderType=='091001'?'试刀':'购买') +"</div>";
	       	content+="<div class='indent_operation'>"+tradeStus+"</div>";
	       	content+="</div>";/* div.message */
		}
	   	content+="<div class='row'>";
	   	content+="<span>默认到货时间："+Row.rows[tmpguan[i][1]].wishPayDt+"</span>";
	   	content+="<span class='delivery_date'>期望收货时间："+Row.rows[tmpguan[i][1]].defaultPayDt+"</span>";
	   	content+="</div>";/* div.row */
	   	content+="<div class='remark'>";
	   	content+="<label>备注：</label><div class='left'>";
		for(var j=0;j<data.map[Row.rows[tmpguan[i][1]].orderNo].length;j++){
			if((j+1)%2!=0){
				content+="<span>"+new Date(data.map[Row.rows[tmpguan[i][1]].orderNo][j].insertDate).Format("yyyy-MM-dd hh:mm:ss")+" "+(data.map[Row.rows[tmpguan[i][1]].orderNo][j].status==1?'客户状态':'供方状态')+"："+tradeStus+" "+(data.map[Row.rows[tmpguan[i][1]].orderNo][j].status==1?'客户备注':'供方备注')+"："+(data.map[Row.rows[tmpguan[i][1]].orderNo][j].remark!=null?data.map[Row.rows[tmpguan[i][1]].orderNo][j].remark:'')+"</span><br>";
			}else{
				content+="<span>"+new Date(data.map[Row.rows[tmpguan[i][1]].orderNo][j].insertDate).Format("yyyy-MM-dd hh:mm:ss")+" "+(data.map[Row.rows[tmpguan[i][1]].orderNo][j].status==1?'客户状态':'供方状态')+"："+tradeStus+" "+(data.map[Row.rows[tmpguan[i][1]].orderNo][j].status==1?'客户备注':'供方备注')+"："+(data.map[Row.rows[tmpguan[i][1]].orderNo][j].remark!=null?data.map[Row.rows[tmpguan[i][1]].orderNo][j].remark:'')+"</span><br>";
			}
		}
		if(Row.rows.orderStatus=='090003'||Row.rows.orderStatus=='090004'||Row.rows.orderStatus=='090005'){
		}else{
		
			content+="<input type='text'  maxlength='150'/>";  
		}
	   	content+="</div><div class='clear'></div></div>";/* div.remark */
	   	content+="<div class='row site'>";
	   	content+="<span>收货地址</span><span>"+(Row.rows[tmpguan[i][1]].addresseeName!=null?Row.rows[tmpguan[i][1]].addresseeName:'')+"</span><span>"+(Row.rows[tmpguan[i][1]].addresseePhone!=null?Row.rows[tmpguan[i][1]].addresseePhone:'')+"</span><span>"+(Row.rows[tmpguan[i][1]].address!=null?Row.rows[tmpguan[i][1]].address:'')+"</span>";
	   	content+="</div>";/* div.row */
	   	content+="<div class='row text-bar-right'>";
	   	if(Row.rows[tmpguan[i][1]].orderStatus=='090001'){
	   		content+="<span>共有<em>"+quantity+"</em>件商品，总计：<em>￥"+price.toFixed(2)+"</em></span>";
	   		if((quantity>1)&&(Row.rows[tmpguan[i][1]].splitStatus!="2")){
	   			content+="<button type='button' class='cancel_indent' onclick=load(\'"+Row.rows[tmpguan[i][1]].orderNo+"\')>拆分订单</button>";
	   		}
	   		content+="<button type='button' class='cancel_indent' onclick=cancelOrder(\'"+Row.rows[tmpguan[i][1]].orderNo+"\',\'"+Row.rows[tmpguan[i][1]].orderType+"\',this)>取消订单</button>";
	   		content+="<button type='button' class='affirm_indent' onclick=operatorOrder(\'"+Row.rows[tmpguan[i][1]].orderNo+"\',this)>确认订单</button>";
	   	}else if(Row.rows[tmpguan[i][1]].orderStatus=='090002'){
	   
	   			
	   		//添加内容
	   		/* content+="<button type='button' id='my_button' class='cancel_indent' onclick=writeWl(\'"+Row.rows[tmpguan[i][1]].orderNo+"\')>提交物流号</button>";  */
	   		content+="<select id='my-menu' class='select-c' tabindex='2' > <option value='' selected>物流号输入</option><option value='上门取货'>上门取货</option><option value='滴滴配送'>滴滴配送</option></select>";
	   		content+="<input type='text'  class='text-input' 	id='my_text' name='WlNum'  placeholder='发货之前选择对应的物流方式'/>"; 
			

				

				content += "<span>总计：<em>￥" + price + "</em></span>";
				content += "<button type='button' class='cancel_indent' onclick=invoiceLook(\'"
						+ Row.rows[tmpguan[i][1]].orderNo
						+ "\')>查看发票信息</button>";
				content += "<button type='button'  id='makeSure' class='affirm_indent' onclick=operatorOrder(\'"
						+ Row.rows[tmpguan[i][1]].orderNo
						+ "\',this)>确认发货</button>";
						


			} else if (Row.rows[i].orderStatus == '090005') {
				content += "<span>总计：<em>￥" + price.toFixed(2) + "</em></span>";
			} else if (Row.rows[i].orderStatus == '090006') {
				content += "<button type='button' class='affirm_indent' onclick=deleteOrder(\'"
						+ Row.rows[tmpguan[i][1]].orderNo + "\',this)>删除订单</a>";
			} else if (Row.rows[i].orderStatus == '090004') {
				content += "<a class='my_link' herf='javascript:void(0)'  onclick=lookWlMsg(\'"
						+ Row.rows[tmpguan[i][1]].lgtNums
						+ "\',this)>查看物流信息</a>";
				content += "<div class='myLgtMsg sale' id=\'"+Row.rows[tmpguan[i][1]].orderNo+"\'></div>";
			}
			content += "</div>";/* div.row text-bar-right */
			content += "</div>";
		}
		$(".sheet").html(content);
		
		// select - input
		$('.select-c').on('change',function() {
			var $this = $(this);
			var val = $this.find(':selected').val();
			$this.closest('.row').find('.text-input').val(val);
			
			var i = $this.find(':selected').index();
			if (i > 0) {
				$("#makeSure").prop('disabled', false);
				$(".text-input").prop('disabled', true);
			} else {
				$("#makeSure").prop('disabled', true);
				$(".text-input").prop('disabled', false);
			}
		})
		
		// input的input event
		$('.text-input').on('input',function() {
			if ($(this).val && num.test($(this).val)) {
				$("#makeSure").prop('disabled', false);
			} else {
				$("#makeSure").prop('disabled', true);
			}
		})
		
		var totalPage = Math.ceil(eval(data.obj.total / data.obj.pageSize));
		//显示分页
		layui.use([ 'laypage', 'layer' ], function() {
			var laypage = layui.laypage;
			var layer = layui.layer;
			laypage({
				cont : 'demo', //容器。值支持id名、原生dom对象，jquery对象。【如该容器为】：<div id="page1"></div>
				pages : totalPage, //通过后台拿到的总页数
				curr : data.obj.pageNo || 1, //当前页
				skin : '#03A1A4',
				groups : 5,
				prev : "<",
		  	next:">",
				jump : function(obj, first) { //触发分页后的回调
					if (!first) { //点击跳页触发函数自身，并传递当前页：obj.curr
						if ((orderStatus == "") && (query == "")) {
							demo(obj.curr);
						} else if (query != "") {
							seek(obj.curr, orderStatus);
						} else {
							stateLook(obj.curr, orderStatus);
						}
					}
				}
			});
		});
		
	}
	function getOrderStus(orderStatus, userType) {
		var tradeStus;
		if (orderStatus == 090005) {
			tradeStus = '客户订单完成';
		} else if (orderStatus == 090001) {
			tradeStus = '供方待确认';
		} else if (orderStatus == 090002) {
			tradeStus = '供方待发货';
		} else if (orderStatus == 090003) {
			tradeStus = '客户待付款';
		} else if (orderStatus == 090004) {
			tradeStus = '客户待收货';
		} else if (orderStatus == 090006) {
			if ("00010003" == userType) {//供方
				tradeStus = '供方订单已取消';
			} else {//买方
				tradeStus = '客户订单已取消';
			}
		} 
		else if(orderStatus == 0  || orderStatus == "0")
		{
				tradeStus = '无效订单';
		}
		return tradeStus;
	}
	//查看发票信息
	function invoiceLook(orderNo) {
		layer.open({
			title : '发票信息',
			type : 2,
			content : 'busOrder/borderBillDetail.do?orderNo=' + orderNo,
			area : [ '500px', '530px' ],
		});
	}
	//订单拆分
	function load(val) {
		location.href = "busOrder/getbygood.do?key=" + val;
	}
	//取消订单
	function cancelOrder(orderNo, orderType, element) {
		var orde = $(element).parent().prev().find(".clear>input").val();
		layer
				.open({
					title : '提示信息',
					content : "是否取消已选中的订单?<br/><select class='cause'><option>协商取消订单</option><option>交期时间有问题</option><option>商品价格不符合预期</option><option>其他</option></select>"
							+ "<input class='cause' placeholder='请输入取消的原因' maxlength='150'>",
					btn : [ '确认', '取消' ],
					yes : function(index, layero) {
						layer.close(index);
						$.ajax({
							url : 'busOrder/cancelOrder.do',
							data : {
								"orderNo" : orderNo,
								"dealType" : "cancel",
								"orderType" : orderType,
								"remark" : $("select option:selected").text()
										+ "" + $("input.cause").val(),
								"statusWay" : "0",
							},
							dataType : "json",
							type : 'post',
							success : function(data) {
								if (data.success) {
									count();
									layer.msg('操作成功', {
										icon : 1,
										time : 2000
									}, function() {
										stateLook("1", orde);
									});
								} else {
									layer.open({
										title : '错误信息',
										content : data.msg
									});
								}
							}
						});
					},
					btn2 : function(index, layero) {
						layer.close(index);
					},
					closeBtn : 0
				});
	}
	//删除订单
	function deleteOrder(orderNo, element) {
		var orde = $(element).parent().prev().find(".clear>input").val();
		layer.open({
			title : '提示信息',
			content : "是否删除已选中的订单?",
			btn : [ '确认', '取消' ],
			yes : function(index, layero) {
				layer.close(index);
				$.ajax({
					url : 'busOrder/deleteOrder.do',
					data : {
						"orderNo" : orderNo,
						"type" : "0"
					},//增加操作类型，以便于后续扩展
					dataType : "json",
					type : 'post',
					success : function(data) {
						if (data.success) {
							count();
							layer.msg('操作成功', {
								icon : 1,
								time : 2000
							}, function() {
								stateLook("1", orde);
							});
						} else {
							layer.open({
								title : '错误信息',
								content : data.msg
							});
						}
					}
				});
			},
			btn2 : function(index, layero) {
				layer.close(index);
			},
			closeBtn : 0
		});
	}


	function operatorOrder(orderNo, element) {
		$(element).attr('disabled',true); 
		var orde = $(element).parent().prev().find(".clear>input").val();
		console.log(orde);
		var remark;
		var lgtNums = $(element).closest('.row').find('.text-input').val();
		
		$(element).parent().parent().find(".remark input[type='text']").each(
				function() {
					remark = $(this).val();
				});
		$.ajax({
			url : 'busOrder/orderOperator.do',
			type : 'post',
			data : {
				"remark" : remark,
				"orderNo" : orderNo,
				"lgtNums":lgtNums
			},
			success : function(data) {		
				if (data.success) {
				
					layer.msg('操作成功', {
						icon : 1,
						time : 2000
					},  function() {
						stateLook("1", orde);
						});
				} else {
					layer.open({
						title : '错误信息',
						content : data.msg
					});
				}
			}
		});
	}
	function count() {
		$.ajax({
			url : 'busOrder/getApplyOrderCount.do',
			success : function(data) {
				$("#all").text(data.obj.all);
				$("#confirmed").text(data.obj.confirmed);
				$("#payment").text(data.obj.pay);
				$("#readyShip").text(data.obj.readyShip);
				$("#readCollect").text(data.obj.get);
				$("#complete").text(data.obj.complete);
				$("#cancel").text(data.obj.cancel);
			}
		});
	}
	//触发发事件
/* 	function writeWl(orderNos) {
		debugger;
		var lgtNums = $("#my_text").val();
		var num = orderNos;
		//正则表达式
		var nums = /^[0-9]*$/;
		if (lgtNums != null && lgtNums != '') {
			if (nums.test(lgtNums)) {
				$.ajax({
					url : 'busOrder/lgtDeal.do',
					type : "POST",
					data : {
						"lgtNums" : lgtNums,
						"orderNo" : num
					},
					success : function(data) {
						alert("输入成功,请确认发货");
						var numDeal = data;
						if (numDeal == 1) {
							$("#makeSure").attr('disabled', false);
						}
					}
				});

			} else {
				alert("请输入正确格式的物流号");
				return false;
			}
		} else {
			alert("物流号不能为空");
			return false;
		}

	} */

	//显示物流信息
	var myData;
	var myDivId;
function lookWlMsg(str, that) {
		event.stopPropagation();
		myDivId = $(that).next().attr('id');
		var $modal = $('#' + myDivId);
		$modal.show();
		var $info = $('#info'), html = '';
		$
				.ajax({
					type : 'GET',
					url : "busOrder/sendlgtMsg.do",
					data : {
						"lgtNums" : str
					},
					beforeSend : function() {
						$modal.html('加载中...');
					},
					success : function(dataStr) {
						if (dataStr == 1) {
							html = '<li style="color: red;">物流信息：' + '<span style="color: black;">客户亲自拿货' + '</span>'
									+ '</li>';
						}else if (dataStr == 2) {
							html =  '<li style="color: red;">物流信息：' + '<span style="color: black;">滴滴送货,一天内到达' + '</span>'
									+ '</li>';
						}else{
						myData = JSON.parse(dataStr);
						var data = JSON.parse(dataStr);
						if (data.status === '0' && data.msg === 'ok') {
							var r = data.result, list = r.list, result = r.issign === '1' ? '已签收'
									: '未签收';
							html += '<li style="color: red;">物流状态：' + result
									+ '</li>';
							html += "<li>" + findSth(r.type)
									+ "&nbsp;&nbsp;&nbsp;";
							html += "运单号：" + r.number + "</li>";
							for (var i = list.length - 1; i >= list.length - 1; i--) {
								html += "<li>" + list[i].status
										+ "<p class='timeMsg'>" + list[i].time
										+ "</p>" + "</li>";
							}
							html += "<li>"
									+ "<a id='my_a' style='color: red;' onclick='showAll(this)'>查看详情</a>"
									+ "</li>";
						}
						else {
							html = "当前无信息";
						}
						
					}
					$modal.html(html);
					}
				});
	}

	//显示所有物流信息
	function showAll(that) {
		event.stopPropagation();
		var $modal = $('#' + myDivId);
		$modal.show();
		var $info = $('#info'), html = '';
		if (myData.status === '0' && myData.msg === 'ok') {
			var r = myData.result, list = r.list, result = r.issign === '1' ? '已签收'
					: '未签收';
			html += '<li style="color: red;">物流状态：' + result + '</li>';
			html += "<li>" + findSth(r.type) + "&nbsp;&nbsp;&nbsp;";
			html += "运单号：" + r.number + "</li>";
			for (var i = 0; i < list.length; i++) {
				html += "<li>" + list[i].status + "<p class='timeMsg'>"
						+ list[i].time + "</p>" + "</li>";
			}

		} else {
			html = "当前无信息";
		}
		$modal.html(html)
	}
	//翻译英文
	function findSth(type) {
		var comp;
		if (type == 'AAEWEB' || type == 'aaeweb') {
			comp = 'AAE';
		} else if (type == 'ARAMEX' || type == 'aramex') {
			comp = 'Aramex';
		} else if (type == 'DHL' || type == 'dhl') {
			comp = 'DHL';
		} else if (type == 'DPEX' || type == 'dpex') {
			comp = 'DPEX';
		} else if (type == 'DEXP' || type == 'dexp') {
			comp = 'D速';
		} else if (type == 'EMS' || type == 'ems') {
			comp = 'EMS';
		} else if (type == 'EWE' || type == 'ewe') {
			comp = 'EWE';
		} else if (type == 'FEDEX' || type == 'fedex') {
			comp = 'FedEx';
		} else if (type == 'FEDEXIN' || type == 'fedexin') {
			comp = 'FedEx国际';
		} else if (type == 'PCA' || type == 'pca') {
			comp = 'PCA';
		} else if (type == 'TNT' || type == 'txt') {
			comp = 'TNT';
		} else if (type == 'UPS' || type == 'ups') {
			comp = 'UPS';
		} else if (type == 'ANJELEX' || type == 'anjelex') {
			comp = '安捷';
		} else if (type == 'ANE' || type == 'ane') {
			comp = '安能';
		} else if (type == 'aneex' || type == 'ANEEX') {
			comp = '安能快递';
		} else if (type == 'ANXINDA' || type == 'anxinda') {
			comp = '安信达';
		} else if (type == 'EES' || type == 'ees') {
			comp = '百福东方';
		} else if (type == 'HTKY' || type == 'htky') {
			comp = '百世快递';
		} else if (type == 'BSKY' || type == 'bsky') {
			comp = '百世快运';
		} else if (type == 'FLYWAYEX' || type == 'flywayex') {
			comp = '程光';
		} else if (type == 'DTW' || type == 'dtw') {
			comp = '大田';
		} else if (type == 'DEPPON' || type == 'deppon') {
			comp = '德邦';
		} else if (type == 'GCE' || type == 'gce') {
			comp = '飞洋';
		} else if (type == 'PHOENIXEXP' || type == 'phoenixexp') {
			comp = '凤凰';
		} else if (type == 'FTD' || type == 'ftd') {
			comp = '富腾达';
		} else if (type == 'GSD' || type == 'gsd') {
			comp = '共速达';
		} else if (type == 'GTO' || type == 'gto') {
			comp = '国通';
		} else if (type == 'BLACKDOG' || type == 'blackdog') {
			comp = '黑狗';
		} else if (type == 'HENGLU' || type == 'henglu') {
			comp = '恒路';
		} else if (type == 'HYE' || type == 'hye') {
			comp = '鸿远';
		} else if (type == 'HQKY' || type == 'hqky') {
			comp = '华企';
		} else if (type == 'JOUST' || type == 'joust') {
			comp = '急先达';
		} else if (type == 'TMS' || type == 'tms') {
			comp = '加运美';
		} else if (type == 'JIAJI' || type == 'jiaji') {
			comp = '佳吉';
		} else if (type == 'KERRY' || type == 'kerry') {
			comp = '嘉里物流';
		} else if (type == 'HREX' || type == 'hrex') {
			comp = '锦程快递';
		} else if (type == 'PEWKEE' || type == 'pewkee') {
			comp = '晋越';
		} else if (type == 'JD' || type == 'jd') {
			comp = '京东';
		} else if (type == 'KKE' || type == 'kke') {
			comp = '京广';
		} else if (type == 'JIUYESCM' || type == 'jiuyescm') {
			comp = '九曳';
		} else if (type == 'KYEXPRESS' || type == 'kyexpress') {
			comp = '跨越';
		} else if (type == 'FASTEXPRESS' || type == 'fastexpress') {
			comp = '快捷';
		} else if (type == 'BLUESKY' || type == 'bluesky') {
			comp = '蓝天';
		} else if (type == 'LTS' || type == 'lts') {
			comp = '联昊通';
		} else if (type == 'LBEX' || type == 'lbex') {
			comp = '龙邦';
		}

		else if (type == 'CNPL' || type == 'cnpl') {
			comp = '中邮';
		} else if (type == 'ZTO' || type == 'zto') {
			comp = '中通';
		} else if (type == 'ZTKY' || type == 'ztky') {
			comp = '中铁物流';
		} else if (type == 'CRE' || type == 'cre') {
			comp = '中铁快运';
		} else if (type == 'COE' || type == 'coe') {
			comp = '中国东方';
		} else if (type == 'ZMKMEX' || type == 'zmkmex') {
			comp = '芝麻开门';
		} else if (type == 'ZJS' || type == 'zjs') {
			comp = '宅急送';
		}

		else if (type == 'YUNDA' || type == 'yunda') {
			comp = '韵达';
		} else if (type == 'YTEXPRESS' || type == 'ytexpress') {
			comp = '运通';
		} else if (type == 'YFEXPRESS' || type == 'yfexpress') {
			comp = '越丰';
		} else if (type == 'YCGWL' || type == 'ycgwl') {
			comp = '远成';
		} else if (type == 'YADEX' || type == 'yadex') {
			comp = '源安达';
		} else if (type == 'YTO' || type == 'yto') {
			comp = '圆通';
		} else if (type == 'YFHEX' || type == 'yfhex') {
			comp = '原飞航';
		} else if (type == 'CHINAPOST' || type == 'chinapost') {
			comp = '邮政包裹';
		} else if (type == 'UC56' || type == 'uc56') {
			comp = '优速';
		} else if (type == 'ETD' || type == 'etd') {
			comp = '易通达';
		} else if (type == 'QEXPRESS' || type == 'qexpress') {
			comp = '易达通';
		} else if (type == 'YIEXPRESS' || type == 'yiexpress') {
			comp = '宜送';
		} else if (type == 'BROADASIA' || type == 'broadasia') {
			comp = '亚风';
		} else if (type == 'XFEXPRESS' || type == 'xfexpress') {
			comp = '信丰';
		} else if (type == 'EWINSHINE' || type == 'ewinshine') {
			comp = '万象';
		} else if (type == 'WANJIA' || type == 'wanjia') {
			comp = '万家物流';
		} else if (type == 'VANGEN' || type == 'vangen') {
			comp = '万庚';
		} else if (type == 'TTKDEX' || type == 'ttdex') {
			comp = '天天';
		} else if (type == 'HOAU' || type == 'hoau') {
			comp = '天地华宇';
		} else if (type == 'SURE' || type == 'sure') {
			comp = '速尔';
		} else if (type == 'SUNING' || type == 'suning') {
			comp = '苏宁';
		} else if (type == 'SFEXPRESS' || type == 'sfexpress') {
			comp = '顺丰';
		} else if (type == 'SDEX' || type == 'sdex') {
			comp = '顺达快递';
		} else if (type == 'SHENGHUI' || type == 'shenghui') {
			comp = '盛辉';
		} else if (type == 'STO' || type == 'sto') {
			comp = '申通';
		} else if (type == 'SFC' || type == 'sfc') {
			comp = '三态';
		} else if (type == 'RFD' || type == 'rfd') {
			comp = '如风达';
		} else if (type == 'APEX' || type == 'apex') {
			comp = '全一';
		} else if (type == 'QFKD' || type == 'qfkd') {
			comp = '全峰';
		} else if (type == 'CHINZ56' || type == 'chinz56') {
			comp = '秦远物流';
		} else if (type == 'EFSPOST' || type == 'efspost') {
			comp = '平安快递';
		} else if (type == 'PEISI' || type == 'peisi') {
			comp = '配思航宇';
		} else if (type == 'ND56' || type == 'nd56') {
			comp = '能达';
		} else if (type == 'CAE' || type == 'nd56') {
			comp = '民航';
		} else {
			comp = '无法识别';
		}
		return comp;
	}

	$(document).on('click', '.my_link', function(e) {
		e.stopPropagation()
		$(that).siblings('#' + myDivId).show();
	});

	$(document).on('click', function() {
		$('.myLgtMsg').hide();
	})

	$(document).on('click', '.myLgtMsg', function(e) {
		e.stopPropagation();
	})
	

</script>