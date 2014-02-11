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


- (CDVPlugin*)initWithWebView:(UIWebView*)theWebView
{
    self = (TabBar*)[super initWithWebView:theWebView];
    if (self)
	{
        tabs = [[NSMutableArray alloc] initWithCapacity:4];
        
    }
    return self;
}

- (void)setup:(CDVInvokedUrlCommand *)command {
    
    tabBar = [UITabBar new];
    [tabBar sizeToFit];
    tabBar.delegate = self;
    tabBar.multipleTouchEnabled = NO;
    tabBar.userInteractionEnabled = YES;
	tabBar.opaque = YES;
    
    // [tabBar setTintColor:[UIColor colorWithRed:0.090196078 green:0.623529412 blue:0.831372549 alpha:1.0]];
    // [tabBar setSelectedImageTintColor:[UIColor colorWithRed:0.678431373 green:0.22745098 blue:0.450980392 alpha:1.0]];
    
    [tabBar setTintColor:[UIColor colorWithRed:0.678431373 green:0.22745098 blue:0.450980392 alpha:1.0]];
    

    // setup bounds for tabbar
    float height = 49.0f;
    CGRect webViewBounds = self.webView.bounds;
    
    CGRect tabBarBounds = CGRectMake(
                                     webViewBounds.origin.x,
                                     webViewBounds.origin.y + webViewBounds.size.height - height,
                                     webViewBounds.size.width,
                                     height
                                     );
    [tabBar setFrame:tabBarBounds];
    
    // webview resizes subviews automatically
	self.webView.superview.autoresizesSubviews = YES;
    
	[self.webView.superview addSubview:tabBar];
}

- (void)addTab:(uint)tag withTitle:(NSString *)title andIcon:(NSString*)icon {
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"www/%@@2x",icon] ofType:@"png"];
    UIImage *img = [UIImage imageWithContentsOfFile:filePath];
    
    
    UITabBarItem *tabItem = [UITabBarItem new];
    [tabItem setTag:tag];
    [tabItem setTitle:title];
    [tabItem setImage:img];

    [tabs addObject:tabItem];
    
    [tabBar setItems:tabs];
    
}

- (void)addTab:(CDVInvokedUrlCommand *)command {
    
    uint tag = [[command.arguments objectAtIndex:0] intValue];
    NSString *title = [command.arguments objectAtIndex:1];
    NSString *icon = [command.arguments objectAtIndex:2];
    
    [self addTab:tag withTitle:title andIcon:icon];
    
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    
    NSLog(@"tab selected: %i %@", item.tag, item.title);
    
}


@end