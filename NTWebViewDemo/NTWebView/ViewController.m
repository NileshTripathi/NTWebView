//
//  ViewController.m
//  NTWebView
//
//  Created by mac24 on 10/1/12.
//  Copyright (c) 2012 NileshTripathi. All rights reserved.
//

#import "ViewController.h"
#import "NTWebView/NTWebView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NTWebView *webView = [[NTWebView alloc] initWithFrame:self.view.frame withWebViewAccessories:UIWebViewAccessoriesTop];
    
    // Demonstrates bug in proxying code.
    webView.scalesPageToFit = YES;
    if (webView.scalesPageToFit){
        NSLog(@"YES");
    } else {
        NSLog(@"NO");
    }
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.google.co.in/"]]];
    [self.view addSubview:webView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
