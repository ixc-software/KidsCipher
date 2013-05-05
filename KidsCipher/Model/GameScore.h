//
//  GameScore.h
//  KidsCipher
//
//  Created by Oleksii Vynogradov on 5/3/13.
//  Copyright (c) 2013 IXC-USA Corp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface GameScore : NSManagedObject

@property (nonatomic, retain) NSNumber * attempts;
@property (nonatomic, retain) NSNumber * difficultLevel;
@property (nonatomic, retain) NSNumber * gameTime;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSData * photo;

@end
