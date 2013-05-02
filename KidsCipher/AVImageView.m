//
//  AVButton.m
//  RabbitVsBear
//
//  Created by Oleksii Vynogradov on 3/29/12.
//  Copyright (c) 2012 IXC-USA Corp. All rights reserved.
//

#import "AVImageView.h"
#import <QuartzCore/CoreAnimation.h>
#import "CipherAppDelegate.h"
#import "CipherViewController.h"
//#import "GameRow.h"
#import "CipherViewCell.h"

@implementation AVImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //self.startPoint = self.frame.origin;

    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect
//{
//    [super drawRect:rect];
//    self.startPoint = self.frame.origin;
//}

- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
    //NSLog(@"touchesBegan");
    if (!self.hidden) {
        CipherAppDelegate *mainDelegate = (CipherAppDelegate *)[[UIApplication sharedApplication] delegate];
        CipherViewController *game = [mainDelegate.viewControllers valueForKey:@"CipherViewController"];
        //self.startPoint = self.frame.origin;
        Row *activeRow = [mainDelegate getActiveRow];
        
        AVImageView *necessaryImage = nil;
        if ([self isEqual:game.row1image1]) necessaryImage = game.image1OutsideTableView;
        if ([self isEqual:game.row1image2]) necessaryImage = game.image2OutsideTableView;
        if ([self isEqual:game.row1image3]) necessaryImage = game.image3OutsideTableView; 
        if ([self isEqual:game.row1image4]) necessaryImage = game.image4OutsideTableView;
        if ([self isEqual:game.row1image5]) necessaryImage = game.image5OutsideTableView;
        NSUInteger isStartPointMatchedOneOfFrames = 0;
        if (self.frame.origin.x == game.row1frame1.frame.origin.x && self.frame.origin.y == game.row1frame1.frame.origin.y) isStartPointMatchedOneOfFrames = 1;
        if (self.frame.origin.x == game.row1frame2.frame.origin.x && self.frame.origin.y == game.row1frame2.frame.origin.y) isStartPointMatchedOneOfFrames = 2;
        if (self.startPoint.x == game.row1frame3.frame.origin.x && self.startPoint.y == game.row1frame3.frame.origin.y) isStartPointMatchedOneOfFrames = 3;
        if (self.startPoint.x == game.row1frame4.frame.origin.x && self.startPoint.y == game.row1frame4.frame.origin.y) isStartPointMatchedOneOfFrames = 4;
        
        if (necessaryImage && isStartPointMatchedOneOfFrames > 0) {
//            NSMutableArray *choosedColorsForEveryPoint = [mainDelegate.currentChoosesArray objectAtIndex:game.selectedRowNumber];
//            if (isStartPointMatchedOneOfFrames == 1) [choosedColorsForEveryPoint replaceObjectAtIndex:0 withObject:[NSNumber numberWithUnsignedInteger:0]];
//            if (isStartPointMatchedOneOfFrames == 2) [choosedColorsForEveryPoint replaceObjectAtIndex:1 withObject:[NSNumber numberWithUnsignedInteger:0]];
//            if (isStartPointMatchedOneOfFrames == 3) [choosedColorsForEveryPoint replaceObjectAtIndex:2 withObject:[NSNumber numberWithUnsignedInteger:0]];
//            if (isStartPointMatchedOneOfFrames == 4) [choosedColorsForEveryPoint replaceObjectAtIndex:3 withObject:[NSNumber numberWithUnsignedInteger:0]];

            self.hidden = YES;
            necessaryImage.hidden = NO;
            CABasicAnimation *zoomNormal = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            zoomNormal.toValue = [NSNumber numberWithDouble:1.0];
            zoomNormal.duration = 0.1;
            zoomNormal.fillMode=kCAFillModeForwards;
            zoomNormal.removedOnCompletion=NO;

            [UIView animateWithDuration:0.4
                                  delay:0
                                options:UIViewAnimationOptionBeginFromCurrentState
                             animations:^{
                                 necessaryImage.frame = CGRectMake(necessaryImage.startPoint.x, necessaryImage.startPoint.y,
                                                                                necessaryImage.frame.size.width, necessaryImage.frame.size.height);
                             } completion:^(BOOL finished) {
                                 [self touchesCancelled:touches withEvent:event];
                                 [necessaryImage.layer addAnimation:zoomNormal forKey:@"zoomNormal"];
                             }];
        }
    }
    CABasicAnimation *zoomOutMax = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    zoomOutMax.beginTime = CACurrentMediaTime();
    zoomOutMax.toValue = [NSNumber numberWithDouble:1.2];
    zoomOutMax.duration = 0.2;
    zoomOutMax.fillMode=kCAFillModeForwards;
    zoomOutMax.removedOnCompletion = NO;
    [self.layer addAnimation:zoomOutMax forKey:@"zoomOutMax"];
    self.isScalled = YES;
}

