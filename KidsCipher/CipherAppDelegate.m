//
//  CipherAppDelegate.m
//  KidsCipher
//
//  Created by Oleksii Vynogradov on 4/29/13.
//  Copyright (c) 2013 IXC-USA Corp. All rights reserved.
//

#import "CipherAppDelegate.h"
#import "Game.h"
#import "Row.h"
#import "CipherViewController.h"

@implementation CipherAppDelegate
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //NSLog(@"didFinishLaunchingWithOptions");

    self.game = (Game *)[NSEntityDescription insertNewObjectForEntityForName:@"Game" inManagedObjectContext:self.managedObjectContext];
    self.game.combination1color = [NSNumber numberWithInt:arc4random() % 5+1];
    self.game.combination2color = [NSNumber numberWithInt:arc4random() % 5+1];
    self.game.combination3color = [NSNumber numberWithInt:arc4random() % 5+1];
    self.game.combination4color = [NSNumber numberWithInt:arc4random() % 5+1];
    for (int i= 0; i < 10; i++) {
        Row *newRow = (Row *)[NSEntityDescription insertNewObjectForEntityForName:@"Row" inManagedObjectContext:self.managedObjectContext];
        newRow.game = self.game;
    }
    [self saveContext];
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

#pragma mark - Core Data
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}
- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) return _managedObjectContext;
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) return _managedObjectModel;
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) return _persistentStoreCoordinator;
    NSManagedObjectModel *mom = [self managedObjectModel];
    if (!mom) {
        NSAssert(NO, @"Managed object model is nil");
        NSLog(@"%@:%@ No model to generate a store from", [self class], NSStringFromSelector(_cmd));
        return nil;
    }
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"callsfreecalls.sqlite"];
    //NSMutableDictionary *pragmaOptions = [NSMutableDictionary dictionary];
    //[pragmaOptions setObject:[NSNumber numberWithBool:YES] forKey:NSMigratePersistentStoresAutomaticallyOption];
    //[pragmaOptions setObject:[NSNumber numberWithBool:YES] forKey:NSInferMappingModelAutomaticallyOption];
    //NSDictionary *options = [NSDictionary dictionaryWithDictionary:pragmaOptions];
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSInMemoryStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];
        if (![_persistentStoreCoordinator addPersistentStoreWithType:NSInMemoryStoreType configuration:nil URL:storeURL options:nil error:&error])
        {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
    return _persistentStoreCoordinator;
}

-(Row *)getActiveRow;
{
    NSNumber *activeRowNumber = self.game.activeRowNumber;
    NSOrderedSet *rows = self.game.rows;
    Row *activeRow = [rows objectAtIndex:activeRowNumber.unsignedIntegerValue];
    CipherViewController *vc = [self.viewControllers valueForKey:@"CipherViewController"];
    
    switch (activeRowNumber.intValue) {
        case 0:
            activeRow.frame = NSStringFromCGRect(vc.row1view.frame);
            activeRow.frame1startingPoint = NSStringFromCGRect(vc.row1frame1.frame);
            activeRow.frame2startingPoint = NSStringFromCGRect(vc.row1frame2.frame);
            activeRow.frame3startingPoint = NSStringFromCGRect(vc.row1frame3.frame);
            activeRow.frame4startingPoint = NSStringFromCGRect(vc.row1frame4.frame);
            break;
            
        default:
            break;
    }
    [self saveContext];
    return activeRow;
}

@end
