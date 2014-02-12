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
        tags = 0;
        tabs = [[NSMutableArray alloc] initWithCapacity:4];
        tabCallbacks = [NSMutableDictionary new];
        tabTags = [NSMutableDictionary new];
    }
    return self;
}


- (UIColor *)stringAsUIColor:(NSString*)colorString {
    NSArray *parts = [colorString componentsSeparatedByString:@","];
    return [UIColor colorWithRed:[[parts objectAtIndex:0] doubleValue]
                           green:[[parts objectAtIndex:1] doubleValue]
                            blue:[[parts objectAtIndex:2] doubleValue]
                           alpha:[[parts objectAtIndex:3] doubleValue]];
}

- (void)reset:(CDVInvokedUrlCommand *)command {
    
    // remove all tab items
    [tabs removeAllObjects];
    
    // remove tabbar
    [tabBar removeFromSuperview];
    
}

- (void)setup:(CDVInvokedUrlCommand *)command {
    
    // get parameters
    NSString *jsTintColor = [command.arguments objectAtIndex:0];
    NSString *jsTintSelectedColor = [command.arguments objectAtIndex:1];
    
    // if already has a tabbar stop here
    if (tabBar != nil) {
        return;
    }
    
    // setup tabbar
    tabBar = [UITabBar new];
    [tabBar sizeToFit];
    tabBar.delegate = self;
    tabBar.multipleTouchEnabled = NO;
    tabBar.userInteractionEnabled = YES;
	tabBar.opaque = YES;

    // apply colors
    /*
    currently tint color is not implemented
    if (jsTintColor != (id)[NSNull null]) {
        UIColor *tintColor = [self stringAsUIColor:jsTintColor];
    }
    */
    
    if (jsTintSelectedColor != (id)[NSNull null]) {
        UIColor *tintSelectedColor = [self stringAsUIColor:jsTintSelectedColor];
        [tabBar setTintColor:tintSelectedColor];
    }
    
    
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

- (void)addTab:(int)tag withTitle:(NSString *)title andIcon:(NSString*)icon {
    
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
    
    NSString *tid = [command.arguments objectAtIndex:0];
    NSString *title = [command.arguments objectAtIndex:1];
    NSString *icon = [command.arguments objectAtIndex:2];
    
    // get tag by name
    NSNumber *tagnr = [tabTags objectForKey:tid];
    
    // if no tag found create a new tab
    if (tagnr == nil) {
        
        // get new tag nr
        int tag = tags++;
        
        tagnr = [NSNumber numberWithInt:tag];
        
        // link tag to tab id
        [tabTags setObject:tagnr forKey:tid];
        
        // add the tab
        [self addTab:tag withTitle:title andIcon:icon];
        
    }
    
    // store in hashtable
    [tabCallbacks setObject:command.callbackId forKey:tagnr];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
    // get callback from hashtable
    NSString *callbackId = [tabCallbacks objectForKey:[NSNumber numberWithInt:item.tag]];
    
    // return to js
    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:callbackId];
    
}


- (void)selectTab:(CDVInvokedUrlCommand *)command {
    
    NSString *tid = [command.arguments objectAtIndex:0];
    
    // get tag by name
    NSNumber *tagnr = [tabTags objectForKey:tid];
    
    // if no tag found stop here
    if (tagnr == nil) {
        return;
    }
    
    // convert to int
    int tag = [tagnr intValue];
    
    // set as selected
    [tabBar setSelectedItem:[tabBar.items objectAtIndex:tag]];
    
}


@end