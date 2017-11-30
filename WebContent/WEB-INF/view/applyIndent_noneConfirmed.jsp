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
<title>供方订单-待确认</title>
<style type="text/css">
.layui-layer-content input{
	border: 1px solid #666;
	margin: 5px;
	padding:5px;
	width: 180px;
}
</style>
</head>
<body>
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
		<!-- 内容显示的模块 -->
	</div>
	<div id="demo"></div>
</body>
</html>
<script type="text/javascript">
$(function(){
	layui.config({
		dir: 'frame/layui/' //layui.js 所在路径（注意，如果是script单独引入layui.js，无需设定该参数。），一般情况下可以无视
		,version: false //一般用于更新模块缓存，默认不开启。设为true即让浏览器不缓存。也可以设为一个固定的值，如：201610
		,debug: false //用于开启调试模式，默认false，如果设为true，则JS模块的节点会保留在页面
		,base: 'frame/layui/' //设定扩展的Layui模块的所在目录，一般用于外部模块扩展
	});
	var curr=1;
	//运行
	demo(curr);
	//以下将以jquery.ajax为例，演示一个异步分页
	function demo(curr){
		$.ajax({
			url:'busOrder/getSupplyOrders.do',
			data:{pageNo:curr||1,orderStatus:'090001'},
			success:function(data){
				if(data.success){
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
		        	//设置交易状态
				  	var content = "";
					for(var i in tmpguan){
						var tradeStus=getOrderStus(Row.rows[tmpguan[i][1]].orderStatus,Row.rows[tmpguan[i][1]].updateCustType);
						var quantity = 0;
						var price = parseInt(0);
			        	content+="<div class='moudle'>";
			        	content+="<div class='line'>";
			        	content+="<span class='uname'>买家："+Row.rows[tmpguan[i][1]].custName+"</span>";
			        	content+="<span class='utel'>"+Row.rows[tmpguan[i][1]].custPhone+"</span>";
			        	content+="<div class='float-bar-right'>";
			        	content+="<span class='uindent'>订单编号："+Row.rows[tmpguan[i][1]].orderNo+"</span>";
			        	content+="<span class='udate'>提交时间："+new Date(Row.rows[tmpguan[i][1]].insertDate).Format("yyyy-MM-dd hh:mm:ss")+"</span>";
			        	content+="</div>";/* div.text-bar-right */
			        	content+="</div>";/* div.line */
						for(var num = 1; num < tmpguan[i].length; num++){
				        	content+="<div class='message'>";
				        	content+="<div class='indent_name'><p title='"+Row.rows[tmpguan[i][num]].goodsName+"'>"+(Row.rows[tmpguan[i][num]].goodsName!=null ? Row.rows[tmpguan[i][num]].goodsName : '')+"</p>";
				        	content+="<p title='"+Row.rows[tmpguan[i][num]].par+"'>"+(Row.rows[tmpguan[i][num]].par!=null?Row.rows[tmpguan[i][num]].par:'')+"</p></div>";
				        	content+="<div class='indent_price input_price'><input type='hidden' value="+Row.rows[tmpguan[i][num]].tableKey+"><span class='fs14 vertical-m'>"+Row.rows[tmpguan[i][num]].goodsPrice+"</span><br/>";
				        	if(Row.rows[tmpguan[i][num]].goodsDiscount==10){
				        		content+="<span class='fs12 vertical-m' style='color:blue'>无折扣</span></div>";
				        	}else{
				        	  	content+="<span class='fs12 vertical-m' style='color:blue'>"+Row.rows[tmpguan[i][num]].goodsDiscount+"折</span></div>";
				        	}
				        	content+="<div class='indent_quantity'>"+Row.rows[tmpguan[i][num]].goodsCount+"</div>";
				        	quantity+=Row.rows[tmpguan[i][num]].goodsCount;
				        	price+=parseInt(Row.rows[tmpguan[i][num]].goodsMoney);
				        	content+="<div class='indent_aggregate input_aggregate'>"+Row.rows[tmpguan[i][num]].goodsMoney+"</div>";
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
								content+="<span>"+new Date(data.map[Row.rows[tmpguan[i][1]].orderNo][j].insertDate).Format("yyyy-MM-dd hh:mm:ss")+" "+(data.map[Row.rows[tmpguan[i][1]].orderNo][j].status==0?'客户状态':'供方状态')+"："+tradeStus+" "+(data.map[Row.rows[tmpguan[i][1]].orderNo][j].status==0?'客户备注':'供方备注')+"："+(data.map[Row.rows[tmpguan[i][1]].orderNo][j].remark!=null?data.map[Row.rows[tmpguan[i][1]].orderNo][j].remark:'')+"</span><br>";
							}
						}
			        	content+="<input type='text' maxlength='150' />";  
			        	content+="</div><div class='clear'></div></div>";/* div.remark */
			        	content+="<div class='row site'>";
			        	content+="<span>收货地址</span><span>"+(Row.rows[tmpguan[i][1]].addresseeName!=null?Row.rows[tmpguan[i][1]].addresseeName:'')+"</span><span>"+(Row.rows[tmpguan[i][1]].addresseePhone!=null?Row.rows[tmpguan[i][1]].addresseePhone:'')+"</span><span>"+(Row.rows[tmpguan[i][1]].address!=null?Row.rows[tmpguan[i][1]].address:'')+"</span>";
			        	content+="</div>";/* div.row */
		        		content+="<div class='row text-bar-right'>";
		        		content+="<span>共有<em>"+quantity+"</em>件商品，总计：<em>￥"+price+"</em></span>";
		        		if(quantity>1){
		        			content+="<button type='button' class='cancel_indent' onclick=load(\'"+Row.rows[tmpguan[i][1]].orderNo+"\')>拆分订单</button>";
		        		}
		        		content+="<button type='button' class='cancel_indent' onclick=cancelOrder(\'"+Row.rows[tmpguan[i][1]].orderNo+"\',\'"+Row.rows[tmpguan[i][1]].orderType+"\')>取消订单</button>";
		        		content+="<button type='button' class='affirm_indent' onclick=operatorOrder(\'"+Row.rows[tmpguan[i][1]].orderNo+"\',this)>确认订单</button>";
		        		content+="</div>";/* div.row text-bar-right */
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
						          demo(obj.curr);
						        }
						      }
						});
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
		var index = layer.open({
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
					//var goodsDiscount1 = "";//折扣
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
					  		if(data.success){
					  			//location.reload();
					  			layer.close(index);
					  			$(".show").load("busOrder/toPage/applyIndent_noneConfirmed.do");
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
		var index = layer.open({
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
					  			//location.reload();
					  			layer.close(index);
					  			$(".show").load("busOrder/toPage/applyIndent_noneConfirmed.do");
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
//订单拆分
function load(val){
	location.href = "busOrder/getbygood.do?key="+val;
}
//取消订单
function cancelOrder(orderNo,orderType){
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
					"statusWay":"1",
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
							$(".sheet").parent().load("busOrder/toApplyConfirmed.do");
						});
					}else{
						layer.open({
							 title: '错误信息'
							 ,content:data.msg
						}); 
					}
				}
			});
		},btn2: function(index, layero){
			layer.close(index);
		},closeBtn: 0
	});	
}
//各种操作订单
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
					  location.reload();
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
function count(){
	$.ajax({
		url:'busOrder/getBuyerOrderCount.do',
		success:function(data){
			$("#payment").text(data.obj.payment);
			$("#readCollect").text(data.obj.readCollect);
			$("#complete").text(data.obj.complete);
			$("#all").text(data.obj.all);
			$("#cancel").text(data.obj.cancel);
		}
	});
}
</script>