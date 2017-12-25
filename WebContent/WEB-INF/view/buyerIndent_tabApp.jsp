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
        <div class="text-tit fl">我的订单</div>
        <div class="fl openTicket" style="float: right;font-size: 1.25rem;color: #f6f6f6;;">开发票</div>
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
	<input type="hidden" id="curr">
	<input type="hidden" id="orderStatus">
		<div class='address-lis'>
			<ul></ul>
		</div>
	</div>
	
<div id="goTop" style="position: fixed;
    bottom: 50px;
    right: 50px;
    width: 45px;
    height: 45px;
    background: url(frame/static/img/getTop.png) no-repeat 0 0;
    display:none;
    cursor: pointer;
   "></div>
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
	
	var orderStatus = "";
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
		curr = 1;
		
		$(".search-terms>div").click(function() {
			$(".search-terms>div").removeClass("on-terms");
			$(this).addClass("on-terms");
		});
		demo(curr);
		$(".search-terms>div:eq(0)").click(function() {//全部
			demo(1);
			orderStatus = "";
			$("#orderStatus").val(orderStatus);
		});
		$(".search-terms>div:eq(1)").click(function() {//待付款
			stateLook(1, "090003");
			orderStatus = "090003";
			$("#orderStatus").val(orderStatus);
		});
		$(".search-terms>div:eq(2)").click(function() {//待收货
			stateLook(1, "090004");
			orderStatus = "090004";
			$("#orderStatus").val(orderStatus);
		});
		$(".search-terms>div:eq(3)").click(function() {//完成
			stateLook(1, "090005");
			orderStatus = "090005";
			$("#orderStatus").val(orderStatus);
		});
		$(".search-terms>div:eq(4)").click(function() {//已取消
			stateLook(1, "090006");
			orderStatus = "090006";
			$("#orderStatus").val(orderStatus);
		});
		
		
	});

	
	//延迟加载
	var finished=0; //避免连续加载
	var sover=0;  //最后一页时设置为1，不再加载
	var curr = 1;  
	
	//如果屏幕未到整屏自动加载下一页补满  
	var setdefult=setInterval(function (){  
	    if(sover==1)  
	        clearInterval(setdefult);     
	    else if($(".address-lis>ul").height()+100<$(window).height()) {
	        loadmore($(window));  
	    }
	    else  
	        clearInterval(setdefult);  
	},500);  
	  
	//加载完  
	function loadover(){  
	    if(sover==1)  
	    {     
	        var overtext="Duang～到底了";  
	            var txt='<div><span>'+overtext+'</span></div>'  
	            $("body").append(txt);  
	         
	    }  
	}  
	  
	//加载更多  
	var vid=0;  
	function loadmore(obj){  
	     
		if($(obj).scrollTop() > 400){
			$("#goTop").show();
		}else{
			$("#goTop").hide();
			}
		
		var scrollTop = $(obj).scrollTop();  
	        var scrollHeight = $(document).height();  
	        var windowHeight = $(".address-lis>ul").height();  
	        curr= $("#curr").val();
            orderStatus = $("#orderStatus").val(); 
	        
	      /*   console.log("scrollTop:"+scrollTop
		        	
		        	+"  window:"+scrollHeight
		        	
		        	+"  document:"+windowHeight
		        	+"  finished:"+finished
		        	+"  sover:"+sover
		        	+"  curr:"+curr
		        	+"  orderStatus:"+orderStatus
		        ); */
	    if(finished==0 && sover==0)  
	    {  
	        
	       /*  if($(".loadmore").length==0)  
	        {  
	            var txt='<div class="loadmore"><span class="loading"></span>加载中..</div>'  
	            $("body").append(txt);  
	        }   */
	          
	        if (scrollTop + scrollHeight >= windowHeight) {  
	            //此处是滚动条到底部时候触发的事件，在这里写要加载的数据，或者是拉动滚动条的操作  
	            //防止未加载完再次执行  
	            finished=1; 
	            
	            if(orderStatus == ""){
	           	 	demo(parseInt(curr)+1);
	            }else{
	            	stateLook(parseInt(curr)+1,orderStatus);
	            }
	        }  
	    }  
	}  
	//页面滚动执行事件  
	$(".mains").scroll(function(){  
		loadmore($(this));  
	});
	//返回顶部
	$("#goTop").click(function(){
		$(".mains").scrollTop(0);
	});	
	
	function demo(curr) {
		$.ajax({
			url : 'busOrder/getBuyerOrders.do',
			data : {
				pageNo : curr || 1
			},
			/* beforeSend : function() {
				$(".address-lis>ul").html(	 "<div class='warn-box'>"
						+	"<div class='warn-infos'>"        
						+	           "<div class='onload-img'><img src='frame/static/picture/onload.png'></div>" 
						+	            "<div class='warn-texts'>正在努力为您加载!请耐心等待...</div>"
						+	       " </div>"
						+	    "</div>"		);
			}, */
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
			url : 'busOrder/getBuyerOrders.do',
			data : {
				pageNo : curr || 1,
				orderStatus : orderStatus
			},
			/* beforeSend : function() {
				$(".address-lis>ul").html(	 
						"<div class='warn-box'>"
						+	"<div class='warn-infos'>"        
						+	           "<div class='onload-img'><img src='frame/static/picture/onload.png'></div>" 
						+	            "<div class='warn-texts'>正在努力为您加载!请耐心等待...</div>"
						+	       " </div>"
						+	    "</div>"		);
			}, */
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
		var curr = data.obj.pageNo;
		
		if(curr == "1"){
			$(".address-lis>ul").empty();
			sover=0;
			$(window).scrollTop(0);
		} 
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
			content += "<div class='href-btn' onclick='goShop()'>去商城逛逛</div>";
			content += "</div>";
			content += "</div>";
		}
		for ( var i in tmpguan) {
			var tradeStus = getOrderStus(Row.rows[tmpguan[i][1]].orderStatus,
					Row.rows[tmpguan[i][1]].updateCustType);
			var quantity = 0;
			var price = parseInt(0);
			
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
				content += "<h5>"
						+ (Row.rows[tmpguan[i][num]].goodsName != null ? Row.rows[tmpguan[i][num]].goodsName
								: '') + "</h5>";
				content += "<p class='num-text' title='"+Row.rows[tmpguan[i][num]].par+"'>"
						+ (Row.rows[tmpguan[i][num]].par != null ? Row.rows[tmpguan[i][num]].par
								: '') + "</p>";
				content += " <p class='one-price'><span>"
						+ Row.rows[tmpguan[i][num]].goodsPrice.toFixed(2)
						+ "</span>"; 
				quantity += Row.rows[tmpguan[i][num]].goodsCount;
				price += parseInt(Row.rows[tmpguan[i][num]].goodsMoney);
				content += "<span>*</span>";
				content += "<span class='myOnlyNums'>"
						+ Row.rows[tmpguan[i][num]].goodsCount + "</span>";
				content += "</p>";
				content += "<p class='total-price'><span>合计:</span><span>"
						+ parseInt(Row.rows[tmpguan[i][num]].goodsMoney)
								.toFixed(2) + "</span></p>";
				content +="</div>";		
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
			content += "<div class='remark-com' style='height: auto;'>";
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
				content += "<span class='on-red qrfk' onclick=invoice(\'"
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
						+ "\',\'"+Row.rows[tmpguan[i][1]].code+"\',this)>查看物流信息</span>"; 
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
		}
		$(".address-lis>ul").append(content);

		var totalPage = Math.ceil(eval(data.obj.total / data.obj.pageSize));
		if(totalPage == curr){
			sover = 1;
			loadover();
		}
		
		//alert(pageNo);
		
		$("#curr").val(curr);
		finished=0;
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
	
	$(".openTicket").click(function(){
		location.href="busShoppCart/toOpenTicketTable.do";
	});
	//确认付款
	function invoice(orderNo, price, element) {
		var remark;
		$(element).parent().parent().parent().find("input[type='text']").each(
				function() {
					remark = $(this).val();
				});
		var supplyNo = $(element).parent().parent().attr("data-supplyno");
		$(this).attr("disabled",true);
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
											time:1.5,
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
		$(this).attr("disabled",true);
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
						time:1.5,
						end:function() {
							stateLook(curr, "090004");
							orderStatus = "090004";
							count();
										}
					}
							);
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
								time:1.5,
								end:function(){
									stateLook(curr, orde);
											  }
							}
									);
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
		$(element).attr("disabled",true);
		location.href = "busOrder/toPage/cancelOrder.do?orderNo="+orderNo+"&orderType="+orderType;
	}
	
	//再次购买
	function againPurchase(Row, supplyNo, element) {
		var brands = "";
		$(element).parent().parent().prev().children("div[display='none']").each(function(){
			brands += $(this).attr("data-brand") + ",";
		});
		$(this).attr("disabled",true);
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
	};
	
	//显示部分物流信息
	var myData;
	var myDivId;
	
	function lookWlMsg(str1,str2,that) {
		var str3 = $(that).parent().parent().prev(".infos-details").find(".myOnlyNums").text();
		location.href = "busOrder/toPage/trackApp.do?lgtNums="+str1+"&code="+str2+"&nums="+str3;
	}
	
	function goShop(){
		var custNo = "${sessionScope.custNo}";
		location.href="http://new.cp2013.com.cn/WEBAPP/User_Action_UserLogin_Mobile/"+custNo;
	}
	
	$(document).on('click', function() {
		$('.myLgtMsg').hide();
	});

	
</script>