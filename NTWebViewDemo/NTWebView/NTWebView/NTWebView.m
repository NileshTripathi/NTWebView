
#import "NTWebView.h"

@implementation NTWebView

@synthesize webView;
@synthesize strHTMLString;
@synthesize baseURL;
@synthesize data;
@synthesize strMIMEType;
@synthesize strEncoding;
@synthesize request;
@synthesize scalesPageToFit;
@synthesize detectsPhoneNumbers;
@synthesize dataDetectorTypes;
@synthesize allowsInlineMediaPlayback;
@synthesize mediaPlaybackRequiresUserAction;
@synthesize mediaPlaybackAllowsAirPlay;
@synthesize suppressesIncrementalRendering;
@synthesize keyboardDisplayRequiresUserAction;
@synthesize webViewAccessories;

-(id)initWithFrame:(CGRect)frame withWebViewAccessories:(UIWebViewAccessories)_webViewAccessories{
    webViewAccessories = _webViewAccessories;
    self = [self initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGRect webViewFrame, viewBarFrame;
        switch (webViewAccessories) {
            case 0:
                webViewFrame = CGRectMake(self.frame.origin.x, 0, self.frame.size.width, self.frame.size.height);
                viewBarFrame = CGRectZero;
                break;
            case 1:
                webViewFrame = CGRectMake(self.frame.origin.x, 44, self.frame.size.width, self.frame.size.height-44);
                viewBarFrame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 44);
                break;
            case 2:
                webViewFrame = CGRectMake(self.frame.origin.x, 0, self.frame.size.width, self.frame.size.height-44);
                viewBarFrame = CGRectMake(self.frame.origin.x, self.frame.origin.y+self.frame.size.height-44, self.frame.size.width, 44);
                break;
                
            default:
                break;
        }
        
        self.webView = [[UIWebView alloc] initWithFrame:webViewFrame];
        [self.webView setDelegate:self];
        [self.webView setOpaque:NO];
        [self addSubview:self.webView];

        if (webViewAccessories == UIWebViewAccessoriesNone) {
            return self;
        }
        viewBar = [[UIView alloc] initWithFrame:viewBarFrame];
        [viewBar setBackgroundColor:[UIColor lightGrayColor]];
        [self addSubview:viewBar];
        
        btnHome = [self initButtonWithFrame:CGRectMake(viewBar.frame.size.width-40, 6, 30, 30) image:@"Home.png"];
        [btnHome addTarget:self action:@selector(homeBtnPressed) forControlEvents:UIControlEventTouchUpInside];
        
        btnReload = [self initButtonWithFrame:CGRectMake(btnHome.frame.origin.x-35, btnHome.frame.origin.y, 30, 30) image:@"Reload.png"];
        [btnReload addTarget:self action:@selector(reloadBtnPressed) forControlEvents:UIControlEventTouchUpInside];
        
        btnPrevious = [self initButtonWithFrame:CGRectMake(viewBar.frame.origin.x+10, 6, 30, 30) image:@"Previous.png"];
        [btnPrevious addTarget:self action:@selector(previousBtnPressed) forControlEvents:UIControlEventTouchUpInside];

        btnNext = [self initButtonWithFrame:CGRectMake(btnPrevious.frame.origin.x+32, btnPrevious.frame.origin.y, 30, 30) image:@"Next.png"];
        [btnNext addTarget:self action:@selector(nextBtnPressed) forControlEvents:UIControlEventTouchUpInside];
        
        [btnPrevious setEnabled:FALSE];
        [btnNext setEnabled:FALSE];
        
        indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [indicator setFrame:CGRectMake(btnNext.frame.origin.x+32, btnPrevious.frame.origin.y, 30, 30)];
        [indicator setHidesWhenStopped:YES];
        [viewBar addSubview:indicator];
        
        lblHelper = [[UILabel alloc] initWithFrame:CGRectMake(indicator.frame.origin.x+30, indicator.frame.origin.y, 300, 30)];
        [lblHelper setBackgroundColor:[UIColor clearColor]];
        [lblHelper setFont:[UIFont fontWithName:@"Cochin-Bold" size:17]];
        [lblHelper setTextAlignment:NSTextAlignmentLeft];
        [lblHelper setTextColor:[UIColor blackColor]];
        [viewBar addSubview:lblHelper];
    }
    return self;
}

-(UIButton *)initButtonWithFrame:(CGRect)frame image:(NSString *)strImage {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:frame];
    [btn setImage:[UIImage imageNamed:strImage] forState:UIControlStateNormal];
    [viewBar addSubview:btn];
    return btn ;
}

#pragma mark ButtonsEvents
-(void)homeBtnPressed{
    if (self.strHTMLString) {
        [self.webView loadHTMLString:self.strHTMLString baseURL:self.baseURL];
        return;
    }
    if (self.request) {
        [self.webView loadRequest:self.request];
        return;
    }
    if (self.data) {
        [self.webView loadData:self.data MIMEType:self.strMIMEType textEncodingName:self.strEncoding baseURL:self.baseURL];
        return;
    }
}
-(void)reloadBtnPressed{
    [self.webView reload];
}
-(void)previousBtnPressed{
    if (self.webView.canGoBack) {
        [self.webView goBack];
    }
}
-(void)nextBtnPressed{
    if (self.webView.canGoForward) {
        [self.webView goForward];
    }
}

