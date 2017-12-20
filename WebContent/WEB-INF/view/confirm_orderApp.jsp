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
<title>订单确认</title>
<base href="<%=basePath%>" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link rel="stylesheet" type="text/css" href="frame/static/css/shop.css">
</head>
<body>
	<div class="header address-pri">
		<div class="header-box">
			<div class="header-img fl">
				<img class="l-img returnShopCart"
					src="frame/static/picture/arrow-white.png">
			</div>
			<div class="text-tit fl">订单确认</div>
			<div class="clear-box"></div>
		</div>
	</div>
	<div class="header address-more" style="display:none">
		<div class="header-box ">
			<div class="header-img fl">
				<img class="l-img address-more-close"
					src="frame/static/picture/arrow-white.png">
			</div>
			<div class="text-tit fl">收货地址</div>
			<div class="header-img fr" style="text-align: right" id="addressAdd">新增</div>
		</div>
	</div>

	<div class="addressTip-table mains"
		style="height:100%;overflow-y: auto;">
		
	</div>


	<div class="footer">
		<div class="price-box fl">
			<span>合计:</span> <span>&yen;</span> <span class="totalMoney">0</span>
		</div>
		<div class="footer-btn fr" id="createOrder">确认订单</div>
	</div>

	<div class="header addressAdd" style="display:none">
		<div class="header-box addressAdd">
			<div class="header-img fl">
				<img class="l-img addressAddClose"
					src="frame/static/picture/arrow-white.png">
			</div>
			<div class="text-tit fl">新增地址</div>
		</div>
	</div>
	<div class="mains addressAdd" style="overflow: auto;display:none">
		<div class="address-infos">
			<ul>
				<li>
					<div class="check-texts fl">
						<span>收货人</span>
					</div>
					<div class="oper-texts fr">
						<input type="text" placeholder="请输入收货人" name='consignee'>
					</div>
					<div class="clear-box"></div>
				</li>
				<li>
					<div class="check-texts fl">
						<span>手机号</span>
					</div>
					<div class="oper-texts fr">
						<input type="text" placeholder="请输入手机号" name='phone'>
					</div>
					<div class="clear-box"></div>
				</li>
				<li>
					<div class="check-texts fl">
						<span>省</span>
					</div>
					<div class="oper-texts fr">
						<select name='input_province' id="input_province"
							style="width: 121px;"></select>
					</div>
					<div class="clear-box"></div>
				</li>
				<li>
					<div class="check-texts fl">
						<span>市</span>
					</div>
					<div class="oper-texts fr">
						<select name="input_city" id="input_city" style="width: 121px;"></select>
					</div>
					<div class="clear-box"></div>
				</li>
				<li>
					<div class="check-texts fl">
						<span>区</span>
					</div>
					<div class="oper-texts fr">
						<select name="input_area" id="input_area" style="width: 121px;"></select>
					</div>
					<div class="clear-box"></div>
				</li>
				<li style="height: auto">
					<div class="check-texts fl">
						<span>详细地址</span>
					</div>
					<div class="address-area fr">
						<textarea rows="4" placeholder="请输入详细地址" name='dizhi'></textarea>
					</div>
					<div class="clear-box"></div>
				</li>
			</ul>
			<div class="btn-order insert">确认</div>
			<div class="btn-order update" style="display: none;">确认</div>
		</div>	
	</div>



</body>

</html>
<script type="text/javascript"
	src="frame/static/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="frame/layui/layui.js"></script>
<script type="text/javascript" src="frame/static/js/baiduTemplate.js"></script>
<script type="text/javascript" src="frame/static/js/jQuery-jcDate.js"></script>
<script type="text/javascript" src="frame/static/layer/layer.js"></script>
<script type="text/javascript" src="frame/static/js/pdata.js"></script>
<script type="text/javascript"
	src="frame/static/js/jquery.validate.min.js"></script>
<script type="text/javascript" src="frame/static/js/messages_zh.js"></script>
<script type="text/javascript"
	src="frame/static/js/additional-methods.js"></script>
<script type="text/javascript"
	src="frame/static/js/jquery.validate.method.extend.js"></script>
