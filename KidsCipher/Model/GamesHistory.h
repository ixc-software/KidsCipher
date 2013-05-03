//
//  GamesHistory.h
//  KidsCipher
//
//  Created by Oleksii Vynogradov on 5/3/13.
//  Copyright (c) 2013 IXC-USA Corp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface GamesHistory : NSManagedObject

@property (nonatomic, retain) NSNumber * attempts;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * gameTime;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSData * photo;
@property (nonatomic, retain) NSNumber * difficultLevel;

@end
