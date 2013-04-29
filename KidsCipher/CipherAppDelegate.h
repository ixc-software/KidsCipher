//
//  CipherAppDelegate.h
//  KidsCipher
//
//  Created by Oleksii Vynogradov on 4/29/13.
//  Copyright (c) 2013 IXC-USA Corp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CipherAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (retain,nonatomic) NSMutableDictionary *viewControllers;
- (void)registerViewController:(NSString *)name controller:(UIViewController *)controller;

@end
