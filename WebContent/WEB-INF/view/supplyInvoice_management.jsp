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
<link rel="stylesheet" type="text/css" href="frame/static/css/invoiceMask.css">
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
	
	<div class="mask">
		<input type="hidden" class="sendDate">
	</div>

	<!-- 显示输入框 -->
  	<div class="mask-contents myWriteMsg" style="display:none; margin-top: 6%;height: 40%;">
    <div class="tits-box">设置
      <!--   <img src="frame/static/picture/shut.png"> -->
    </div>
   	<div style="height: 16%;"></div>
    <div class="select-box" style="height: 223px;">
        <table cellpadding="0" cellspacing="0" class="fl tab2" style="margin-left: 18%;height: 247px;">
            <tr>
                <td style="text-align: center;"><span></span>预期发票到货时间(天):</td>
                <td class="td-items"><input type="text" name="arriveTime" placeholder="请输入预期发票到货时间(天)"></td>
            </tr>
            <tr>
                <td style="text-align: center;"><span></span>最低开票金额(元):</td>
                <td class="td-items"><input type="text" name="openTicketBalance" placeholder="请输入最低开票金额(元)"></td>
            </tr>
            <tr>
                <td colspan="3" class="btn-td"><span id="goBackSetting">取消</span><span id="saveSetting">确认</span></td>
            </tr>
        </table>
        <div class="clear-box"></div>
    </div>
	</div>
	
	
	
	
	<!--1-->
	<div class="mask-contents mask1" style="display:none">
    <div class="tits-box">开发票
        <img src="frame/static/picture/shut.png">
    </div>
    <div class="inv-flow">
        <div class="nums fl"><span class="textsNum check-col">1</span><span class="textsp span-col">设置发票类型</span></div>
        <div class="lines fl"></div>
        <div class="nums fl"><span class="textsNum">2</span><span class="textsp">填写发票信息</span></div>
        <div class="lines fl"></div>
        <div class="nums fl"><span class="textsNum">3</span><span class="textsp">填写收票地址</span></div>
    </div>
    <div class="select-box">
        <div class="tits-sel">设置发票类型(以下均为必填项)</div>
        <table cellpadding="0" cellspacing="0" class="fl tab1">
            <tr class="fpsz">
                <td class="tit-td"><span>*</span>发票设置:</td>
                <td class="td-items zzfp"><span>纸质发票<img src="frame/static/picture/select-frame.png"></span></td>
                <td class="td-items dzfp"><span>电子发票</span></td>
            </tr>
            <tr class="fplx">
                <td class="tit-td"><span>*</span>发票类型:</td>
                <td class="td-items ptfp"><span>普通发票</span></td>
                <td class="td-items zzsfp"><span>增值税发票</span></td>
            </tr>
            <tr class="fptt">
                <td class="tit-td"><span>*</span>发票抬头:</td>
                <td class="td-items gr"><span>个人</span></td>
                <td class="td-items dw"><span>单位</span></td>
            </tr>
            <tr>
                <td colspan="3" class="btn-td"><span id="btn-next1" style="background-color: #26c4c7;color: #FFFFFF;">下一步</span></td>
            </tr>
        </table>
        <div class="clear-box"></div>
    </div>
</div>

