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
<link rel="stylesheet" type="text/css" href="frame/static/css/invoiceMask.css">
<link rel="stylesheet" type="text/css" href="frame/layui/css/layui.css" />
<link rel="stylesheet" type="text/css"
	href="frame/static/css/indentIndent.css" />
<title>发票管理</title>
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
	<input type="hidden"  class="sendName">
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
        <div class="tits-sel">填写收票地址(带<span style="color: #d5090c">*</span>号为必填项)</div>
        <table cellpadding="0" cellspacing="0" class="fl tab2" style="width: 100%;">
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
           		<td class="tit-td"><span>*</span>地址:</td>
           		<td class="td-items">
				<label style="margin-left: -9%;">省:</label>
				<select name="input_province" id="input_province" class="form-control" style="height: 34px;line-height: 36px;">
				</select>
				<label>市:</label>
				<select name="input_city" id="input_city" class="form-control" style="height: 34px;line-height: 36px;">;
				</select>
				<label>区:</label>
				<select name="input_area" id="input_area" class="form-control" style="height: 34px;line-height: 36px;">;
				</select>
           		</td>
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
					<li class="choice"><a style="width: 137px;">未开发票订单（<span id="buyerNoInvoice"></span>）
					</a></li>
					<li><a style="width: 137px;">已开发票订单（<span id="buyerOpenInvoice"></span>）
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
<script type="text/javascript" src="frame/static/js/pdata.js"></script>

