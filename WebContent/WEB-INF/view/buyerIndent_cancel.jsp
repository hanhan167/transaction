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
<title>买方订单-全部</title>
</head>
<body>
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
			url:'busOrder/getBuyerOrders.do',
			data:{pageNo:curr||1,orderStatus:'090006'},
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
					for(var i in tmpguan){
						var content = "";
						var tradeStus=getOrderStus(Row.rows[tmpguan[i][1]].orderStatus,Row.rows[tmpguan[i][1]].updateCustType);
						var quantity = 0;
						var price = 0;
						content+="<div class='moudle'>";
						content+="<div class='line'>";
						content+="<span class='uname' onclick='vendor(\""+Row.rows[tmpguan[i][1]].custNo+"\")'>卖家："+Row.rows[tmpguan[i][1]].supperName+"</span>";
						content+="<span class='utel'>"+Row.rows[tmpguan[i][1]].applyPhone+"</span>";
						content+="<span class='udate right'>提交时间："+new Date(Row.rows[tmpguan[i][1]].insertDate).Format("yyyy-MM-dd hh:mm:ss")+"</span>";
						content+="<span class='uindent right'>订单编号："+tmpguan[i][0]+"</span>";
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
				        	price+=Row.rows[tmpguan[i][num]].goodsPrice*Row.rows[tmpguan[i][num]].goodsCount*Row.rows[tmpguan[i][num]].goodsDiscount/10;
			        	  	content+="<div class='indent_quantity'>"+Row.rows[tmpguan[i][num]].goodsCount+"</div>";
			        	  	content+="<div class='indent_aggregate'>"+(Row.rows[tmpguan[i][num]].goodsPrice*Row.rows[tmpguan[i][num]].goodsCount*Row.rows[tmpguan[i][num]].goodsDiscount/10).toFixed(2)+"</div>";
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
		        	  	for(j in data.list){
							if(j!=1){
						  		content+="<span>"+new Date(data.list[j].insertDate).Format("yyyy-MM-dd hh:mm:ss")+" "+(data.list[j].status==1?'客户状态':'供方状态')+"："+tradeStus+" "+(data.list[j].status==1?'客户备注':'供方备注')+"："+(data.list[j].remark!=null?data.list[j].remark:'')+"</span><br>";
							}else{
						  		content+="<span >"+new Date(data.list[j].insertDate).Format("yyyy-MM-dd hh:mm:ss")+" "+(data.list[j].status==1?'客户状态':'供方状态')+"："+tradeStus+" "+(data.list[j].status==0?'客户备注':'供方备注')+"："+(data.list[j].remark!=null?data.list[j].remark:'')+"</span><br>";
							}
					  	}
		        		content+="<input type='text'/>"; 
		        	  	content+="</div><div class='clear'></div></div>";
	        	  		content+="<div class='row text-bar-right'>";
	        	  		content+="<button type='button' class='cancel_indent' onclick=againPurchase('"+Row.rows[tmpguan[i][1]].orderNo+"','"+Row.rows[tmpguan[i][1]].supplyNo+"',this)>再次购买</button>";
	        	  		content+="<button type='button' class='affirm_indent' onclick=deleteOrder(\'"+Row.rows[tmpguan[i][1]].orderNo+"'\)>删除订单</button>";
	        	  		content+="</div>";
						content+="</div>";
					   	$(".sheet").append(content);
					}
					
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
//再次购买
function againPurchase(orderNo,supplyNo,element){
	var brands = "";
	$(element).parents(".moudle").find(".message").each(function(){
		brands += $(this).attr("data-brand")+",";
	});
	$.ajax({
		url:"busShoppCart/buyAgain.do",
		data:{
			"orderNo":orderNo,
			"brand":brands,
			"supplyNo":supplyNo
		},
		type:"post",
		success:function(data){
			if(data.success){
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
//删除订单
function deleteOrder(orderNo){
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
							//$(".sheet").parent().load("busOrder/toBuyerAll.do");
							$(".sheet").parent().load("busOrder/toPage/buyerIndent_cancel.do");
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
};
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
</script>