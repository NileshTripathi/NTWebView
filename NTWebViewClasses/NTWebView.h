
#import <UIKit/UIKit.h>

typedef enum {
    UIWebViewAccessoriesNone =0,
    UIWebViewAccessoriesTop,
    UIWebViewAccessoriesBottom
}UIWebViewAccessories;

@interface NTWebView : UIView <UIWebViewDelegate>{
    UIButton *btnReload;
    UIButton *btnPrevious;
    UIButton *btnNext;
    UIButton *btnHome;
    UIActivityIndicatorView *indicator;
    UIView *viewBar;
    UILabel *lblHelper;
}

@property (nonatomic, strong)  UIWebView    *webView;
@property (nonatomic, strong)  NSString     *strHTMLString;
@property (nonatomic, strong)  NSURL        *baseURL;
@property (nonatomic, strong)  NSData       *data;
@property (nonatomic, strong)  NSString     *strMIMEType;
@property (nonatomic, strong)  NSString     *strEncoding;
@property (nonatomic, strong)  NSURLRequest *request;

@property (nonatomic, assign) UIWebViewAccessories webViewAccessories;

@property(nonatomic) BOOL scalesPageToFit;

@property(nonatomic) BOOL detectsPhoneNumbers NS_DEPRECATED_IOS(2_0, 3_0);
@property(nonatomic) UIDataDetectorTypes dataDetectorTypes NS_AVAILABLE_IOS(3_0);

@property (nonatomic) BOOL allowsInlineMediaPlayback NS_AVAILABLE_IOS(4_0); // iPhone Safari defaults to NO. iPad Safari defaults to YES
@property (nonatomic) BOOL mediaPlaybackRequiresUserAction NS_AVAILABLE_IOS(4_0); // iPhone and iPad Safari both default to YES

@property (nonatomic) BOOL mediaPlaybackAllowsAirPlay NS_AVAILABLE_IOS(5_0); // iPhone and iPad Safari both default to YES

@property (nonatomic) BOOL suppressesIncrementalRendering NS_AVAILABLE_IOS(6_0); // iPhone and iPad Safari both default to NO

@property (nonatomic) BOOL keyboardDisplayRequiresUserAction NS_AVAILABLE_IOS(6_0); // default is YES

-(UIButton *)initButtonWithFrame:(CGRect)frame image:(NSString *)strImage;
-(id)initWithFrame:(CGRect)frame withWebViewAccessories:(UIWebViewAccessories)_webViewAccessories;
- (void)loadRequest:(NSURLRequest *)_request;
- (void)loadHTMLString:(NSString *)string baseURL:(NSURL *)_baseURL;
- (void)loadData:(NSData *)_data MIMEType:(NSString *)MIMEType textEncodingName:(NSString *)textEncodingName baseURL:(NSURL *)_baseURL;
- (NSString *)stringByEvaluatingJavaScriptFromString:(NSString *)script;
@end
