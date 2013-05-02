//
//  CipherAppDelegate.h
//  KidsCipher
//
//  Created by Oleksii Vynogradov on 4/29/13.
//  Copyright (c) 2013 IXC-USA Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"

@interface CipherAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (retain,nonatomic) NSMutableDictionary *viewControllers;
- (void)registerViewController:(NSString *)name controller:(UIViewController *)controller;
//@property (readwrite) CGPoint image1OutsideTableViewStartPoint;
//@property (readwrite) CGPoint image2OutsideTableViewStartPoint;
//@property (readwrite) CGPoint image3OutsideTableViewStartPoint;
//@property (readwrite) CGPoint image4OutsideTableViewStartPoint;
//@property (readwrite) CGPoint image5OutsideTableViewStartPoint;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (retain,nonatomic) Game *game;
-(Row *)getActiveRow;

@end
