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
<title>供方订单-已取消</title>
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
		<!-- 内容显示的地方 -->
	</div>
	<!-- 分页 -->
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
		        	//设置交易状态
				  	var content = "";
					for(var i in tmpguan){
						var tradeStus=getOrderStus(Row.rows[tmpguan[i][1]].orderStatus,Row.rows[tmpguan[i][1]].updateCustType);
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
				        	content+="<div class='indent_price'><span class='fs14 vertical-m'>"+Row.rows[tmpguan[i][num]].goodsPrice+"</span><br/>";
				        	if(Row.rows[tmpguan[i][num]].goodsDiscount==10){
				        		content+="<span class='fs12 vertical-m'>无折扣</span></div>";
				        	}else{
				        	  	content+="<span class='fs12 vertical-m'>"+Row.rows[tmpguan[i][num]].goodsDiscount+"</span>折</div>";
				        	}
				        	content+="<div class='indent_quantity'>"+Row.rows[tmpguan[i][num]].goodsCount+"</div>";
				        	content+="<div class='indent_aggregate'>"+(Row.rows[tmpguan[i][num]].goodsPrice*Row.rows[tmpguan[i][num]].goodsCount*Row.rows[tmpguan[i][num]].goodsDiscount/10).toFixed(2)+"</div>";
				        	content+="<div class='indent_type'>"+ (Row.rows[tmpguan[i][num]].orderType=='091001'?'试刀':'购买') +"</div>";
				        	content+="<div class='indent_operation'>"+tradeStus+"</div>";
				        	content+="</div>";/* div.message */
			        	}
			        	content+="<div class='row'>";
			        	content+="<span>默认到货时间："+Row.rows[i].wishPayDt+"</span>";
			        	content+="<span class='delivery_date'>期望收货时间："+Row.rows[i].defaultPayDt+"</span>";
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
			        	content+="<input type='text' maxlength='150'/>";  
			        	content+="</div><div class='clear'></div></div>";/* div.remark */
			        	content+="<div class='row site'>";
			        	content+="<span>收货地址</span><span>"+(Row.rows[tmpguan[i][1]].addresseeName!=null?Row.rows[tmpguan[i][1]].addresseeName:'')+"</span><span>"+(Row.rows[tmpguan[i][1]].addresseePhone!=null?Row.rows[tmpguan[i][1]].addresseePhone:'')+"</span><span>"+(Row.rows[tmpguan[i][1]].address!=null?Row.rows[tmpguan[i][1]].address:'')+"</span>";
			        	content+="</div>";/* div.row */
			        	content+="<div class='row text-bar-right'>";
			        	content+="<button type='button' class='affirm_indent' onclick=deleteOrder(\'"+Row.rows[tmpguan[i][1]].orderNo+"\')>删除订单</button>";
			        	content+="</div>";
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
					data:{"orderNo":orderNo},
					type:'post',
					success:function(data){
						if(data.success){
							count();
							layer.msg('操作成功', {
								icon: 1,
								time: 2000
							}, function(){
								$(".sheet").load("busOrder/toApplyConfirmed.do");
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