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
    
}

- (void)setup:(CDVInvokedUrlCommand *)command;

- (void)addTab:(NSString *)name withTitle:(NSString *)title andIcon:(NSString*)icon;

- (void)addTab:(CDVInvokedUrlCommand *)command;

@end