//
//  TabBar.m
//  TabBar
//
//  Created by Rik Schennink on 11/02/14.
//
//

#import "TabBar.h"
#import <Cordova/CDV.h>

@implementation TabBar


/*
-(CDVPlugin*)initWithWebView:(UIWebView*)theWebView
{
    self = (TabBar*)[super initWithWebView:theWebView];
    if (self)
	{
        tabBarItems = [[NSMutableDictionary alloc] initWithCapacity:5];
		originalWebViewBounds = theWebView.bounds;
        tabBarHeight = 49.0f;
        navBarHeight = 44.0f;
    }
    return self;
}
*/

- (void)setup:(CDVInvokedUrlCommand *)command {
    
    UITabBar *tabBar = [UITabBar new];
    [tabBar sizeToFit];
    tabBar.delegate = self;
    tabBar.multipleTouchEnabled = NO;
    tabBar.userInteractionEnabled = YES;
	tabBar.opaque = YES;
    
    CGFloat height = 49.0f;
    CGRect webViewBounds = self.webView.bounds;
    webViewBounds.size.height += height;
    CGFloat topBar = 44.0f;
    CGRect tabBarBounds = CGRectMake(
        webViewBounds.origin.x,
        webViewBounds.origin.y + webViewBounds.size.height - height + topBar,
        webViewBounds.size.width,
        height
    );
    [tabBar setFrame:tabBarBounds];
    
	self.webView.superview.autoresizesSubviews = YES;
    
	[ self.webView.superview addSubview:tabBar];
}

@end