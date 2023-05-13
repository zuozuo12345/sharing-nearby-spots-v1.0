function browserRedirect() {
    var sUserAgent = navigator.userAgent.toLowerCase();
    if (/ipad|iphone|midp|rv:1.2.3.4|ucweb|android/.test(sUserAgent)) {
        //跳转移动端页面
        // window.location.href="https://localhost:8080/jump-page.html";
        // window.location.href="http://43.206.181.204:8080/index.html";

    } else {
        //跳转pc端页面
        window.location.href="http://43.206.181.204:8080/jump-page.html";
        // window.location.href="http://43.206.181.204:8080/index.html";

    }
}
browserRedirect();