<!--2-->
<div class="mask-contents mask2" style="display:none">
    <div class="tits-box">开发票
        <img src="frame/static/picture/shut.png">
    </div>
    <div class="inv-flow">
        <div class="nums fl"><span class="textsNum check-col">1</span><span class="textsp span-col">设置发票类型</span></div>
        <div class="lines fl check-line"></div>
        <div class="nums fl"><span class="textsNum check-col">2</span><span class="textsp span-col">填写发票信息</span></div>
        <div class="lines fl"></div>
        <div class="nums fl"><span class="textsNum">3</span><span class="textsp">填写收票地址</span></div>
    </div>
    <div class="select-box">
        <div class="tits-sel">填写发票信息(带<span style="color: #d5090c">*</span>号为必填项)</div>
        <table cellpadding="0" cellspacing="0" class="fl tab2">
            <tr>
                <td class="tit-td"><span></span>单位名称:</td>
                <td class="td-items"><input type="text" name="companyName" placeholder="请输入单位名称"></td>
            </tr>
            <tr>
                <td class="tit-td"><span></span>纳税人识别号:</td>
                <td class="td-items"><input type="text" name="billReceipt" placeholder="请输入纳税人识别号"></td>
            </tr>
            <tr>
                <td class="tit-td"><span></span>注册地址:</td>
                <td class="td-items"><input type="text" name="registerAddress" placeholder="请输入详细地址"></td>
            </tr>
            <tr>
                <td class="tit-td"><span></span>注册电话:</td>
                <td class="td-items"><input type="text" name="registerPhone" placeholder="请输入注册电话"></td>
            </tr>
            <tr>
                <td class="tit-td"><span></span>开户银行:</td>
                <td class="td-items"><input type="text" name="openBand" placeholder="请输入开户银行"></td>
            </tr>
            <tr>
                <td class="tit-td"><span></span>银行账号:</td>
                <td class="td-items"><input type="text" name="bandCard" placeholder="请输入银行账户"></td>
            </tr>
            <tr>
                <td colspan="3" class="btn-td"><span id="btn-back1">上一步</span><span id="btn-next2">下一步</span></td>
            </tr>
        </table>
        <div class="clear-box"></div>
    </div>