#pragma mark UIWebView Properties

-(void)setScalesPageToFit:(BOOL)_scalesPageToFit{
    [self.webView setScalesPageToFit:_scalesPageToFit];
}
-(void)setDataDetectorTypes:(UIDataDetectorTypes)_dataDetectorTypes{
    [self.webView setDataDetectorTypes:_dataDetectorTypes];
}
-(void)setAllowsInlineMediaPlayback:(BOOL)_allowsInlineMediaPlayback{
    [self.webView setAllowsInlineMediaPlayback:_allowsInlineMediaPlayback];
}
-(void)setMediaPlaybackRequiresUserAction:(BOOL)_mediaPlaybackRequiresUserAction{
    [self.webView setMediaPlaybackRequiresUserAction:_mediaPlaybackRequiresUserAction];
}
-(void)setMediaPlaybackAllowsAirPlay:(BOOL)_mediaPlaybackAllowsAirPlay{
    [self.webView setMediaPlaybackAllowsAirPlay:_mediaPlaybackAllowsAirPlay];
}
-(void)setSuppressesIncrementalRendering:(BOOL)_suppressesIncrementalRendering{
    [self.webView setSuppressesIncrementalRendering:_suppressesIncrementalRendering];
}
-(void)setKeyboardDisplayRequiresUserAction:(BOOL)_keyboardDisplayRequiresUserAction{
    [self.webView setKeyboardDisplayRequiresUserAction:_keyboardDisplayRequiresUserAction];
}

#pragma mark UIWebView Methods
- (void)loadRequest:(NSURLRequest *)_request;{
    self.request = _request;
    [self.webView loadRequest:_request];
}
- (void)loadHTMLString:(NSString *)string baseURL:(NSURL *)_baseURL;{
    self.strHTMLString = string; self.baseURL = _baseURL;
    [self.webView loadHTMLString:string baseURL:baseURL];
}
- (void)loadData:(NSData *)_data MIMEType:(NSString *)MIMEType textEncodingName:(NSString *)textEncodingName baseURL:(NSURL *)_baseURL;{
    self.data = _data; self.strMIMEType = MIMEType; self.strEncoding = textEncodingName; self.baseURL = _baseURL;
    [self.webView loadData:_data MIMEType:MIMEType textEncodingName:textEncodingName baseURL:_baseURL];
}
- (NSString *)stringByEvaluatingJavaScriptFromString:(NSString *)script;{
    [self.webView stringByEvaluatingJavaScriptFromString:script];
    return script;
}

#pragma mark UIWebview Delegate Methods
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;{
    if (navigationType == UIWebViewNavigationTypeReload) {
        [lblHelper setText:@"Reloading..."];
    }else {
        [lblHelper setText:@"Loading..."];
    }
    return TRUE;
}
- (void)webViewDidStartLoad:(UIWebView *)_webView;{
    [indicator startAnimating];
    [lblHelper setText:@"Loading..."];
    if(_webView.canGoBack){
        [btnPrevious setEnabled:TRUE];
    }else{
        [btnPrevious setEnabled:FALSE];
    }
    if(_webView.canGoForward){
        [btnNext setEnabled:TRUE];
    }else{
        [btnPrevious setEnabled:FALSE];
    }
}
- (void)webViewDidFinishLoad:(UIWebView *)_webView;{
    [indicator stopAnimating];
    [lblHelper setText:@""];
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];
    if(_webView.canGoBack){
        [btnPrevious setEnabled:TRUE];
    }else{
        [btnPrevious setEnabled:FALSE];
    }
    if(_webView.canGoForward){
        [btnNext setEnabled:TRUE];
    }else{
        [btnNext setEnabled:FALSE];
    }
    [self performSelector:@selector(hideLable) withObject:nil afterDelay:2.0];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;{
    [indicator stopAnimating];
    [lblHelper setText:@"Error occurs..."];
    [self performSelector:@selector(hideLable) withObject:nil afterDelay:2.0];
}

-(void)hideLable{
    [lblHelper setText:@""];
}

-(void)dealloc{
    [super dealloc];
    [self.webView stringByEvaluatingJavaScriptFromString:@"var body=document.getElementsByTagName('body')[0];body.style.backgroundColor=(body.style.backgroundColor=='')?'white':'';"];
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.open();document.close()"];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [self.webView setDelegate:nil];
    [self.webView removeFromSuperview];
    [self.webView release];
    self.webView = nil;
    
    [self.strHTMLString release];
    self.strHTMLString = nil;
    [self.baseURL release];
    self.baseURL = nil;
    [self.data release];
    self.data = nil;
    [self.strMIMEType release];
    self.strMIMEType = nil;
    [self.strEncoding release];
    self.strEncoding = nil;
    [self.request release];
    self.request = nil;
}

@end
