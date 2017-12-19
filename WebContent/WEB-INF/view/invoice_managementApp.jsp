<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
request.setAttribute("basePath", basePath);
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath %>"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <link rel="stylesheet" type="text/css" href="frame/static/css/shop.css">
    <link rel="stylesheet" type="text/css" href="frame/static/css/invoice.css">
    <title>开发票</title>
</head>
<body>
		<div class="header">
		    <div class="header-box">
		        <div class="header-img fl"><img class="l-img" src="frame/static/picture/arrow-white.png"></div>
		        <div class="text-tit fl">开具发票</div>
		    </div>
		</div>
		<div class="mains" style="overflow: auto;bottom: 0">
		    <div class="address-infos">
		        <ul>
		            <li style="margin-top: 0">
		                <div class="check-texts fl">
		                    <span>开票类型</span>
		                </div>
		                <div class="r-invoice-btn fr">
		                    <div class="top-btns">
		                        <span class="onclick-span" >电子发票</span>
		                        <span style="float: right" >纸质发票</span>
		                    </div>
		                    <div class="down-infos"></div>
		                </div>
		                <div class="clear-box"></div>
		            </li>
		            <li>
		                <div class="check-texts fl">
		                    <span style="font-size: 0.87rem">发票类型</span>
		                </div>
		                <div class="oper-texts fr" style="position: relative;">
		                    <span style="color: #999999" id="itemsTexts">请选择发票类型</span>
		                    <img class="oper-img" src="frame/static/picture/arrow.png">
		                    <select class="select-items">
		                        <option value="">普通发票</option>
		                        <option value="">增值税发票</option>
		                    </select>
		                </div>
		                <div class="clear-box"></div>
		            </li>
		        </ul>
		        <div class="li-tits">请填写发票详情</div>
		        <ul>
		         	<li>
		                <div class="check-texts fl">
		                    <span style="font-size: 0.87rem">抬头类型</span>
		                </div>
		                <div class="oper-texts fr" style="position: relative;">
		                    <span style="color: #999999" id="itemsTexts">请选择抬头类型</span>
		                    <img class="oper-img" src="frame/static/picture/arrow.png">
		                    <select class="select-items">
		                        <option value="">个人</option>
		                        <option value="">企业</option>
		                    </select>
		                </div>
		                <div class="clear-box"></div>
		            </li>
		            <li style="margin-top: 0">
		                <div class="check-texts fl">
		                    <span>单位名称</span>
		                </div>
		                <div class="oper-texts fr">
		                    <input type="text" name='companyName' placeholder="请输入单位全称">
		                </div>
		                <div class="clear-box"></div>
		            </li>
		            <li>
		                <div class="check-texts fl">
		                    <span>纳税人识别号</span>
		                </div>
		                <div class="oper-texts fr">
		                    <input type="text" name='billReceipt' placeholder="请输入识别号">
		                </div>
		                <div class="clear-box"></div>
		            </li>
		            <li style="height: auto">
		                <div class="check-texts fl">
		                    <span>注册地址</span>
		                </div>
		                <div class="address-area fr">
		                    <textarea rows="4" name='registerAddress' placeholder="请输入详细注册地址"></textarea>
		                </div>
		                <div class="clear-box"></div>
		            </li>
		            <li>
		                <div class="check-texts fl">
		                    <span>注册电话</span>
		                </div>
		                <div class="oper-texts fr">
		                    <input type="text" name='registerPhone' placeholder="请输入手机号">
		                </div>
		                <div class="clear-box"></div>
		            </li>
		            <li>
		                <div class="check-texts fl">
		                    <span>开户银行</span>
		                </div>
		                <div class="oper-texts fr">
		                    <input type="text" name='openBand' placeholder="请输入开户银行名称">
		                </div>
		                <div class="clear-box"></div>
		            </li>
		            <li>
		                <div class="check-texts fl">
		                    <span>银行账户</span>
		                </div>
		                <div class="oper-texts fr">
		                    <input type="text" name='bandCard' placeholder="请输入开户银行账号">
		                </div>
		                <div class="clear-box"></div>
		            </li>
		
		        </ul>
		        <div class="li-tits">请填写收票邮箱</div>
		        <ul>
		            <li style="margin-top: 0">
		                <div class="check-texts fl">
		                    <span>收票人姓名</span>
		                </div>
		                <div class="oper-texts fr">
		                    <input type="text" name='billReceiveName' placeholder="请输入收票人姓名">
		                </div>
		                <div class="clear-box"></div>
		            </li>
		            <li>
		                <div class="check-texts fl">
		                    <span>收票人手机号</span>
		                </div>
		                <div class="oper-texts fr">
		                    <input type="text" name='billReceivePhone' placeholder="请输入收票人手机号">
		                </div>
		                <div class="clear-box"></div>
		            </li>
		            <li>
		                <div class="check-texts fl">
		                    <span>所在地区</span>
		                </div>
		                <div class="oper-texts fr">
		                    <span style="color: #999999;font-size: 0.75rem">省/市/区</span>
		                    <img class="oper-img" src="frame/static/picture/arrow.png">
		                </div>
		                <div class="clear-box"></div>
		            </li>
		            <li style="height: auto">
		                <div class="check-texts fl">
		                    <span>详细地址</span>
		                </div>
		                <div class="address-area fr">
		                    <textarea rows="4" name='billReceiveAddress' placeholder="请输入详细地址"></textarea>
		                </div>
		                <div class="clear-box"></div>
		            </li>
		             <li class="mail">
		                <div class="check-texts fl">
		                    <span>收票人邮箱</span>
		                </div>
		                <div class="oper-texts fr">
		                    <input type="text" name='billReceiveMail' placeholder="请输入收票人邮箱">
		                </div>
		                <div class="clear-box"></div>
		            </li>
		        </ul>
		        <div class="submit-btn"><span>提交</span></div>
		    </div>
		</div>

</body>
</html>
<script type="text/javascript" src="frame/static/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="frame/static/layer/mobile/layer.js"></script>
<script type="text/javascript">
	
		 $.ajax({
				url:'busOrder/getByIds.do',
				type:"post",
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
	$(".top-btns").children().click(function(){
		$(".top-btns").children().removeClass("onclick-span");
		$(this).addClass("onclick-span");
		if($(this).text() == "纸质发票"){
			$(".address-infos ul:eq(2)").children().not(".mail").show();
			$(".address-infos ul:eq(2)").children().filter(".mail").hide();
			$(".li-tits:eq(1)").text('请填写收票地址');
		}else{
			$(".address-infos ul:eq(2)").children().not(".mail").hide();
			$(".address-infos ul:eq(2)").children().filter(".mail").show();
			$(".li-tits:eq(1)").text('请填写收票邮箱');
		}
	});
	
	$(".address-infos ul:eq(2)").children().not(".mail").hide();
	
</script>
