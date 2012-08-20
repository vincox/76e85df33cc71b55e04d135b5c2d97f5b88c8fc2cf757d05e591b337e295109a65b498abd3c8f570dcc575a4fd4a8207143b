//
//  AppDelegate.m
//  NewFacebook
//
//  Created by Vincox on 14/8/12.
//  Copyright (c) 2012 sc. All rights reserved.
//

#import "AppDelegate.h"
#import "WelcomeViewController.h"
#import "ViewController.h"

@implementation AppDelegate
@synthesize window = _window;
@synthesize viewController=_viewController;
@synthesize facebook;
@synthesize navController = _navController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
//    // Override point for customization after application launch.
    WelcomeViewController *welcomeViewController = [[WelcomeViewController alloc] initWithNibName:@"WelcomeViewController" bundle:nil];
    
//    self.navController = [[UINavigationController alloc] initWithRootViewController:welcomeViewController];
//    [[self window] setRootViewController:_navController];

    
    self.window.rootViewController = welcomeViewController;
    [self.window makeKeyAndVisible];
    
    
    return YES;
}

- (void) logoutButtonClicked:(id)sender {
    [facebook logout];
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
    NSLog(@"A");
    return [facebook handleOpenURL:url]; 
}

// For iOS 4.2+ support
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    NSLog(@"B");
    return [facebook handleOpenURL:url]; 
}

- (void)fbDidLogin {
    NSLog(@"FBDIDLOGIN");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[facebook accessToken] forKey:@"FBAccessTokenKey"];
    [defaults setObject:[facebook expirationDate] forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
    
    [facebook requestWithGraphPath:@"me" andDelegate:self];
    
}

- (void)request:(FBRequest *)request didLoad:(id)result {
    
    if ([result isKindOfClass:[NSArray class]]) {
        result = [result objectAtIndex:0];
    }
//    NSString *nameID = [[NSString alloc] initWithFormat:@"%@ (%@)", [result objectForKey:@"name"], [result objectForKey:@"id"]];
//    NSMutableArray *userData = [[NSMutableArray alloc] initWithObjects:
//                                [NSDictionary dictionaryWithObjectsAndKeys:
//                                 [result objectForKey:@"id"], @"id",
//                                 nameID, @"name",
//                                 [result objectForKey:@"picture"], @"details",
//                                 nil], nil];
    
//    [userData release];
//    [nameID release];
    NSLog(@"DATA RECEIVED: %@", result);
}

- (void)request:(FBRequest *)request didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"request:didReceiveResponse:");
}

- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"%@", [error localizedDescription]);
    NSLog(@"Err details: %@", [error description]);
};

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
