var oimg = document.createElement("img");
var current_path = window.location.pathname;
var referrer_path = document.referrer;
// local address http://192.168.0.151
oimg.setAttribute('src', 'http://navigation_tracking.weboapps.com/apis/tracker.png?current_path='+current_path+'&referrer_path='+referrer_path + "&domain_url=" + domain_url);
oimg.setAttribute('alt', '');
oimg.setAttribute('height', '1px');
oimg.setAttribute('width', '1px');
document.body.appendChild(oimg);