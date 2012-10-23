//
//  ABWebView.m
//  NTWebView
//
//  Created by Aaron Brethorst on 10/23/12.
//  Copyright (c) 2012 NileshTripathi. All rights reserved.
//

#import "ABWebView.h"

@interface ABWebView () <UIWebViewDelegate>
@property(nonatomic,assign) id<UIWebViewDelegate> secondaryDelegate;
@end

@implementation ABWebView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.secondaryDelegate = nil;
        self.delegate = self;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        self.secondaryDelegate = nil;
        self.delegate = self;
    }
    
    return self;
}

- (void)dealloc
{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    self.delegate = nil;
    self.secondaryDelegate = nil;
}

#pragma mark - Icky Delegate Proxy Stuff

- (void)setDelegate:(id<UIWebViewDelegate>)delegate
{
    self.secondaryDelegate = delegate;
}

- (id<UIWebViewDelegate>)delegate
{
    return self.secondaryDelegate;
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if (self.secondaryDelegate && [self.secondaryDelegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)])
    {
        return [self.secondaryDelegate webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
    }
    else
    {
        return YES;
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    if (self.secondaryDelegate && [self.secondaryDelegate respondsToSelector:@selector(webViewDidStartLoad:)])
    {
        [self.secondaryDelegate webViewDidStartLoad:webView];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if (self.secondaryDelegate && [self.secondaryDelegate respondsToSelector:@selector(webViewDidFinishLoad:)])
    {
        [self.secondaryDelegate webViewDidFinishLoad:webView];
    }
    
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    if (self.secondaryDelegate && [self.secondaryDelegate respondsToSelector:@selector(webView:didFailLoadWithError:)])
    {
        [self.secondaryDelegate webView:webView didFailLoadWithError:error];
    }
}

@end
