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
	//商户所有goodsCode
	var rade = Grade();
	console.log(rade);
	$.ajax({
		url:"goods/getTopMenu.do",
		type:"post",
		data:{"id":rade},
		success:function(data){
			console.log(rade)
			var mom = data.obj;
			if(data.success){
				$("#right_top").html('');
				var contont='<div class="items" id="brand">';
				contont+='<div class="items-tit fl">选择品牌</div>';
				contont+='<div class="items-box fl">';
				contont+='<span data-key="brand" data-v="" class="on-red">所有</span>';
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
						//window.location.reload();
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
				alert("获取失败");
			}
		}
	});
	$(".Screening>.items>a").click(function(){
		var val = $(".Screening>.items>input").val();
		fiflterCommodity(val,pageNo);
	});
	function startAndEnd(tableKey){
		layer.msg('您确定要停用或者启用该商品么？', {
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
		startAndEnd(dataId);
	});
	$(document).on("click",".commodityEdit",function(){
		var dataId = $(this).attr("data-id");
		edit(dataId);
	});
	$("#allchecked").click(function(){
		if($(this).prop("checked")){
			$("input.Checked").prop("checked",true);
		}else{
			$("input.Checked").prop("checked",false);
		}
	});
	function fiflterCommodity(val,pageNo){
		var brands = "";
		if(goodsType!="W01"){brands = brand;}
		$('#fiflterCommodity').append('<span style="font-size:20px;display:inline-block;width:100%;height:40px;line-height:40px;text-align:center;margin-top:170px;">加载中...</span>');
		$.ajax({
			type:"post",
			url:"goods/getCommodityAll.do",
			datatype:'json',
			data:{
				pageNo : pageNo,
				brand : brands,
				name : name,
				gg : gg,
				code : code,
				pyname : pyname,
				"query":val
			},
			success:function(data){
				if(data.success){
					$('#fiflterCommodity').empty();
					var content="";
					content+="<div class='upDown1'>";
					content+="<div class='layui-form'>";
					content+="<table class='layui-table'>";
					content+="<colgroup>";
					content+="<col width='120'><col width='270'><col width='50'><col width='70'><col width='90'><col width='50'><col width='70'><col width='80'><col width='110'><col width='85'><col>";
					content+="</colgroup>";
					content+="<tbody>";
					content+="<tr>";
					content+="<td><p style='text-overflow: ellipsis;white-space: nowrap;width: 109px;'>产品代码</p></td>";
					content+="<td>产品规格</td>";
					content+="<td>库存</td>";
					content+="<td>最小起订量</td>";
					content+="<td>价格</td>";
					content+="</tr>";
					content+="</tbody>";
					content+="</table>";
					content+="</div>";
					content+="</div>";
					$(data.obj.rows).each(function (n, Row) {
						content+="<div class='upDown1'>";
						content+="<div class='layui-form'>";
						content+="<table class='layui-table'>";
						content+="<colgroup>";
						content+="<col width='120'><col width='270'><col width='50'><col width='70'><col width='90'><col width='50'><col width='70'><col width='80'><col width='110'><col width='85'><col>";
						content+="</colgroup>";
						content+="<tbody>";
						content+="<tr>";
						content+="<td><input type='checkbox' name='' lay-skin='primary' class='Checked'><p title='"+Row.cpdm+"' style='overflow: hidden;text-overflow: ellipsis;white-space: nowrap;width: 109px;'>"+Row.cpdm+"</p></td>";
						content+="<td><p class='commoditySize'>"+Row.guige+"</p></td>";
						content+="<td>"+Row.kc+"</td>";
						content+="<td>"+(Row.minkc!=null?Row.minkc:'')+"</td>";
						content+="<td><p title='"+Row.goodsPrice+"' style='overflow: hidden;text-overflow: ellipsis;white-space: nowrap;'>"+Row.goodsPrice+"</p></td>";
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
						for(var i=0;i<Row.list.length;i++){
							content+="<li>"+Row.list[i].discountRate+"</li>";
						}
						content+="</ul>";
						content+="</div>";
						content+="</div>";
				   		
					}); 
					$("#fiflterCommodity").append(content);
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
		my.addClass('on-red').siblings().removeClass('on-red');
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
	$('#fiflterCommodity').on('click','.checkThis',function(){
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
		var before;
		$.ajax({
			url:"goods/getDataCpmlss.do",
			data:{"classTypeId":classTypeId,"brand":brand,"brandNo":brandNo},
			type:"post",
			success:function(data){
				layer.close(before)
				var shop_option = '';
				if(data.obj.length > 0){
					shop_option+='<div class="specification">选择规格<button>一键发布</button><span id="div_select">更多</span></div>';
					for(var i in data.obj){
						shop_option+='<div class="shop_mode" data-id='+data.obj[i].code+'>'+data.obj[i].name1+'</div>';
					}
					shop_option+='<div style="clear:both"></div>';
					
					select_mode(data.obj[0].code,pageNo);
				}else{
					shop_option+='<div style="line-height:32px;text-align:center;margin-top:15px">未查询到符合条件的数据！</div>';
					$("#shop_select").empty();
					$("#fiflterCommodity").empty();
				}
				$("#shop_select").html(shop_option);
				$("#shop_select .shop_mode:eq(0)").addClass("on-red");
				$(".commodityDetail").empty();
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
	
	function demo(brandId,grade){
		var vercol = true;
		var brands = "";
		var gradeNum = grade;
		if(goodsType!="W01"){brands = brand;}
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
					if(vercol){
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
			url:"goods/getDataCpmlss2.do",
			data:{"code":code,"pageNo":pageNo},
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
					$("#fiflterCommodity").empty();
					var content="";
					var rows = data.obj.rows;
					if(rows.length > 0){
						content+="<div class='upDown1'>";
						content+="<div class='layui-form'>";
						content+="<table class='layui-table'>";
						content+="<colgroup>";
						content+="<col width='120'><col width='120'><col width='220'><col width='100'><col width='70'><col width='90'><col>";
						content+="</colgroup>";
						content+="<tbody>";
						content+="<tr>";
						content+="<td><p style='text-overflow: ellipsis;white-space: nowrap;width: 109px;'>产品代码</p></td>";
						content+="<td>品牌标识符</td>";
						content+="<td>产品规格</td>";
						content+="<td>库存</td>";
						/*content+="<td>状态</td>";*/
						content+="<td>最小起订量</td>";
						content+="<td>价格</td>";
						content+="</tr>";
						content+="</tbody>";
						content+="</table>";
						content+="</div>";
						content+="</div>";
						$(data.obj.rows).each(function (n, Row) {
							content+="<div class='upDown1'>";
							content+="<div class='layui-form'>";
							content+="<table class='layui-table' style='table-layout:fixed'>";
							content+="<colgroup>";
							content+="<col width='120'><col width='120'><col width='220'><col width='100'><col width='70'><col width='90'>";
							content+="</colgroup>";
							content+="<tbody>";
							content+="<tr>";
							content+="<td><input type='checkbox' name='' lay-skin='primary' class='Checked'><p title='"+Row.id+"' style='overflow: hidden;text-overflow: ellipsis;white-space: nowrap;width: 109px;'>"+Row.id+"</p></td>";
							content+="<td>"+Row.cpdmBrand+"</td>";
							content+="<td><p class='commoditySize' title='"+Row.guige+"'>"+Row.guige+"</p></td>";
							content+="<td>"+Row.kc+"</td>";
							content+="<td>"+(Row.minkc!=null?Row.minkc:'')+"</td>";
							content+="<td><p title='"+Row.jiage+"' style='overflow: hidden;text-overflow: ellipsis;white-space: nowrap;width: 39px;'>"+Row.jiage+"</p></td>";
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
							for(var i=0;i<data.map[Row.id].length;i++){
								content+="<li>"+data.map[Row.id][i].discountRate+"</li>";
							}
							content+="</ul>";
							content+="</div>";
							content+="</div>";
				        });
					}else{
						content+="<div style='background-color:#fff;line-height:32px;text-align:center;'>未查询到符合条件的数据！</div>";
					}
					$("#fiflterCommodity").append(content);
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
	/**
	* 发布商品时传入参数
	*/
	var param = {
		brand : brand,
		name : name,
		gg : gg,
		code : code,
		codes : "",
		pyname : pyname,
		checkId:null,
		minkc:null,
		defaultPayDt:null,
		orderIncrement:null,
		grade:{
			grade001:null,
			grade002:null,
			grade003:null,
			grade004:null
		}
	};
	//$("#shop_select").on("click",".specification>button",function(){
	$(document).on("click",".specification>button",function(){
		layer.confirm('批量发布全部满足条件的商品？', {
			shade:0,
			btn: ['确定','取消'] //按钮
		},function(){
			var checkIds = [];
			param.checkId = "";
			$("#shop_select .shop_mode").each(function(){
				checkIds.push($(this).attr("data-id"));
			});
			param.codes = checkIds.join(",");
			console.log(param.codes);
			var ind = layer.msg('保存与发布中,请稍等...', {icon: 16,time: 1000});
			publish(param,ind);
		},function(){
			layer.closeAll();
		});
	});
	$("#comfirmPublish").on("click",function(){
		layer.confirm('批量发布全部或者已选择满足条件的商品？', {
		  shade:0,
		  btn: ['已选择','取消'] //按钮
		}, function(){
			var checkIds = [];
			$("input.Checked").each(function(){
				if($(this).prop("checked") || $(this).attr("checked") == "checked" || $(this).attr("checked") == true){
					checkIds.push($(this).next().text());
				}
			});
			if(checkIds.length > 0){
				param.checkId = checkIds.join(",");
				var ind = layer.msg('保存与发布中,请稍等...', {icon: 16,time: 2000});
				publish(param,ind);
			}else{
				layer.msg('请选择对应的产品', {icon: 3,time: 2000});
			}
		}, function(){
			layer.closeAll();
		});
	});
	
	/**
	* 发布商品
	*/
	function publish(param,ind){
		param.minkc = $("#minkc").val();
		param.defaultPayDt = $("#defaultPayDt").val();
		param.orderIncrement = $("#orderIncrement").val();
		param.grade.grade001 = $("#grade001").val();
		param.grade.grade002 = $("#grade002").val();
		param.grade.grade003 = $("#grade003").val();
		param.grade.grade004 = $("#grade004").val();
		param.gg = gg;
		param.code = code;
		param.pyname = pyname;
		param.name = name;
		param.brand = brand;
		var flag = valudate(param);
		if(!flag){
			$.ajax({
				type:"post",  
				url:"goods/goodsPublishs.do",
				datatype:'json',
				data:param,
				success:function(data){
					layer.closeAll();
					if(data.success){
						layer.msg(data.msg, {icon: 1,time: 1000});
						window.location.reload();
					}else{
						layer.msg(data.msg, {icon: 2,time: 1000});
					}
				}});
		}else{
			layer.close(ind);
		}
	}
	function valudate(param){
		var flag = false;
		if(isNull(param.minkc)){
			flag = true;
			layer.tips('最小起订量不能为空！', '#minkc',{tips: [2, 'red']});
			return flag;
		}
		if(isNull(param.defaultPayDt)){
			flag = true;
			layer.tips('默认交期不能为空！', '#defaultPayDt',{tips: [2, 'red']});
			return flag;
		}
		if(isNull(param.orderIncrement)){
			flag = true;
			layer.tips('订购递增量不能为空！', '#orderIncrement',{tips: [2, 'red']});
			return flag;
		}
		if(isNull(param.grade.grade001)){
			flag = true;
			layer.tips('一级会员折扣不能为空！', '#grade001',{tips: [1, 'red']});
			return flag;
		}
		if(isNull(param.grade.grade002)){
			flag = true;
			layer.tips('二级会员折扣不能为空！', '#grade002',{tips: [1, 'red']});
			return flag;
		}
		if(isNull(param.grade.grade003)){
			flag = true;
			layer.tips('三级会员折扣不能为空！', '#grade003',{tips: [1, 'red']});
			return flag;
		}
		if(isNull(param.grade.grade004)){
			flag = true;
			layer.tips('四级会员折扣不能为空！', '#grade004',{tips: [1, 'red']});
			return flag;
		}
		return flag;
	}
	function isNull(str){
		var falg = false;
		if(str == null || str == "" || str == undefined || str == "undefined" || str == "null"){
			falg = true;
		}
		return falg;
	}
	
});