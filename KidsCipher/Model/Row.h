//
//  Row.h
//  KidsCipher
//
//  Created by Oleksii Vynogradov on 5/3/13.
//  Copyright (c) 2013 IXC-USA Corp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Game;

@interface Row : NSManagedObject

@property (nonatomic, retain) NSString * frame;
@property (nonatomic, retain) NSString * frameToGetImage1;
@property (nonatomic, retain) NSString * frameToGetImage2;
@property (nonatomic, retain) NSString * frameToGetImage3;
@property (nonatomic, retain) NSString * frameToGetImage4;
@property (nonatomic, retain) NSNumber * frame1FilledNumber;
@property (nonatomic, retain) NSNumber * frame2FilledNumber;
@property (nonatomic, retain) NSNumber * frame3FilledNumber;
@property (nonatomic, retain) NSNumber * frame4FilledNumber;
@property (nonatomic, retain) NSNumber * numberOfMatchedColor;
@property (nonatomic, retain) NSNumber * numberOfMatchedColorAndPosition;
@property (nonatomic, retain) NSString * image1insideIdentifier;
@property (nonatomic, retain) NSString * image2insideIdentifier;
@property (nonatomic, retain) NSString * image3insideIdentifier;
@property (nonatomic, retain) NSString * image4insideIdentifier;
@property (nonatomic, retain) NSString * image5insideIdentifier;
@property (nonatomic, retain) NSNumber * isFilled;
@property (nonatomic, retain) Game *game;

@end
