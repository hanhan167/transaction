$(function(){
	//筛选 查询商品
	var pageNo = 1; //默认第一页
	var brand = null; //产品品牌
	var name = null; //产品名称
	var pyname = null; //产品规格详情
	var code = null; //产品代码
	var gg =null; //产品规格
	var W01CodesList = null;//数控刀片类特殊处理
	//获取左边选中的刀具类型
	var goodsType=$("#gType",parent.document).val();
	code = goodsType;
	
	trademark();
function trademark(){
	var rade = Grade();
	$.ajax({
		url:"goods/getTopMenu.do",
		type:"post",
		data:{"id":rade},
		success:function(data){
			var mom = data.obj;
			if(data.success){
				$("#right_top").html('');
				var contont='<div class="items" id="brand">';
				contont+='<div class="items-tit fl">选择品牌</div>';
				contont+='<div class="items-box fl">';
				contont+='<span data-key="brand" data-v="" class="on-red" data-id="">所有</span>';
				for(var i in mom){
					contont+='<span data-key="brand" data-id="'+mom[i].brandNo+'" data-v="'+mom[i].brandName+'">'+mom[i].brandName+'</span>';
				}
				contont+='</div>';
				contont+='<div style="clear:both"></div>';
				contont+='</div>';
				contont+='<div style="clear:both"></div>';
				$("#right_top").html(contont);
				var grade = Grade();
				for(var num=0;num<=10;num++){
					if((grade == "")||(grade == undefined)){
						//trademark();
						//layer.msg("左侧菜单加载失败！");
					}else{
						break;
					}
					if(num==10){
						//layer.msg("左侧菜单加载失败！");
						return false;
					}
				}
				demo("",grade);
				$(".specifica").find("span:eq(0)").addClass("on-red");
			}else{
				layer.msg("获取商品失败");
			}
		}
	});
}
	
	$(".Screening>.items>a").click(function(){
		var val = $(".Screening>.items>input").val();
		fiflterCommodity(val,pageNo);
	});
	function startAndEnd(text,tableKey){
		var tit='';
		if(text == "启用") { tit = "禁用" }else{tit = "启用"}
		layer.msg('您确定要'+tit+'该商品么？', {
			time: 0 //不自动关闭
			,btn: ['确定', '取消']
			,yes: function(index){
				layer.close(index);
			    var ind = layer.msg('修改商品状态中,请稍等...', {icon: 16,time: 0});
			 	$.ajax({
		 			url:'goods/startAndEnd.do',
		 			data:{"tableKey":tableKey},
		 			type:"post",
		 			success:function(data){
		 				layer.closeAll();
						if(data.success){
							layer.msg(data.msg, {icon: 1,time: 1000},function(){
								location.reload();
							});
						}else{
							layer.msg(data.msg, {icon: 2,time: 1000},function(){
								location.reload();
							});
						}
			  		  	demo("",grade);
		 			}
		 		});
			}
		});
	}
	
	$(document).on("click",".start",function(){
		var dataId = $(this).attr("data-id");
		var text = $(this).text();
		startAndEnd(text,dataId);
	});
	
	$(document).on("click",".commodityEdit",function(){
		var dataId = $(this).attr("data-id");
		edit(dataId);
	});
	
	function fiflterCommodity(val,pageNo){
		var brands = "";
		if(goodsType!="W01"){brands = brand;}
		$('#fiflterCommodity').html('<span style="font-size:20px;display:inline-block;width:100%;height:40px;line-height:40px;text-align:center;margin-top:170px;">加载中...</span>');
		$.ajax({
			type:"post",
			url:"goods/getCommodityAll.do",
			datatype:'json',
			data:{
				pageNo : pageNo,
				brand : brands,
				name : name,
				gg : gg,
				//code : code,
				code : "",
				pyname : pyname,
				"query":val
			},
			success:function(data){
				if(data.success){
					$(".commodityDetail").empty();
					$(data.obj.rows).each(function (n, Row) {
						var content="";
						content+="<div class='upDown1'>";
						content+="<div class='layui-form'>";
						content+="<table class='layui-table'>";
						content+="<colgroup>";
						content+="<col width='120'><col width='270'><col width='50'><col width='70'><col width='90'><col width='50'><col width='70'><col width='80'><col width='110'><col width='85'><col>";
						content+="</colgroup>";
						content+="<tbody>";
						content+="<tr>";
						content+="<td><input type='checkbox' name='' lay-skin='primary' class='Checked'><p title='"+Row.id+"' style='overflow: hidden;text-overflow: ellipsis;white-space: nowrap;width: 109px;'>"+Row.id+"</p></td>";
						content+="<td><p class='commoditySize'>"+Row.guige+"</p></td>";
						content+="<td>"+Row.kc+"</td>";
						content+="<td><p class='start' data-id="+Row.tableKey+"><a>"+Row.goodsStatus+"</a></p></td>";
						content+="<td>"+(Row.minkc!=null?Row.minkc:'')+"</td>";
						content+="<td><p title='"+Row.goodsPrice+"' style='overflow: hidden;text-overflow: ellipsis;white-space: nowrap;width: 39px;'>"+Row.goodsPrice+"</p></td>";
						content+="<td><a><p class='checkThis'>查看</p></a></td>";
						content+="<td><p class='commodityEdit' data-id="+Row.tableKey+"><a>编辑</a></p></td>";
						content+="</tr>";
						content+="</tbody>";
						content+="</table>";
						content+="</div>";
						content+="<div class='checkLevel'>";
						content+="<ul class='levelMove'>";
						content+="<li class='levelColor'>等级：</li>";
						content+="<li>一级用户</li>";
						content+="<li>二级用户</li>";
						content+="<li>三级用户</li>";
						content+="<li>四级用户</li>";
						content+="</ul>";
						content+="</div>";
						content+="<div class='checkLevel'>";
						content+="<ul class='levelMove'>";
						content+="<li class='levelColor'>折扣：</li>";
						for(var i=0;i<Row.list.length;i++){
							content+="<li>"+Row.list[i].discountRate+"</li>";
						}
						content+="</ul>";
						content+="</div>";
						content+="</div>";
				   		$(".commodityDetail").append(content);
			        }); 
					reinitIframe();
					var totalPage=Math.ceil(eval(data.obj.total/data.obj.pageSize));
					$('#conuntPage').html('总共 '+totalPage+' 页');
				    //显示分页
					layui.use(['laypage', 'layer'], function(){
						var laypage = layui.laypage;
						var layer = layui.layer;
						laypage({
							cont: 'demo3', //容器。值支持id名、原生dom对象，jquery对象。【如该容器为】：<div id="page1"></div>
							pages: totalPage, //通过后台拿到的总页数
							curr: pageNo, //当前页
							jump: function(obj, first){ //触发分页后的回调
								if(!first){ //点击跳页触发函数自身，并传递当前页：obj.curr
						        	pageNo = obj.curr;
									fiflterCommodity(val,pageNo);
						        }
							}
						});
					});
				}else{
					layer.open({
						 title: '错误信息'
						 ,content:data.msg
					}); 
				}
			}
		});
	}
	function repalseW01_(key){
		if(key == 'ggs'){
			$("#pynames").html("");
			var obj = W01CodesList["W01"+brand];
			var templatevalues=' ';
			if(obj!=null){
				var templatevaluesArr = obj.templatevalues.split(',');
				for(var j in templatevaluesArr){
					var temp = templatevaluesArr[j];
					templatevalues += '<span data-key="gg" data-v="'+temp.substring(temp.lastIndexOf("(")+1,(temp.length-1)) +'">'+temp+'</span>';
				}
			}
			$("#ggs").html(templatevalues);
		}
		if(key == 'pynames'){
			var obj = W01CodesList["W01"+gg];
			var templatevalues=' ';
			if(obj!=null){
				var templatevaluesArr = obj.templatevalues.split(',');
				for(var j in templatevaluesArr){
					var temp = templatevaluesArr[j];
					templatevalues += '<span data-key="pyname" data-v="'+temp.substring(temp.lastIndexOf("(")+1,(temp.length-1)) +'">'+temp+'</span>';
				}
			}
			$("#pynames").html(templatevalues);
		}
	}
	//条件筛选
	$(document).on('click','.specifica span',function(){
		var my = $(this);
		my.siblings().removeClass('on-red');
		my.addClass('on-red');
		var uerdid = my.attr("data-id");
		if(uerdid == undefined){
			uerdid = "";
		}
		my.parent().parent().nextAll(".items").remove();
		demo("",uerdid);
	});
	
	//商品goodsCode改变时改变规格
	$("#model").change(function(){
		if($(this).val()!="请选择商品codes"){
			var goodsCode=$(this).val();
			$.ajax({
				url:"goods/getByGoodsCode.do",
				data:{"goodsCode":goodsCode},
				type:"post",
				success:function(data){
					$("#thisname").empty();
					var guige=data.obj;
					$("#thisname").append("<option value=''>商品规格</option>");
					for(var i in guige){
						var html="<option value='"+guige[i].tableKey+"'>"+guige[i].guige+"</option>";
						$("#thisname").append(html);
					}
				}
			});
		}
	});
	$('.commodityDetail').on('click','.checkThis',function(){
		if($(this).text() == '查看'){
			$(this).text('收起').parents('.upDown1').css({height:'110px'});
		}else{
			$(this).text('查看').parents('.upDown1').css({height:'48px'});
		}
		reinitIframe();
	});
	
	$("#shop_select").on("click",".shop_mode",function(){
		$(this).addClass('on-red').siblings().removeClass('on-red');
		select_mode($(this).attr("data-id"),pageNo);
	});
	var jisu = 0;
	$("#shop_select").on("click","#div_select",function(){
		if(jisu == 0){
			$("#shop_select").css({"height":"auto"});
			$("#div_select").text("收起");
			jisu = 1;
		}else{
			$("#shop_select").css({"height":"82px"});
			$("#div_select").text("更多");
			jisu = 0;
		}
	});

	function filtrate(classTypeId){
		var brand;
		var brandNo="";
		for(var i=0;i<$("#brand .items-box span").length;i++){
			if($($("#brand .items-box span")[i]).attr("class")=="on-red"){
				brand = $($("#brand .items-box span")[i]).attr("data-v");
				brandNo= $($("#brand .items-box span")[i]).attr("data-id");
			}
		}
		if(classTypeId==null){
			classTypeId="";
		}
		$.ajax({
			url:"goods/getDataCpmlss.do",
			data:{"classTypeId":classTypeId,"brand":brand,"brandNo":brandNo},
			type:"post",
			success:function(data){
				$("#shop_select").empty();
				var shop_option = '';
				if(data.obj.length > 0){
					shop_option+='<div class="specification">选择规格<button>一键修改</button><span id="div_select">更多</span></div>';
					for(var i in data.obj){
						shop_option+='<div class="shop_mode" data-id='+data.obj[i].code+'>'+data.obj[i].name1+'</div>';
					}
					shop_option+='<div style="clear:both"></div>';
					
					select_mode(data.obj[0].code,pageNo);
				}else{
					shop_option+='<div style="line-height:32px;text-align:center;margin-top:15px">未查询到符合条件的数据！</div>';
				
				}
				$("#shop_select").html(shop_option);
				$("#shop_select .shop_mode:eq(0)").addClass("on-red");
				$(".commodityDetail").html("<div style='background-color:#fff;line-height:32px;text-align:center;margin-top:15px'>未查询到符合条件的数据！</div>");
			}
		});
	}
	function Grade(){
		var grade;//左侧类型
		var li_a = $(window.parent.document).find("#gType").val();
		var li_calss=$(window.parent.document).find("#menu").children("li.layui-nav-item");
		
		for(var i=0;i<li_calss.length;i++){
			var li_a_text = $($(window.parent.document).find("#menu").children("li.layui-nav-item")[i]).text();
			if(li_a == li_a_text){
				grade = $($(window.parent.document).find("#menu").children("li.layui-nav-item")[i]).children("a").attr("goodsgrade");
				break;
			}
		}
		return grade;
	}
	var oneKey =0;
	function demo(brandId,grade){
		var vercol = true;
		var brands = "";
		var gradeNum = grade;
		if(goodsType!="W01"){brands = brand;}
		oneKey ++;
		$.ajax({
			url:"goods/getByGradeAndBrand.do",
			data:{"grade":grade,"brandId":brandId},
			type:"post",
			success:function(data){
				if(data.success){
					var contont='<div class="items specifica">';
					contont+='<div class="items-tit fl">选择规格</div>';
					contont+='<div class="items-box fl">';
					for(var i in data.obj){
						contont+='<span data-key="brand" data-v="'+data.obj[i].chName+'" data-id="'+data.obj[i].id+'">'+data.obj[i].chName+'</span>';
					}
					contont+='</div>';
					contont+='<div style="clear:both"></div>';
					contont+='</div>';
					contont+='<div style="clear:both"></div>';
					var gType = $(window.parent.document).find("#gType").val();
					if(data.obj.length<=0){
						vercol = false;
					}
					if(vercol){
						gradeNum = data.obj[0].id;
					}
					if((gType=="刀具")||(gType=="刀片")){
						if(data.obj.length<=0){
							filtrate(gradeNum);
						}else{
							$("#right_top").append(contont);
							var grade = data.obj[0].id;
							demo("",grade);
						}
					}else{
						if(data.obj.length>0){
							$("#right_top").append(contont);
						}
						filtrate(gradeNum);
					}
					if(oneKey <=1){
						$(".specifica .items-box").find("span:eq(0)").addClass("on-red");
					}
				}else{
					layer.open({
						 title: '错误信息'
						 ,content:data.msg
					}); 
				}
			}
		});
	}
	function reinitIframe(){
		var parent = window.parent;
		var iframe = parent.document.getElementById("iFrame");
		var bHeight = iframe.contentWindow.document.body.scrollHeight;
		var dHeight = iframe.contentWindow.document.documentElement.scrollHeight;
		var height = Math.max(bHeight, dHeight);
		iframe.height = height;
	}
	function select_mode(click_div,pageNo){
		var code = click_div;
		var before;
		$.ajax({
			url:"goods/getDataCpmlss1.do",
			data:{"code":code,"pageNo":pageNo,"isSell":0},
			type:"post",
			beforeSend:function(){
				before = layer.msg('查询中...', {
				  icon: 16
				  ,shade: 0.01
				  ,time:0
				});
			},
			success:function(data){
				layer.close(before);
				if(data.success){
					$(".commodityDetail").empty();
					var content="";
					var rows = data.obj.rows;
					if(rows.length > 0){
						$(data.obj.rows).each(function (n, Row) {
							content+="<div class='upDown1'>";
							content+="<div class='layui-form'>";
							content+="<table class='layui-table' style='table-layout:fixed'>";
							content+="<colgroup>";
							content+="<col width='120'><col width='120'><col width='220'><col width='100'><col width='70'><col width='90'><col width='50'><col width='70'><col width='80'>";
							content+="</colgroup>";
							content+="<tbody>";
							content+="<tr>";
							content+="<td><input type='checkbox' name='' lay-skin='primary' class='Checked'><p title='"+Row.id+"' style='overflow: hidden;text-overflow: ellipsis;white-space: nowrap;width: 109px;'>"+Row.id+"</p></td>";
							content+="<td>"+Row.cpdmBrand+"</td>";
							content+="<td><p class='commoditySize' title='"+Row.guige+"' >"+Row.guige+"</p></td>";
							content+="<td>"+Row.kc+"</td>";
							content+="<td><p class='start' data-id="+Row.tableKey+"><a>"+Row.status+"</a></p></td>";
							content+="<td>"+(Row.minkc!=null?Row.minkc:'')+"</td>";
							content+="<td><p title='"+Row.jiage+"' style='overflow: hidden;text-overflow: ellipsis;white-space: nowrap;width: 39px;'>"+Row.jiage+"</p></td>";
							content+="<td><a><p class='checkThis'>查看</p></a></td>";
							content+="<td><p class='commodityEdit' data-id="+Row.tableKey+"><a>编辑</a></p></td>";
							content+="</tr>";
							content+="</tbody>";
							content+="</table>";
							content+="</div>";
							content+="<div class='checkLevel'>";
							content+="<ul class='levelMove'>";
							content+="<li class='levelColor'>等级：</li>";
							content+="<li>一级用户</li>";
							content+="<li>二级用户</li>";
							content+="<li>三级用户</li>";
							content+="<li>四级用户</li>";
							content+="</ul>";
							content+="</div>";
							content+="<div class='checkLevel'>";
							content+="<ul class='levelMove'>";
							content+="<li class='levelColor'>折扣：</li>";
							//折扣
							for(var i=0;i<data.map[Row.cpdm].length;i++){
								content+="<li>"+data.map[Row.cpdm][i].discountRate+"</li>";
							}
							content+="</ul>";
							content+="</div>";
							content+="</div>";
				        });
					}else{
						content+="<div style='background-color:#fff;line-height:32px;text-align:center;margin-top:15px'>未查询到符合条件的数据！</div>";
					}
					$(".commodityDetail").append(content);
			        reinitIframe();
			        var totalPage=Math.ceil(eval(data.obj.total/data.obj.pageSize));
			        $('#conuntPage').html('总共 '+totalPage+' 页');
				    //显示分页
				    layui.use(['laypage', 'layer'], function(){
						var laypage = layui.laypage;
						var layer = layui.layer;
						laypage({
							cont: 'demo3', //容器。值支持id名、原生dom对象，jquery对象。【如该容器为】：<div id="page1"></div>
						    pages: totalPage, //通过后台拿到的总页数
						    curr: pageNo, //当前页
						    jump: function(obj, first){ //触发分页后的回调
						    	if(!first){ //点击跳页触发函数自身，并传递当前页：obj.curr
						        	pageNo = obj.curr;
						          	select_mode(click_div,pageNo);
						        }
						    }
						});
					});
				}else{
					layer.open({
						title: '错误信息'
						,content:data.msg
					}); 
				}
			},error:function(){
				layer.close(before);
			}
		});
	}
	//编辑
	function edit(tableKey){
	    layui.use('layer', function(){
			var layer = layui.layer;
			layer.open({
				type:2,
				shade:0,
				title: '修改商品价格与折扣信息',
				area:['500px','520px'],
				resize:false,
				content: ['goods/toEdit.do?tableKey='+tableKey,'no']
			});
		});
	}
	
	//选择品牌
	$(document).on('click','#brand span',function(){
		var my = $(this);
		my.addClass('on-red').siblings().removeClass('on-red');
		var brandId = my.attr("data-id");
		if(brandId == undefined){
			brandId = "";
		}
		var grade;
		var li_a = $(window.parent.document).find("#gType").val();
		var li_calss=$(window.parent.document).find("#menu").children("li.layui-nav-item");
		for(var i=0;i<li_calss.length;i++){
			var li_a_text = $($(window.parent.document).find("#menu").children("li.layui-nav-item")[i]).text();
			if(li_a == li_a_text){
				grade = $($(window.parent.document).find("#menu").children("li.layui-nav-item")[i]).children("a").attr("goodsgrade");
				break;
			}
		}
		$(".specifica").remove();
		demo(brandId,grade);
	});
	var update_discount='<div class="update_discount">';
	update_discount+='<label>最小起订数量：</label><input name="dsMinkc" value="10"><br>';
	update_discount+='<label>递增量：</label><input name="orderIncrement" value="10"><br>';
	update_discount+='<label>默认交期：</label><input name="defaultPayDat" value="10"><br>';
	update_discount+='<label>等级1：</label><input name="discountRate1" value="10"><br>';
	update_discount+='<label>等级2：</label><input name="discountRate2" value="10"><br>';
	update_discount+='<label>等级3：</label><input name="discountRate3" value="10"><br>';
	update_discount+='<label>等级4：</label><input name="discountRate4" value="10"><br>';
	update_discount+='</div>';
	
	$(document).on("click",".specification>button",function(){
		layer.open({
			title: '修改折扣'
			,content:update_discount
			,shade:0
			,yes:function(){
				var update_input = $(".update_discount input").length;
				var current = true;
				for(var i=0;i<update_input;i++){
					if($($(".update_discount input")[i]).val().length==0){
						current = false;
						$($(".update_discount input")[i]).css("border","2px solid red");
						break;
					}else{
						current = true; 
						$($(".update_discount input")[i]).css("border","2px solid rgb(238,238,238)");
					}
				}
				if(current){
					var tbusOrderDiscountVO={
						classId:$(".specifica .items-box:last span.on-red").attr("data-id"),
						dsMinkc:$("[name=dsMinkc]").val(),
						orderIncrement:$("[name=orderIncrement]").val(),
						defaultPayDat:$("[name=defaultPayDat]").val(),
						discountRate1:$("[name=discountRate1]").val(),
						discountRate2:$("[name=discountRate2]").val(),
						discountRate3:$("[name=discountRate3]").val(),
						discountRate4:$("[name=discountRate4]").val(),
					}
					$.ajax({
						url:"goods/updateDiscounts.do",
						type:"post",
						data:tbusOrderDiscountVO,
						datatype:'json',
						success:function(data){
							if(data.success){
								location.reload();
							}else{
								layer.open({
									title: '错误信息'
									,content:data.msg
								}); 
							}
						}
					});
				}
			}
		}); 
	});
});