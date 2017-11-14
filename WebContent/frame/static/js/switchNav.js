/**
 * Created by Administrator on 2017/4/12.
 */
layui.use('jquery',function() {
	loadMenu();
    var $=layui.jquery;
    $('.buttonCss').on('click',function(){
        var httpNav;
        switch ($(this).text()){
            case '所有商品':httpNav = 'goods/toCommodityAll.do';break;
            case '商品销售':httpNav = 'goods/toPubCommodity.do';break;
            case '发布商品':httpNav = 'goods/toPublishGoods.do';break;
        }
        $("#gType").val('卡尺');
        $('#iFrame').attr('src',httpNav);
        loadMenu(httpNav);
    });
});
function loadMenu(dom){
	dom  =  dom || "";
	var html;
	var before;
	$.ajax({
		url:"goods/getLeftMenu.do",
		success:function(data){
			if(data.success){
				if(data.obj.length == 0){
					html+='<li id="bg" class="hidden"><span>通用量具类</span></li>';
					$("#gType").attr("data-menu",1);
				}else{
					html+='<li id="bg"><span>通用量具类</span></li>';
					var menu=data.obj;
					$("#gType").val(menu[0].chName);
					for(var i in menu){
						html+="<li class='layui-nav-item'>";
						html+="<a class='navChange' goodsGrade='"+menu[i].id+"' goodsType='"+menu[i].chName+"'>"+menu[i].chName+"</a>";
						html+="</li>";
					}
				}
				$.ajax({
					url:"goods/getLeftMenuNum.do",
					success:function(data){
						if(data.success){
							//成功后赋值链接 防止请求 超过内容请求速度
							if(dom == ""){
								$("#iFrame").attr("src","goods/toCommodityAll.do");
							}
							var menu=data.obj;
							if(data.obj.length == 0){
								html+="<li id='bg' class='hidden'><span>数控类</span></li>";
							}else{
								html+="<li id='bg'><span>数控类</span></li>";
								for(var i in menu){
									html+="<li class='layui-nav-item'>";
									html+="<a class='navChange' goodsGrade='"+menu[i].id+"' goodsType='"+menu[i].chName+"'>"+menu[i].chName+"</a>";
									html+="</li>";
								}
							}
							
							$("#menu").html(html);
							$("#menu").find('.navChange').eq(0).attr('style','background-color: #e2dfdf; color: white;');
							if($("#gType").attr("data-menu") == 1){
								$("#gType").val(menu[0].chName);
							}
						}else{
							layer.msg("查询菜单信息失败！");
						}
					},complete:function(){
						var i = $("#menu #bg").length;
						var k = $("#menu #bg.hidden").length;
						if(i == k){
							layer.msg("没有所代理的商品品牌！")
						}
					}
				});
			}else{
				layer.msg("查询菜单信息失败！");
			}
		}
	});
}
