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
			<div class="head_tab" style="margin: -30px 0 31px 7px;">
				<ul>	
					<li><a style="width: 120px;">未开发票（<span id="supplyNoInvoice"></span>）
					</a></li>
					<li><a style="width: 120px;">已开发票（<span id="supplyOpenInvoice"></span>）
					</a></li>
					<li><a>开票
					</a></li>
					<li><a>设置
					</a></li>
				</ul>
				<div class="clear"></div>
			</div>
			<div class="header myOnlyheader" style="height: 50px;">
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
<script type="text/javascript" src="frame/static/js/jQuery-jcDate.js"></script>
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
		
		$(".head_tab>ul>li:eq(0)").click(function() {//未打印订单
			$('div.myOnlyheader').show();
			stateLook(curr, "090005");
			orderStatus = "090005";
		});
		
		$(".head_tab>ul>li:eq(1)").click(function() {//已打印订单
			
			$('div.myOnlyheader').hide();
			stateLook(curr, "090005","001");
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
	
	function stateLook(curr,orderStatus, invoiceStatus) {
		$.ajax({
			url : 'busOrder/getSupplyOrdersInvoic.do',
			data : {
				pageNo : curr || 1,
				invoiceStatus : invoiceStatus
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
					+ new Date(Row.rows[tmpguan[i][1]].insertDate).Format("yyyy-MM-dd hh:mm:ss")
							 + "</span>";
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
			if (Row.rows[tmpguan[i][1]].orderStatus == '090005') {
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
			url : 'busOrder/getApplyOrderCountInvoice.do',
			success : function(data) {
				$("#supplyNoInvoice").text(data.obj.supplyNoInvoice);
				$("#supplyOpenInvoice").text(data.obj.supplyOpenInvoice);
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