</div>
<!--3-->
<div class="mask-contents mask3" style="display:none">
    <div class="tits-box">开发票
        <img src="frame/static/picture/shut.png">
    </div>
    <div class="inv-flow">
        <div class="nums fl"><span class="textsNum check-col">1</span><span class="textsp span-col">设置发票类型</span></div>
        <div class="lines fl check-line"></div>
        <div class="nums fl"><span class="textsNum check-col">2</span><span class="textsp span-col">填写发票信息</span></div>
        <div class="lines fl check-line"></div>
        <div class="nums fl"><span class="textsNum check-col">3</span><span class="textsp span-col">填写收票地址</span></div>
    </div>
    <div class="select-box">
        <div class="tits-sel">填写收藏地址(带<span style="color: #d5090c">*</span>号为必填项)</div>
        <table cellpadding="0" cellspacing="0" class="fl tab2">
            <tr>
                <td class="tit-td"><span>*</span>收票人姓名:</td>
                <td class="td-items"><input type="text" name="billReceiveName" placeholder="请输入收款人姓名"></td>
            </tr>
            <tr>
                <td class="tit-td"><span>*</span>收票人手机:</td>
                <td class="td-items"><input type="text" name="billReceivePhone" placeholder="请输入收票人手机"></td>
            </tr>
            <tr>
                <td class="tit-td"><span>*</span>收票人邮箱:</td>
                <td class="td-items"><input type="text" name="billReceiveMail"  placeholder="请输入收票人邮箱(电子发票必填)"></td>
            </tr>
            <tr>
                <td class="tit-td"><span>*</span>详细地址:</td>
                <td class="td-items"><input type="text" name="billReceiveAddress" placeholder="请输入详细地址"></td>
            </tr>
            <tr>
                <td colspan="3" class="btn-td"><span id="btn-back2">上一步</span><span id="btn-sumit">提交</span></td>
            </tr>
        </table>
        <div class="clear-box"></div>
    </div>
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
					<li><a style="width: 120px;">去开票
					</a></li>
					<li><a style="width: 120px;">设置
					</a></li>
				</ul>
				<div class="clear"></div>
			</div>
			<div class="header myOnlyheader" style="height: 50px;">
				<label class="all_check"><input type="checkbox" style='margin-left: 2%;margin-top: 2%;'>全选</label>
				<button type='button' class='cancel_indent goDrawing' style=" float: right;margin-top: 5px;margin-right: 15px;background-color: #03a1a4;color: #FFFFFf;">开发票</button>
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
		invoiceStatus = "";
		
		$(".head_tab>ul>li").click(function() {
			$(".head_tab>ul>li").removeClass("choice");
			$(this).addClass("choice");
		});
		/* if($("#loginName0").text()!=""){demo(curr);} */
		stateLook(curr);
		
		$(".head_tab>ul>li:eq(0)").addClass("choice");
		$(".head_tab>ul>li:eq(0)>a").click(function() {//未打印订单
			$('div.myOnlyheader').show();
			stateLook(curr);
		});
		
		$(".head_tab>ul>li:eq(1)>a").click(function() {//已打印订单
			
			$('div.myOnlyheader').hide();
			stateLook(curr,"001");
			invoiceStatus = "001";
			
		});
		
		$(".head_tab>ul>li:eq(2)>a").click(function() {//去开票
			
			location.href="sys/toOpenTick.do";
			
		});
		
		
		$(".head_tab>ul>li:eq(3)>a").click(function() {//设置
			
			$.ajax({
				url:'busOrder/getLimitPrice.do',
				beforeSend:function(){
					$(".sheet").html("获取数据中");
				},
				success:function(data){
					$("input[name=arriveTime]").val(data.obj.billArriveDate);
					$("input[name=openTicketBalance]").val(data.obj.limitPrice);//parseInt(data.obj.limitPrice).toFixed(2)
					
				}
			});
			$(".mask").show();
			$(".myWriteMsg").show();
		});
		
	});



	
	function stateLook(curr, invoiceStatus) {
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
					display(data, "090005", "");
				} else {
					layer.open({
						title : '错误信息',
						content : data.msg
					});
				}
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
			if(Row.rows[tmpguan[i][1]].invoicStatus!='001')
			{	
			content += "<input type='checkbox' class='vertical-m chooseGoOpen'>";
			}
			content+="<input type='hidden' value='"+Row.rows[tmpguan[i][1]].custNo+"'>";
			content+="<span class='uname'>买家："+Row.rows[tmpguan[i][1]].custName+"</span>";
			content+="<span class='utel'>"+Row.rows[tmpguan[i][1]].custPhone+"</span>";		
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
				/* 		} else if (query != "") {
							seek(obj.curr, invoiceStatus); */
						} else {
							stateLook(obj.curr, invoiceStatus);
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
	
	//显示对应的开发票信息
	function showGoDrawing(){
		$(".mask").show();
		$(".mask1").show();
	}
	
	//开发票操作
	$(".goDrawing").click(function(){
		//长度
		var clength=$('.chooseGoOpen:checked').length;
		var nameArr = new Array(clength);
		var	priceArr = new Array(clength);
		var z = 0;
		var custNo = null;
		$($('.chooseGoOpen:checked').siblings(".uname")).each(function(){
			custNo = $(this).prev().val();
			nameArr[z] = $(this).text().substring(3);
			
			priceArr[z] = $(this).parent().parent().find("em").text().substring(1);
			z++;
		});
		//没有选择买家
		if(clength == 0){
			layer.msg('请选择买家', {
				icon: 2,
				time: 1500
			});
			return;
		}
		//选择多个买家
		for (var int = 1; int < nameArr.length; int++) {
			if(nameArr[0] != nameArr[int]){
				layer.msg('请选择相同买家</br>已选择：</br>【'+nameArr[0]+'】</br>【'+nameArr[int]+'】', {
					icon: 2,
					time: 3000
				});
				return;
			}
		}
		//判断已选择订单的金额
		 $.ajax({
		    	url:"busOrder/getSupplyInvoicArr.do",
		    	type:"post",
		    	dataType: "json", 
		    	async : false,
		        cache : false,
		        traditional: true,
		    	data:{
		    		 priceArr :priceArr,
		    		 nameArr :nameArr,
		    	},
		    	success:function(data){
		    		if(data.success){
						showGoDrawing();
		    		}else{
		    			layer.open({
		    				title:'提示'
		    				,content:data.msg+'</br> 是否继续'
		    				,btn:['继续','取消']
		    				,yes:function(index,layero){
		    					layer.close(index);
		    					showGoDrawing();
		    				}
		    			});
		    		}
		    		
		    	},
		    });
		
		 $.ajax({
				url:'busOrder/getByIds.do?custNo='+custNo,
				success:function(data){
					if(data.success&&data.obj!=null){
						$("[name='billReceipt']").val(data.obj.billReceipt);//纳税人识别号
						$("[name='billReceivePhone']").val(data.obj.billReceivePhone);//收票人手机号
						$("[name='billReceiveAddress']").val(data.obj.billReceiveAddress);//收票人地址
						$("[name='billStatus']").val(data.obj.billStatus);//发票状态
						$("[name='companyName']").val(data.obj.companyName);//单位名称
						$("[name='registerAddress']").val(data.obj.registerAddress);//单位注册地址
						$("[name='registerPhone']").val(data.obj.registerPhone);//单位注册手机号码
						$("[name='openBand']").val(data.obj.openBand);//开户行
						$("[name='bandCard']").val(data.obj.bandCard);//银行卡
						$("[name='billReceiveName']").val(data.obj.billReceiveName);//收票人姓名
						$("[name='billReceiveMail']").val(data.obj.billReceiveMail);//收票人邮箱
					}
				}
			});

	});
	
	
	
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
	});

	$(document).on('click','.myLgtMsg',function(e) {
	 e.stopPropagation();
	 });
	
