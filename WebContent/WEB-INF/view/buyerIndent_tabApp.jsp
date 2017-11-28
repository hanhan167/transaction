<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
 <head>
 <base href="<%=basePath%>" />
 <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>我的订单</title>
    <link rel="stylesheet" type="text/css" href="frame/static/css/shopList.css">
     <link rel="stylesheet" type="text/css" href="frame/static/css/shopwait.css">
</head>
<body>
<div class="header" style="height: 43px">
    <div class="header-box">
        <div class="header-img fl"><img class="l-img returnShopCart"  style='padding-top:11px;' src="frame/static/picture/arrow-white.png"></div>
        <div class="text-tit fl">我的订单</div>
        <div class="clear-box"></div>
    </div>
    <div class="search-terms">
        <div class="terms-box fl on-terms">全部</div>
        <div class="terms-box fl wPayment">待付款</div>
        <div class="terms-box fl">待收货</div>
        <div class="terms-box fl">已完成</div>
        <div class="terms-box fl" style="border-right: none">已取消</div>
        <div class="clear-box"></div>
    </div>
</div>

<div class="mains" style="top: 88px;bottom: 0;overflow-y: auto">
<!-- content += "<div class='moudle'>"; -->
	<div class='moudle'>
		<div class='address-lis'>
			<ul></ul>
		</div>
	</div>
</div>
</body>
</html>

<script type="text/javascript"
	src="frame/static/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="frame/layui/layui.js"></script>