<script type="text/javascript" src="frame/static/js/company.js"></script>
<script type="text/javascript" src="frame/static/layer/mobile/layer.js"></script>
<script id="bd_t1" type="text/template">
	
	<div class="geng-duo-di-zhi" style="background-color: #c2c2c2;height: 27px;font-size: 18px;text-align: center;">更多地址</div>
		<div class="arrow-box geng-duo-di-zhi-imge" style="display:none">
			<img src="frame/static/picture/arrow.png">
		</div>

	<*for(var key in obj){*>
		<*var list = obj[key]*>
		<li class="newLi">
			<div style="display:none">
				<input type="radio" name="operation" <*=list.status==1?"class='pitch' checked='checked'":""*>/>
				<input type="hidden" name="tableKey" value="<*=list.tableKey*>">
				<input type="hidden" name="area" value="<*=list.area*>">
				<input type="hidden" name="city" value="<*=list.city*>">
				<input type="hidden" name="province" value="<*=list.province*>">
			</div>
			
		
			<div class="address-box">
        		<div class="address-com" style="padding-top: 14px">
         		   <div class="fl address-tit">收货人:</div>
         		   <div class="fl address-conts">
               		 	<span style="padding-right: 10px"><*=list.userName*></span>
               			<span><*=list.userPhone*></span>
           			</div>
            		<div class="clear-box"></div>
        		</div>
        		<div class="address-com">
           			 <div class="fl address-tit">收货地址:</div>
            		 <div class="fl address-conts" style="line-height: 16px;margin-top: 4px;"><*=list.userAddress*></div>
           			 <div class="clear-box"></div>
        		</div>
     
    		</div>
		
		</li>
<*}*>
	
</script>
<script id="bd_t2" type="text/template">
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
		
		
		<div class="lists-box">
			<div style="background-color: #FFFFFF">
         	   <div class="tit-box">
         	       <div class="tit-text fl"><*=list.supplyName*></div>
        	       <div class="phone fr"><*=list.supplyPhone*></div>
        	   </div>
     	    </div>

	<ul>		
<*for(var num = 1; num < tmpguan[key].length; num++){*>
<*var listDetail = shoppCart[tmpguan[key][num]]*>
			<!--商品信息-->
			<span style="display:none"><*=listDetail.buyNum*></span>
            <li class="message" style="height:auto"   id="<*=listDetail.tableKey*>"  data-supplyno="<*=listDetail.supplyNo*>">
              	<input type="hidden" value="<*=listDetail.tableKey*>">
				  <div class="li-img fl">
                  <img src="http://new.cp2013.com.cn/File/B/<*=(listDetail.code).substring((listDetail.code).indexOf("-"),(listDetail.code).length)+".jpg"*>">
                </div>
                <div class="li-texts fl" style="margin-left: 15px">
                    <h5><*=listDetail.goodsName*></h5>
                    <p class="num-text"><*=listDetail.goodsCode*>-<*=listDetail.goodsNo*></p>
                    <p class="one-price">
                        <span><*=listDetail.goodsPrice.toFixed(2)*></span>
                        <span>*</span>
                        <span class="buy_amount"><*=listDetail.buyNum*></span>
                    </p>
                    <p class="total-price"><span>合计:</span><span class="totalEvr buy_aggregate"><*=(Math.round(listDetail.buyNum*listDetail.goodsPrice*listDetail.goodsDiscount)/10).toFixed(2)*></span></p>
                </div>
               	<div class="buy_operate" style="display:none">
					<label"><span class="vertical-m fs14 font-666 buytype" buytype="<*=listDetail.buyType*>"><*=listDetail.buyType==09001? "试刀" : "购买"*></span></label>
				</div>
				<div class="clear-box"></div>
            </li>
<*}*>
			<li class="newStyle">
			<div class="remark-box">
                    <div class="remark-com">
                        <span class="fl">默认收货时间:</span>
                        <span class="fr" style="margin-right: 20px"><*=list.defaultPayDt*></span>
                        <div class="clear-box"></div>
                    </div>
                    <div class="remark-com">
                        <span class="fl">期望收货时间:</span>
                        <input class="fr wishDate" type="date">
                        <div class="clear-box"></div>
                    </div>
                    <div class="remark-com">
                        <span>备注:</span>
                        <input class="fr input-remark" type="text" placeholder="备注信息">
                        <div class="clear-box"></div>
                    </div>
                    <div class="clear-box"></div>
                </div>
			</li>
             </ul>
    		
	<*}*>
</script>

