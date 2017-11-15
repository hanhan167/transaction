<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath %>"/>
<!-- <meta  http-equiv="Content-Type" content="text/html; charset=UTF-8"> -->
<meta name="viewport" content="width=device-width, initial-scale=1,minimum-scale=0.5,maximum-scale=2.0">
<title>购物车</title>
<link rel="stylesheet" type="text/css" href="frame/static/css/shopping_cart.css"/> 
<link rel="stylesheet" type="text/css" href="frame/static/css/jcDate.css"/> 
<style type="text/css">
.shopping_checked{
	background-color: #eee;
}
.content>.header,
.content>#sheet,
.content>.clearing{
	display: none;
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
			<div class="header">
				<label class="all_check"><input type="checkbox">全选</label>
				<span class="buy_name">商品</span>
				<span class="buy_discount">折扣</span>
				<span class="buy_univalence">单价（元）</span>
				<span class="buy_amount">数量</span>
				<span class="buy_aggregate">小计（元）</span>
				<span class="buy_operate">类型</span>
				<span class="buy_delete">操作</span>
			</div>
			<div id="sheet" class="sheet">
				<!--供应商模块-->
			</div>
			<div class="row clearing">
				<input type="checkbox" />
				<label >全选</label>
				<a id="multiDelete">删除</a>
				<a id="clearInvalid">清空失效商品</a>
				<div class='text-bar-right'>
					<span class="cost">共有<em class="vertical-m margin-left-5 margin-right-5">0</em>件商品，总计：<em class="vertical-m">￥0</em></span>
					<button type="button" class="affirm_indent" id="createOrder">生成订单</button>
				</div>
			</div>
		</div>
	</div> 
	
	<!--底部-->
	<div class="base">
		 <jsp:include page="base.jsp" flush="true"/>
	</div>
	
</body>
<div id="addressTip" style="display:none">
	<table class="layui-table" lay-skin="line">
		
	</table>
</div>
</html>
<script type="text/javascript" src="frame/static/js/baiduTemplate.js"></script>
<script type="text/javascript" src="frame/static/js/jQuery-jcDate.js"></script>
<script id="bd_t1" type="text/template">
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
				<label><input type="checkbox" class="vertical-m"><span class="margin-right-40 vertical-m"><*=list.supplyName*></span><span class="vertical-m utel"><*=list.supplyPhone*></span></label>
			</div>
<*for(var num = 1; num < tmpguan[key].length; num++){*>
<*var listDetail = shoppCart[tmpguan[key][num]]*>
			<!--商品信息-->
			<div class="message" id="<*=listDetail.tableKey*>">
				<input type="checkbox" class="singleCheck">
				<input type="hidden" value="<*=listDetail.tableKey*>">
				<input type="hidden" value="<*=listDetail.minkc*>">
				<div class="buy_name">
					<p style="width:310px;" class="text-l margin-bottom-10 text-flow" title="<*=listDetail.goodsName*>"><*=listDetail.goodsName*></p>
					<p style="width:310px;" class="text-l text-flow" title="<*=listDetail.par*>"><*=listDetail.par*></p>
				</div>
				<div class="buy_discount">
					<*if(listDetail.goodsDiscount==10){*>
						无折扣
					<*}else{*>
						<*=listDetail.goodsDiscount*>
					<*}*>
				</div>

				<div class="buy_univalence"><*=listDetail.goodsPrice.toFixed(2)*></div>
				<div class="buy_amount">
					<div class="amout_num">
						<button class="amout_subtrac"></button>
						<input class="num" value="<*=listDetail.buyNum*>" onafterpaste="if(this.value.length==1){this.value=this.value.replace(/[^1-9]/g,'')}else{this.value=this.value.replace(/\D/g,'')}"/>
						<button class="amout_add"></button>
					</div>
				</div>
				<div class="buy_aggregate"><*=(Math.round(listDetail.buyNum*listDetail.goodsPrice*listDetail.goodsDiscount)/10).toFixed(2)*></div>
				<div class="buy_operate">
					<label"><span class="vertical-m fs14 font-666 buytype" buytype="<*=listDetail.buyType*>"><*=listDetail.buyType==09001? "试刀" : "购买"*></span></label>
				</div>
				<div class="buy_delete"><a class="fs14" style='color:#ec7720'>删除</a></div>
			</div>
<*}*>
	<!--	<div class="date">
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
-->
		</div>
	<*}*>
