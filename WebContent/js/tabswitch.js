$(function(){
    var tabNum=$(".important").find("li");
    var contentNum=$(".contents").children();
    $(tabNum).each(function(index){
       $(this).mouseover(function(){
            $(contentNum).eq(index).css({"display":"block"});
            $(contentNum).eq(index).siblings().css({"display":"none"});
            $(this).find("strong").css({"display":"block"});
            $(this).siblings().find("strong").css({"display":"none"});
        })
    })
})

$(function(){
    var tabNum=$(".content-tab").find("li");
    var contentNum=$(".contents").children();
    $(tabNum).each(function(index){
       $(this).mouseover(function(){
            $(contentNum).eq(index).css({"display":"block"});
            $(contentNum).eq(index).siblings().css({"display":"none"});
            $(this).find("strong").css({"display":"block"});
            $(this).siblings().find("strong").css({"display":"none"});
        }).mouseout(function(){
		   $(contentNum).eq(index).css({"display":"none"});
            $(contentNum).eq(index).siblings().css({"display":"block"});
            //$(this).find("strong").css({"display":"block"});
            //$(this).siblings().find("strong").css({"display":"none"});
		})
    })
})

$(function(){
    var tabNum=$(".table").find("li");
    var contentNum=$(".contents").children();
    var timer;
    $(tabNum).each(function(index){
        $(this).hover(function(){
            var that=$(this)
             timer=window.setTimeout(function(){
                $(contentNum).eq(index).css({"display":"block"});
                $(contentNum).eq(index).siblings().css({"display":"none"});
               
            },100)
        },function(){
            window.clearTimeout(timer);
        })
    })
})