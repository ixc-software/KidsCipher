//
//  GameScore.m
//  KidsCipher
//
//  Created by Oleksii Vynogradov on 6/6/13.
//  Copyright (c) 2013 IXC-USA Corp. All rights reserved.
//

#import "GameScore.h"


@implementation GameScore

@dynamic attempts;
@dynamic date;
@dynamic difficultLevel;
@dynamic gameTime;
@dynamic name;
@dynamic photo;
@dynamic guid;
- (void)awakeFromInsert {
    [self willChangeValueForKey:@"guid"];
    [self setPrimitiveValue:[[NSProcessInfo processInfo] globallyUniqueString] forKey:@"guid"];
    [self didChangeValueForKey:@"guid"];
}
@end
