<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css"
	href="frame/static/css/commonality.css" />
<link rel="stylesheet" type="text/css" href="frame/layui/css/layui.css" />
<link rel="stylesheet" type="text/css"
	href="frame/static/css/indentIndent.css" />
<title>供方发票管理</title>
<style type="text/css">
.uname {
	color: blue;
}

.label {
	display: inline-block;
	text-align: right;
	width: 100px;
}
.invoice{
    margin: 0 0 50px 0;
}
.invoice li{
	float: left;
    margin-right: 14px;
    border-right: 1px solid rgb(210, 210, 210);
    padding-right: 14px;
}
.invoice li>a{
    display: inline-block;
    width: 100px;
    height: 30px;
    border-radius: 3px;
    line-height: 30px;
    text-align: center;
}
</style>
</head>
<body>
	<!--顶部-->
	<div class="head">
		<jsp:include page="head.jsp" flush="true" />
	</div>

	<!-- 中间的内容 -->
	<div class="centre">
		<div class="content">
		<ul class="invoice">
					<li ><a>未开发票（<span id="all"></span>）
					</a></li>
					<li><a>已开发票（<span id="confirmed"></span>）
					</a></li>
					<li><a>开票
					</a></li>
					<li><a>设置
					</a></li>
					
		</ul>
			<div class="header" style="height: 50px;">
				<label class="all_check"><input type="checkbox" style='margin-left: 2%;margin-top: 2%;'>全选</label>
				<button type='button' class='cancel_indent' style=" float: right;margin-top: 5px;margin-right: 15px;background-color: #03a1a4;color: #FFFFFf;">开发票</button>
			</div>	
			<div class="header">
					<span class="buyerIndex_name">商品</span> <span class="indent_price">单价（元）</span>
					<span class="indent_quantity">数量</span> <span
						class="indent_aggregate">小计（元）</span> <span class="indent_type">类型</span>
					<span class="indent_operation">交易状态</span>
			</div>
			<!-- 显示 -->
			<div class="show">
			
				<!-- 内容 -->
				<div class="sheet">
					<!-- 内容显示 -->

				</div>
				<div id="demo"></div>
			</div>
		</div>
	</div>

	<!--底部-->
	<div class="base">
		<jsp:include page="base.jsp" flush="true" />
	</div>

</body>
</html>
<script type="text/javascript"
	src="frame/static/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="frame/layui/layui.js"></script>
<script type="text/javascript" src="frame/static/layer/layer.js"></script>
<script type="text/javascript" src="frame/static/js/company.js"></script>
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
		count();
		curr = 1;
		var pageNo = 1;
		var orderStatus = "";
		$(".head_tab>ul>li").click(function() {
			$(".head_tab>ul>li").removeClass("choice");
			$(this).addClass("choice");
		});
		/* if($("#loginName0").text()!=""){demo(curr);} */
		stateLook(curr, "090005");
	
		$(".head_tab>ul>li:eq(5)>a").click(function() {//完成
			stateLook(curr, "090005");
			orderStatus = "090005";
		});
		
	});