<script type="text/javascript" src="frame/static/js/company.js"></script>
<script type="text/javascript" src="frame/static/layer/mobile/layer.js"></script>
<script type="text/javascript">
	var curr;
	$(function() {
		layui.config({
			dir : 'frame/layui/' //layui.js 所在路径（注意，如果是script单独引入layui.js，无需设定该参数。），一般情况下可以无视
			,
			version : false //一般用于更新模块缓存，默认不开启。设为true即让浏览器不缓存。也可以设为一个固定的值，如：201610
			,
			debug : false //用于开启调试模式，默认false，如果设为true，则JS模块的节点会保留在页面
			,
			base : 'frame/layui/' //设定扩展的Layui模块的所在目录，一般用于外部模块扩展
		});
		//count();
		curr = 1;
		var pageNo = 1;
		var orderStatus = "";
		$(".search-terms>div").click(function() {
			$(".search-terms>div").removeClass("on-terms");
			$(this).addClass("on-terms");
		});
		demo(curr);
		$(".search-terms>div:eq(0)").click(function() {//全部
			demo(curr);
			orderStatus = "";
		});
		/* $(".search-terms>div:eq(1)").click(function() {//待确认
			stateLook(curr, "090001");
			orderStatus = "090001";
		}); */
		$(".search-terms>div:eq(1)").click(function() {//待付款
			stateLook(curr, "090003");
			orderStatus = "090003";
		});
		/* $(".head_tab>ul>li:eq(3)>a").click(function() {//待发货
			stateLook(curr, "090002");
			orderStatus = "090002";
		}); */
		$(".search-terms>div:eq(2)").click(function() {//待收货
			stateLook(curr, "090004");
			orderStatus = "090004";
		});
		$(".search-terms>div:eq(3)").click(function() {//完成
			stateLook(curr, "090005");
			orderStatus = "090005";
		});
		$(".search-terms>div:eq(4)").click(function() {//已取消
			stateLook(curr, "090006");
			orderStatus = "090006";
		});
		
		
	});

	//查找
	/* function seek(pageNo, orderStatus) {
		var query = $(".head_tab>div>input").val();
		$.ajax({
			url : 'busOrder/getBuyerOrders.do',
			type : "post",
			data : {
				"query" : query,
				pageNo : pageNo,
				orderStatus : orderStatus
			},
			beforeSend : function() {
				$(".").html("获取数据中");
			},
			success : function(data) {
				//搜索结果的显示
				if (data.success) {
					display(data, "", query);
				} else {
					layer.open({
						title : '错误信息',
						content : data.msg
					});
				}
			}
		});
	} */

	function demo(curr) {
		$.ajax({
			url : 'busOrder/getBuyerOrdersApp.do',
			data : {
				pageNo : curr || 1
			},
			beforeSend : function() {
				$(".address-lis>ul").html(	 "<div class='warn-box'>"
						+	"<div class='warn-infos'>"        
						+	           "<div class='onload-img'><img src='frame/static/picture/onload.png'></div>" 
						+	            "<div class='warn-texts'>正在努力为您加载!请耐心等待...</div>"
						+	       " </div>"
						+	    "</div>"		);
			},
			success : function(data) {
				if (data.success) {
					display(data, "", "");
				} else {
					layer.open({
						title : '错误信息',
						content : data.msg
					});
				}
			}
		});
	}
	
	function stateLook(curr, orderStatus) {
		$.ajax({
			url : 'busOrder/getBuyerOrdersApp.do',
			data : {
				pageNo : curr || 1,
				orderStatus : orderStatus
			},
			beforeSend : function() {
				$(".address-lis>ul").html(	 
						"<div class='warn-box'>"
						+	"<div class='warn-infos'>"        
						+	           "<div class='onload-img'><img src='frame/static/picture/onload.png'></div>" 
						+	            "<div class='warn-texts'>正在努力为您加载!请耐心等待...</div>"
						+	       " </div>"
						+	    "</div>"		);
			},
			success : function(data) {
				if (data.success) {
					display(data, orderStatus, "");
				} else {
					layer.open({
						title : '错误信息',
						content : data.msg
					});
				}
			}
		});
	}
	
	function display(data, orderStatus, query) {
		$(".address-lis>ul").empty();
		var Row = data.obj;
		var supplyName = [];
		var tmp = [];
		var tmpguan = new Array();
		for ( var i in Row.rows) {
			supplyName.push(Row.rows[i].orderNo);
		}
		for ( var i in supplyName) {
			//该元素在tmp内部不存在才允许追加
			if (tmp.indexOf(supplyName[i]) == -1) {
				tmp.push(supplyName[i]);
			}
		}
		for ( var i in tmp) {
			tmpguan[i] = new Array();
			tmpguan[i].push(tmp[i]);
		}
		for ( var i in tmp) {
			for ( var numerical in Row.rows) {
				if (tmp[i] == Row.rows[numerical].orderNo) {
					tmpguan[i].push(numerical);
				}
			}
		}
		var content = "";
		if (data.obj.count == 0) {
			content += "<div class='warn-box'>";
			content += "<div class='warn-infos'>";
			content += "<div class='order-img'><img src='frame/static/picture/order-img.png'></div>";
			content += "<div class='warn-texts'>你还没有相关订单哦!</div>";
			content += "<div class='href-btn'>去商城逛逛</div>";
			content += "</div>";
			content += "</div>";
		}
		for ( var i in tmpguan) {
			var tradeStus = getOrderStus(Row.rows[tmpguan[i][1]].orderStatus,
					Row.rows[tmpguan[i][1]].updateCustType);
			var quantity = 0;
			var price = parseInt(0);
			
			//content += "<div class='address-lis'>";
			//content += "<ul>";
			content += "<li>";
			content += "<div class='title-infos'>";
			content += "<div class='tit-top'>"; 
			content += "<p>"; 
			content += "<span class='fl' onclick='vendor(\""
					+ Row.rows[tmpguan[i][1]].supplyNo + "\")'>"
					+ Row.rows[tmpguan[i][1]].supperName  +  "</span>";
			
			content += "<span class='fr' style='color: #b2191b'>"
						+ tradeStus
						+ "</span>";
			content += "</p>"; 	
			content += "<p>"; 	
					/* content += "<span class='utel'>"
					+ Row.rows[tmpguan[i][1]].applyPhone + "</span>"; */
			content += "<span class='fl'>订单号:"
						+ Row.rows[tmpguan[i][1]].orderNo + "</span>";
			content += "<span class='fr'>"
					+ new Date(Row.rows[tmpguan[i][1]].insertDate)
							.Format("yyyy-MM-dd") + "</span>";
			content += "</p>"; 	
			content += "</div>";
			content += "<div class='tit-bottom'></div>"; 
			content += "</div>";
				content += "<div class='message infos-details'>";
			for (var num = 1; num < tmpguan[i].length; num++) {
				content += "<div display='none' data-brand='"+Row.rows[tmpguan[i][num]].goodsCode+"'></div>";
				if(Row.rows[tmpguan[i][num]].code==null || Row.rows[tmpguan[i][num]].code=="" || Row.rows[tmpguan[i][num]].code=="null")
				{	
				content += "<div class='li-img fl'>";
				content += "<img>";
				content += "</div>";
				}else{
					content += "<div class='li-img fl'>";
					content += "<img src='http://new.cp2013.com.cn/File/B/"
							+ ((Row.rows[tmpguan[i][num]].code)).substring((Row.rows[tmpguan[i][num]].code).indexOf("-"),(Row.rows[tmpguan[i][num]].code).length)+".jpg'>";
					content += "</div>";
				}
				content +=	"<div class='li-texts fl' style='margin-left: 15px'>";
				content += "<h5>"+Row.rows[tmpguan[i][num]].goodsName
						+ (Row.rows[tmpguan[i][num]].goodsName != null ? Row.rows[tmpguan[i][num]].goodsName
								: '') + "</h5>";
				content += "<p class='num-text' title='"+Row.rows[tmpguan[i][num]].par+"'>"
						+ (Row.rows[tmpguan[i][num]].par != null ? Row.rows[tmpguan[i][num]].par
								: '') + "</p>";
				content += " <p class='one-price'><span>"
						+ Row.rows[tmpguan[i][num]].goodsPrice.toFixed(2)
						+ "</span>"; 
				/* if (Row.rows[tmpguan[i][num]].goodsDiscount == 10) {
					content += "<span class='fs12 vertical-m'>无折扣</span></div>";
				} else {
					content += "<span class='fs12 vertical-m'>"
							+ Row.rows[tmpguan[i][num]].goodsDiscount
							+ "折</span></div>";
				} */
				quantity += Row.rows[tmpguan[i][num]].goodsCount;
				price += parseInt(Row.rows[tmpguan[i][num]].goodsMoney);
				content += "<span>*</span>";
				content += "<span>"
						+ Row.rows[tmpguan[i][num]].goodsCount + "</span>";
				content += "</p>";
				content += "<p class='total-price'><span>合计:</span><span>"
						+ parseInt(Row.rows[tmpguan[i][num]].goodsMoney)
								.toFixed(2) + "</span></p>";
				content +="</div>";		
			/* 	content += "<div class='indent_type'>"
						+ (Row.rows[tmpguan[i][num]].orderType == '091001' ? '试刀'
								: '购买') + "</div>"; */
				content +="<div class='clear-box'></div>";			
				
				
			
			}
			
			content += "<div class='remark-box'>";
			
			content += "<div class='remark-com'>"; 
			content += "<span class='fl'>默认收货时间:</span>"
					+	"<span class='fr' style='margin-right: 2px'>" + Row.rows[tmpguan[i][1]].wishPayDt + "</span>" 
					+ 	"<div class='clear-box'></div>"
					+   "</div>";
					
			
			content += "<div class='remark-com'>"; 
			content += "<span class='fl'>期望收货时间:</span>"
					+	"<span class='fr'>" + Row.rows[tmpguan[i][1]].defaultPayDt + "</span>"
					+ 	"<div class='clear-box'></div>"
					+ 	"</div>";
			
			/*备注*/
			content += "<div class='remark-com'>";
			content += "<span>备注:</span>";	
			content += "<input  type='text' readonly='readonly' style='font-family:Microsoft YaHei; color:gray;' value=' "+(data.map[Row.rows[tmpguan[i][1]].orderNo][0].remark != null ? data.map[Row.rows[tmpguan[i][1]].orderNo][0].remark
					: '')+"' />";
		
					if(Row.rows[tmpguan[i][1]].orderStatus == '090006'){
						
						
						var remark = null;
						if(data.map[Row.rows[tmpguan[i][1]].orderNo].length == 2){
							remark=data.map[Row.rows[tmpguan[i][1]].orderNo][1].remark;
						}
						if(data.map[Row.rows[tmpguan[i][1]].orderNo].length == 3){
							remark=data.map[Row.rows[tmpguan[i][1]].orderNo][2].remark;
						}
						if(remark != null){
						var index = remark.indexOf('】');
						var remarkSubstr1 = remark.substring(0,index+1);
						var remarkSubstr2 = remark.substring(index+1);
						content += "</br><span>取消原因:"+remarkSubstr1+"</span>";
						content += "<input  type='text' readonly='readonly' style='font-family:Microsoft YaHei; color:gray;' value=' "+remarkSubstr2+"' />";
						}
						
						
					}	
		
		
			
			content+= "<div class='clear'><input type='hidden' value="+Row.rows[tmpguan[i][1]].orderStatus+"></div></div>"; 
			content+= "<div class='clear-box'></div>";
			content+="</div>";
			content+= "<div class='clear-box'></div>";
			content+="</div>";
			
			
			if (Row.rows[tmpguan[i][1]].orderStatus == '090001') {//待确认
				content += "<div class='btns-box'>";
				content += "<div class='fr'>";
				content += "<span style='margin-right: 12px;' onclick=cancelOrder(\'"
						+ Row.rows[tmpguan[i][1]].orderNo
						+ "\',\'"
						+ Row.rows[tmpguan[i][1]].orderType
						+ "\',this)>取消订单</span>";
				content += "</div>";
				content += "</div>";
			} else if (Row.rows[tmpguan[i][1]].orderStatus == '090003') {//待付款
				content += "<div class='btns-box' data-supplyNo="+Row.rows[tmpguan[i][1]].supplyNo+">";
				content += "<div class='fr'>";
				content += "<span   onclick=cancelOrder(\'"
						+ Row.rows[tmpguan[i][1]].orderNo
						+ "\',\'"
						+ Row.rows[tmpguan[i][1]].orderType
						+ "\',this)>取消订单</span>";
				content += "<span class='on-red' onclick=invoice(\'"
						+ Row.rows[tmpguan[i][1]].orderNo
						+ "\',"
						+ price
						+ ",this)>确认付款</span>";
				content += "</div>";
				content += "</div>";
			} else if (Row.rows[tmpguan[i][1]].orderStatus == '090004') {//待收货
				content += "<div class='btns-box'>";
				content += "<div class='fr'>";
				content += "<span class='my_link' style='color: #333333;'  onclick=lookWlMsg(\'"
						+ Row.rows[tmpguan[i][1]].lgtNums
						+ "\',this)>查看物流信息</span>"; 
				content += "<span class='on-red'  onclick=operatorOrder(\'"
						+ Row.rows[tmpguan[i][1]].orderNo
						+ "\',this)>确认收货</span>";
				content += "</div>";
				content += "</div>";
				content += "<div class='myLgtMsg' id=\'"+Row.rows[tmpguan[i][1]].orderNo+"\'></div>";
			} else if (Row.rows[tmpguan[i][1]].orderStatus == '090006') {//取消
				content += "<div class='btns-box'>";
				content += "<div class='fr'>";
				content += "<span  onclick=againPurchase('"
						+ Row.rows[tmpguan[i][1]].orderNo
						+ "','"
						+ Row.rows[tmpguan[i][1]].supplyNo
						+ "',this)>继续购买</span>";
				content += "<span  class='on-red' onclick=deleteOrder(\'"
						+ Row.rows[tmpguan[i][1]].orderNo
						+ "',this\)>删除订单</span>";
				content += "</div>";
				content += "</div>";
			} else if (Row.rows[tmpguan[i][1]].orderStatus == '090005') {//完成
				content += "<div class='btns-box'>";
				content += "<div class='fr'>";
				content += "<span  class='on-red' onclick=againPurchase('"
						+ Row.rows[tmpguan[i][1]].orderNo
						+ "','"
						+ Row.rows[tmpguan[i][1]].supplyNo
						+ "',this)>再次购买</span>";
				content += "</div>";
				content += "</div>";
			}
			//content += "</ul>";
			//content += "</div>";
		}
		$(".address-lis>ul").append(content);

		var totalPage = Math.ceil(eval(data.obj.total / data.obj.pageSize));
		//显示分页
/* 		layui.use([ 'laypage', 'layer' ], function() {
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
		}); */ 
	}
	function count() {
		$.ajax({
			url : 'busOrder/getBuyerOrderCount.do',
			success : function(data) {
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
		return tradeStus;
	}
	//填写发票信息
	/* function invoiceInformation(orderNo, price, remark) {
		layer.open({
			title : '发票信息',
			type : 2,
			content : 'busOrder/borderBill.do?orderNo=' + orderNo
					+ '&billMoney=' + price + '&remark=' + remark,
			area : [ '800px', '600px' ],
		});
	} */
	
	//确认付款
	function invoice(orderNo, price, element) {
		var remark;
		$(element).parent().parent().parent().find("input[type='text']").each(
				function() {
					remark = $(this).val();
				});
		var supplyNo = $(element).parent().parent().attr("data-supplyno");
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
										layer.open(	
										{
											content:'操作成功',
										    end:function() {
												stateLook(
														curr,
														"090003");
												orderStatus = "090003";
												//location.reload();
												count();
											}
										}
										);	
									}else {
										layer.open({
											title : '错误信息',
											content : data.msg
													});
									}
								}
							});
						}
					}
				});
		/*  */
	}
	//确认收货
	function operatorOrder(orderNo, element) {
		var remark;
		$(element).parent().parent().parent().find("input[type='text']").each(
				function() {
					remark = $(this).val();
				});
		$.ajax({
			url : 'busOrder/orderOperator.do',
			type : 'post',
			data : {
				"remark" : remark,
				"orderNo" : orderNo
			},
			success : function(data) {
				if (data.success) {
					layer.open(
					{
						content:'操作成功',
						end:function() {
							stateLook(curr, "090004");
							orderStatus = "090004";
							count();
										}
					}
							)
				} else {
					layer.open({
						title : '错误信息',
						content : data.msg
					});
				}
			}
		});
	};
	
	//删除订单
	function deleteOrder(orderNo, element) {
		var orde = $(element).parent().parent().prev().find(".clear>input").val();
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
						"type" : "1"
					},
					type : 'post',
					success : function(data) {
						if (data.success) {
							count();
							layer.open(
							{
								content:'操作成功',
								end:function(){
									stateLook(curr, orde);
											  }
							}
									)
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
	};
	function vendor(val) {
		location.href = "/portal/commercial_particulars.jsp?key=" + val;
	}
	//取消订单
	function cancelOrder(orderNo, orderType, element) {
		var orde = $(element).parent().parent().prev().find(".clear>input").val();
		layer
				.open({
					title : '请填写取消原因',
					content : "<select class='cause'><option>协商取消订单</option><option>交期时间有问题</option><option>商品价格不符合预期</option><option>其他</option></select>"
							+ "<input class='cause' placeholder='请输入取消的原因' maxlength='150'>",
					btn : [ '确认', '取消' ],
					yes : function(index, layero) {
						$.ajax({
							url : 'busOrder/cancelOrder.do',
							data : {
								"orderNo" : orderNo,
								"dealType" : "cancel",
								"orderType" : orderType,
								"remark" : "【" + $("select option:selected").text()
										+ "】" + $("input.cause").val(),
								"statusWay" : "0",
							},
							dataType : "json",
							type : 'post',
							success : function(data) {
								if (data.success) {
									count();
									layer.open({
									 content:'操作成功',
									 end:function(){
										 stateLook(curr, orde);
									 				}
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
	
	//再次购买
	function againPurchase(Row, supplyNo, element) {
		var brands = "";
		$(element).parent().parent().prev().children("div[display='none']").each(function(){
			brands += $(this).attr("data-brand") + ",";
		});
		$.ajax({
			url : "busShoppCart/buyAgain.do",
			data : {
				"orderNo" : Row,
				"brand" : brands,
				"supplyNo" : supplyNo
			},
			type : "post",
			success : function(data) {
				if (data.success) {
					layer.open({
						title : '',
						content : data.msg
					});
					location.href = "busShoppCart/toShoppCartApp.do";
				} else {
					layer.open({
						title : '错误信息',
						content : data.msg
					});
				}
			}
		});
	}
	
	Date.prototype.Format = function(fmt) { //author: meizz 
		var o = {
			"M+" : this.getMonth() + 1, //月份 
			"d+" : this.getDate(), //日 
			"h+" : this.getHours(), //小时 
			"m+" : this.getMinutes(), //分 
			"s+" : this.getSeconds(), //秒 
			"q+" : Math.floor((this.getMonth() + 3) / 3), //季度 
			"S" : this.getMilliseconds()
		//毫秒 
		};
		if (/(y+)/.test(fmt))
			fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "")
					.substr(4 - RegExp.$1.length));
		for ( var k in o)
			if (new RegExp("(" + k + ")").test(fmt))
				fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k])
						: (("00" + o[k]).substr(("" + o[k]).length)));
		return fmt;
	}
	
	//显示部分物流信息
	var myData;
	var myDivId;
	function lookWlMsg(str, that) {
		event.stopPropagation();
		myDivId = $(that).parent().next().attr('id');
		
		$modal = $('#'+ myDivId);
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
						$modal.html(
						
						);
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
							html += "<li>" + "<a id='my_a' style='color: red;' onclick='showAll(this)'>查看详情</a>" + "</li>";
						} else {
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
		var $modal = $('#'+myDivId);
		$modal.show();
		var $info = $('#info'), html = '';
		if (myData.status === '0' && myData.msg === 'ok') {
			var r = myData.result, list = r.list, result = r.issign === '1' ? '已签收'
					: '未签收';
			html += '<li style="color: red;">物流状态：' + result + '</li>';
			html += "<li>" + findSth(r.type) + "&nbsp;&nbsp;&nbsp;";
			html += "运单号：" + r.number + "</li>";
			for (var i = 0; i < list.length ; i++) {
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
		e.stopPropagation();
		$(that).parent().siblings('#'+ myDivId).show();
	});
	
	
	$(document).on('click', function() {
		$('.myLgtMsg').hide();
	});

	$(document).on('click','.myLgtMsg',function(e) {
	 e.stopPropagation();
	 });
	
</script>