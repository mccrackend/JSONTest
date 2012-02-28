//
//  JSONTestAppDelegate.h
//  JSONTest
//
//  Created by Dan McCracken on 12/13/10.
//  Copyright 2010 Elusive Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSONTestAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@end
