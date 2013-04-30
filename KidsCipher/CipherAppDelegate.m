//
//  CipherAppDelegate.m
//  KidsCipher
//
//  Created by Oleksii Vynogradov on 4/29/13.
//  Copyright (c) 2013 IXC-USA Corp. All rights reserved.
//

#import "CipherAppDelegate.h"

@implementation CipherAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSMutableArray *gameRow1 = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0], nil];
    NSMutableArray *gameRow2 = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0], nil];
    NSMutableArray *gameRow3 = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0], nil];
    NSMutableArray *gameRow4 = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0], nil];
    NSMutableArray *gameRow5 = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0], nil];
    NSMutableArray *gameRow6 = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0], nil];
    NSMutableArray *gameRow7 = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0], nil];
    NSMutableArray *gameRow8 = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0], nil];
    NSMutableArray *gameRow9 = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0], nil];
    NSMutableArray *gameRow10 = [[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0],[NSNumber numberWithInteger:0], nil];
    
    self.currentChoosesArray = [NSMutableArray arrayWithObjects:
                                gameRow1,
                                gameRow2,
                                gameRow3,
                                gameRow4,
                                gameRow5,
                                gameRow6,
                                gameRow7,
                                gameRow8,
                                gameRow9,
                                gameRow10,
                                nil];
    return YES;
}

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

- (void)registerViewController:(NSString *)name controller:(UIViewController *)controller
{
    if(_viewControllers == nil)
    {
        _viewControllers = [[NSMutableDictionary alloc] init];
        
    }
    
    [_viewControllers setObject:controller forKey:name];
}

@end
