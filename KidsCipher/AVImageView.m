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
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
    //NSLog(@"touchesBegan");
    if (!self.hidden) {
        CipherAppDelegate *mainDelegate = (CipherAppDelegate *)[[UIApplication sharedApplication] delegate];
        CipherViewController *game = [mainDelegate.viewControllers valueForKey:@"CipherViewController"];
        self.startPoint = self.frame.origin;
        AVImageView *necessaryImage = nil;
        if ([self isEqual:game.row1image1]) necessaryImage = game.image1OutsideTableView;
        if ([self isEqual:game.row1image2]) necessaryImage = game.image2OutsideTableView;
        if ([self isEqual:game.row1image3]) necessaryImage = game.image3OutsideTableView; 
        if ([self isEqual:game.row1image4]) necessaryImage = game.image4OutsideTableView;
        if ([self isEqual:game.row1image5]) necessaryImage = game.image5OutsideTableView;
        NSUInteger isStartPointMatchedOneOfFrames = 0;
        if (self.startPoint.x == game.row1frame1.frame.origin.x && self.startPoint.y == game.row1frame1.frame.origin.y) isStartPointMatchedOneOfFrames = 1;
        if (self.startPoint.x == game.row1frame2.frame.origin.x && self.startPoint.y == game.row1frame2.frame.origin.y) isStartPointMatchedOneOfFrames = 2;
        if (self.startPoint.x == game.row1frame3.frame.origin.x && self.startPoint.y == game.row1frame3.frame.origin.y) isStartPointMatchedOneOfFrames = 3;
        if (self.startPoint.x == game.row1frame4.frame.origin.x && self.startPoint.y == game.row1frame4.frame.origin.y) isStartPointMatchedOneOfFrames = 4;
        
        if (necessaryImage && isStartPointMatchedOneOfFrames > 0) {
            NSMutableArray *choosedColorsForEveryPoint = [mainDelegate.currentChoosesArray objectAtIndex:game.selectedRowNumber];
            if (isStartPointMatchedOneOfFrames == 1) [choosedColorsForEveryPoint replaceObjectAtIndex:0 withObject:[NSNumber numberWithUnsignedInteger:0]];
            if (isStartPointMatchedOneOfFrames == 2) [choosedColorsForEveryPoint replaceObjectAtIndex:1 withObject:[NSNumber numberWithUnsignedInteger:0]];
            if (isStartPointMatchedOneOfFrames == 3) [choosedColorsForEveryPoint replaceObjectAtIndex:2 withObject:[NSNumber numberWithUnsignedInteger:0]];
            if (isStartPointMatchedOneOfFrames == 4) [choosedColorsForEveryPoint replaceObjectAtIndex:3 withObject:[NSNumber numberWithUnsignedInteger:0]];

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
                                 //[self touchesCancelled:touches withEvent:event];
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
        self.hidden = YES;
        CGRect frameImageInsideCellConvertedFromOutsoidedImage = [game.view convertRect:self.frame toView:game.gamePlayScrollView];
        [self touchesCancelled:touches withEvent:event];
        CABasicAnimation *zoomNormal = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        zoomNormal.toValue = [NSNumber numberWithDouble:1.0];
        zoomNormal.duration = 0.1;
        zoomNormal.fillMode=kCAFillModeForwards;
        zoomNormal.removedOnCompletion=NO;
        CGPoint pointOfFinalImagePositionInsideCell;
        if (result1) pointOfFinalImagePositionInsideCell = CGPointMake(game.row1frame1.frame.origin.x, game.row1frame1.frame.origin.y);
        if (result2) pointOfFinalImagePositionInsideCell = CGPointMake(game.row1frame2.frame.origin.x, game.row1frame2.frame.origin.y);
        if (result3) pointOfFinalImagePositionInsideCell = CGPointMake(game.row1frame3.frame.origin.x, game.row1frame3.frame.origin.y);
        if (result4) pointOfFinalImagePositionInsideCell = CGPointMake(game.row1frame4.frame.origin.x, game.row1frame4.frame.origin.y);
        //NSLog(@"frameImageInsideCellConvertedFromOutsoidedImage->%@",NSStringFromCGRect(frameImageInsideCellConvertedFromOutsoidedImage));
        NSNumber *number = nil;
        
        AVImageView *necessaryImage = nil;
        if ([self isEqual:game.image1OutsideTableView]) { necessaryImage = game.row1image1,number = [[NSNumber alloc] initWithInteger:1]; }
        if ([self isEqual:game.image2OutsideTableView]) { necessaryImage = game.row1image2,number = [[NSNumber alloc] initWithInteger:2]; }
        if ([self isEqual:game.image3OutsideTableView]) { necessaryImage = game.row1image3,number = [[NSNumber alloc] initWithInteger:3]; }
        if ([self isEqual:game.image4OutsideTableView]) { necessaryImage = game.row1image4,number = [[NSNumber alloc] initWithInteger:4]; }
        if ([self isEqual:game.image5OutsideTableView]) { necessaryImage = game.row1image5,number = [[NSNumber alloc] initWithInteger:5]; }
        necessaryImage.hidden = NO;
        
        
        
        [UIView animateWithDuration:0.4
                              delay:0
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             necessaryImage.frame = frameImageInsideCellConvertedFromOutsoidedImage;
                             necessaryImage.frame = CGRectMake(pointOfFinalImagePositionInsideCell.x, pointOfFinalImagePositionInsideCell.y,
                                                               necessaryImage.frame.size.width, necessaryImage.frame.size.height);
                         } completion:^(BOOL finished) {
                             [necessaryImage.layer addAnimation:zoomNormal forKey:@"zoomNormal"];
                             NSMutableArray *choosedColorsForEveryPoint = [mainDelegate.currentChoosesArray objectAtIndex:game.selectedRowNumber];
                             if (result1) [choosedColorsForEveryPoint replaceObjectAtIndex:0 withObject:number];
                             if (result2) [choosedColorsForEveryPoint replaceObjectAtIndex:1 withObject:number];
                             if (result3) [choosedColorsForEveryPoint replaceObjectAtIndex:2 withObject:number];
                             if (result4) [choosedColorsForEveryPoint replaceObjectAtIndex:3 withObject:number];
                             NSPredicate *filter = [NSPredicate predicateWithFormat:@"SELF > %@",[NSNumber numberWithInt:0]];
                             NSArray *filtered = [choosedColorsForEveryPoint filteredArrayUsingPredicate:filter];
                             if (filtered.count == 4) {
                                game.image1OutsideTableView.hidden = NO;
                                game.image2OutsideTableView.hidden = NO;
                                game.image3OutsideTableView.hidden = NO;
                                game.image4OutsideTableView.hidden = NO;
                                game.image5OutsideTableView.hidden = NO;

                             }

                         }];

//        [UIView beginAnimations:@"Dragging image inside cell" context:nil];
//
//        necessaryImage.frame = CGRectMake(pointOfFinalImagePositionInsideCell.x, pointOfFinalImagePositionInsideCell.y,
//                                           necessaryImage.frame.size.width, necessaryImage.frame.size.height);
//        [UIView commitAnimations];
//        necessaryImage.isScalled = NO;        
//        NSMutableArray *choosedColorsForEveryPoint = [mainDelegate.currentChoosesArray objectAtIndex:game.selectedRowNumber];
//        if (result1) [choosedColorsForEveryPoint replaceObjectAtIndex:0 withObject:number];
//        if (result2) [choosedColorsForEveryPoint replaceObjectAtIndex:1 withObject:number];
//        if (result3) [choosedColorsForEveryPoint replaceObjectAtIndex:2 withObject:number];
//        if (result4) [choosedColorsForEveryPoint replaceObjectAtIndex:3 withObject:number];
//        NSPredicate *filter = [NSPredicate predicateWithFormat:@"SELF > %@",[NSNumber numberWithInt:0]];
//        NSArray *filtered = [choosedColorsForEveryPoint filteredArrayUsingPredicate:filter];
//        if (filtered.count == 4) {
        
//            game.image1OutsideTableView.hidden = NO;
//            game.image2OutsideTableView.hidden = NO;
//            game.image3OutsideTableView.hidden = NO;
//            game.image4OutsideTableView.hidden = NO;
//            game.image5OutsideTableView.hidden = NO;
//        }
        //            [game.currentChoosesArray enumerateObjectsUsingBlock:^(GameRow *row, NSUInteger idx, BOOL *stop) {
        //                //if (idx == 0) NSLog(@"START idx->%lu row.choosedColorsForEveryPoint->%@",(unsigned long)idx,row.choosedColorsForEveryPoint);
        //            }];
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
        [UIView beginAnimations:@"Dragging A DraggableView" context:nil];
        self.frame = CGRectMake(self.startPoint.x, self.startPoint.y,
                                self.frame.size.width, self.frame.size.height);
        [UIView commitAnimations];
        
        //self.transform = CGAffineTransformScale(self.transform, 1.0, 1.0);
        if (self.isScalled) {
            
            self.isScalled = NO;
            CABasicAnimation *zoomNormal = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            //zoomNormal.beginTime = CACurrentMediaTime();
            zoomNormal.toValue = [NSNumber numberWithDouble:1.0];
            zoomNormal.duration = 0.1;
            zoomNormal.fillMode=kCAFillModeForwards;
            zoomNormal.removedOnCompletion=NO;
            [self.layer addAnimation:zoomNormal forKey:@"zoomNormal"];
        }
        //NSLog(@"touchesEnded self.hidden->NO self.startPoint->%@",NSStringFromCGPoint(self.startPoint));

    } else {
        //NSLog(@"touchesEnded self.hidden->YES self.startPoint->%@",NSStringFromCGPoint(self.startPoint));

    }

}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!self.hidden) {
        //NSLog(@"touchesCancelled");
        if (self.isScalled) {
            //self.transform = CGAffineTransformScale(self.transform, 1.0, 1.0);
            self.isScalled = NO;
            CABasicAnimation *zoomNormal = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            //zoomNormal.beginTime = CACurrentMediaTime();
            zoomNormal.toValue = [NSNumber numberWithDouble:1.0];
            zoomNormal.duration = 0.1;
            zoomNormal.fillMode=kCAFillModeForwards;
            zoomNormal.removedOnCompletion=NO;
            [self.layer addAnimation:zoomNormal forKey:@"zoomNormal"];
        }
    }
}


