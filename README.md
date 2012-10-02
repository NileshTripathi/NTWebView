# NTWebView
===========

NTWebView will allow you to have UIWebView Class, which has many functions like as Memory Management, Home, Reload, Previous, Back. Its a complete package of WebView to use.


Features:
=========
- Accessories view which can be set at Top/Bottom/None.
- Accessories view functions:-
	Home button: It will push the page to main/Home page.(Which is first called).
	Reload button: It will reload the page.
	Back Button: It will take you to the last page you have visited.(If any)
	Forward Button: It will take you to the ago  page.(If any)
	Loading Indicator: Which will show you if any process continues.
	Help Lable: It will show whats going on the page.


## Installation
===============
* Import `NTWebView.h/m and all images:Home,Previous,Forward,Reload.` to your project. I have provided a combine folder of it. You can import that folder in to your project.
* `#import "NTWebView.h"'


## Usage
========
    NTWebView *webView = [[NTWebView alloc] initWithFrame:self.view.frame withWebViewAccessories:UIWebViewAccessoriesTop];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.google.co.in/"]]];
    [self.view addSubview:webView];

This methods will give you web view with accessories view on the top of screen. That accessories view will give you the functions like as Home, Back, Forward, Reload. It will indicate you each and every process whats going on in web view.
 
The most important part I have included in the project is Memory management of UIWebView. Have a created a logic to maintain and manage the issues occurs while using web view fluent. 

To implement memory management features user just have to write below code in its controller, but for this you have to create a Global object of NTWebView in ViewController.h.

-(void) dealloc{
    [webview release];
    webview = nil;
}

Enjoy the features.

If you any questions you can mail me on nileshtripathi@yahoo.co.in

Thank you.

## License
===========
See LICENSE file.
