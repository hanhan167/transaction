var maxPage = null;



//输出目录(列表)
function scml(grade, divid) {
    SelectDataDwr.SelectData_oneSQL("Data_catalog_manage", "GRADE", grade, function (list) {

        li = "";
        for (var i = 0; i < list.length; i++) {
            if (code == list[i].id) {
                li += "<li lj-code='" + list[i].id + "' ><a href='ka-chi-list.html?code=" + list[i].id + "'  style='color:red'  >" + list[i].ch_name + "</a></li>";

                $(".am-icon-users").html(list[i].ch_name);
            } else {
                li += "<li lj-code='" + list[i].id + "' ><a href='ka-chi-list.html?code=" + list[i].id + "'  >" + list[i].ch_name + "</a></li>";

            }
        }
        $("#" + divid).append(li);
    });

}

//输出目录相应的品牌
function scbrand(grade, divid) {
    SelectDataDwr.getbrand(grade, function (list) {
        guige = "";
        for (var i = 0; i < list.length; i++) {
            oldcode = list[i];
            guige += "<span  num='" + oldcode + "' class='nav_brand'>" + oldcode + "</span>";
        }
        $("." + divid).append("<div class='items' ><div class='items-tit fl'>选择品牌:</div><div class='items-box fl'><span class='on-red nav_brand'  >所有</span>" + guige + "</div><div class='clear-box' style='width:100%; height:0; overflow:hidden;'></div></div>");
        scguige(grade, divid);
    });


}

//输出目录相应的规格
function scguige(grade, divid) {
    SelectDataDwr.SelectData_oneSQL("Data_catalog_manage", "GRADE", grade, function (list) {

        if (list.length != 0) {
            var fristcode = "";

            var guigeBox = $("<div class='items' ><div>");
            var guigeTit = $("<div class='items-tit fl'>选择规格:</div>");
            guigeBox.append(guigeTit);
            var guigeCont = $("<div class='items-box fl'></div>");

            for (var i = 0; i < list.length; i++) {
                //var oldcode = list[i].en_code;
                var guigeSpan = $("<span rel='" + list[i].id + "' class='nav_guige' num='" + list[i].en_code + "'>" + list[i].ch_name + "</span>");

                if (i == 0) {
                    //点开页面默认'所有'为红色字体
                    guigeSpan.addClass("on-red");
                }
                guigeCont.append(guigeSpan);

            }
            guigeBox.append(guigeCont);
            var clearBox = $("<div class='clear-box' style='width:100%; height:0; overflow:hidden;'></div>");
            guigeBox.append(clearBox);

            $("." + divid).append(guigeBox);

                $(".items .on-red:last").click();
        }
    });
}


$("body").on('click', '.items span', function () {

    //点击时清除原有的红色字体
    $(this).siblings(".on-red").removeClass("on-red");
    //再加上红色字体样式
    $(this).addClass("on-red");
    // 拼接查询条件:品牌,规格,功能
    var brand = $(".nav_brand.on-red").text();
    var ggNum = $(".nav_guige.on-red").attr("rel");
    //判断用户是否选择的是品牌 如果选择的是品牌 不执行规格的查询
    if ($(this).is(".nav_brand")) {
    } else {
        $(this).parent().parent().nextAll().remove();

        ggNum = $(this).attr("rel");
        SelectDataDwr.SelectData_oneSQL("Data_catalog_manage", "GRADE", ggNum, function (lists) {
            if (lists.length != 0) {
                scguige(ggNum, "right-top");
            }
        });

    }
    var endSum = page * 20;//结束数量
    var startSum = (page - 1) * 20;//开始数量

    SelectDataDwr.getCpmls(ggNum, brand, startSum, endSum, writeProductToPage);

    SelectDataDwr.getCpmlsNum(ggNum, brand, function (num) {
        maxPage = Math.ceil(num / 20);//得到最大页数(总页数)
        $(".page-box .total").text(maxPage);
        getNumPages(maxPage, page, ggNum, brand);

    });

});