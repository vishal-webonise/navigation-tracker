var oimg = document.createElement("img");
var current_path = window.location.pathname;
var referrer_path = document.referrer;
oimg.setAttribute('src', 'http://192.168.0.151/apis/tracker.png?current_path='+current_path+'&referrer_path='+referrer_path + "&domain_url=" + domain_url);
oimg.setAttribute('alt', '');
oimg.setAttribute('height', '1px');
oimg.setAttribute('width', '1px');
document.body.appendChild(oimg);