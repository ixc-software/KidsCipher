//
//  Game.h
//  KidsCipher
//
//  Created by Oleksii Vynogradov on 5/2/13.
//  Copyright (c) 2013 IXC-USA Corp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Row;

@interface Game : NSManagedObject

@property (nonatomic, retain) NSNumber * activeRowNumber;
@property (nonatomic, retain) NSDate * startTime;
@property (nonatomic, retain) NSNumber * isFrame1empty;
@property (nonatomic, retain) NSNumber * isFrame2empty;
@property (nonatomic, retain) NSNumber * isFrame3empty;
@property (nonatomic, retain) NSNumber * isFrame4empty;
@property (nonatomic, retain) NSNumber * isFrame5empty;
@property (nonatomic, retain) NSNumber * combination1color;
@property (nonatomic, retain) NSNumber * combination2color;
@property (nonatomic, retain) NSNumber * combination3color;
@property (nonatomic, retain) NSNumber * combination4color;
@property (nonatomic, retain) NSString * frame1startingPoint;
@property (nonatomic, retain) NSString * frame2startingPoint;
@property (nonatomic, retain) NSString * frame3startingPoint;
@property (nonatomic, retain) NSString * frame4startingPoint;
@property (nonatomic, retain) NSString * frame5startingPoint;
@property (nonatomic, retain) NSOrderedSet *rows;
@end

@interface Game (CoreDataGeneratedAccessors)

- (void)insertObject:(Row *)value inRowsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromRowsAtIndex:(NSUInteger)idx;
- (void)insertRows:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeRowsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInRowsAtIndex:(NSUInteger)idx withObject:(Row *)value;
- (void)replaceRowsAtIndexes:(NSIndexSet *)indexes withRows:(NSArray *)values;
- (void)addRowsObject:(Row *)value;
- (void)removeRowsObject:(Row *)value;
- (void)addRows:(NSOrderedSet *)values;
- (void)removeRows:(NSOrderedSet *)values;
@end