<script>
	$(function(){
		siteAdd();
	});

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
    	else if(billType=="01"  && billTitle=="001") 
        {
        	$(".mask2>.select-box>.tab2>tbody>tr:eq(0)>td:eq(0)>span").html("*");
        	$(".mask2>.select-box>.tab2>tbody>tr:eq(1)>td:eq(0)>span").html("");
        	$(".mask2>.select-box>.tab2>tbody>tr:eq(2)>td:eq(0)>span").html("");
        	$(".mask2>.select-box>.tab2>tbody>tr:eq(3)>td:eq(0)>span").html("");
        	$(".mask2>.select-box>.tab2>tbody>tr:eq(4)>td:eq(0)>span").html("");
        	$(".mask2>.select-box>.tab2>tbody>tr:eq(5)>td:eq(0)>span").html("");
        }
    	else if(billType=="01"  && billTitle=="002") 
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
             	$(this).find("td:eq(1)").find("span").html("*");   
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
    
    var myLength = $('.chooseGoOpen:checked').length;
    var nameStrr = new Array(myLength);
   
    var i=0;
    $('#btn-next2').click(function () {
    	$($('.chooseGoOpen:checked').siblings("span.uname")).each(function(){
			  var myVal =  ($(this).text()).substring(3);
			  nameStrr[i] = myVal;
			  i++;
		});
    	
    	var supplyName =  nameStrr[0];
    	 $(".sendName").val(supplyName);
    	
    	
    		if(billType=="01" && billTitle=="001")
    		{
    			var myVal1 = $(".mask2>.select-box>.tab2>tbody>tr:eq(0)>td:eq(1)").find("input").val();
    			var myVal2 = $(".mask2>.select-box>.tab2>tbody>tr:eq(1)>td:eq(1)").find("input").val();
    			if(myVal1==null || myVal1.trim()=="" ||  myVal1=="undefind"){
    				layer.msg('必填项不能为空', {
    					icon: 2,
    					time: 1500
    				});
    				
    				return;
    			}
    		}	
    		 else if(billType=="01" && billTitle=="002")
    			{
    				var myVal1 = $(".mask2>.select-box>.tab2>tbody>tr:eq(0)>td:eq(1)").find("input").val();
    				var myVal2 = $(".mask2>.select-box>.tab2>tbody>tr:eq(1)>td:eq(1)").find("input").val();
    				if(myVal1==null || myVal1.trim()=="" ||  myVal1=="undefind" || myVal2==null || myVal2.trim()=="" ||  myVal2=="undefind"){
    					layer.msg('必填项不能为空', {
    						icon: 2,
    						time: 1500
    					});
    					
    					return;
    				}
    			}	else if(billType=="02"){
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
    			$(".mask3>.select-box>.tab2>tbody>tr:eq(0)>td:eq(0)>span").html("*");
    			$(".mask3>.select-box>.tab2>tbody>tr:eq(1)>td:eq(0)>span").html("*");
    			$(".mask3>.select-box>.tab2>tbody>tr:eq(2)>td:eq(0)>span").html("");
    			$(".mask3>.select-box>.tab2>tbody>tr:eq(3)>td:eq(0)>span").html("*");
    			$(".mask3>.select-box>.tab2>tbody>tr:eq(4)>td:eq(0)>span").html("*");
    		}	
    		else if(billNatrue=="1")
    		{
    			$(".mask3>.select-box>.tab2>tbody>tr:eq(0)>td:eq(0)>span").html("");
    			$(".mask3>.select-box>.tab2>tbody>tr:eq(1)>td:eq(0)>span").html("");
    			$(".mask3>.select-box>.tab2>tbody>tr:eq(2)>td:eq(0)>span").html("*");
    			$(".mask3>.select-box>.tab2>tbody>tr:eq(3)>td:eq(0)>span").html("");
    			$(".mask3>.select-box>.tab2>tbody>tr:eq(4)>td:eq(0)>span").html("");
    		}
    	
    		
    		
    		  $(".mask3").show();
    	      $(".mask1").hide();
    	      $(".mask2").hide();
    
    });
    
    $('#btn-sumit').click(function () {
    	var myVal1 =  $(".mask3>.select-box>.tab2>tbody>tr:eq(0)>td:eq(1)").find("input").val();
		var myVal2 =  $(".mask3>.select-box>.tab2>tbody>tr:eq(1)>td:eq(1)").find("input").val();
		var myVal3 =  $(".mask3>.select-box>.tab2>tbody>tr:eq(2)>td:eq(1)").find("input").val();
		var myVal4 =  $(".mask3>.select-box>.tab2>tbody>tr:eq(4)>td:eq(1)").find("input").val();
		var input_provinceVal = $("#input_province").val();
		var input_cityVal = $("#input_city").val();
		var input_areaVal = $("#input_area").val();
		
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
    		else if(input_provinceVal==null ||  input_provinceVal.trim()=="" || input_cityVal==null ||  input_cityVal.trim()=="" ||  input_areaVal==null ||  input_areaVal.trim()==""){
    			layer.msg('必填项不能为空', {
    				icon: 2,
    				time: 1500
    			});	
    			return;
    		}
    		
    	}
    	else if(billNatrue=="1")
    	{
    		if(myVal3==null || myVal3.trim()=="" ||  myVal3=="undefind"){
    			layer.msg('必填项不能为空', {
    				icon: 2,
    				time: 1500
    			});	
    			return;
    		}
    		
    	}	
    	//订单号
    	var supplyName =  $(".sendName").val();
    	var orderNoArr = $(".sendDate").val();
    	$.ajax({
    		url:'busOrder/saveBill.do',
    		type:"post",
	    	dataType: "json", 
	    	async : false,
	        cache : false,
	        traditional: true,
		data:{
			 orderNoArr:orderNoArr,//订单编号
			"billNatrue":billNatrue,//发票状态 "1":"电子发票",  "2":"纸质发票"
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
			"billProvince":input_provinceVal,//省
			"billCity":input_cityVal,//市
			"billArea":input_areaVal,//区
		},
		/* beforeSend:function(){
			layer.msg('加载中...', {
				icon: 2,
			});
		}, */
		//
		
		success:function(data){
			if(data.success){
			  $.ajax({
				  url:"busOrder/getBillDateByName.do",
				  type:"post",
				  data:{
					  "supplyName":supplyName
				  },
			  	  success:function(data){
			  		layer.open({
	    				title:'提示'
	    				,content:'操作成功</br>发票预计'+data.obj.billArriveDate+'天内到达'
	    				,btn:['确认']
	    				,end:function(){
	    					window.location.href="${basePath}goods/toInvoicMgt.do";
	    				}
	    			});  
			  	  },
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
    var billNatrue = "2";//发票状态 "0":"电子发票","1":"纸质发票"
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
    
    
    
</script>

<script type="text/javascript">
	var curr;
	var invoicStatus;
	$(function() {
		/* $(".mask").hide();
	    $(".mask-contents").hide(); */
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
		//var invoicStatus = "";
		var pageNo = 1;
		var orderStatus = "";
		$(".head_tab>ul>li").click(function() {
			$(".head_tab>ul>li").removeClass("choice");
			$(this).addClass("choice");
		});
		/* if($("#loginName0").text()!=""){demo(curr);} */
		stateLook(curr, "090005");
	
		$(".head_tab>ul>li:eq(0)>a").click(function() {//未打印订单
			$('div.myOnlyheader').show();
			stateLook(curr, "090005");
			orderStatus = "090005";
		});
		
		$(".head_tab>ul>li:eq(1)>a").click(function() {//已打印订单
			$('div.myOnlyheader').hide();
			stateLook(curr, "090005","001");
			orderStatus = "090005";
			invoicStatus = "001";
		});
		
		
	});

	function demo(curr){
		$.ajax({
			url:'busOrder/getBuyerOrdersInvoic.do',
			data:{pageNo:curr||1},
			success:function(data){
				if(data.success){
					display(data,"","");
				}else{
					layer.open({
						 title: '错误信息'
						 ,content:data.msg
					}); 
				}
			}
		});
	}
	
	
	function stateLook(curr, orderStatus) {
		$.ajax({
			url : 'busOrder/getBuyerOrdersInvoic.do',
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
	
	function stateLook(curr, orderStatus,invoicStatus) {
		$.ajax({
			url : 'busOrder/getBuyerOrdersInvoic.do',
			data : {
				pageNo : curr || 1,
				orderStatus : orderStatus,
				invoicStatus:invoicStatus
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
			if(Row.rows[tmpguan[i][1]].invoicStatus!='001')
			{	
			content += "<input type='checkbox' class='vertical-m chooseGoOpen'>";
			}
			content += "<span class='uname'>卖家："
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
			if (Row.rows[tmpguan[i][1]].orderStatus == '090005') {
				content += "<div class='row text-bar-right'>";
				content += "<span>总计：<em class='myPrice'>￥" + price + "</em></span>";
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
						} else if(invoicStatus!=""){
							stateLook(obj.curr, orderStatus,invoicStatus);
						} 
						else {
							stateLook(obj.curr, orderStatus);
						}
					}
				}
			});
		});
	}
	function count() {
		$.ajax({
			url : 'busOrder/getBuyerOrderCountInvoic.do',
			success : function(data) {
				$("#buyerNoInvoice").text(data.obj.buyerNoInvoice);
				$("#buyerOpenInvoice").text(data.obj.buyerOpenInvoice);
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
	

	//显示对应的开发票信息
	function showGoDrawing(orderNoArr){
		$(".mask").show();
		$(".mask1").show();
		$(".sendDate").val(orderNoArr);
		
	}
	
	
	//开发票操作
	$(".goDrawing").click(function(){
		//长度
		var clength=$('.chooseGoOpen:checked').length;
		
		if(clength == 0){
			layer.msg('请选择买家', {
				icon: 2,
				time: 1500
			});
			return;
		}

		
		//orderNoArr长度
		var orderNoArr = new Array(clength);
		var i = 0;
		$($('.chooseGoOpen:checked').siblings("span.uindent")).each(function(){
			  var myVal =  ($(this).text()).substring(5);
			  orderNoArr[i] = myVal;
			  i++;
			});
		
		//将price塞入其中
		var priceArr = new Array(clength);
		var j = 0;
		$($('.chooseGoOpen:checked').parent().siblings(".text-bar-right").find(".myPrice")).each(function(){
			 var priceVal =  ($(this).text()).substring(1);
			 priceArr[j] = priceVal;
			 j++;
			});
		
		//姓名
		var nameArr = new Array(clength);
		var z = 0;
		$($('.chooseGoOpen:checked').siblings('.uname')).each(function(){
			var nameVal = ($(this).text()).substring(3);
			nameArr[z] = nameVal;
			z++;
		});
		
		for (var int = 1; int < nameArr.length; int++) {
			if(nameArr[0] != nameArr[int]){
				layer.msg('请选择相同买家</br>已选择：</br>【'+nameArr[0]+'】</br>【'+nameArr[int]+'】', {
					icon: 2,
					time: 3000
				});
				return;
			}
		}
		
		
	    $.ajax({
	    	url:"busOrder/getBuyerInvoicArr.do",
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
	    		if(data=="" || data==null)
	    		{
	    			showGoDrawing(orderNoArr);
	    		}else{
	    		
	    		layer.open({
					title : '提示',
					content : data,
				});	
	    		}
	    	},
	    });	
	});
	
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