-(CGPoint) calculatePositionForPoint:(CGPoint)location {
    
    return location;
}
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag;
{
    //NSLog(@">>>>>>>>> SUCCESS");
}

- (void) touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event {
    CipherAppDelegate *mainDelegate = (CipherAppDelegate *)[[UIApplication sharedApplication] delegate];
    CipherViewController *game = [mainDelegate.viewControllers valueForKey:@"CipherViewController"];
    UITouch *aTouch = [touches anyObject];
    CGPoint location = [aTouch locationInView:self.superview];
    [UIView beginAnimations:@"Dragging A DraggableView" context:nil];
    self.frame = CGRectMake(location.x-self.offset.x, location.y-self.offset.y,
                            self.frame.size.width, self.frame.size.height);
    [UIView commitAnimations];

    CGRect frame1 = [game.gamePlayScrollView convertRect:game.row1frame1.frame toView:game.view];
    CGRect frame2 = [game.gamePlayScrollView convertRect:game.row1frame2.frame toView:game.view];
    CGRect frame3 = [game.gamePlayScrollView convertRect:game.row1frame3.frame toView:game.view];
    CGRect frame4 = [game.gamePlayScrollView convertRect:game.row1frame4.frame toView:game.view];
    bool result1 = CGRectContainsPoint(frame1,location);
    bool result2 = CGRectContainsPoint(frame2,location);
    bool result3 = CGRectContainsPoint(frame3,location);
    bool result4 = CGRectContainsPoint(frame4,location);
    //NSLog(@"game.nextRowToFill.row->%ld result1->%@ frame1->%@ result2->%@ result3->%@ result4->%@",(long)game.nextRowToFill.row,[NSNumber numberWithBool:result1],NSStringFromCGRect(frame1),[NSNumber numberWithBool:result2],[NSNumber numberWithBool:result3],[NSNumber numberWithBool:result4]);
    if (result1 || result2 || result3 || result4) {
//        NSMutableArray *choosedColorsForEveryPoint = [mainDelegate.currentChoosesArray objectAtIndex:game.selectedRowNumber];
//        CGPoint pointOfFinalImagePositionInsideCell;
//        if (result1) {
//            if ([[choosedColorsForEveryPoint objectAtIndex:0] integerValue] > 0) return;
//            pointOfFinalImagePositionInsideCell = CGPointMake(game.row1frame1.frame.origin.x, game.row1frame1.frame.origin.y);
//        }
//        if (result2) {
//            if ([[choosedColorsForEveryPoint objectAtIndex:1] integerValue] > 0) return;
//            pointOfFinalImagePositionInsideCell = CGPointMake(game.row1frame2.frame.origin.x, game.row1frame2.frame.origin.y);
//        }
//        if (result3) {
//            if ([[choosedColorsForEveryPoint objectAtIndex:2] integerValue] > 0) return;
//            pointOfFinalImagePositionInsideCell = CGPointMake(game.row1frame3.frame.origin.x, game.row1frame3.frame.origin.y);
//        }
//        if (result4) {
//            if ([[choosedColorsForEveryPoint objectAtIndex:3] integerValue] > 0) return;
//            pointOfFinalImagePositionInsideCell = CGPointMake(game.row1frame4.frame.origin.x, game.row1frame4.frame.origin.y);
//        }
        
        self.hidden = YES;
        CGRect frameImageInsideCellConvertedFromOutsoidedImage = [game.view convertRect:self.frame toView:game.gamePlayScrollView];
        //NSLog(@"frameImageInsideCellConvertedFromOutsoidedImage->%@",NSStringFromCGRect(frameImageInsideCellConvertedFromOutsoidedImage));
        NSNumber *number = nil;
        
        AVImageView *necessaryImage = nil;
        if ([self isEqual:game.image1OutsideTableView]) {
            necessaryImage = game.row1image1,
            number = [[NSNumber alloc] initWithInteger:1];
//            game.image1OutsideTableView.frame =
//            CGRectMake(game.image1OutsideTableView.startPoint.x,
//                       game.image1OutsideTableView.startPoint.y,
//                       game.image1OutsideTableView.frame.size.width,
//                       game.image1OutsideTableView.frame.size.height);
        }
        if ([self isEqual:game.image2OutsideTableView]) {
            necessaryImage = game.row1image2,
            number = [[NSNumber alloc] initWithInteger:2];
//            game.image2OutsideTableView.frame =
//            CGRectMake(game.image2OutsideTableView.startPoint.x,
//                       game.image2OutsideTableView.startPoint.y,
//                       game.image2OutsideTableView.frame.size.width,
//                       game.image2OutsideTableView.frame.size.height);
        }
        if ([self isEqual:game.image3OutsideTableView]) {
            necessaryImage = game.row1image3,
            number = [[NSNumber alloc] initWithInteger:3];
//            game.image3OutsideTableView.frame =
//            CGRectMake(game.image3OutsideTableView.startPoint.x,
//                       game.image3OutsideTableView.startPoint.y,
//                       game.image3OutsideTableView.frame.size.width,
//                       game.image3OutsideTableView.frame.size.height);
        }
        if ([self isEqual:game.image4OutsideTableView]) {
            necessaryImage = game.row1image4,
            number = [[NSNumber alloc] initWithInteger:4];
//            game.image4OutsideTableView.frame =
//            CGRectMake(game.image4OutsideTableView.startPoint.x,
//                       game.image4OutsideTableView.startPoint.y,
//                       game.image4OutsideTableView.frame.size.width,
//                       game.image4OutsideTableView.frame.size.height);
        }
        if ([self isEqual:game.image5OutsideTableView]) { necessaryImage = game.row1image5,number = [[NSNumber alloc] initWithInteger:5]; }
        necessaryImage.hidden = NO;
        //self.frame = CGRectMake(self.startPoint.x, self.startPoint.y, self.frame.size.width, self.frame.size.height);
        //NSLog(@"self.startPoint->%@",NSStringFromCGPoint(self.startPoint));
        [UIView animateWithDuration:0.2
                              delay:0
                            options:0
                         animations:^{
                             necessaryImage.frame = frameImageInsideCellConvertedFromOutsoidedImage;
//                             necessaryImage.frame = CGRectMake(pointOfFinalImagePositionInsideCell.x, pointOfFinalImagePositionInsideCell.y,
//                                                               necessaryImage.frame.size.width, necessaryImage.frame.size.height);
                         } completion:^(BOOL finished) {
                             CABasicAnimation *zoomNormal = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
                             zoomNormal.toValue = [NSNumber numberWithDouble:1.0];
                             zoomNormal.duration = 0.1;
                             zoomNormal.fillMode=kCAFillModeForwards;
                             zoomNormal.removedOnCompletion=NO;
                             [necessaryImage.layer addAnimation:zoomNormal forKey:@"zoomNormal"];
                             
                             CABasicAnimation *zoomNormalOutside = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
                             zoomNormalOutside.toValue = [NSNumber numberWithDouble:1.0];
                             zoomNormalOutside.duration = 0.1;
                             zoomNormalOutside.fillMode=kCAFillModeForwards;
                             zoomNormalOutside.removedOnCompletion=NO;
                             [self.layer addAnimation:zoomNormalOutside forKey:@"zoomNormal"];
                             
//                             NSMutableArray *choosedColorsForEveryPoint = [mainDelegate.currentChoosesArray objectAtIndex:game.selectedRowNumber];
//                             if (result1) [choosedColorsForEveryPoint replaceObjectAtIndex:0 withObject:number];
//                             if (result2) [choosedColorsForEveryPoint replaceObjectAtIndex:1 withObject:number];
//                             if (result3) [choosedColorsForEveryPoint replaceObjectAtIndex:2 withObject:number];
//                             if (result4) [choosedColorsForEveryPoint replaceObjectAtIndex:3 withObject:number];
                             NSPredicate *filter = [NSPredicate predicateWithFormat:@"SELF > %@",[NSNumber numberWithInt:0]];
                             NSArray *filtered = nil;//[choosedColorsForEveryPoint filteredArrayUsingPredicate:filter];
                             if (filtered.count == 4) {
                                 [self touchesCancelled:touches withEvent:event];

                                 
                                 if (game.image1OutsideTableView.startPoint.x != 0)
                                 game.image1OutsideTableView.frame = CGRectMake(game.image1OutsideTableView.startPoint.x, game.image1OutsideTableView.startPoint.y,
                                                                                game.image1OutsideTableView.frame.size.width, game.image1OutsideTableView.frame.size.height);
                                 if (game.image2OutsideTableView.startPoint.x != 0)
                                 game.image2OutsideTableView.frame = CGRectMake(game.image2OutsideTableView.startPoint.x, game.image2OutsideTableView.startPoint.y,
                                                                                game.image2OutsideTableView.frame.size.width, game.image2OutsideTableView.frame.size.height);
                                 if (game.image3OutsideTableView.startPoint.x != 0)
                                 game.image3OutsideTableView.frame = CGRectMake(game.image3OutsideTableView.startPoint.x, game.image3OutsideTableView.startPoint.y,
                                                                                game.image3OutsideTableView.frame.size.width, game.image3OutsideTableView.frame.size.height);
                                 if (game.image4OutsideTableView.startPoint.x != 0)
                                 game.image4OutsideTableView.frame = CGRectMake(game.image4OutsideTableView.startPoint.x, game.image4OutsideTableView.startPoint.y,
                                                                                game.image4OutsideTableView.frame.size.width, game.image4OutsideTableView.frame.size.height);
                                 if (game.image5OutsideTableView.startPoint.x != 0)
                                 game.image5OutsideTableView.frame = CGRectMake(game.image5OutsideTableView.startPoint.x, game.image5OutsideTableView.startPoint.y,
                                                                                game.image5OutsideTableView.frame.size.width, game.image5OutsideTableView.frame.size.height);
                                 //NSLog(@"game.image1OutsideTableView.frame->%@",NSStringFromCGRect(game.image1OutsideTableView.frame));
                                 //NSLog(@"game.image2OutsideTableView.frame->%@",NSStringFromCGRect(game.image2OutsideTableView.frame));
                                 //NSLog(@"game.image3OutsideTableView.frame->%@",NSStringFromCGRect(game.image3OutsideTableView.frame));
                                 //NSLog(@"game.image4OutsideTableView.frame->%@",NSStringFromCGRect(game.image4OutsideTableView.frame));
                                 //NSLog(@"game.image5OutsideTableView.frame->%@",NSStringFromCGRect(game.image5OutsideTableView.frame));
                                 //NSLog(@"self->%@ game.image4OutsideTableView->%@",self,game.image4OutsideTableView);
                                 if (![self isEqual:game.image1OutsideTableView]) game.image1OutsideTableView.hidden = NO;
                                 else game.image1OutsideTableView.isCanceledTouches = YES;
                                 if (![self isEqual:game.image2OutsideTableView]) game.image2OutsideTableView.hidden = NO;
                                 else game.image2OutsideTableView.isCanceledTouches = YES;
                                 if (![self isEqual:game.image3OutsideTableView]) game.image3OutsideTableView.hidden = NO;
                                 else game.image3OutsideTableView.isCanceledTouches = YES;
                                 if (![self isEqual:game.image4OutsideTableView]) game.image4OutsideTableView.hidden = NO;
                                 else game.image4OutsideTableView.isCanceledTouches = YES;
                                 if (![self isEqual:game.image5OutsideTableView]) game.image5OutsideTableView.hidden = NO;
                                 else game.image5OutsideTableView.isCanceledTouches = YES;
                                 [game startCompletingCurrentRowAndOpenNext];
                             }

                         }];

    }
}


