//图片上传预览    IE是用了滤镜。
function previewImage(file){
  var MAXWIDTH  = 90; 
  var MAXHEIGHT = 90;
  var div = document.getElementById('preview');
  if (file.files && file.files[0])
  {
      div.innerHTML ='<img id=imghead onclick=$("#previewImg").click()>';
      var img = document.getElementById('imghead');
      var reader = new FileReader();
      reader.onload = function(evt){img.src = evt.target.result;}
      reader.readAsDataURL(file.files[0]);
  }
  else //兼容IE
  {
    var sFilter='filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale,src="';
    file.select();
    var src = document.selection.createRange().text;
    div.innerHTML = '<img id=imghead>';
    var img = document.getElementById('imghead');
    img.filters.item('DXImageTransform.Microsoft.AlphaImageLoader').src = src;
    var rect = clacImgZoomParam(MAXWIDTH, MAXHEIGHT, img.offsetWidth, img.offsetHeight);
    status =('rect:'+rect.top+','+rect.left+','+rect.width+','+rect.height);
    div.innerHTML = "<div id=divhead style='width:"+rect.width+"px;height:"+rect.height+"px;margin-top:"+rect.top+"px;"+sFilter+src+"\"'></div>";
  }
}
function clacImgZoomParam( maxWidth, maxHeight, width, height ){
    var param = {top:0, left:0, width:width, height:height};
    if( width>maxWidth || height>maxHeight ){
        rateWidth = width / maxWidth;
        rateHeight = height / maxHeight;
        
        if( rateWidth > rateHeight ){
            param.width =  maxWidth;
            param.height = Math.round(height / rateWidth);
        }else{
            param.width = Math.round(width / rateHeight);
            param.height = maxHeight;
        }
    }
    param.left = Math.round((maxWidth - param.width) / 2);
    param.top = Math.round((maxHeight - param.height) / 2);
    return param;
}

$(function() { 
	centre_height();
	$(window).resize(function(){
		centre_height();
	});
	//内容的最小高度适应
	function centre_height(){
		var win_height = $(window).height();
		$(".centre").css("min-height",win_height-200);
	}
	//同意用户协议后运行提交
	$("#check").change(function(){
		/*chekbox选中返回true，否则为false*/
		var check = $("#check").is(":checked");
		if(check){
			$("button.fillet").removeAttr("disabled")
		}else{
			$("button.fillet").attr("disabled","disabled")
		}
	});
});
/*截取字符串*/
var splitStr = function(str,num){
	if(num == undefined){
		num = 10;
	}
	var returnStr = str;
	if(str.length > num+1){
		return returnStr = str.substring(0,num+1)+"..";
	}else{
		return str
	}

}