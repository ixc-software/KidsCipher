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
@property (retain) NSMutableArray *currentChoosesArray;
@property (readwrite) CGPoint image1OutsideTableViewStartPoint;
@property (readwrite) CGPoint image2OutsideTableViewStartPoint;
@property (readwrite) CGPoint image3OutsideTableViewStartPoint;
@property (readwrite) CGPoint image4OutsideTableViewStartPoint;
@property (readwrite) CGPoint image5OutsideTableViewStartPoint;

@end