<script id="bd_t3" type="text/template">
	<div class="address-lis" style="display:none">
        <ul>
	<*for(var key in obj){*>
		<*var list = obj[key]*>

		
            <li>
                <div class="top-li">
                    <p class="texts-adrs" style="margin-top: 5px">
                        <span class="fl">姓名：<*=list.userName*></span>
                        <span class="fr">电话：<*=list.userPhone*></span>
                    </p>
                    <p style="margin-bottom: 5px">地址：<*=list.userAddress*></p>
                </div>
                <div class="down-li">
                    <div class="check-texts fl">
						<div style="display:none">
                        	<input type="radio" name="operation" <*=list.status==1?"class='pitch' checked='checked'":""*>/>
							<input type="hidden" name="tableKey" value="<*=list.tableKey*>">
							<input type="hidden" name="area" value="<*=list.area*>">
							<input type="hidden" name="city" value="<*=list.city*>">
							<input type="hidden" name="province" value="<*=list.province*>">
						</div>
                        <span>使用该地址</span>
                    </div>
                    <div class="oper-texts fr">
                        <span class="update-btn">编辑</span>
                        <span class="delete">删除</span>
                    </div>
                    <div class="clear-box"></div>
                </div>
            </li>
<*}*>
	 </ul>
    </div>