/* 	function demo(curr) {
		$.ajax({
			url : 'busOrder/getBuyerOrders.do',
			data : {
				pageNo : curr || 1
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
	} */
	
	function stateLook(curr, orderStatus) {
		$.ajax({
			url : 'busOrder/getBuyerOrders.do',
			data : {
				pageNo : curr || 1,
				orderStatus : orderStatus
			},
			beforeSend:function(){
				$(".sheet").html("获取数据中");
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
		$(".sheet").empty();
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
			content += "<div class='moudleNull'>";
			content += "没有相应的订单";
			content += "</div>";
		}
		for ( var i in tmpguan) {
			var tradeStus = getOrderStus(Row.rows[tmpguan[i][1]].orderStatus,
					Row.rows[tmpguan[i][1]].updateCustType);
			var quantity = 0;
			var price = parseInt(0);
			content += "<div class='moudle'>";
			content += "<div class='line'>";
			content += "<input type='checkbox' class='vertical-m'>";
			content += "<span class='uname' onclick='vendor(\""
					+ Row.rows[tmpguan[i][1]].supplyNo + "\")'>卖家："
					+ Row.rows[tmpguan[i][1]].supperName + "</span>";
			content += "<span class='utel'>"
					+ Row.rows[tmpguan[i][1]].applyPhone + "</span>";
			content += "<span class='udate right'>下单时间："
					+ new Date(Row.rows[tmpguan[i][1]].insertDate)
							.Format("yyyy-MM-dd hh:mm:ss") + "</span>";
			content += "<span class='uindent right'>订单编号："
					+ Row.rows[tmpguan[i][1]].orderNo + "</span>";
			content += "</div>";
			for (var num = 1; num < tmpguan[i].length; num++) {
				content += "<div class='message' data-brand='"+Row.rows[tmpguan[i][num]].goodsCode+"'>";
				content += "<div class='buyerIndex_name'><p title='"+Row.rows[tmpguan[i][num]].goodsName+"'>"
						+ (Row.rows[tmpguan[i][num]].goodsName != null ? Row.rows[tmpguan[i][num]].goodsName
								: '') + "</p>";
				content += "<p title='"+Row.rows[tmpguan[i][num]].par+"'>"
						+ (Row.rows[tmpguan[i][num]].par != null ? Row.rows[tmpguan[i][num]].par
								: '') + "</p></div>";
				content += "<div class='indent_price'><span class='fs14 vertical-m'>"
						+ Row.rows[tmpguan[i][num]].goodsPrice.toFixed(2)
						+ "</span><br/>";
				if (Row.rows[tmpguan[i][num]].goodsDiscount == 10) {
					content += "<span class='fs12 vertical-m'>无折扣</span></div>";
				} else {
					content += "<span class='fs12 vertical-m'>"
							+ Row.rows[tmpguan[i][num]].goodsDiscount
							+ "折</span></div>";
				}
				quantity += Row.rows[tmpguan[i][num]].goodsCount;
				price += parseInt(Row.rows[tmpguan[i][num]].goodsMoney);
				content += "<div class='indent_quantity'>"
						+ Row.rows[tmpguan[i][num]].goodsCount + "</div>";
				content += "<div class='indent_aggregate'>"
						+ parseInt(Row.rows[tmpguan[i][num]].goodsMoney)
								.toFixed(2) + "</div>";
				content += "<div class='indent_type'>"
						+ (Row.rows[tmpguan[i][num]].orderType == '091001' ? '试刀'
								: '购买') + "</div>";
				content += "<div class='indent_operation'><p class='fs14 margin-bottom-5'>"
						+ tradeStus
						+ "</p><a href='javascript:;' style='display:none;' class='fs12 margin-bottom-5'>订单详情</a><a style='display:none;' href='javascript:;' class='fs12'>查看物流</a></div>";
				content += "</div>";
			}
			content += "<div class='row'>";
			content += "<span class='font-888'>期望到货时间："
					+ Row.rows[tmpguan[i][1]].wishPayDt + "</span>";
			content += "<span class='delivery_date font-888'>预期收货时间："
					+ Row.rows[tmpguan[i][1]].defaultPayDt + "</span>";
			content += "</div>";
			if (Row.rows[tmpguan[i][1]].orderStatus == '090001') {
				content += "<div class='row text-bar-right'>";
				content += "<span>总计：<em>￥" + price + "</em></span>";
				content += "<button type='button' class='affirm_indent' onclick=cancelOrder(\'"
						+ Row.rows[tmpguan[i][1]].orderNo
						+ "\',\'"
						+ Row.rows[tmpguan[i][1]].orderType
						+ "\',this)>取消订单</button>";
				content += "</div>";
			} else if (Row.rows[tmpguan[i][1]].orderStatus == '090003') {
				content += "<div class='row text-bar-right' data-supplyNo="+Row.rows[tmpguan[i][1]].supplyNo+">";
				content += "<span>总计：<em>￥" + price + "</em></span>";
				content += "<button type='button' class='cancel_indent' onclick=cancelOrder(\'"
						+ Row.rows[tmpguan[i][1]].orderNo
						+ "\',\'"
						+ Row.rows[tmpguan[i][1]].orderType
						+ "\',this)>取消订单</button>";
				content += "<button type='button' class='affirm_indent' onclick=invoice(\'"
						+ Row.rows[tmpguan[i][1]].orderNo
						+ "\',"
						+ price
						+ ",this)>确认付款</button>";
				content += "</div>";
			} else if (Row.rows[tmpguan[i][1]].orderStatus == '090004') {
				content += "<div class='row text-bar-right'>";
				content += "<a class='my_link' herf='javascript:void(0)'  onclick=lookWlMsg(\'"
						+ Row.rows[tmpguan[i][1]].lgtNums
						+ "\',this)>查看物流信息</a>";
				content += "<span>总计：<em>￥" + price + "</em></span>";
				content += "<button type='button' class='affirm_indent' onclick=operatorOrder(\'"
						+ Row.rows[tmpguan[i][1]].orderNo
						+ "\',this)>确认收货</button>";
				content += "</div>";
				content += "<div class='myLgtMsg' id=\'"+Row.rows[tmpguan[i][1]].orderNo+"\'></div>";
			} else if (Row.rows[tmpguan[i][1]].orderStatus == '090006') {
				content += "<div class='row text-bar-right'>";
				content += "<span>总计：<em>￥" + price + "</em></span>";
				content += "<button type='button' class='cancel_indent' onclick=againPurchase('"
						+ Row.rows[tmpguan[i][1]].orderNo
						+ "','"
						+ Row.rows[tmpguan[i][1]].supplyNo
						+ "',this)>继续购买</button>";
				content += "<button type='button' class='affirm_indent' onclick=deleteOrder(\'"
						+ Row.rows[tmpguan[i][1]].orderNo
						+ "',this\)>删除订单</button>";
				content += "</div>";
			} else if (Row.rows[tmpguan[i][1]].orderStatus == '090005') {
				content += "<div class='row text-bar-right'>";
				content += "<span>总计：<em>￥" + price + "</em></span>";
				content += "</div>";
			}
			content += "</div>";
		}
		$(".sheet").append(content);

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
	
	//付款
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
	function operatorOrder(orderNo, element) {
		var remark;
		$(element).parent().parent().find("input[type='text']").each(
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
					layer.msg('操作成功', {
						icon : 1,
						time : 2000
					}, function() {
						stateLook(curr, "090004");
						orderStatus = "090004";
						count();
					});
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
						"type" : "1"
					},
					type : 'post',
					success : function(data) {
						if (data.success) {
							count();
							layer.msg('操作成功', {
								icon : 1,
								time : 2000
							}, function() {
								stateLook(curr, orde);
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
	};
	/* 点击顶部全选 */
	$(".header input[type=checkbox]").click(function(){command(this);});
	/*点击全选选中取消全选*/
	function command(place){
		if($(place).is(':checked')){
			$("input[type='checkbox']").prop("checked", true);
		}else{
			$("input[type='checkbox']").prop("checked", false);
		}
	}
	function vendor(val) {
		location.href = "/portal/commercial_particulars.jsp?key=" + val;
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
										+ "," + $("input.cause").val(),
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
										stateLook(curr, orde);
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
		$(element).parents(".moudle").find(".message").each(function() {
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
					location.href = "busShoppCart/toShoppCart.do";
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
		alert(myDivId);
		console.log(myDivId);	
		console.log(str);
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
	})

	$(document).on('click','.myLgtMsg',function(e) {
	 e.stopPropagation();
	 });
</script>