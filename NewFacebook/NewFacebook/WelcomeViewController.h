//
//  WelcomeViewController.h
//  NewFacebook
//
//  Created by Scott Frank Sithu on 14/8/12.
//  Copyright (c) 2012 sc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"
@interface WelcomeViewController : UIViewController<UIApplicationDelegate, FBSessionDelegate>
@property (strong, nonatomic) IBOutlet UIButton *buttonLogIn;
@property (strong, nonatomic) IBOutlet UIButton *buttonLogOut;
- (IBAction)LogInClicked:(id)sender;
- (IBAction)LogOutClicked:(id)sender;

@end