</script>

<script>
$(window).scroll(function () {
    var scrollht = $(document).scrollTop();
    var curht = $(window).height();
    var curmaskHt = scrollht + curht;
    if (curmaskHt > curht) {
        $(".mask").css("height", curmaskHt);
    }
    else {
        $(".mask").css("height", "100%");
    }
});

$(".tits-box img").click(function () {
    $(".mask").hide();
    $(".mask-contents").hide();
});

$("#btn-back1").click(function () {
    $(".mask1").show();
    $(".mask2").hide();
    $(".mask3").hide();
});

$("#btn-back2").click(function () {
    $(".mask2").show();
    $(".mask1").hide();
    $(".mask3").hide();
});

$('#btn-next1').click(function () {
	if(billNatrue==null || billType==null || billTitle==null)
	{
		layer.msg('必选项未选择', {
			icon: 2,
			time: 1500
		});
		
		return;
	}
	else if(billType=="01") 
    {
    	$(".mask2>.select-box>.tab2>tbody>tr:eq(0)>td:eq(0)>span").html("*");
    	$(".mask2>.select-box>.tab2>tbody>tr:eq(1)>td:eq(0)>span").html("*");
    	$(".mask2>.select-box>.tab2>tbody>tr:eq(2)>td:eq(0)>span").html("");
    	$(".mask2>.select-box>.tab2>tbody>tr:eq(3)>td:eq(0)>span").html("");
    	$(".mask2>.select-box>.tab2>tbody>tr:eq(4)>td:eq(0)>span").html("");
    	$(".mask2>.select-box>.tab2>tbody>tr:eq(5)>td:eq(0)>span").html("");
    }
    else if(billType=="02")
    {
    	var i = 0;
    	$(".mask2 .tab2").find("tr").each(function(){
    		if(i<=5)
    		{	
         	$(this).find("td:eq(0)").find("span").html("*");     
    		}
    		i++;
        });
    	 $(".mask2").show();
         $(".mask1").hide();
         $(".mask3").hide();	
    }
    	 $(".mask2").show();
         $(".mask1").hide();
         $(".mask3").hide();	
    
	
   
});

	//填写设置条件 取消按钮
	$("#goBackSetting").click(function(){
		location.reload();
	});
	
	//确认按钮
	$("#saveSetting").click(function(){
		var billArriveDate =  $("input[name=arriveTime]").val();
		var limitPrice = $("input[name=openTicketBalance]").val();
		//$(this).attr('disabled',true);
		$(this).off("click");
		$.ajax({
			url:"busOrder/updateLimitPrice.do",
			type:"post",
			data:{
				"billArriveDate":billArriveDate,
				"limitPrice":limitPrice
			},
			beforeSend:function(){
				$(".sheet").html("保存中...");
			},
			success:function(){
				layer.msg('操作成功', {
					icon: 1,
					time: 1500
				},function(){
					location.reload();
				});
			}
		});
	});


