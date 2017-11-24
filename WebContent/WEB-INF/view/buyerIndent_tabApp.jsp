<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="en">
 <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>我的订单</title>
    <link rel="stylesheet" type="text/css" href="frame/static/css/shop.css">
</head>
<body>
<div class="header" style="height: auto">
    <div class="header-box">
        <div class="header-img fl"><img class="l-img" src="arrow-white.png"></div>
        <div class="text-tit fl">我的订单</div>
        <div class="clear-box"></div>
    </div>
    <div class="search-terms">
        <div class="terms-box fl on-terms">全部</div>
        <div class="terms-box fl">待付款</div>
        <div class="terms-box fl">待收货</div>
        <div class="terms-box fl">已完成</div>
        <div class="terms-box fl" style="border-right: none">已取消</div>
        <div class="clear-box"></div>
    </div>
</div>

<div class="mains" style="top: 88px;bottom: 0;overflow-y: auto">
    <div class="address-lis">
        <ul>
            <li>
                <div class="title-infos">
                    <div class="tit-top">
                        <p>
                            <span class="fl">成都伊高数控工具有限公司</span>
                            <span class="fr" style="color: #b2191b">待付款</span>
                        </p>
                        <p>
                            <span class="fl">订单号:289900900</span>
                            <span class="fr">下单时间:2017.09.09</span>
                        </p>
                    </div>
                    <div class="tit-bottom"></div>
                </div>
                <div class="infos-details">
                    <div class="li-img fl">
                        <img src="jdc.png">
                    </div>
                    <div class="li-texts fl" style="margin-left: 15px">
                        <h5>游标卡尺万能角度尺</h5>
                        <p class="num-text">10123098 29-09</p>
                        <p class="one-price">
                            <span>16.00</span>
                            <span>*</span>
                            <span>2</span>
                        </p>
                        <p class="total-price"><span>合计:</span><span>32.00</span></p>
                    </div>
                    <div class="clear-box"></div>
                    <div class="remark-box">
                        <div class="remark-com">
                            <span class="fl">默认收货时间:</span>
                            <span class="fr" style="margin-right: 20px">2017.08.12</span>
                            <div class="clear-box"></div>
                        </div>
                        <div class="remark-com">
                            <span class="fl">期望收货时间:</span>
                            <input class="fr" type="date">
                            <div class="clear-box"></div>
                        </div>
                        <div class="remark-com">
                            <span>备注:</span>
                            <input class="fr" type="text" placeholder="备注信息">
                            <div class="clear-box"></div>
                        </div>
                        <div class="clear-box"></div>
                    </div>
                    <div class="btns-box">
                        <div class="fr">
                            <span>取消订单</span>
                            <span class="on-red">确认付款</span>
                        </div>
                    </div>
                </div>
            </li>
            <li>
                <div class="title-infos">
                    <div class="tit-top">
                        <p>
                            <span class="fl">成都伊高数控工具有限公司</span>
                            <span class="fr" style="color: #b2191b">待收货</span>
                        </p>
                        <p>
                            <span class="fl">订单号:289900900</span>
                            <span class="fr">下单时间:2017.09.09</span>
                        </p>
                    </div>
                    <div class="tit-bottom"></div>
                </div>
                <div class="infos-details">
                    <div class="li-img fl">
                        <img src="jdc.png">
                    </div>
                    <div class="li-texts fl" style="margin-left: 15px">
                        <h5>游标卡尺万能角度尺</h5>
                        <p class="num-text">10123098 29-09</p>
                        <p class="one-price">
                            <span>16.00</span>
                            <span>*</span>
                            <span>2</span>
                        </p>
                        <p class="total-price"><span>合计:</span><span>32.00</span></p>
                    </div>
                    <div class="clear-box"></div>
                    <div class="remark-box">
                        <div class="remark-com">
                            <span class="fl">默认收货时间:</span>
                            <span class="fr" style="margin-right: 20px">2017.08.12</span>
                            <div class="clear-box"></div>
                        </div>
                        <div class="remark-com">
                            <span class="fl">期望收货时间:</span>
                            <input class="fr" type="date">
                            <div class="clear-box"></div>
                        </div>
                        <div class="remark-com">
                            <span>备注:</span>
                            <input class="fr" type="text" placeholder="备注信息">
                            <div class="clear-box"></div>
                        </div>
                        <div class="clear-box"></div>
                    </div>
                    <div class="btns-box">
                        <div class="fr">
                            <span>取消订单</span>
                            <span class="on-red">确认收货</span>
                        </div>
                    </div>
                </div>
            </li>
        </ul>
    </div>
</div>
<div class="footer">
    <div class="footer-box">
        <div class="nav-bar fl">
            <div class="img-bar">
                <img src="../images/com/index-red.png">
            </div>
            <div class="bar-tit  bar-red">商城</div>
        </div>
        <div class="nav-bar fl">
            <div class="img-bar">
                <img src="../images/com/use-gray.png">
            </div>
            <div class="bar-tit">应用</div>
        </div>
        <div class="nav-bar fl">
            <div class="img-bar">
                <img src="../images/com/compute-gray.png">
            </div>
            <div class="bar-tit">公式</div>
        </div>
        <div class="nav-bar fl">
            <div class="img-bar">
                <img src="../images/com/my-gray.png">
            </div>
            <div class="bar-tit">我的</div>
        </div>
        <div class="clear-box"></div>
    </div>
</div>
</body>
</html>