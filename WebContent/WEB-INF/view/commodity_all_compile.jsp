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
<title>商品管理-所有商品</title>
<link rel="stylesheet" type="text/css" href="frame/static/css/padding_and_marign.css">
<link rel="stylesheet" type="text/css" href="frame/static/css/commonality.css"/>
<link rel="stylesheet" type="text/css" href="frame/layui/css/layui.css" />
<link rel="stylesheet" type="text/css" href="frame/static/css/commodityCompile.css" />

</head>
<body>

	<h2>修改商品价格与折扣信息</h2>
	<hr />
	<form action="" method="post" onsubmit="return false" id="postForm">
		<input type="hidden" value="${tableKey}" id="goodsKey" />
		<div class="danjia">
			<label>商品单价：</label>
			<input type="text" class="margin-right-10" id="goodsPrice" goodsNo="${goodsNo}" name="goodsPrice"/>元
		</div>
		<div id="discount">
			
		</div>
		<hr />
		<div class="affirm_button">
			<input type="button" value="取消" class="cancel"/>
			<input type="submit" value="确定修改" class="affirm" />
		</div>
	</form>
		
</body>
</html>
<script type="text/javascript" src="frame/static/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="frame/static/layer/layer.js"></script>
<script type="text/javascript" src="frame/layui/layui.js"></script>
<script type="text/javascript" src="frame/static/js/company.js"></script>
<script type="text/javascript" src="frame/static/js/baiduTemplate.js"></script>
<script id="bd_t1" type="text/template">
	<*for(var key in list){*>
		<*var temp = list[key]*>
		<*var temp2 = list2[key]*>
		<label><*=temp.discountObject*>：</label>
		<input class="margin-right-10" type="text" gradeNo="<*=temp.gradeNo*>" name="<*=temp2.tableKey*>" value="<*=temp2.discountRate==null?'10':temp2.discountRate*>"/>折
	<*}*>
</script>
<script type="text/javascript">
$(function(){
	baidu.template.LEFT_DELIMITER='<*';
	baidu.template.RIGHT_DELIMITER='*>';
	var tableKey=$("#postForm input[type=hidden]").val();
	$.ajax({
		url:"goods/getDiscountPrice.do",
		data:{"tableKey":tableKey},
		type:"post",
		success:function(data){
			var goodsAll=data.obj;
			if(data.success){
				$("#goodsPrice").val(goodsAll.goodsPrice);
				var html=baidu.template('bd_t1',goodsAll);
				$("#discount").html(html);
			}else{
				alert("获取信息失败，请重试");
			}
		}
	});
	$(document).on('click','.cancel',function(){							
		parent.layer.closeAll(); //再执行关闭    
   	});
   	
	$(".affirm").click(function(){
		var goodsPrice=$("#goodsPrice").val();
		var goodsKey=$("#goodsKey").val();
		var goodsNo=$("#goodsKey").attr("goodsNo");
		var flag=1;
		var pricePattern=new RegExp("^[1-9]?\\d+(\\.\\d{1,2})?$");
		var param={};
		
		//价格验证
		if(!pricePattern.test(goodsPrice)){
			var index = layer.msg('请填入正确价格，保留两位小数', {icon: 2,time: 2000});
 			return false;
 		}
		param["goodsPrice"]=goodsPrice;
		param["goodsKey"]=goodsKey;
		param["goodsNo"]=goodsNo;
		var discountPattern=new RegExp("^([0-9]{1}(\.[0-9]{1})?)?$");
		var discountArray=new Array();
		
		$("#discount").find("input").each(function(){
			var discoun={};
			var discount=$(this).val();
			if(!discountPattern.test(discount)){
	 			if(discount!=10){
	 				flag=0;
	 				layer.msg('输入正确的折扣，保留一位小数', {icon: 2,time: 2000});
		 			return false;
	 			}
	 		}
			discoun["discount"]=$(this).val();
			discoun["tableKey"]=$(this).attr("name");
			discoun["gradeNo"]=$(this).attr("gradeNo");
	 		if(discoun["discount"]!=""&&discoun["discount"]==0){
	 			flag=0;
	 			layer.msg('输入正确的折扣，保留一位小数', {icon: 2,time: 2000});
	 			return false;
	 		}
			discountArray.push(discoun);
		});
		if(flag==0){
			return false;
		}
		param["discount"]=discountArray;
		param=JSON.stringify(param);
		$.ajax({
			url:"goods/updateDiscountPrice.do",
			data:{"param":param},
			type:"post",
			dataType:"json",
			success:function(data){
				if(data.success){
					layer.msg('操作成功', {icon: 1,time: 2000},
						function(){parent.location.reload();}		
					);
				}else{
					layer.open({
						 title: '错误信息'
						 ,content:data.msg
					}); 
				}
			}
		});
	});
	
	//折扣验证
	$("#discount").on("change","input[type='text']",function(){
		var discount=$(this).val();
		var pattern=new RegExp("^([0-9]{1}(\.[0-9]{1})?)?$");
 		if(!pattern.test(discount)){
 			if(discount!=10){
 				layer.msg('输入正确的折扣，保留一位小数', {icon: 2,time: 2000});
 	 			return false;
 			}
 		}else{ 	
 			if(discount!=""&&discount==0){
 				layer.msg('输入正确的折扣，保留一位小数', {icon: 2,time: 2000});
	 			return false;
	 		}
 		}
	});
	//价格验证(正数，保留两位小数)
	$("input[name='goodsPrice']").change(function(){
		var goodsPrice=$(this).val();
		var pattern=new RegExp("^[1-9]?\\d+(\\.\\d{1,2})?$");
		if(!pattern.test(goodsPrice)){
			layer.msg('请填入正确价格，保留两位小数', {icon: 2,time:2000});
 			return false;
 		}else{
 			//为价格后面添加小数位数，没有小数则添加".00",一位则添加".0",保证至少有两位小数
 			if(goodsPrice.indexOf(".")==-1){
 				goodsPrice+=".00";	
				$(this).val(goodsPrice);
 			}else{
 				var temp=goodsPrice.substring(goodsPrice.indexOf(".")+1,goodsPrice.length);	
	 			if(temp.length==1){
	 				goodsPrice+="0";	
 					$(this).val(goodsPrice);
	 			}
 			}
 		}
	});
});
</script>