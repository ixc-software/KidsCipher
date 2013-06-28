//
//  AVLabel.m
//  KidsCipher
//
//  Created by Oleksii Vynogradov on 6/25/13.
//  Copyright (c) 2013 IXC-USA Corp. All rights reserved.
//

#import "AVLabel.h"

@implementation AVLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawTextInRect:(CGRect)rect {
    UIEdgeInsets insets = {5, 5, 5, 5};
    return [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
