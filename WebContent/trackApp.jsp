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
        <div class="header-img fl"><img class="l-img" src="arrow-white.png"></div>
        <div class="text-tit fl">物流信息</div>
        <div class="clear-box"></div>
    </div>
</div>
<div class="mains" style="bottom: 0;background-color: #f3f3f3">
    <div class="detail-info">
        <div class="img-shop fl">
            <img src="jdc.png">
            <div class="describe-shop">共1件商品</div>
        </div>
        <div class="track-texts fl">
            <p>物流状态:运输中</p>
            <p>快递公司:顺丰快运</p>
            <p>快递单号:949303089089</p>
        </div>
        <div class="clear-box"></div>
    </div>
    <div class="track-frames">
        <ul class="time-lists">
            <li>
                <div class="adress-box">
                    <div class="fl adress-tit">收货地址:</div>
                    <div class="fl adress-texts">重庆市沙平坝区建兴路街道200号1幢2单元3fdsfsdf0656546号fddsfsdfsfsdfdsfdsafdsf结束</div>
                    <div class="clear-box"></div>
                </div>
            </li>
            <li>
                <div class="fl time-describe">
                    <p>19:24</p>
                    <p>2017-02-03</p>
                </div>
                <div class="fl circle-box">
                    <div class="circle-big-blue">
                        <div class="circle-small-blue"></div>
                    </div>
                    <div class="line-down"></div>
                </div>
                <div class="fl time-texts">
                    <p style="color: #b2191b">【已签收】,感谢使用顺丰,期待再次为你服务!</p>
                </div>
                <div class="clear-box"></div>
            </li>
            <li>
                <div class="fl time-describe">
                    <p>19:24</p>
                    <p>2017-02-03</p>
                </div>
                <div class="fl circle-box">
                    <div class="line-up"></div>
                    <div class="circle-big-gray">
                        <div class="circle-small-gray"></div>
                    </div>
                    <div class="line-down"></div>
                </div>
                <div class="fl time-texts">
                    <p>货物交给沙平坝区,正在派送途中,联系电话:13900000000</p>
                </div>
                <div class="clear-box"></div>
            </li>
            <li>
                <div class="fl time-describe">
                    <p>19:24</p>
                    <p>2017-02-03</p>
                </div>
                <div class="fl circle-box">
                    <div class="line-up"></div>
                    <div class="circle-big-gray">
                        <div class="circle-small-gray"></div>
                    </div>
                    <div class="line-down"></div>
                </div>
                <div class="fl time-texts">
                    <p>货物到达【重庆分公司】</p>
                </div>
                <div class="clear-box"></div>
            </li>
            <li>
                <div class="fl time-describe">
                    <p>19:24</p>
                    <p>2017-02-03</p>
                </div>
                <div class="fl circle-box">
                    <div class="line-up"></div>
                    <div class="circle-big-gray">
                        <div class="circle-small-gray"></div>
                    </div>
                    <div class="line-down"></div>
                </div>
                <div class="fl time-texts">
                    <p>【成都市】顺丰小张接件</p>
                </div>
                <div class="clear-box"></div>
            </li>
            <li>
                <div class="fl time-describe" style="border-bottom: none">
                    <p>19:24</p>
                    <p>2017-02-03</p>
                </div>
                <div class="fl circle-box">
                    <div class="line-up"></div>
                    <div class="circle-big-gray">
                        <div class="circle-small-gray"></div>
                    </div>
                </div>
                <div class="fl time-texts" style="border-bottom: none">
                    <p>包裹正在等待揽收</p>
                </div>
                <div class="clear-box"></div>
            </li>
        </ul>
    </div>
</div>
</body>
</html>