//
//  TabBar.h
//  TabBar
//
//  Created by Rik Schennink on 11/02/14.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UITabBar.h>
#import <Cordova/CDV.h>

@interface TabBar : CDVPlugin <UITabBarDelegate> {
    
    UITabBar *tabBar;
    NSMutableArray *tabs;
    NSMutableDictionary *tabCallbacks;
    
}

- (UIColor *)stringAsUIColor:(NSString*)str;

- (void)reset:(CDVInvokedUrlCommand *)command;

- (void)setup:(CDVInvokedUrlCommand *)command;

- (void)addTab:(uint)tag withTitle:(NSString *)title andIcon:(NSString*)icon;

- (void)addTab:(CDVInvokedUrlCommand *)command;

- (void)selectTab:(CDVInvokedUrlCommand *)command;

@end