</script>
<script id="bd_t2" type="text/template">
	<*for(var key in obj){*>
		<*var list = obj[key]*>
		<tr style="height:60px">
			<td><input type="radio" name="operation" <*=list.status==1?"class='pitch' checked='checked'":""*>/><input type="hidden" value="<*=list.tableKey*>"></td>
			<td><*=list.userName*></td>
			<td><*=list.userPhone*></td>
			<td><*=list.userAddress*></td>
		</tr>
	<*}*>
</script>
<script type="text/javascript">
$(function(){
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
	
	$.ajax({
		url:'busShoppCart/getShoppCart.do',
		success:function(data){
			if(data.success){
				if(data.map.goodsNo!="0"){
					$(".content>.header").show();
					$(".content>#sheet").show();
					$(".content>.clearing").show();
					var html=baidu.template('bd_t1',data.map);
		            $(".sheet").html(html);
		            $("#addressName").text(data.map.userAddress.userName);
		            $("#addressPhone").text(data.map.userAddress.userPhone);
		            $("#address").text(data.map.userAddress.userAddress);	            
		            $("#addressNo").val(data.map.userAddress.tableKey);	 
		         	// 日历插件
		        	laydate.skin('molv');// 切换皮肤，请查看skins下面皮肤库
		        	clearHeight = $('#sheet').height();
		        	fixed(clearHeight);
		        	
		        	//判断失效商品
		        	var rows = data.map.shoppCart;
		        	var listbrandNames = listSupplyNos = listGoods ="";
		        	for(var l=0;l<rows.length;l++){
		        		listbrandNames += rows[l].code+",";
		        		listSupplyNos += rows[l].supplyNo+",";
		        		listGoods += rows[l].goodsNo+",";
		        	}
		        	var datas = {"listbrandNames":listbrandNames,"listSupplyNos":listSupplyNos,"listGoods":listGoods}
		        	overTimeShop(datas);
		        	
		        	//调用清空失效商品
		        	clearShopCar({"listbrandNames":listbrandNames,"listSupplyNos":listSupplyNos});
		        }else{
		        	$(".centre>.content").html("<div style='text-align:center;background:#fff;padding:120px;height:400px;'><img src='frame/static/img/gouwu.png'>购物车是空的,赶快去挑选商品吧</div>");
		        }
			}else{
				layer.open({
					 title: '错误信息'
					 ,content:data.msg
				}); 
			}
		}
	});
	$("body").on("click","input[type=checkbox]",function(){
		var choose = $(".moudle").children(".message").length;
		for(var i = 0; i < choose; i++){
			if($($(".message")[i]).children("input[type=checkbox]").prop("checked")){
				$($(".message")[i]).addClass("shopping_checked");
			}else{
				$($(".message")[i]).removeClass("shopping_checked");
			}
		}
	});
	/* 检查购物车中是否有 过期商品 */
	var overTimeShop = function(data){
		if(data.listbrandNames=="" ||  data.listSupplyNos=="" ||  data.listGoods=="" ){
		}else{
			$.ajax({
				url:'busShoppCart/selectIsExist.do',
				data:data,
				type:"post",
				success:function(data){
					if(!data.success){
						layer.alert(data.msg)
						$("#createOrder").attr("disabled","disabled");
					}else{
						$("#createOrder").removeAttr("disabled");
					}
				}
				
			});
		}
	}
	/* 商品数量变化 */
/* 	 $(".sheet").on("keyup",".num",function(){
		var reg = /^[1-9]\d*$/;
		var shu =$(this).val(); //获取现有的数量
		if(reg.test(shu)){
			shu = $(this).val();
		}else{
			$(this).val('');
			shu = 0;
		}
		var univalence = $(this).parent().parent().prev().html();//获取到单价		
		var discount = $(this).parent().parent().prev().prev().html();//获取到折扣
		if(discount == "无折扣"){
			discount = 10
		}
		if(shu>=0){
			var result=Math.round(univalence*shu*discount)/10;
			$(this).parent().parent().next().text(result);
		}
		total();
	});  */
	function countPrice($dom){
		var reg = /^[1-9]\d*$/;
		var shu =$dom.val(); //获取现有的数量
		if(reg.test(shu)){
			shu = $dom.val();
		}else{
			$dom.val('');
			shu = 0;
		}
		var univalence = $dom.parent().parent().prev().html();//获取到单价		
		var discount =  $dom.parent().parent().prev().prev().html();//获取到折扣
		if(discount == "无折扣"){
			discount = 10
		}
		if(shu>=0){
			var result=Math.round(univalence*shu*discount)/10;
			$dom.parent().parent().next().text(result.toFixed(2));
		}
		total();
	}
	$(".sheet").on("blur",".num",function(){
		var tablekey = $(this).parent().parent().parent().children("input[type=hidden]:eq(0)").val();
		var num = $(this).parent().children(".num").val();
		var minkc = $(this).parent().parent().parent().children("input[type=hidden]:eq(1)").val();
		
		if(num < minkc){
			$(this).val(minkc);
			num = minkc;
			countPrice($(this));
			numupdate(tablekey,num,minkc);
			total();
		}else if(num%minkc != 0){
			layer.open({
				title: '提示信息'
				,content:"该商品数量必须是最小起订量"+minkc+"的整数倍！"
			});
			$(this).val(minkc);
			num = minkc;
			countPrice($(this));
			numupdate(tablekey,num,minkc);
			total();
		}else{
			countPrice($(this));
			numupdate(tablekey,num,minkc);
			total();
		}
	});
	/* 商品数量减少 */
	$(".sheet").on("click",".amout_subtrac",function(){
		var univalence = $(this).parent().parent().prev().html();//获取到单价
		var shu = $(this).next().val();//获取现有的数量
		var discount = $(this).parent().parent().prev().prev().html();//获取到折扣
		var tablekey = $(this).parent().parent().parent().children("input[type=hidden]:eq(0)").val();
		var minkc = $(this).parent().parent().parent().children("input[type=hidden]:eq(1)").val();
		if(discount == "无折扣"){
			discount = 10;
		}
		if(shu <= minkc){
			shu = minkc;
			$(this).next().val(minkc);
			
			var result=Math.round(univalence*minkc*discount)/10;
			$(this).parent().parent().next().text(result.toFixed(2));
		
			var num = $(this).parent().children(".num").val();
			numupdate(tablekey,num,minkc);
			total();
			
		}else if(shu%minkc==0){
			var upshu = shu-minkc;
			$(this).next().val(upshu);
			var result=Math.round(univalence*upshu*discount)/10;
			$(this).parent().parent().next().text(result.toFixed(2));
		
			var num = $(this).parent().children(".num").val();
			numupdate(tablekey,num,minkc);
			total();
		}
	});
	/* 商品数量添加 */
	$(".sheet").on("click",".amout_add",function(){
		var tablekey = $(this).parent().parent().parent().children("input[type=hidden]:eq(0)").val();
		var minkc = $(this).parent().parent().parent().children("input[type=hidden]:eq(1)").val();
		var univalence = $(this).parent().parent().prev().html();//获取到单价
		var shu = $(this).prev().val();//获取现有的数量
		var discount = $(this).parent().parent().prev().prev().html();//获取到折扣
		if(discount == "无折扣"){
			discount = 10;
		}
		var upshu;
		if (shu < minkc){
			$(this).prev().val(minkc);
			upshu = eval(minkc);
		}else{
			upshu = eval(shu+"+"+minkc);
			$(this).prev().val(upshu);
		}
		var result=Math.round(univalence*upshu*discount)/10;
		
		
		$(this).parent().parent().next().text(result.toFixed(2));
		var num = $(this).parent().children(".num").val();
		
		numupdate(tablekey,num,minkc);
		total();
	});
	/* 点击顶部全选 */
	$(".header input[type=checkbox]").click(function(){command(this);});
	/* 点击底部全选 */
	$(".clearing input[type=checkbox]").click(function(){command(this);});
	//点供货商选中商品
	$(".sheet").on("click",".shop-info input[type=checkbox]",function(){
		var choose = $(".moudle").children(".message").length;//选购的总数
		for(var i = 0; i < choose; i++){
			if($(".shop-info:eq("+i+") input[type=checkbox]").is(':checked')){
				$(".moudle:eq("+i+")>.message>input[type=checkbox]").prop("checked", true);
			}else{
				$(".moudle:eq("+i+")>.message>input[type=checkbox]").prop("checked", false);
			}
		}
	});
	/*点击全选选中取消全选*/
	function command(place){
		if($(place).is(':checked')){
			$("input[type='checkbox']").prop("checked", true);
		}else{
			$("input[type='checkbox']").prop("checked", false);
		}
	}
	/* 计算商品数量和价格 */ 
	$("input[type=checkbox]").click(function(){
		total();
	});
	$(".sheet").on("click","input[type=checkbox]",function(){
		total();
	});
	function total(){
		var aggregate = 0;
		var amount = 0; //累计计算总数量
		$(".sheet").find(".buy_amount").each(function(i){
			var obj = $(this);
			if(obj.siblings(".singleCheck").is(":checked")){
				amount = eval(amount+"+"+obj.find(".num").val());
				aggregate = (eval(aggregate +"+"+ obj.siblings(".buy_aggregate").text())).toFixed(2);
			}
		});
		if(amount==" "){
			$(".cost em:eq(0)").html("0");
			$(".cost em:eq(1)").html("￥0");
		}else{ 
			$(".cost em:eq(0)").html(amount);
			$(".cost em:eq(1)").html("￥"+aggregate);
		} 
	}
	
	//批量删除
	$("#multiDelete").click(function(){
		layer.open({
			 title: '提示信息'
			 ,content:"是否删除已选中的商品?"
			 ,btn:['确认','取消']
			 ,yes: function(index, layero){
				 layer.close(index);
				 var tableKey=new Array();
					var flag=0;
					//循环遍历，获取选中的checkbox，并把tableKey封装成数组
					$(".moudle .message").find(".singleCheck:checked").each(function(){
						tableKey.push($(this).next().val());
						flag=1;
					});
					if(flag!=1){
						layer.msg('请至少选中一条记录', {
							  icon: 2,
							  time: 2000
							}, function(){
						});
						return;
					}
					$.ajax({
						url:"busShoppCart/deleteShoppCar.do",
						data:{tableKey:tableKey},
						type:"post",
						success:function(data){
							if(data.success){
								layer.msg('删除成功', {
								  icon: 1,
								  time: 3000
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
			  ,btn2: function(index, layero){
				 layer.close(index);
			  }
			  ,closeBtn: 0
		});
	});
	
	//单个删除
	$(".sheet").on("click",".buy_delete",function(){
		var buyId = $(this).parent().attr('id');
		layer.open({
			 title: '提示信息'
			 ,content:"是否删除已选中的商品?"
			 ,btn:['确认','取消']
			 ,yes: function(index, layero){
				layer.close(index);
				var tableKey=new Array();
				tableKey.push(buyId);
				$.ajax({
					url:"busShoppCart/deleteShoppCar.do",
					data:{tableKey:tableKey},
					type:"post",
					success:function(data){
						if(data.success){
							layer.msg('删除成功', {
							  icon: 1,
							  time: 3000
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
			,btn2: function(index, layero){
				layer.close(index);
			}
			,closeBtn: 0
		});
	});
	var clearShopCar = function(data){
		//清空失效的商品
		$("#clearInvalid").click(function(){
			layer.open({
				 title: '提示信息'
				 ,content:"是否清空已失效的商品?"
				 ,btn:['确认','取消']
				 ,yes: function(index, layero){
					layer.close(index);
					$.ajax({
						url:"busShoppCart/clearShoppCar.do",
						data:data,
						type:"post",
						success:function(data){
							if(data.success){
								layer.msg('清空成功', {
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
				  ,btn2: function(index, layero){
					 layer.close(index);
				  }
				  ,closeBtn: 0
			});
		});
	};
	
	//生成订单
	$("#createOrder").click(function(){
		var orderArray=new Array();
		var flag=0,typeFlag=1,dateFlag=1;
		var array = [];
		$(".moudle").find(".singleCheck:checked").each(function(){
			var order={};
			$(this).parent().find(".buy_amount").find("input").each(function(){
				order["num"]=$(this).val();
			});
			$(this).parent().find(".buytype").each(function(){
				order["type"]=$(this).attr("buytype");
			});
			$(this).parent().parent().find(".wishDate").each(function(){
				order["wishDate"]=$(this).val();
			});
			$(this).parent().parent().find(".input-remark").each(function(){
				order["remark"]=$(this).val();
			});
			$(this).parent().find("input[type=hidden]:eq(0)").each(function(){
				order["tableKey"]=$(this).val();
			});
			$(this).parent().find("input[type=hidden]:eq(1)").each(function(){
				order["minkc"]=$(this).val();
			});
			orderArray.push(order);
			flag=1;
		});
		for(var i in orderArray){
				array.push(orderArray[i].tableKey);
			if(orderArray[i].num < orderArray[i].minkc){
				layer.msg('商品数量小于最小起订量', {
					  icon: 2,
					  time: 2000
				}, function(){
				});
				return;
			}
		}
		if(flag!=1){
			layer.msg('请至少选中一条记录', {
				  icon: 2,
				  time: 2000
			}, function(){
			});
			return;
		}
		
		$.ajax({
			url:"goods/toConfirmOrder.do",
			type:"post",
			data:{"orderArray":array},
			success:function(data){
				location.href="goods/toConfirmOrder.do";
			}
		});
	});
	
	//修改收货地址
	$("#updateAddress").click(function(){
		 $.ajax({
			 url:"busShoppCart/getUserAddress.do",
			 success:function(data){
				 if(data.success){
					 $("#addressTip table").empty();
					 var html1="";
					 html1+="<thead><tr><th>选择</th>";
					 html1+="<th>收货人</th>";
					 html1+="<th>电话号码</th>";
					 html1+="<th>详细地址</th></tr></thead>";	
					 var html2=baidu.template('bd_t2',data);
					 $("#addressTip table").append(html1);
			         $("#addressTip table").append(html2);
			         layer.open({
			        	  type: 1,
			        	  title: ['收货地址', 'font-size:18px;'],
			        	  area: ['70%', '400px'],
			        	  content: $('#addressTip') ,
			        	  btnAlign: 'c',
			        	  btn: ['确认','取消'],
				          yes: function(index, layero){
				           	var addressNo=$("#addressTip input:radio[name='operation']:checked").next().val();
				           	var userName=$("#addressTip input:radio[name='operation']:checked").parent().next().text();
				           	var userPhone=$("#addressTip input:radio[name='operation']:checked").parent().next().next().text();
				           	var userAddress=$("#addressTip input:radio[name='operation']:checked").parent().next().next().next().text();
				           	$("#addressName").text(userName);
				            $("#addressPhone").text(userPhone);
				            $("#address").text(userAddress);	            
				            $("#addressNo").val(addressNo);
				            layer.msg('修改成功', {
								  icon: 1,
								  time: 1000
								}, function(){						
				            	  layer.close(index);
				            	  $("#addressTip").hide();
							});
				          },
				          btn2: function(index, layero){
				        	$("#addressTip").hide();
				        	layer.close(index);
				          },
			        	  cancel: function(){ 
			        		  $("#addressTip").hide();
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
	});
	$(window).scroll(function() {
		fixed(clearHeight);
	});
	
});
//保存商品数量
function numupdate(key,num,minkc){
	$.ajax({
		type: "POST",
		url: "busShoppCart/updateShoppCarNum.do",
		data:{"tableKey":key,"num":num,"minkc":minkc},
		dataTpe:"json",
		success: function(data){
			if(data.msg){
			}else{
				layer.open({
					 title: '错误信息'
					 ,content:data.msg
				}); 
			}
		}
	});
}

function fixed(clear_height){
	var win_height = $(document).scrollTop();//滚动高度
	var height_difference = clear_height-win_height;
	if(height_difference > 700){
		$('.clearing').addClass('fixed-bottom');
		$('.clearing').width($(document).width());
	}else{
		$('.clearing').removeClass('fixed-bottom');
		$('.clearing').width(966);
	}
}

//单选删除
function singleDelete(key){
	layer.open({
		 title: '提示信息'
		 ,content:"是否删除?"
		 ,btn:['确认','取消']
		 ,yes: function(index, layero){
			 layer.close(index);
			 var tableKey=new Array();
			 tableKey.push(key);
			 $.ajax({
					url:"busShoppCart/deleteShoppCar.do",
					data:{"tableKey":tableKey},
					type:"post",
					success:function(data){
						if(!data.success){
							layer.open({
								 title: '错误信息'
								 ,content:data.msg
							}); 
						}else{
							layer.msg('删除成功', {
								  icon: 1,
								  time: 3000
								}, function(){
									location.href="busShoppCart/toShoppCart.do";
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
</script>