$('#btn-next2').click(function () {
	if(billType=="01")
	{
		var myVal1 = $(".mask2>.select-box>.tab2>tbody>tr:eq(0)>td:eq(1)").find("input").val();
		var myVal2 = $(".mask2>.select-box>.tab2>tbody>tr:eq(1)>td:eq(1)").find("input").val();
		if(myVal1==null || myVal1.trim()=="" ||  myVal1=="undefind" || myVal2==null || myVal2.trim()==""  || myVal2=="undefind"){
			layer.msg('必填项不能为空', {
				icon: 2,
				time: 1500
			});
			
			return;
		}
	}else if(billType=="02"){
		var myVal1 =  $(".mask2>.select-box>.tab2>tbody>tr:eq(0)>td:eq(1)").find("input").val();
		var myVal2 =  $(".mask2>.select-box>.tab2>tbody>tr:eq(1)>td:eq(1)").find("input").val();
		var myVal3 =  $(".mask2>.select-box>.tab2>tbody>tr:eq(2)>td:eq(1)").find("input").val();
		var myVal4 =  $(".mask2>.select-box>.tab2>tbody>tr:eq(3)>td:eq(1)").find("input").val();
		var myVal5 =  $(".mask2>.select-box>.tab2>tbody>tr:eq(4)>td:eq(1)").find("input").val();
		var myVal6 =  $(".mask2>.select-box>.tab2>tbody>tr:eq(5)>td:eq(1)").find("input").val();
		
		if(myVal1==null || myVal1.trim()=="" ||  myVal1=="undefind"){
			layer.msg('必填项不能为空', {
				icon: 2,
				time: 1500
			});
			return;
		}
		else if(myVal2==null || myVal2.trim()=="" ||  myVal2=="undefind"){
			layer.msg('必填项不能为空', {
				icon: 2,
				time: 1500
			});
			
			return;
		}
		else if(myVal3==null || myVal3.trim()=="" ||  myVal3=="undefind"){
			layer.msg('必填项不能为空', {
				icon: 2,
				time: 1500
			});	
			return;
		}
		else if(myVal4==null || myVal4.trim()=="" ||  myVal4=="undefind"){
			layer.msg('必填项不能为空', {
				icon: 2,
				time: 1500
			});
			return;
		}
		else if(myVal5==null || myVal5.trim()=="" ||  myVal5=="undefind"){
			layer.msg('必填项不能为空', {
				icon: 2,
				time: 1500
			});
			return;
		}
		else if(myVal6==null || myVal6.trim()=="" ||  myVal6=="undefind"){
			layer.msg('必填项不能为空', {
				icon: 2,
				time: 1500
			});
			return;
		}
	}
	
		if(billNatrue=="2")
		{
			$(".mask3>.select-box>.tab2>tbody>tr:eq(2)>td:eq(0)>span").html("");
		}	
		else if(billNatrue=="1")
		{
			$(".mask3>.select-box>.tab2>tbody>tr:eq(2)>td:eq(0)>span").html("*");
		}
	
		  $(".mask3").show();
	      $(".mask1").hide();
	      $(".mask2").hide();

});

