//
//  WelcomeViewController.m
//  NewFacebook
//
//  Created by Scott Frank Sithu on 14/8/12.
//  Copyright (c) 2012 sc. All rights reserved.
//

#import "WelcomeViewController.h"
#import "AppDelegate.h"
#import "ViewController.h"
@interface WelcomeViewController ()

@end

@implementation WelcomeViewController
@synthesize buttonLogIn = _buttonLogIn;
@synthesize buttonLogOut = _buttonLogOut;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (IBAction)LogInClicked:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.facebook = [[Facebook alloc] initWithAppId:@"254875884551613" andDelegate:self];
   
   
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"] 
        && [defaults objectForKey:@"FBExpirationDateKey"]) {
        appDelegate.facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
        appDelegate.facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
    }
    if (![appDelegate.facebook isSessionValid]) {
        NSArray *permissions = [[NSArray alloc] initWithObjects:
                                @"user_likes",
                                @"user_about_me",
                                @"user_photos",
                                @"user_birthday",
                                @"friends_about_me",
                                @"friends_activities",
                                @"read_stream",
                                @"publish_stream",
                                nil];
        [appDelegate.facebook authorize:permissions];
    }
NSLog(@"HELLO");
}

- (IBAction)LogOutClicked:(id)sender {
    
     AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate.facebook logout];
    
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies])
    {
        NSString* domainName = [cookie domain];
        NSRange domainRange = [domainName rangeOfString:@"facebook"];
        if(domainRange.length > 0)
        {
            [storage deleteCookie:cookie];
        }
    }
    
    NSLog(@"LOG OUT");
    
}
- (void) fbDidLogout {
    // Remove saved authorization information if it exists
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"]) {
        [defaults removeObjectForKey:@"FBAccessTokenKey"];
        [defaults removeObjectForKey:@"FBExpirationDateKey"];
        [defaults synchronize];
    }
}

// Pre iOS 4.2 support
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    NSLog(@"1A");
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return [appDelegate.facebook handleOpenURL:url]; 
}

// For iOS 4.2+ support
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    NSLog(@"1B");
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return [appDelegate.facebook handleOpenURL:url]; 
}

- (void)fbDidLogin {
    NSLog(@"1FBDIDLOGIN");
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[appDelegate.facebook accessToken] forKey:@"FBAccessTokenKey"];
    [defaults setObject:[appDelegate.facebook expirationDate] forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
    [appDelegate.facebook requestWithGraphPath:@"me" andDelegate:self];
}

- (void)request:(FBRequest *)request didLoad:(id)result {
    
    if ([result isKindOfClass:[NSArray class]]) {
        result = [result objectAtIndex:0];
    }
        NSString *birthday = [[NSString alloc] initWithFormat:@"%@ (%@)", [result objectForKey:@"birthday"], [result objectForKey:@"id"]];
//        NSMutableArray *userData = [[NSMutableArray alloc] initWithObjects:
//                                    [NSDictionary dictionaryWithObjectsAndKeys:
//                                     [result objectForKey:@"id"], @"id",
//                                     nameID, @"name",
//                                     [result objectForKey:@"picture"], @"details",
//                                     nil], nil];
    
    //    [userData release];
    //    [nameID release];
    NSLog(@"DATA RECEIVED: %@", result);
    NSLog(@"birthday: %@", birthday);
//    ViewController *viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:[NSBundle mainBundle]];
//    [self.window addSubview:viewController.view];
}

- (void)request:(FBRequest *)request didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"request:didReceiveResponse:");
}

- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"%@", [error localizedDescription]);
    NSLog(@"Err details: %@", [error description]);
};

@end
