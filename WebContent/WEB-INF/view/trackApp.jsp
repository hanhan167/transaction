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
    <link rel="stylesheet" type="text/css" href="frame/static/css/track.css">
    <title>物流跟踪</title>
</head>
<body>
<div class="header" style="height: auto">
    <div class="header-box">
        <div class="header-img fl"><img class="l-img returnShopCart" src="frame/static/picture/arrow-white.png"></div>
        <div class="text-tit fl">物流信息</div>
        <div class="clear-box"></div>
    </div>
</div>
<div class="mains" style="bottom: 0;background-color: #f3f3f3">
   
</div>
</body>
</html>
<script type="text/javascript"
	src="frame/static/js/jquery-1.11.1.min.js"></script>
<script>
	$(function(){ 
		
		
		var html = "";
		var myData;
		var lgtNum = GetQueryString("lgtNums");
		var code = GetQueryString("code");
		var num = GetQueryString("nums");
		function GetQueryString(name) {
			var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
			var r = window.location.search.substr(1).match(reg);
			if (r != null){
				return unescape(r[2]);
			}
			return null;
		}
		
		$.ajax({
			type:'post',
			url:'busOrder/sendlgtMsgApp.do',
			data:{
				"lgtNums":lgtNum,		
			},
			beforeSend:function(){
				$(".mains").html(	 
						"<div class='warn-box'>"
						+	"<div class='warn-infos'>"        
						+	           "<div class='onload-img'><img src='frame/static/picture/onload.png'></div>" 
						+	            "<div class='warn-texts'>正在努力为您加载!请耐心等待...</div>"
						+	       " </div>"
						+	    "</div>"		);

			},
			success:function(dataStr){
				html ="<div class=\"detail-info\">";
				html+="<div class=\"img-shop fl\">";
		        html+="<img src=\"http://new.cp2013.com.cn/File/B/"+code.substring(code.indexOf("-"),code.length)+".jpg\">";
		        html+="<div class=\"describe-shop\">共"+num+"件商品</div>";
		        html+="</div>";
		        html+="<div class=\"track-texts fl\">";
				if (dataStr == 1) {
			        html+="<p style='color:red;'>物流状态:客户亲自拿货</p>";
			        html+="<p>快递公司:无</p>";
			        html+="<p>快递单号:无</p>";
			        html+="</div>";
			        html+="<div class=\"clear-box\"></div>";
			        html+="</div>";
			        html+="<ul class='time-lists'></ul>";
				}else if (dataStr == 2) {
			        html+="<p style='color:red;'>物流状态:滴滴送货,一天内到达</p>";
			        html+=" <p>快递公司:无</p>";
			        html+="<p>快递单号:无</p>";
			        html+="</div>";
			        html+="<div class=\"clear-box\"></div>";
			        html+="</div>";
			        html+="<ul class='time-lists'>"
			        +"<div class='warn-box'>"
					+	"<div class='warn-infos'>"      
					+	"<div class='warn-texts'>无具体物流信息...</div>"
					+	           "<div class='onload-img'><img src='frame/static/picture/order-img.png'></div>" 
					+	       " </div>"
					+	    "</div>"	
					+"</ul>";
				}else{
					myData = JSON.parse(dataStr);
					var data = JSON.parse(dataStr);
					if (data.status === '0' && data.msg === 'ok') {
						
				        var r= data.result;
				        if(r.issign === '1'){
				        	
				       		 html+="<p>物流状态:已签收</p>";
				        }else{
				       		 html+="<p>物流状态:运输中</p>";
				        	
				        }
				        html+=" <p>快递公司:"+findSth(r.type)+"</p>";
				        html+="<p>快递单号:"+r.number+"</p>";
				        html+="</div>";
				        html+="<div class=\"clear-box\"></div>";
				        html+="</div>";
				        html+="<div class=\"track-frames\">";
				        html+="<ul class=\"time-lists\">";

				        var list = r.list;
						 for (var i = 0; i < list.length ; i++) {
							 
							 html +=" <li>";
							 html +="<div class=\"fl time-describe\">";
							 var index=list[i].time.indexOf(" ");
							 
							 
							 html +="<p>"+(list[i].time).substring(index+1)+"</p>";
							 html +="<p>"+(list[i].time).substring(0,index)+"</p>";
							 html +="</div>";
							 html +="<div class=\"fl circle-box\">";
							 html +="<div class=\"circle-big-blue\">";
							 if(i==0){
								 html +="<div class=\"circle-small-blue\"></div>";
							 }
							 html +="</div>";
							 html +="<div class=\"line-down\"></div>";
							 html +="</div>";
							 html +="<div class=\"fl time-texts\">";
							 html +="<p style=\"color: #b2191b\">"+list[i].status +"</p>";
							 html +="</div>";
							 html +="<div class=\"clear-box\"></div>";
							 html +="</li>";
							}
						    html+="</div>";
					        html+="</ul>";

					} else {
						 html = "当前无信息";
					}
					 
				}	
				$(".mains").html(html);
			}
			
		});

	});
	
	$(".returnShopCart").click(function() {
		location.href = "busOrder/toPage/buyerIndent_tabApp.do";
	});

	
	//翻译英文
	function findSth(type) {
		var comp;
		if (type == 'AAEWEB' || type == 'aaeweb') {
			comp = 'AAE';
		} else if (type == 'ARAMEX' || type == 'aramex') {
			comp = 'Aramex';
		} else if (type == 'DHL' || type == 'dhl') {
			comp = 'DHL';
		} else if (type == 'DPEX' || type == 'dpex') {
			comp = 'DPEX';
		} else if (type == 'DEXP' || type == 'dexp') {
			comp = 'D速';
		} else if (type == 'EMS' || type == 'ems') {
			comp = 'EMS';
		} else if (type == 'EWE' || type == 'ewe') {
			comp = 'EWE';
		} else if (type == 'FEDEX' || type == 'fedex') {
			comp = 'FedEx';
		} else if (type == 'FEDEXIN' || type == 'fedexin') {
			comp = 'FedEx国际';
		} else if (type == 'PCA' || type == 'pca') {
			comp = 'PCA';
		} else if (type == 'TNT' || type == 'txt') {
			comp = 'TNT';
		} else if (type == 'UPS' || type == 'ups') {
			comp = 'UPS';
		} else if (type == 'ANJELEX' || type == 'anjelex') {
			comp = '安捷';
		} else if (type == 'ANE' || type == 'ane') {
			comp = '安能';
		} else if (type == 'aneex' || type == 'ANEEX') {
			comp = '安能快递';
		} else if (type == 'ANXINDA' || type == 'anxinda') {
			comp = '安信达';
		} else if (type == 'EES' || type == 'ees') {
			comp = '百福东方';
		} else if (type == 'HTKY' || type == 'htky') {
			comp = '百世快递';
		} else if (type == 'BSKY' || type == 'bsky') {
			comp = '百世快运';
		} else if (type == 'FLYWAYEX' || type == 'flywayex') {
			comp = '程光';
		} else if (type == 'DTW' || type == 'dtw') {
			comp = '大田';
		} else if (type == 'DEPPON' || type == 'deppon') {
			comp = '德邦';
		} else if (type == 'GCE' || type == 'gce') {
			comp = '飞洋';
		} else if (type == 'PHOENIXEXP' || type == 'phoenixexp') {
			comp = '凤凰';
		} else if (type == 'FTD' || type == 'ftd') {
			comp = '富腾达';
		} else if (type == 'GSD' || type == 'gsd') {
			comp = '共速达';
		} else if (type == 'GTO' || type == 'gto') {
			comp = '国通';
		} else if (type == 'BLACKDOG' || type == 'blackdog') {
			comp = '黑狗';
		} else if (type == 'HENGLU' || type == 'henglu') {
			comp = '恒路';
		} else if (type == 'HYE' || type == 'hye') {
			comp = '鸿远';
		} else if (type == 'HQKY' || type == 'hqky') {
			comp = '华企';
		} else if (type == 'JOUST' || type == 'joust') {
			comp = '急先达';
		} else if (type == 'TMS' || type == 'tms') {
			comp = '加运美';
		} else if (type == 'JIAJI' || type == 'jiaji') {
			comp = '佳吉';
		} else if (type == 'KERRY' || type == 'kerry') {
			comp = '嘉里物流';
		} else if (type == 'HREX' || type == 'hrex') {
			comp = '锦程快递';
		} else if (type == 'PEWKEE' || type == 'pewkee') {
			comp = '晋越';
		} else if (type == 'JD' || type == 'jd') {
			comp = '京东';
		} else if (type == 'KKE' || type == 'kke') {
			comp = '京广';
		} else if (type == 'JIUYESCM' || type == 'jiuyescm') {
			comp = '九曳';
		} else if (type == 'KYEXPRESS' || type == 'kyexpress') {
			comp = '跨越';
		} else if (type == 'FASTEXPRESS' || type == 'fastexpress') {
			comp = '快捷';
		} else if (type == 'BLUESKY' || type == 'bluesky') {
			comp = '蓝天';
		} else if (type == 'LTS' || type == 'lts') {
			comp = '联昊通';
		} else if (type == 'LBEX' || type == 'lbex') {
			comp = '龙邦';
		}

		else if (type == 'CNPL' || type == 'cnpl') {
			comp = '中邮';
		} else if (type == 'ZTO' || type == 'zto') {
			comp = '中通';
		} else if (type == 'ZTKY' || type == 'ztky') {
			comp = '中铁物流';
		} else if (type == 'CRE' || type == 'cre') {
			comp = '中铁快运';
		} else if (type == 'COE' || type == 'coe') {
			comp = '中国东方';
		} else if (type == 'ZMKMEX' || type == 'zmkmex') {
			comp = '芝麻开门';
		} else if (type == 'ZJS' || type == 'zjs') {
			comp = '宅急送';
		}

		else if (type == 'YUNDA' || type == 'yunda') {
			comp = '韵达';
		} else if (type == 'YTEXPRESS' || type == 'ytexpress') {
			comp = '运通';
		} else if (type == 'YFEXPRESS' || type == 'yfexpress') {
			comp = '越丰';
		} else if (type == 'YCGWL' || type == 'ycgwl') {
			comp = '远成';
		} else if (type == 'YADEX' || type == 'yadex') {
			comp = '源安达';
		} else if (type == 'YTO' || type == 'yto') {
			comp = '圆通';
		} else if (type == 'YFHEX' || type == 'yfhex') {
			comp = '原飞航';
		} else if (type == 'CHINAPOST' || type == 'chinapost') {
			comp = '邮政包裹';
		} else if (type == 'UC56' || type == 'uc56') {
			comp = '优速';
		} else if (type == 'ETD' || type == 'etd') {
			comp = '易通达';
		} else if (type == 'QEXPRESS' || type == 'qexpress') {
			comp = '易达通';
		} else if (type == 'YIEXPRESS' || type == 'yiexpress') {
			comp = '宜送';
		} else if (type == 'BROADASIA' || type == 'broadasia') {
			comp = '亚风';
		} else if (type == 'XFEXPRESS' || type == 'xfexpress') {
			comp = '信丰';
		} else if (type == 'EWINSHINE' || type == 'ewinshine') {
			comp = '万象';
		} else if (type == 'WANJIA' || type == 'wanjia') {
			comp = '万家物流';
		} else if (type == 'VANGEN' || type == 'vangen') {
			comp = '万庚';
		} else if (type == 'TTKDEX' || type == 'ttdex') {
			comp = '天天';
		} else if (type == 'HOAU' || type == 'hoau') {
			comp = '天地华宇';
		} else if (type == 'SURE' || type == 'sure') {
			comp = '速尔';
		} else if (type == 'SUNING' || type == 'suning') {
			comp = '苏宁';
		} else if (type == 'SFEXPRESS' || type == 'sfexpress') {
			comp = '顺丰';
		} else if (type == 'SDEX' || type == 'sdex') {
			comp = '顺达快递';
		} else if (type == 'SHENGHUI' || type == 'shenghui') {
			comp = '盛辉';
		} else if (type == 'STO' || type == 'sto') {
			comp = '申通';
		} else if (type == 'SFC' || type == 'sfc') {
			comp = '三态';
		} else if (type == 'RFD' || type == 'rfd') {
			comp = '如风达';
		} else if (type == 'APEX' || type == 'apex') {
			comp = '全一';
		} else if (type == 'QFKD' || type == 'qfkd') {
			comp = '全峰';
		} else if (type == 'CHINZ56' || type == 'chinz56') {
			comp = '秦远物流';
		} else if (type == 'EFSPOST' || type == 'efspost') {
			comp = '平安快递';
		} else if (type == 'PEISI' || type == 'peisi') {
			comp = '配思航宇';
		} else if (type == 'ND56' || type == 'nd56') {
			comp = '能达';
		} else if (type == 'CAE' || type == 'nd56') {
			comp = '民航';
		} else {
			comp = '无法识别';
		}
		return comp;
	}
</script>