$("#btn-sumit").click(function () {
	var myVal1 =  $(".mask3>.select-box>.tab2>tbody>tr:eq(0)>td:eq(1)").find("input").val();
	var myVal2 =  $(".mask3>.select-box>.tab2>tbody>tr:eq(1)>td:eq(1)").find("input").val();
	var myVal3 =  $(".mask3>.select-box>.tab2>tbody>tr:eq(2)>td:eq(1)").find("input").val();
	var myVal4 =  $(".mask3>.select-box>.tab2>tbody>tr:eq(3)>td:eq(1)").find("input").val();
	if(billNatrue=="2")
	{
		if(myVal1==null || myVal1.trim()=="" ||  myVal1=="undefind"){
			layer.msg('必填项不能为空', {
				icon: 2,
				time: 1500
			});
			return;
		}
		else if(myVal2==null || myVal2.trim()=="" ||  myVal2=="undefind"){
			layer.msg('必填项不能为空', {
				icon: 2,
				time: 1500
			});
			
			return;
		}
		else if(myVal4==null || myVal4.trim()=="" ||  myVal4=="undefind"){
			layer.msg('必填项不能为空', {
				icon: 2,
				time: 1500
			});	
			return;
		}
	}
	else if(billNatrue=="1")
	{
		if(myVal1==null || myVal1.trim()=="" ||  myVal1=="undefind"){
			layer.msg('必填项不能为空', {
				icon: 2,
				time: 1500
			});
			return;
		}
		else if(myVal2==null || myVal2.trim()=="" ||  myVal2=="undefind"){
			layer.msg('必填项不能为空', {
				icon: 2,
				time: 1500
			});
			
			return;
		}
		else if(myVal3==null || myVal3.trim()=="" ||  myVal3=="undefind"){
			layer.msg('必填项不能为空', {
				icon: 2,
				time: 1500
			});	
			return;
		}
		else if(myVal4==null || myVal4.trim()=="" ||  myVal4=="undefind"){
			layer.msg('必填项不能为空', {
				icon: 2,
				time: 1500
			});
			return;
		}
	}	
	
		//保存开票信息
	    
	    	
	    	var clength=$('.chooseGoOpen:checked').length;
	    	//订单编号
			var orderNoArr = new Array(clength);
	    	var custNo =$( $('.chooseGoOpen:checked').siblings("[type = 'hidden']")).val();
	    	
			var z = 0;
	    	$($('.chooseGoOpen:checked').siblings(".uindent")).each(function(){
	    		orderNoArr[z] = $(this).text().substring(5);
	    		z++;
	    	});
	       	
	    	$.ajax({
	    		url:'busOrder/saveBill.do',
	    		type:"post",
		    	dataType: "json", 
		    	async : false,
		        cache : false,
		        traditional: true,
	    		data:{
	    			orderNoArr:orderNoArr,//订单编号
	    			"custNo":custNo,
	    			"billNatrue":billNatrue,//发票状态 "0":"电子发票",  "1":"纸质发票"
	    			"billType":billType,//发票类型:01普通发票,02增值税发票
	    			"billTitle":billTitle,//发票抬头 1个人  2.公司
	    			"billReceipt":$("[name='billReceipt']").val(),//纳税人识别号
	    			"billContent":"产品明细",//发票内容
	    			"billReceivePhone":$("[name='billReceivePhone']").val(),//收票人手机号
	    			"billReceiveAddress":$("[name='billReceiveAddress']").val(),//收票人地址
	    			"billStatus":$("[name='billStatus']").val(),//发票状态
	    			"companyName":$("[name='companyName']").val(),//单位名称
	    			"registerAddress":$("[name='registerAddress']").val(),//单位注册地址
	    			"registerPhone":$("[name='registerPhone']").val(),//单位注册手机号码
	    			"openBand":$("[name='openBand']").val(),//开户行
	    			"bandCard":$("[name='bandCard']").val(),//银行卡
	    			"billReceiveName":$("[name='billReceiveName']").val(),//收票人姓名
	    			"billReceiveMail":$("[name='billReceiveMail']").val(),//收票人邮箱
	    		},
	    		success:function(data){
	    			if(data.success){
	    				layer.msg('操作成功', {
	    					icon: 1,
	    					time: 1500,
	    				}, function(){
	    					window.location.href="${basePath}goods/toSupplyInvoicMgt.do";
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
/******************** 选择格式 ***************************/
var billNatrue = "2";//发票状态 "1":"电子发票","2":"纸质发票"
var billType;//发票类型:01普通发票,02增值税发票
var billTitle;//发票抬头,001个人，002公司
$('.zzfp').click(function(){
	 $('.zzfp').find('span').append("<img src='frame/static/picture/select-frame.png'>");
	 $('.dzfp>span>img').remove('img');
	 billNatrue = "2";
});

$('.dzfp').click(function(){
	 $('.dzfp').find('span').append("<img src='frame/static/picture/select-frame.png'>");
	 $('.zzfp>span>img').remove('img');
	 	billNatrue = "1";
});


$('.ptfp').click(function(){
	 $('.ptfp').find('span').append("<img src='frame/static/picture/select-frame.png'>");
	 $('.zzsfp>span>img').remove('img');
	 billType = "01";
});

$('.zzsfp').click(function(){
	 	$('.zzsfp').find('span').append("<img src='frame/static/picture/select-frame.png'>");
	 	$('.ptfp>span>img').remove('img');
	 	$('.dw').find('span').append("<img src='frame/static/picture/select-frame.png'>");
		$('.gr>span>img').remove('img');
	 	billType = "02";
		billTitle = "002";
});

$('.gr').click(function(){
  	 $('.gr').find('span').append("<img src='frame/static/picture/select-frame.png'>");
  	 $('.dw>span>img').remove('img');
  	 $('.zzsfp>span>img').remove('img');
  	 $('.ptfp').find('span').append("<img src='frame/static/picture/select-frame.png'>");
  	 billTitle = "001";
  	 billType="01";
});

$('.dw').click(function(){
 	 $('.dw').find('span').append("<img src='frame/static/picture/select-frame.png'>");
 	 $('.gr>span>img').remove('img');
 	 billTitle = "002";
});
</script>