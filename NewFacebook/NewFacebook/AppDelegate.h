//
//  AppDelegate.h
//  NewFacebook
//
//  Created by Vincox on 14/8/12.
//  Copyright (c) 2012 sc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"
@class ViewController;

@interface AppDelegate : NSObject 
<UIApplicationDelegate, FBSessionDelegate>{
    Facebook *facebook;
}

@property (strong, nonatomic) IBOutlet UIWindow *window;

@property (strong, nonatomic) IBOutlet ViewController *viewController;
@property (nonatomic, retain) Facebook *facebook;

@property (nonatomic, retain) UINavigationController *navController;

@end
