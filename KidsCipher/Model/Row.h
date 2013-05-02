//
//  Row.h
//  KidsCipher
//
//  Created by Oleksii Vynogradov on 5/2/13.
//  Copyright (c) 2013 IXC-USA Corp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Game;

@interface Row : NSManagedObject

@property (nonatomic, retain) NSNumber * isFrame1Filled;
@property (nonatomic, retain) NSNumber * isFrame2Filled;
@property (nonatomic, retain) NSNumber * isFrame3Filled;
@property (nonatomic, retain) NSNumber * isFrame4Filled;
@property (nonatomic, retain) NSNumber * numberOfMatchedColorAndPosition;
@property (nonatomic, retain) NSNumber * numberOfMatchedColor;
@property (nonatomic, retain) NSString * frame;
@property (nonatomic, retain) NSString * frame2startingPoint;
@property (nonatomic, retain) NSString * frame3startingPoint;
@property (nonatomic, retain) NSString * frame4startingPoint;
@property (nonatomic, retain) NSString * frame1startingPoint;
@property (nonatomic, retain) Game *game;

@end
