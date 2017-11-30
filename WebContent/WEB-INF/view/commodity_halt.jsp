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
<title>商品管理-下架商品</title>
<!-- 该页面独有css -->
<link rel="stylesheet" type="text/css" href="frame/static/css/commodity_halt.css"/>
</head>
<body>

	<h4>下架商品</h4>
	<table style="width:100%;" class="sheet">
		<!-- 内容展示区域 -->
	</table>
	
	<div id="demo"></div>
		
</body>
</html>
<script type="text/javascript">
layui.config({
	 dir: 'frame/layui/' //layui.js 所在路径（注意，如果是script单独引入layui.js，无需设定该参数。），一般情况下可以无视
	 ,version: false //一般用于更新模块缓存，默认不开启。设为true即让浏览器不缓存。也可以设为一个固定的值，如：201610
	 ,debug: false //用于开启调试模式，默认false，如果设为true，则JS模块的节点会保留在页面
	 ,base: 'frame/layui/' //设定扩展的Layui模块的所在目录，一般用于外部模块扩展
});
var page;
//运行
demo(1);
//以下将以jquery.ajax为例，演示一个异步分页
function demo(curr){
	$.ajax({
		url:'goods/getCommodityAll.do',
		data:{pageNo:curr||1,goodsStatus:"1"},
		success:function(data){
			if(data.success){
				 var tableHeader='<tr class="bg-fff">'+
								'<th>商品</th>'+
								'<th>品牌</th>'+
								'<th>规格</th>'+
								'<th>单价</th>'+
								'<th>折扣</th>'+
								'<th>操作</th></tr><tr style="height:20px;">'+'</tr>';
				 $(".sheet").empty().html(tableHeader);
				 if(curr>1&&data.obj.rows.length==0){
					 demo(curr-1);
				 }
		          $(data.obj.rows).each(function (n, Row) {
				  	  var content = "";
					  var level="";
					  for(i in Row.list){
								level+='<p>'+Row.list[i].discountObject+"："+Row.list[i].discountRate+'折</p>';
					  }
				  	  content = '<tr class="bg-fff text-r">'+
							    '<td colspan="6" class="fs12 font-888 padding-right-40">商品代码：'+Row.goodsNo+'</td></tr>'+
								'<tr class="bg-fff text-c">'+
								'<td class="text-l">'+
								'<p class="w-300 text-overflow" title="'+Row.goodsName+'">'+Row.goodsName+'</p>'+
								'<p class="font-666 fs12 w-300 text-overflow margin-top-10" title="'+Row.goodsDetail+'">'+Row.goodsDetail+'</p></td>'+
								'<td><p>'+Row.brandName+'</p></td><td><p>'+Row.guige+'</p></td><td>'+
								'<p>￥'+Row.goodsPrice+'</p></td><td>'+ level +'</td><td><p>'+
								'<a class="condition" href="javascript:;" style="color:'+(Row.goodsStatus=='1'?'#666666':'#ec7720')+'" onclick="updateStatus(\''+Row.tableKey+'\',this)">'+(Row.goodsStatus=='1'?'停用':'启用')+'</a></p><p>'+
								'<a class="redact" href="javascript:;" onclick="edit(\''+Row.tableKey+'\')">编辑</a></p></td></tr>'+
								'<tr style="height:10px;"></tr>';
			   		  $(".sheet").append(content);
		          }); 
		          var totalPage=Math.ceil(eval(data.obj.total/data.obj.pageSize));
			    //显示分页
			    layui.use(['laypage', 'layer'], function(){
					var laypage = layui.laypage;
					var layer = layui.layer;
					laypage({
						cont: 'demo', //容器。值支持id名、原生dom对象，jquery对象。【如该容器为】：<div id="page1"></div>
					      pages: totalPage, //通过后台拿到的总页数
					      curr: data.obj.pageNo || 1, //当前页
					      skin: '#03A1A4',
					  	  groups:5,
					  	  prev:"<",
					  	  next:">",
					      jump: function(obj, first){ //触发分页后的回调
					        if(!first){ //点击跳页触发函数自身，并传递当前页：obj.curr
					        	page = obj.curr;					        
						        demo(page);
					        }
					      }
					});
				}); 
			 }else{
				 alert(data.msg);
			 }
		}
	});
};

//更新状态
function updateStatus(tableKey,element){
	if($(element).text()=='启用'){
		var status="0";
		$.ajax({
			url:"goods/goodsShelf.do",
			data:{"tableKey":tableKey,"status":status},
			success:function(data){
				if(data.success){
					demo(page);
					alert(data.msg);
				}else{
					alert(data.msg);
				}
			}
		});
	}else{
		var status="1";
		$.ajax({
			url:"goods/goodsShelf.do",
			data:{"tableKey":tableKey,"status":status},
			success:function(data){
				if(data.success){
					demo(page);
					alert(data.msg);
				}else{
					alert(data.msg);
				}
			}
		});
	}
}
</script>