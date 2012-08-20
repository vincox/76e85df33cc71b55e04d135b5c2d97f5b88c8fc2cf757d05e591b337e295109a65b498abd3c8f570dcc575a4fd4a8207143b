//
//  ViewController.m
//  NewFacebook
//
//  Created by Vincox on 14/8/12.
//  Copyright (c) 2012 sc. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
@interface ViewController ()

@end

@implementation ViewController

@synthesize buttonLogOut = _buttonLogOut;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (IBAction)LogOutClicked:(id)sender {
    NSLog(@"LOG OUT");
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    [appDelegate.facebook logout];
}
@end
