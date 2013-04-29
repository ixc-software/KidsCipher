//
//  GameRow.m
//  SchoolForPreschoolers
//
//  Created by Oleksii Vynogradov on 4/11/13.
//  Copyright (c) 2013 IXC-USA Corp. All rights reserved.
//

#import "GameRow.h"

@implementation GameRow
- (id)init
{
    self = [super init];
    if (self) {
        self.choosedColorsForEveryPoint = [NSMutableArray array];
        for (int i=0;i<6;i++) {
            [self.choosedColorsForEveryPoint addObject:[NSNumber numberWithInteger:0]];
        }
    }
    return self;
}
@end