//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
//    // test if our control subview is on-screen
//    NSLog(@"start checking..");
//    if (self.superview != nil) {
//        NSLog(@"superview not nil..");
//
//        if ([touch.view isDescendantOfView:self] && self.hidden != YES) {
//            // we touched our control surface
//            NSLog(@"ignore the touch");
//
//            return NO; // ignore the touch
//        }
//    }
//    return YES; // handle the touch
//}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{

    //NSLog(@"touchesEnded");
    if (!self.hidden) {
        self.isCanceledTouches = NO;
        [UIView animateWithDuration:1
                              delay:0
                            options:0
                         animations:^{
                             
                             self.frame = CGRectMake(self.startPoint.x, self.startPoint.y,
                                                     self.frame.size.width, self.frame.size.height);
                         } completion:^(BOOL finished) {
                             if (self.isScalled) {
                                 self.isScalled = NO;
                                 CABasicAnimation *zoomNormal = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
                                 zoomNormal.toValue = [NSNumber numberWithDouble:1.0];
                                 zoomNormal.duration = 0.1;
                                 zoomNormal.fillMode=kCAFillModeForwards;
                                 zoomNormal.removedOnCompletion=NO;
                                 [self.layer addAnimation:zoomNormal forKey:@"zoomNormal"];
                             }
                             //NSLog(@"touchesEnded self.hidden->NO self.startPoint->%@ self.isCanceledTouches->%c",NSStringFromCGPoint(self.startPoint),self.isCanceledTouches);
                         }];
        
    } else {
        //NSLog(@"touchesEnded self.hidden->YES self.startPoint->%@ self.isCanceledTouches->%c",NSStringFromCGPoint(self.startPoint),self.isCanceledTouches);
        if (self.isCanceledTouches) { self.hidden = NO,self.isCanceledTouches = NO; }
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!self.hidden) {
        //NSLog(@"touchesCancelled");
        if (self.isScalled) {
            self.isScalled = NO;
            CABasicAnimation *zoomNormal = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            zoomNormal.toValue = [NSNumber numberWithDouble:1.0];
            zoomNormal.duration = 0.1;
            zoomNormal.fillMode=kCAFillModeForwards;
            zoomNormal.removedOnCompletion=NO;
            [self.layer addAnimation:zoomNormal forKey:@"zoomNormal"];
        }
        //NSLog(@"touchesCancelled self.hidden->NO self.startPoint->%@ self.isCanceledTouches->%c",NSStringFromCGPoint(self.startPoint),self.isCanceledTouches);
    } else    {
        //NSLog(@"touchesCancelled self.hidden->YES self.startPoint->%@ self.isCanceledTouches->%c",NSStringFromCGPoint(self.startPoint),self.isCanceledTouches);
    }
}
@end
