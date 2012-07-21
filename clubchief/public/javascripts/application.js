// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults



//var actionbox_hidden = "actionbox_hidden";
//
//window.onload = checkActionBox;
//
///* Cookie Controls for JS - Missing 'updateCookie()' */
//function createCookie(name,value,days) {
//    if (days) {
//        var date = new Date();
//        date.setTime(date.getTime()+(days*24*60*60*1000));
//        var expires = "; expires="+date.toGMTString();
//    }
//    else var expires = "";
//    document.cookie = name+"="+value+expires+"; path=/";
//}
//
//function readCookie(name) {
//    var nameEQ = name + "=";
//    var ca = document.cookie.split(';');
//    for(var i=0;i < ca.length;i++) {
//        var c = ca[i];
//        while (c.charAt(0)==' ') c = c.substring(1,c.length);
//        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
//    }
//    return null;
//}
//
//function eraseCookie(name) {
//    createCookie(name,"",-1);
//}
//
///* Action Box Control - Highly hardcoded for the time being */
//function checkActionBox() {
//    if(readCookie(actionbox_hidden) == 1)
//        minimize_actionbox('actionbox','button_minimize');
//}
//
//function minimize_actionbox(showHideDiv, switchTextDiv) {
//	var ele = document.getElementById(showHideDiv);
//	var text = document.getElementById(switchTextDiv);
//    var actionbox = readCookie(actionbox_hidden);
//	if(ele.style.display == "block") {
//    	ele.style.display = "none";
//		text.innerHTML = "Show Action Box";
//        text.style.backgroundColor = "#fde0a1";
//        text.style.padding = "3px";
//        text.style.opacity = "0.5";
//        if(actionbox == null)
//            createCookie(actionbox_hidden,1,1);
//        else{
//            if(actionbox != 1) {
//                eraseCookie(actionbox_hidden);
//                createCookie(actionbox_hidden,1,1);
//            }
//        }
//  	}
//	else {
//		ele.style.display = "block";
//		text.innerHTML = "Hide Action Box";
//        text.style.backgroundColor = "#e0feb0";
//        text.style.padding = "6px";
//        text.style.opacity = "1";
//        if(actionbox == null)
//            createCookie(actionbox_hidden,0,1);
//        else{
//            if(actionbox != 0) {
//                eraseCookie(actionbox_hidden);
//                createCookie(actionbox_hidden,0,1);
//            }
//        }
//	}
//}