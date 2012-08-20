//
//  ViewController.h
//  NewFacebook
//
//  Created by Vincox on 14/8/12.
//  Copyright (c) 2012 sc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
- (IBAction)LogOutClicked:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *buttonLogOut;
@end