//        bool isMovedObjectInsideCell = CGRectContainsRect(game.frameSelectedCell,self.frame);
//        //NSLog(@"TOUCHED Moved INISDE TABLEVIEW CELL game.frameSelectedCell->%@ self.frame->%@ isMovedObjectInsideCell->%@",NSStringFromCGRect(game.frameSelectedCell),NSStringFromCGRect(self.frame),[NSNumber numberWithBool:isMovedObjectInsideCell]);
//        if (!isMovedObjectInsideCell) {
//            self.hidden = YES;
//            [self setNeedsDisplay];
//            CGRect frameImageOutsideTableViewConvertedFromInsidedImage = [game.gameTableView convertRect:self.frame toView:game.view];
//            [self touchesCancelled:touches withEvent:event];
//            CABasicAnimation *zoomNormal = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//            //zoomNormal.beginTime = CACurrentMediaTime();
//            zoomNormal.toValue = [NSNumber numberWithDouble:1.0];
//            zoomNormal.duration = 0.1;
//            zoomNormal.fillMode=kCAFillModeForwards;
//            zoomNormal.removedOnCompletion=NO;
//            [game.gameTableView setScrollEnabled:YES];
//            if ([self isEqual:cell.image1InsideTableView]) {
//                game.image1OutsideTableView.frame = frameImageOutsideTableViewConvertedFromInsidedImage;
//                game.image1OutsideTableView.hidden = NO;
//                game.image1OutsideTableView.isScalled = NO;
//                //NSLog(@"TOUCHED MOVED game.image1OutsideTableView->%@ \ngame.image1OutsideTableView.startPoint->%@",game.image1OutsideTableView,NSStringFromCGPoint(game.image1OutsideTableView.startPoint));
//                [UIView beginAnimations:@"Return back 1 image outside tableview" context:nil];
//                game.image1OutsideTableView.frame = CGRectMake(game.image1OutsideTableView.startPoint.x, game.image1OutsideTableView.startPoint.y,
//                                                                 game.image1OutsideTableView.frame.size.width, game.image1OutsideTableView.frame.size.height);
//                [UIView commitAnimations];
//                [game.image1OutsideTableView.layer addAnimation:zoomNormal forKey:@"zoomNormal"];
//            }
//            if ([self isEqual:cell.image2InsideTableView]) {
//                game.image2OutsideTableView.frame = frameImageOutsideTableViewConvertedFromInsidedImage;
//                game.image2OutsideTableView.hidden = NO;
//                game.image2OutsideTableView.isScalled = NO;
//                //NSLog(@"TOUCHED MOVED game.imageOneOutsideTableView.startPoint->%@",NSStringFromCGPoint(game.imageOneOutsideTableView.startPoint));
//                [UIView beginAnimations:@"Return back 2 image outside tableview" context:nil];
//                game.image2OutsideTableView.frame = CGRectMake(game.image2OutsideTableView.startPoint.x, game.image2OutsideTableView.startPoint.y,
//                                                               game.image2OutsideTableView.frame.size.width, game.image2OutsideTableView.frame.size.height);
//                [UIView commitAnimations];
//                [game.image2OutsideTableView.layer addAnimation:zoomNormal forKey:@"zoomNormal"];
//            }
//            if ([self isEqual:cell.image3InsideTableView]) {
//                game.image3OutsideTableView.frame = frameImageOutsideTableViewConvertedFromInsidedImage;
//                game.image3OutsideTableView.hidden = NO;
//                game.image3OutsideTableView.isScalled = NO;
//                //NSLog(@"TOUCHED MOVED game.imageOneOutsideTableView.startPoint->%@",NSStringFromCGPoint(game.imageOneOutsideTableView.startPoint));
//                [UIView beginAnimations:@"Return back 3 image outside tableview" context:nil];
//                game.image3OutsideTableView.frame = CGRectMake(game.image3OutsideTableView.startPoint.x, game.image3OutsideTableView.startPoint.y,
//                                                               game.image3OutsideTableView.frame.size.width, game.image3OutsideTableView.frame.size.height);
//                [UIView commitAnimations];
//                [game.image3OutsideTableView.layer addAnimation:zoomNormal forKey:@"zoomNormal"];
//            }
//            if ([self isEqual:cell.image4InsideTableView]) {
//                game.image4OutsideTableView.frame = frameImageOutsideTableViewConvertedFromInsidedImage;
//                game.image4OutsideTableView.hidden = NO;
//                game.image4OutsideTableView.isScalled = NO;
//                //NSLog(@"TOUCHED MOVED game.imageOneOutsideTableView.startPoint->%@",NSStringFromCGPoint(game.imageOneOutsideTableView.startPoint));
//                [UIView beginAnimations:@"Return back 4 image outside tableview" context:nil];
//                game.image4OutsideTableView.frame = CGRectMake(game.image4OutsideTableView.startPoint.x, game.image4OutsideTableView.startPoint.y,
//                                                               game.image4OutsideTableView.frame.size.width, game.image4OutsideTableView.frame.size.height);
//                [UIView commitAnimations];
//                [game.image4OutsideTableView.layer addAnimation:zoomNormal forKey:@"zoomNormal"];
//            }
//            if ([self isEqual:cell.image5InsideTableView]) {
//                game.image5OutsideTableView.frame = frameImageOutsideTableViewConvertedFromInsidedImage;
//                game.image5OutsideTableView.hidden = NO;
//                game.image5OutsideTableView.isScalled = NO;
//                //NSLog(@"TOUCHED MOVED game.imageOneOutsideTableView.startPoint->%@",NSStringFromCGPoint(game.imageOneOutsideTableView.startPoint));
//                [UIView beginAnimations:@"Return back 5 image outside tableview" context:nil];
//                game.image5OutsideTableView.frame = CGRectMake(game.image5OutsideTableView.startPoint.x, game.image5OutsideTableView.startPoint.y,
//                                                               game.image5OutsideTableView.frame.size.width, game.image5OutsideTableView.frame.size.height);
//                [UIView commitAnimations];
//                [game.image5OutsideTableView.layer addAnimation:zoomNormal forKey:@"zoomNormal"];
//            }
//            NSMutableArray *choosedColorsForEveryPoint = [mainDelegate.currentChoosesArray objectAtIndex:game.nextRowToFill.row];
//            NSNumber *number = [NSNumber numberWithInt:0];
//            if (self.currentPointInsideTableViewCell == 1) [choosedColorsForEveryPoint replaceObjectAtIndex:0 withObject:number];
//            if (self.currentPointInsideTableViewCell == 2) [choosedColorsForEveryPoint replaceObjectAtIndex:1 withObject:number];
//            if (self.currentPointInsideTableViewCell == 3) [choosedColorsForEveryPoint replaceObjectAtIndex:2 withObject:number];
//            if (self.currentPointInsideTableViewCell == 4) [choosedColorsForEveryPoint replaceObjectAtIndex:3 withObject:number];
////            [game.currentChoosesArray enumerateObjectsUsingBlock:^(GameRow *row, NSUInteger idx, BOOL *stop) {
////                //if (idx == 0) NSLog(@"FINISH idx->%lu row.choosedColorsForEveryPoint->%@",(unsigned long)idx,row.choosedColorsForEveryPoint);
////            }];
//        }

@end