<div class="moudle" id="<*=key*>"></div>
</script>
<script type="text/javascript">
	$(function() {
		function jiazai() {
			var choose = $(".addressTip-table").children("li").length;
			for (var i = 0; i < choose; i++) {
				if ($($(".addressTip-table li")[i]).find("input[type=radio]")
						.attr("checked")) {
					$($($(".addressTip-table li")[i]).children()[1]).addClass(
							"uearname_checked");
					$($(".addressTip-table li")[i]).show();
				} else {
					$($(".addressTip-table li")[i]).children("div")
							.removeClass("uearname_checked");
				}
			}
		}

	

		//返回
		$(".address-more-close").click(function() {
			location.href = "goods/toConfirmOrderApp.do";
		});

		//新增地址
		$("#addressAdd").click(function() {
			$(".mains").hide();//2-页面
			$(".header").hide();//2-头
			$(".addressAdd").show();//3-头 & 3-页面
			$(".insert").show();//3-新增按钮
			$(".update").hide();//3-修改按钮
			siteAdd();
			$(".insert").click(function() {
				siteAdd_verification();
			});
		});

		//关闭新增地址
		$(".addressAddClose").click(function() {
			$(".mains").show();// 2-页面
			$(".address-more").show();// 2-头
			$(".addressAdd").hide();//3-头 & 3-页面
			$(".address-lis").show();// 2-地址页面

		});

		$(".addressTip-table").on(
				"click",
				"li>.userName",
				function() {
					$("input[type=radio]").attr("checked", false);
					$("input[type=radio]").removeClass("pitch");
					$(this).parent().children().children("input[type=radio]")
							.attr("checked", true);
					$(this).parent().children().children("input[type=radio]")
							.addClass("pitch");
					jiazai();
				});

		$("#addressTip>span").click(function() {
			if ($(this).text() == "更多地址") {//显示
				$(".addressTip-table li").show();
				$(this).text("隐藏");
			} else {
				$(".addressTip-table li").hide();
				jiazai();
				$(this).text("更多地址");
			}
		});

		var clearHeight = 0;
		baidu.template.LEFT_DELIMITER = '<*';
	baidu.template.RIGHT_DELIMITER='*>';
		//layui路径配置
		layui.config({
			dir : 'frame/layui/' //layui.js 所在路径（注意，如果是script单独引入layui.js，无需设定该参数。），一般情况下可以无视
			,
			version : false //一般用于更新模块缓存，默认不开启。设为true即让浏览器不缓存。也可以设为一个固定的值，如：201610
			,
			debug : false //用于开启调试模式，默认false，如果设为true，则JS模块的节点会保留在页面
			,
			base : 'frame/layui/' //设定扩展的Layui模块的所在目录，一般用于外部模块扩展
		});
		/* 自定义的单选radio */
		$("#addressTip").on("click", "input:radio[name=operation]", function() {
			$('input:radio[name="operation"]').removeClass("pitch");
			$('input:radio[name="operation"]:checked').addClass("pitch");
		});

		///设为默认
		$(".addressTip-table").on('click', ".default", function() {
			var val = $(this).parent().find("[name=tableKey]").val();
			$.ajax({
				url : "busShoppCart/defaultAddress.do",
				data : {
					"tableKey" : val
				},
				dataType : "json",
				type : "post",
				success : function(data) {
					if (data.success) {
						location.href = "goods/toConfirmOrder.do";
					} else {
						layer.open({
							title : '错误信息',
							content : data.msg
						});
					}
				}
			});
		});

		function total() {
			var aggregate = 0;
			$(".mains").find(".totalEvr").each(function(i) {
				var obj = $(this);
				aggregate = (eval(aggregate + "+" + obj.text())).toFixed(2);
			});
			$(".totalMoney").html(aggregate);
		}

		//修改地址
		$(".addressTip-table").on('click', ".update", function() {
			var trMould = $(this).parent();
			layer.open({
				title : '修改地址',
				content : siteTemplate,
				btn : [ '确认', '取消' ],
				scrollbar : false,//不允许浏览器出现滚动条
				area : [ '520px', '462px' ],
				success : function() {
					siteUpdate(trMould);
				},
				yes : function() {
					var phone = $("[name=phone]").val();
					if (!(/^1[34578]\d{9}$/.test(phone))) {
						$("#billReceivePhone").text('手机号码有误');
					} else {
						$("#billReceivePhone").text('');
						siteUpdate_verification();
					}
				}
			});
		});
		/* //手机号验证
		$(document).on("blur","[name=phone]",function(){
			var phone = $(this).val();
			if(!(/^1[34578]\d{9}$/.test(phone))){ 
		        $("#billReceivePhone").text('手机号码有误');
		    }else{
		    	$("#billReceivePhone").text('');
		    	//siteUpdate_verification();
		    }
		}); */
		//确认订单
		$("#createOrder").click(function() {
							var orderArray = new Array();
							var address = $('input:radio[name="operation"]:checked').next().val();
							if (address == "" || address == null) {
								layer.open({
									content:'请先确认收货地址',
									time:1500
								});
								return;
							}
							$(".message").each(function() {
							var order = {};
							order["supplyNo"] = $(this).attr("data-supplyno");;
							$(this).find(".buy_amount").each(function() {
								order["num"] = $(this).text();
								});
							$(this).find(".buytype").each(function() {
							order["type"] = $(this).attr("buytype");
							});
							
							//重新设置
							$(this).parent().find(".wishDate").each(function() {
							order["wishDate"] = $(this).val();
							});
							
							$(this).parent().find(".input-remark").each(function() {
							order["remark"] = $(this).val();
							});
							
							
							$(this).find("input[type=hidden]").each(function() {
							order["tableKey"] = $(this).val();
							});
							
							order["address"] = address;
							orderArray.push(order);
							flag = 1;
							});
							var array = JSON.stringify(orderArray);
							$
									.ajax({
										url : "busOrder/createOrder.do",
										data : {
											"orderArray" : array
										},
										dataType : "json",
										type : "post",
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
												layer
														.open({
															content : '订单生成成功',
															time:2,
															end : function() {
																location.href = "busOrder/toPage/buyerIndent_tabApp.do";
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
						});

		function GetQueryString(name) {
			var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
			var r = window.location.search.substr(1).match(reg);
			if (r != null)
				return unescape(r[2]);
			return null;
		}
		//收货地址
		$.ajax({
			url : "busShoppCart/getUserAddress.do",
			boforeSend:function(){
				$(".newLi").html(	
						"<div class='warn-box'>"
						+	"<div class='warn-infos'>"        
						+	           "<div class='onload-img'><img src='frame/static/picture/onload.png'></div>" 
						+	            "<div class='warn-texts'>正在努力为您加载!请耐心等待...</div>"
						+	       " </div>"
						+	    "</div>"		);
			},
			success : function(data) {
				if (data.success) {
					var html1 = baidu.template('bd_t1', data);
					$(".addressTip-table").append(html1);
					var html3 = baidu.template('bd_t3', data);
					$(".addressTip-table").append(html3);
					//判断地址是否为空，显示信息
					if($(".address-lis ul li").length == 0){
						$(".address-lis ul").html(
						"<div class='warn-box'>"
						+	"<div class='warn-infos'>"      
						+	 "<div class='warn-texts'>无地址信息，请新增</div>"
						+	 "<div class='onload-img'><img src='frame/static/picture/order-img.png'></div>" 
						+	" </div>"
						+"</div>");
					}
					//更多地址
					$(".arrow-box").click(function() {
						addressMore();
					});

					$(".geng-duo-di-zhi").click(function() {
						addressMore();
					});
					var choose = $(".addressTip-table").children("li").length;
					var vue = GetQueryString("vue");
					var liatDate = [];
					if (vue) {
						/* 	$(".addressTip-table").children("li").css("dispaly",
									"table-row;")
							for (var i = 0; i < choose; i++) {
								liatDate.push(data.obj[i].insetDate);
								liatDate.sort();
							}
							var sumDate = liatDate[choose - 1];
							for (var i = 0; i < choose; i++) {
								if (data.obj[i].insetDate == sumDate) {
									$($(".addressTip-table li")[i]).find(
											"input[type=radio]").attr("checked",
											"checked");
									//$($($(".addressTip-table li")[i]).children()[1]).addClass("uearname_checked");

								} else {
									$($(".addressTip-table li")[i]).find(
											"input[type=radio]").attr("checked",
											false);
									//$($($(".addressTip-table li")[i]).children()[1]).removeClass("uearname_checked");
									$($(".addressTip-table li")[i]).hide();

								}
							} */
					}
					for (var i = 0; i < choose; i++) {
						if ($($(".addressTip-table li")[i]).find(
								"input[type=radio]").attr("checked")) {
							$(".geng-duo-di-zhi").hide();
							$(".geng-duo-di-zhi-imge").show();
							$($(".address-lis li")[i]).find("input[type=radio]").parent().next().text("默认地址");

						} else {
							$($(".addressTip-table li")[i]).hide();
							$($(".address-lis li")[i])
									.find("input[type=radio]").parent().next()
									.addClass("check-span");
						}
					}
					$(".moudle").append(	
							"<div class='warn-box newWB'>"
							+	"<div class='warn-infos'>"        
							+	           "<div class='onload-img'><img src='frame/static/picture/onload.png'></div>" 
							+	            "<div class='warn-texts'>正在努力为您加载!请耐心等待...</div>"
							+	       " </div>"
							+	    "</div>"		);
				} else {
					layer.open({
						title : '错误信息',
						content : data.msg
					});
				}
			}
		});
		//获取商品信息
		$.ajax({
			url : "busShoppCart/getOrderList.do",
			success : function(data) {
				if (data.success) {
					$(".newWB").hide();
					var html2 = baidu.template('bd_t2', data.map);
					$(".moudle").append(html2);
					total();
					//进页面时跳地址页面
					var vue = GetQueryString("vue");
					if (vue == "update" || vue) {
						addressMore();
					}
				} else {
					layer.open({
						title : '错误信息',
						content : data.msg
					});
				}
			}
		});
	});

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

	function siteAdd() {
		var html = "<option value=''>== 请选择 ==</option>";
		$("#input_city").append(html);
		$("#input_area").append(html);
		$
				.each(
						pdata,
						function(idx, item) {
							if (parseInt(item.level) == 0) {
								html += "<option value='" + item.names + "' exid='" + item.code + "'>"
										+ item.names + "</option>";
							}
						});
		$("#input_province").append(html);
		$("#input_province")
				.change(
						function() {
							if ($(this).val() == "")
								return;
							$("#input_city option").remove();
							$("#input_area option").remove();
							var code = $(this).find("option:selected").attr(
									"exid");
							code = code.substring(0, 2);
							var html = "<option value=''>== 请选择 ==</option>";
							$("#input_area").append(html);
							$
									.each(
											pdata,
											function(idx, item) {
												if (parseInt(item.level) == 1
														&& code == item.code
																.substring(0, 2)) {
													html += "<option value='" + item.names + "' exid='" + item.code + "'>"
															+ item.names
															+ "</option>";
												}
											});
							$("#input_city").append(html);
						});
		$("#input_city")
				.change(
						function() {
							if ($(this).val() == "")
								return;
							$("#input_area option").remove();
							var code = $(this).find("option:selected").attr(
									"exid");
							code = code.substring(0, 4);
							var html = "<option value=''>== 请选择 ==</option>";
							$
									.each(
											pdata,
											function(idx, item) {
												if (parseInt(item.level) == 2
														&& code == item.code
																.substring(0, 4)) {
													html += "<option value='" + item.names + "' exid='" + item.code + "'>"
															+ item.names
															+ "</option>";
												}
											});
							$("#input_area").append(html);
						});
		//绑定
		$("#input_province").val("北京市");
		$("#input_province").change();
		$("#input_city").val("市辖区");
		$("#input_city").change();
		$("#input_area").val("东城区");
	};
	function siteAdd_verification() {
		var province = $("[name='input_province']").val();
		var city = $("[name='input_city']").val();
		var area = $("[name='input_area']").val();
		var postCode = $("[name='youbian']").val();
		var address = $("[name='dizhi']").val();
		var addresseeName = $("[name='consignee']").val();
		var telephone = $("[name='phone']").val();

		if (!$.trim(address)) {
			layer.open({
				content : '收件地址不为空'
			});
			return;
		}
		if (!$.trim(addresseeName)) {
			layer.open({
				content : '收件人不能为空'
			});
			return;
		}

		if (!(/^1[34578]\d{9}$/.test(telephone))) {
			layer.open({
				content : '手机号码有误'
			});
		} else {
			$("#billReceivePhone").text('');
			$.ajax({
				url : "busShoppCart/addSite.do",
				data : {
					"province" : province,
					"city" : city,
					"area" : area,
					"postCode" : postCode,
					"address" : address,
					"addresseeName" : addresseeName,
					"telephone" : telephone
				},
				type : "post",
				success : function(data) {
					if (data.success) {
						//location.reload();
						location.href = "goods/toConfirmOrderApp.do?vue=true";
					} else {
						layer.open({
							title : '错误信息',
							content : data.msg
						});
					}
				}
			});
		}
	}
	//修改
	function siteUpdate(mou) {
		var html = "<option value=''>== 请选择 ==</option>";
		$("#input_city").append(html);
		$("#input_area").append(html);
		$
				.each(
						pdata,
						function(idx, item) {
							if (parseInt(item.level) == 0) {
								html += "<option value='" + item.names + "' exid='" + item.code + "'>"
										+ item.names + "</option>";
							}
						});
		$("#input_province").append(html);
		$("#input_province")
				.change(
						function() {
							if ($(this).val() == "")
								return;
							$("#input_city option").remove();
							$("#input_area option").remove();
							var code = $(this).find("option:selected").attr(
									"exid");
							code = code.substring(0, 2);
							var html = "<option value=''>== 请选择 ==</option>";
							$("#input_area").append(html);
							$
									.each(
											pdata,
											function(idx, item) {
												if (parseInt(item.level) == 1
														&& code == item.code
																.substring(0, 2)) {
													html += "<option value='" + item.names + "' exid='" + item.code + "'>"
															+ item.names
															+ "</option>";
												}
											});
							$("#input_city").append(html);
						});

		$("#input_city")
				.change(
						function() {
							if ($(this).val() == "")
								return;
							$("#input_area option").remove();
							var code = $(this).find("option:selected").attr(
									"exid");
							code = code.substring(0, 4);
							var html = "<option value=''>== 请选择 ==</option>";
							$
									.each(
											pdata,
											function(idx, item) {
												if (parseInt(item.level) == 2
														&& code == item.code
																.substring(0, 4)) {
													html += "<option value='" + item.names + "' exid='" + item.code + "'>"
															+ item.names
															+ "</option>";
												}
											});
							$("#input_area").append(html);
						});
		//绑定
		$("#input_province").val(mou.children("[name=province]").val());
		$("#input_province").change();
		$("#input_city").val(mou.children("[name=city]").val());
		$("#input_city").change();
		$("#input_area").val(mou.children("[name=area]").val());
		$("[name=tableKey]").val(mou.children("[name=tableKey]").val());
		$("input[name=phone]").val(
				(mou.parent().parent().prev().children("p:eq(0)").children(
						"span:eq(1)").text()).substring(3));
		$("input[name=consignee]").val(
				mou.parent().parent().prev().children("p:eq(0)").children(
						"span:eq(0)").text().substring(3));
		$("[name=dizhi]").val(
				mou.parent().parent().prev().children("p:eq(1)").text()
						.substring(3));
	}

	$(".returnShopCart").click(function() {
		var custNo = "${sessionScope.custNo}";
		location.href = "sys/loginShoopingCarbackApp.do?custNo=" + custNo;
	});

	function siteUpdate_verification() {
		var province = $("[name='input_province']").val();
		var city = $("[name='input_city']").val();
		var area = $("[name='input_area']").val();
		var postCode = $("[name='youbian']").val();
		var address = $("[name='dizhi']").val();
		var addresseeName = $("[name='consignee']").val();
		var telephone = $("[name='phone']").val();
		var tableKey = $("[name='tableKey']").val();

		$
				.ajax({
					url : "busShoppCart/addSite.do",
					data : {
						"tableKey" : tableKey,
						"province" : province,
						"city" : city,
						"area" : area,
						"postCode" : postCode,
						"address" : address,
						"addresseeName" : addresseeName,
						"telephone" : telephone
					},
					type : "post",
					boforeSend:function(){
						$(".mains").html(	 "<div class='warn-box'>"
								+	"<div class='warn-infos'>"        
								+	           "<div class='onload-img'><img src='frame/static/picture/onload.png'></div>" 
								+	            "<div class='warn-texts'>正在努力为您加载!请耐心等待...</div>"
								+	       " </div>"
								+	    "</div>"		);
					},
					success : function(data) {
						if (!data.success) {
							layer.open({
								title : '错误信息',
								content : data.msg
							});
						} else {
							layer
									.open({
										content : '修改地址成功',
										end : function() {
											location.href = "goods/toConfirmOrderApp.do?vue=update";
										}
									});
						}
					}
				});
	}

	//更多地址
	function addressMore() {

		//删除
		$(".address-lis")
				.on(
						'click',
						".delete",
						function() {
							var val = $(this).parent().prev().children()
									.children("[name=tableKey]").val();
							$
									.ajax({
										url : "busShoppCart/deleteSite.do",
										data : {
											"tableKey" : val
										},
										dataType : "json",
										type : "post",
										boforeSend:function(){
											$(".mains").html(	 "<div class='warn-box'>"
													+	"<div class='warn-infos'>"        
													+	           "<div class='onload-img'><img src='frame/static/picture/onload.png'></div>" 
													+	            "<div class='warn-texts'>正在努力为您加载!请耐心等待...</div>"
													+	       " </div>"
													+	    "</div>"		);
										},
										success : function(data) {
											if (data.success) {
												location.href = "goods/toConfirmOrderApp.do?vue=update";
											} else {
												layer.open({
													title : '错误信息',
													content : data.msg
												});
											}
										}
									});
						});

		$(".address-lis").show();//2-页面
		$(".arrow-box").hide();//1-标签
		$(".geng-duo-di-zhi").hide();//1-标签
		$(".address-pri").hide();//1-头
		$(".footer").hide();//1-脚
		$(".address-box").hide();//1-地址页面
		$(".lists-box").hide();//1-商品页面
		$(".address-more").show();//2-头

		///设为默认
		$(".address-lis").on("click", ".check-span", function() {
			var val = $(this).prev().children("[name=tableKey]").val();
			$.ajax({
				url : "busShoppCart/defaultAddress.do",
				data : {
					"tableKey" : val
				},
				dataType : "json",
				type : "post",
				boforeSend:function(){
					$(".mains").html(	 "<div class='warn-box'>"
							+	"<div class='warn-infos'>"        
							+	           "<div class='onload-img'><img src='frame/static/picture/onload.png'></div>" 
							+	            "<div class='warn-texts'>正在努力为您加载!请耐心等待...</div>"
							+	       " </div>"
							+	    "</div>"		);
				},
				success : function(data) {
					if (data.success) {
						location.href = "goods/toConfirmOrderApp.do";
					} else {
						layer.open({
							title : '错误信息',
							content : data.msg
						});
					}
				}
			});
		});

		//修改地址
		$(".address-lis").on('click', ".update-btn", function() {
			var trMould = $(this).parent().prev().children();

			$(".mains").hide();//2-页面
			$(".header").hide();//2-头
			$(".addressAdd").show();//3-头 & 3-页面
			$(".insert").hide();//3-新增按钮
			$(".update").show();//3-修改按钮
			siteUpdate(trMould);
			$(".update").click(function() {
				siteUpdate_verification();
			});
		});

	}
</script>