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
#import "Row.h"
#import "Game.h"

@implementation AVImageView

//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        // Initialization code
//        self.uniqueIdentifier = [[NSProcessInfo processInfo] globallyUniqueString];
//    }
//    return self;
//}
//
//-(id)initWithImage:(NSString *)img{
//    self= [super init];
//    
//    if (self) {
//        // Create a property for this call where you keep the image.
//        self.image = [UIImage imageNamed:img];
//    }
//    
//    return self;
//}
- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.uniqueIdentifier = [[NSProcessInfo processInfo] globallyUniqueString];
        NSError *error = nil;
        NSURL* start = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"kidscipher_start_drag" ofType:@"m4a"]];
        self.imageStartTouching = [[AVAudioPlayer alloc] initWithContentsOfURL:start error:&error];
        [self.imageStartTouching prepareToPlay];
        NSURL* putIntoRow = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"kidscipher_fix_image_inside_row" ofType:@"m4a"]];
        self.imagePuttedIntoRow = [[AVAudioPlayer alloc] initWithContentsOfURL:putIntoRow error:&error];
        [self.imagePuttedIntoRow prepareToPlay];
        NSURL* cancelOrReturn = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"kidscipher_return_image_outside_row_or_cancel_drag" ofType:@"m4a"]];
        self.imageCancel = [[AVAudioPlayer alloc] initWithContentsOfURL:cancelOrReturn error:&error];
        [self.imageCancel prepareToPlay];
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
        [self.imageStartTouching play];
        CipherAppDelegate *mainDelegate = (CipherAppDelegate *)[[UIApplication sharedApplication] delegate];
        CipherViewController *game = [mainDelegate.viewControllers valueForKey:@"CipherViewController"];
        Row *activeRow = [mainDelegate getActiveRow];
        AVImageView *necessaryImage = nil;
        CGPoint necessaryStartingPoint;
        if ([self.uniqueIdentifier isEqualToString:activeRow.image1insideIdentifier]) { necessaryImage = game.image1OutsideTableView; necessaryStartingPoint = CGPointFromString(activeRow.game.mainDraggedImage1startingPoint); }
        if ([self.uniqueIdentifier isEqualToString:activeRow.image2insideIdentifier]) { necessaryImage = game.image2OutsideTableView;necessaryStartingPoint = CGPointFromString(activeRow.game.mainDraggedImage2startingPoint); }
        if ([self.uniqueIdentifier isEqualToString:activeRow.image3insideIdentifier]) { necessaryImage = game.image3OutsideTableView;necessaryStartingPoint = CGPointFromString(activeRow.game.mainDraggedImage3startingPoint); }
        if ([self.uniqueIdentifier isEqualToString:activeRow.image4insideIdentifier]) { necessaryImage = game.image4OutsideTableView;necessaryStartingPoint = CGPointFromString(activeRow.game.mainDraggedImage4startingPoint); }
        if ([self.uniqueIdentifier isEqualToString:activeRow.image5insideIdentifier]) { necessaryImage = game.image5OutsideTableView;necessaryStartingPoint = CGPointFromString(activeRow.game.mainDraggedImage5startingPoint); }
        NSUInteger isStartPointMatchedOneOfFrames = 0;
        CGRect frameToGetImage1 = CGRectFromString(activeRow.frameToGetImage1);
        CGRect frameToGetImage2 = CGRectFromString(activeRow.frameToGetImage2);
        CGRect frameToGetImage3 = CGRectFromString(activeRow.frameToGetImage3);
        CGRect frameToGetImage4 = CGRectFromString(activeRow.frameToGetImage4);

        if (self.frame.origin.x == (frameToGetImage1.origin.x + (- self.frame.size.width + frameToGetImage1.size.width) /2) && self.frame.origin.y == (frameToGetImage1.origin.y + (- self.frame.size.height + frameToGetImage1.size.height) /2)) isStartPointMatchedOneOfFrames = 1;
        if (self.frame.origin.x == (frameToGetImage2.origin.x + (- self.frame.size.width + frameToGetImage2.size.width) /2) && self.frame.origin.y == (frameToGetImage2.origin.y + (- self.frame.size.height + frameToGetImage2.size.height) /2)) isStartPointMatchedOneOfFrames = 2;
        if (self.frame.origin.x == (frameToGetImage3.origin.x + (- self.frame.size.width + frameToGetImage3.size.width) /2) && self.frame.origin.y == (frameToGetImage3.origin.y + (- self.frame.size.height + frameToGetImage3.size.height) /2)) isStartPointMatchedOneOfFrames = 3;
        if (self.frame.origin.x == (frameToGetImage4.origin.x + (- self.frame.size.width + frameToGetImage4.size.width) /2) && self.frame.origin.y == (frameToGetImage4.origin.y + (- self.frame.size.height + frameToGetImage4.size.height) /2)) isStartPointMatchedOneOfFrames = 4;
        
        if (necessaryImage && isStartPointMatchedOneOfFrames > 0) {
            [self.imageCancel play];

            if (isStartPointMatchedOneOfFrames == 1) { activeRow.frame1FilledNumber = [NSNumber numberWithUnsignedInteger:0]; [mainDelegate saveContext]; }
            if (isStartPointMatchedOneOfFrames == 2) { activeRow.frame2FilledNumber = [NSNumber numberWithUnsignedInteger:0]; [mainDelegate saveContext]; }
            if (isStartPointMatchedOneOfFrames == 3) { activeRow.frame3FilledNumber = [NSNumber numberWithUnsignedInteger:0]; [mainDelegate saveContext]; }
            if (isStartPointMatchedOneOfFrames == 4) { activeRow.frame4FilledNumber = [NSNumber numberWithUnsignedInteger:0]; [mainDelegate saveContext]; }
            
            self.hidden = YES;
            necessaryImage.hidden = NO;
            CABasicAnimation *zoomNormal = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            zoomNormal.toValue = [NSNumber numberWithDouble:1.0];
            zoomNormal.duration = 0.1;
            zoomNormal.fillMode=kCAFillModeForwards;
            zoomNormal.removedOnCompletion=NO;
            
            [UIView animateWithDuration:0.4
                                  delay:0
                                options:0
                             animations:^{
                                 necessaryImage.frame = CGRectMake(necessaryStartingPoint.x, necessaryStartingPoint.y,
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

    Row *activeRow = [mainDelegate getActiveRow];
    if ([self.uniqueIdentifier isEqualToString:activeRow.game.mainDraggedImage1identifier] &&
        (activeRow.frame1FilledNumber.unsignedIntegerValue == 1 ||
         activeRow.frame2FilledNumber.unsignedIntegerValue == 1 ||
         activeRow.frame3FilledNumber.unsignedIntegerValue == 1 ||
         activeRow.frame4FilledNumber.unsignedIntegerValue == 1)) {
            return;
    }
    if ([self.uniqueIdentifier isEqualToString:activeRow.game.mainDraggedImage2identifier] &&
        (activeRow.frame1FilledNumber.unsignedIntegerValue == 2 ||
         activeRow.frame2FilledNumber.unsignedIntegerValue == 2 ||
         activeRow.frame3FilledNumber.unsignedIntegerValue == 2 ||
         activeRow.frame4FilledNumber.unsignedIntegerValue == 2)) {
            return;
        }
    if ([self.uniqueIdentifier isEqualToString:activeRow.game.mainDraggedImage3identifier] &&
        (activeRow.frame1FilledNumber.unsignedIntegerValue == 3 ||
         activeRow.frame2FilledNumber.unsignedIntegerValue == 3 ||
         activeRow.frame3FilledNumber.unsignedIntegerValue == 3 ||
         activeRow.frame4FilledNumber.unsignedIntegerValue == 3)) {
            return;
        }
    if ([self.uniqueIdentifier isEqualToString:activeRow.game.mainDraggedImage4identifier] &&
        (activeRow.frame1FilledNumber.unsignedIntegerValue == 4 ||
         activeRow.frame2FilledNumber.unsignedIntegerValue == 4 ||
         activeRow.frame3FilledNumber.unsignedIntegerValue == 4 ||
         activeRow.frame4FilledNumber.unsignedIntegerValue == 4)) {
            return;
        }
    if ([self.uniqueIdentifier isEqualToString:activeRow.game.mainDraggedImage5identifier] &&
        (activeRow.frame1FilledNumber.unsignedIntegerValue == 5 ||
         activeRow.frame2FilledNumber.unsignedIntegerValue == 5 ||
         activeRow.frame3FilledNumber.unsignedIntegerValue == 5 ||
         activeRow.frame4FilledNumber.unsignedIntegerValue == 5)) {
            return;
        }

    CGRect frameToGetImage1 = CGRectFromString(activeRow.frameToGetImage1);
    CGRect frameToGetImage2 = CGRectFromString(activeRow.frameToGetImage2);
    CGRect frameToGetImage3 = CGRectFromString(activeRow.frameToGetImage3);
    CGRect frameToGetImage4 = CGRectFromString(activeRow.frameToGetImage4);
    
    UIView *rowView = nil;
    
    switch (activeRow.game.activeRowNumber.unsignedIntegerValue) {
        case 0:
            rowView = game.row1view;
            break;
        case 1:
            rowView = game.row2view;
            break;
        case 2:
            rowView = game.row3view;
            break;
        case 3:
            rowView = game.row4view;
            break;
        case 4:
            rowView = game.row5view;
            break;
        case 5:
            rowView = game.row6view;
            break;
        case 6:
            rowView = game.row7view;
            break;
        case 7:
            rowView = game.row8view;
            break;
        case 8:
            rowView = game.row9view;
            break;
        case 9:
            rowView = game.row10view;
            break;

        default:
            break;
    }
    CGRect frame1 = [rowView convertRect:frameToGetImage1 toView:game.gamePlayScrollView];
//NSLog(@"activeRow.game.activeRowNumber->%@ 1 frame1->%@",activeRow.game.activeRowNumber,NSStringFromCGRect(frame1));
    frame1 = [game.gamePlayScrollView convertRect:frame1 toView:game.view];
    //NSLog(@"2 frame1->%@",NSStringFromCGRect(frame1));
    CGRect frame2 = [rowView convertRect:frameToGetImage2 toView:game.gamePlayScrollView];
    frame2 = [game.gamePlayScrollView convertRect:frame2 toView:game.view];
    CGRect frame3 = [rowView convertRect:frameToGetImage3 toView:game.gamePlayScrollView];
    frame3 = [game.gamePlayScrollView convertRect:frame3 toView:game.view];
    CGRect frame4 = [rowView convertRect:frameToGetImage4 toView:game.gamePlayScrollView];
    frame4 = [game.gamePlayScrollView convertRect:frame4 toView:game.view];

    bool result1 = CGRectContainsPoint(frame1,location);
    bool result2 = CGRectContainsPoint(frame2,location);
    bool result3 = CGRectContainsPoint(frame3,location);
    bool result4 = CGRectContainsPoint(frame4,location);
    //NSLog(@"result1->%@ frame1->%@ result2->%@ result3->%@ result4->%@",[NSNumber numberWithBool:result1],NSStringFromCGRect(frame1),[NSNumber numberWithBool:result2],[NSNumber numberWithBool:result3],[NSNumber numberWithBool:result4]);
    if (result1 || result2 || result3 || result4) {
        [self.imagePuttedIntoRow play];

        CGPoint pointOfFinalImagePositionInsideCell;
        // if position is busy now, we have to return, not allow to push image to busy cell
        if (result1) {
            if (activeRow.frame1FilledNumber.integerValue > 0) return;
            pointOfFinalImagePositionInsideCell = CGPointMake(frameToGetImage1.origin.x + (- self.frame.size.width + frame1.size.width) /2, frameToGetImage1.origin.y + (- self.frame.size.height + frame1.size.height) /2);
        }
        if (result2) {
            if (activeRow.frame2FilledNumber.integerValue > 0) return;
            pointOfFinalImagePositionInsideCell = CGPointMake(frameToGetImage2.origin.x + (- self.frame.size.width + frame2.size.width) /2, frameToGetImage2.origin.y + (- self.frame.size.height + frame2.size.height) /2);
        }
        if (result3) {
            if (activeRow.frame3FilledNumber.integerValue > 0) return;
            pointOfFinalImagePositionInsideCell = CGPointMake(frameToGetImage3.origin.x + (- self.frame.size.width + frame3.size.width) /2, frameToGetImage3.origin.y + (- self.frame.size.height + frame3.size.height) /2);
        }
        if (result4) {
            if (activeRow.frame4FilledNumber.integerValue > 0) return;
            pointOfFinalImagePositionInsideCell = CGPointMake(frameToGetImage4.origin.x + (- self.frame.size.width + frame4.size.width) /2, frameToGetImage4.origin.y + (- self.frame.size.height + frame4.size.height) /2);
        }
        [self touchesCancelled:touches withEvent:event];
        [self touchesEnded:touches withEvent:event];
        self.hidden = YES;
        CGRect frameImageInsideCellConvertedFromOutsoidedImage = [game.view convertRect:self.frame toView:game.gamePlayScrollView];
        //NSLog(@"frameImageInsideCellConvertedFromOutsoidedImage->%@",NSStringFromCGRect(frameImageInsideCellConvertedFromOutsoidedImage));
        NSNumber *number = nil;
        
        AVImageView *necessaryImage = nil;
        CGPoint necessaryStartingPointForImageInsideRow;
        if ([self.uniqueIdentifier isEqualToString:activeRow.game.mainDraggedImage1identifier]) {
//#warning images must getting by ID not directly
            switch (activeRow.game.activeRowNumber.unsignedIntegerValue) {
                case 0:
                    necessaryImage = game.row1image1;
                    break;
                case 1:
                    necessaryImage = game.row2image1;
                    break;
                case 2:
                    necessaryImage = game.row3image1;
                    break;
                case 3:
                    necessaryImage = game.row4image1;
                    break;
                case 4:
                    necessaryImage = game.row5image1;
                    break;
                case 5:
                    necessaryImage = game.row6image1;
                    break;
                case 6:
                    necessaryImage = game.row7image1;
                    break;
                case 7:
                    necessaryImage = game.row8image1;
                    break;
                case 8:
                    necessaryImage = game.row9image1;
                    break;
                case 9:
                    necessaryImage = game.row10image1;
                    break;

                default:
                    break;
            }

            necessaryStartingPointForImageInsideRow = self.frame.origin;
            number = [[NSNumber alloc] initWithInteger:1];
            CGRect frameToReturnMainImage = CGRectFromString(activeRow.game.mainDraggedImage1startingPoint);
            self.frame = CGRectMake(frameToReturnMainImage.origin.x,
                                    frameToReturnMainImage.origin.y,
                                    game.image1OutsideTableView.frame.size.width,
                                    game.image1OutsideTableView.frame.size.height);
        }
        
        if ([self.uniqueIdentifier isEqualToString:activeRow.game.mainDraggedImage2identifier]) {
            switch (activeRow.game.activeRowNumber.unsignedIntegerValue) {
                case 0:
                    necessaryImage = game.row1image2;
                    break;
                case 1:
                    necessaryImage = game.row2image2;
                    break;
                case 2:
                    necessaryImage = game.row3image2;
                    break;
                case 3:
                    necessaryImage = game.row4image2;
                    break;
                case 4:
                    necessaryImage = game.row5image2;
                    break;
                case 5:
                    necessaryImage = game.row6image2;
                    break;
                case 6:
                    necessaryImage = game.row7image2;
                    break;
                case 7:
                    necessaryImage = game.row8image2;
                    break;
                case 8:
                    necessaryImage = game.row9image2;
                    break;
                case 9:
                    necessaryImage = game.row10image2;
                    break;
                    
                default:
                    break;
            }
            necessaryStartingPointForImageInsideRow = self.frame.origin;
            number = [[NSNumber alloc] initWithInteger:2];
            CGRect frameToReturnMainImage = CGRectFromString(activeRow.game.mainDraggedImage2startingPoint);
            self.frame = CGRectMake(frameToReturnMainImage.origin.x,
                                    frameToReturnMainImage.origin.y,
                                    game.image2OutsideTableView.frame.size.width,
                                    game.image2OutsideTableView.frame.size.height);
        }
        
        if ([self.uniqueIdentifier isEqualToString:activeRow.game.mainDraggedImage3identifier]) {
            switch (activeRow.game.activeRowNumber.unsignedIntegerValue) {
                case 0:
                    necessaryImage = game.row1image3;
                    break;
                case 1:
                    necessaryImage = game.row2image3;
                    break;
                case 2:
                    necessaryImage = game.row3image3;
                    break;
                case 3:
                    necessaryImage = game.row4image3;
                    break;
                case 4:
                    necessaryImage = game.row5image3;
                    break;
                case 5:
                    necessaryImage = game.row6image3;
                    break;
                case 6:
                    necessaryImage = game.row7image3;
                    break;
                case 7:
                    necessaryImage = game.row8image3;
                    break;
                case 8:
                    necessaryImage = game.row9image3;
                    break;
                case 9:
                    necessaryImage = game.row10image3;
                    break;
                    
                default:
                    break;
            }
            necessaryStartingPointForImageInsideRow = self.frame.origin;
            number = [[NSNumber alloc] initWithInteger:3];
            CGRect frameToReturnMainImage = CGRectFromString(activeRow.game.mainDraggedImage3startingPoint);
            self.frame = CGRectMake(frameToReturnMainImage.origin.x,
                                    frameToReturnMainImage.origin.y,
                                    game.image3OutsideTableView.frame.size.width,
                                    game.image3OutsideTableView.frame.size.height);
        }
        
        if ([self.uniqueIdentifier isEqualToString:activeRow.game.mainDraggedImage4identifier]) {
            switch (activeRow.game.activeRowNumber.unsignedIntegerValue) {
                case 0:
                    necessaryImage = game.row1image4;
                    break;
                case 1:
                    necessaryImage = game.row2image4;
                    break;
                case 2:
                    necessaryImage = game.row3image4;
                    break;
                case 3:
                    necessaryImage = game.row4image4;
                    break;
                case 4:
                    necessaryImage = game.row5image4;
                    break;
                case 5:
                    necessaryImage = game.row6image4;
                    break;
                case 6:
                    necessaryImage = game.row7image4;
                    break;
                case 7:
                    necessaryImage = game.row8image4;
                    break;
                case 8:
                    necessaryImage = game.row9image4;
                    break;
                case 9:
                    necessaryImage = game.row10image4;
                    break;
                    
                default:
                    break;
            }
            necessaryStartingPointForImageInsideRow = self.frame.origin;
            number = [[NSNumber alloc] initWithInteger:4];
            CGRect frameToReturnMainImage = CGRectFromString(activeRow.game.mainDraggedImage4startingPoint);
            self.frame = CGRectMake(frameToReturnMainImage.origin.x,
                                    frameToReturnMainImage.origin.y,
                                    game.image4OutsideTableView.frame.size.width,
                                    game.image4OutsideTableView.frame.size.height);
        }
        
        if ([self.uniqueIdentifier isEqualToString:activeRow.game.mainDraggedImage5identifier]) {
            switch (activeRow.game.activeRowNumber.unsignedIntegerValue) {
                case 0:
                    necessaryImage = game.row1image5;
                    break;
                case 1:
                    necessaryImage = game.row2image5;
                    break;
                case 2:
                    necessaryImage = game.row3image5;
                    break;
                case 3:
                    necessaryImage = game.row4image5;
                    break;
                case 4:
                    necessaryImage = game.row5image5;
                    break;
                case 5:
                    necessaryImage = game.row6image5;
                    break;
                case 6:
                    necessaryImage = game.row7image5;
                    break;
                case 7:
                    necessaryImage = game.row8image5;
                    break;
                case 8:
                    necessaryImage = game.row9image5;
                    break;
                case 9:
                    necessaryImage = game.row10image5;
                    break;
        
                default:
                    break;
            }
            necessaryStartingPointForImageInsideRow = self.frame.origin;
            number = [[NSNumber alloc] initWithInteger:5];
            CGRect frameToReturnMainImage = CGRectFromString(activeRow.game.mainDraggedImage5startingPoint);
            self.frame = CGRectMake(frameToReturnMainImage.origin.x,
                                    frameToReturnMainImage.origin.y,
                                    game.image5OutsideTableView.frame.size.width,
                                    game.image5OutsideTableView.frame.size.height);
        }
        necessaryImage.hidden = NO;
        //self.frame = CGRectMake(self.startPoint.x, self.startPoint.y, self.frame.size.width, self.frame.size.height);
        //NSLog(@"self.startPoint->%@",NSStringFromCGPoint(self.startPoint));
        [UIView animateWithDuration:0.2
                              delay:0
                            options:0
                         animations:^{
                             necessaryImage.frame = frameImageInsideCellConvertedFromOutsoidedImage;
                             necessaryImage.frame = CGRectMake(pointOfFinalImagePositionInsideCell.x, pointOfFinalImagePositionInsideCell.y,
                                                               necessaryImage.frame.size.width, necessaryImage.frame.size.height);
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
                             dispatch_async(dispatch_get_main_queue(), ^(void) {

                             if (result1) {
                                 if (activeRow.game.isGameStarted.boolValue) activeRow.frame1FilledNumber = number; [mainDelegate saveContext];
                             }
                             if (result2) {
                                  if (activeRow.game.isGameStarted.boolValue)activeRow.frame2FilledNumber = number; [mainDelegate saveContext];
                             }
                             if (result3) {
                                  if (activeRow.game.isGameStarted.boolValue)activeRow.frame3FilledNumber = number; [mainDelegate saveContext];
                             }
                             if (result4) {
                                  if (activeRow.game.isGameStarted.boolValue)activeRow.frame4FilledNumber = number; [mainDelegate saveContext];
                             }
                             
                             if (activeRow.frame1FilledNumber.integerValue > 0 &&
                                 activeRow.frame2FilledNumber.integerValue > 0 &&
                                 activeRow.frame3FilledNumber.integerValue > 0 &&
                                 activeRow.frame4FilledNumber.integerValue > 0) {
                                 //self.hidden = YES;
                                 //[self touchesCancelled:touches withEvent:event];
                                 //NSLog(@" filled all");
                                 //dispatch_async(dispatch_get_main_queue(), ^(void) {
                                     NSLog(@"1 mainDelegate.isNewRowProcessing->%c",mainDelegate.isNewRowProcessing);
                                     if (!mainDelegate.isNewRowProcessing) {
                                         mainDelegate.isNewRowProcessing = YES;
                                         NSLog(@"2 mainDelegate.isNewRowProcessing->%c",mainDelegate.isNewRowProcessing);
                                         [game startCompletingCurrentRowAndOpenNext];
                                     }
                                 //});
                             }
                             });
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
    
    //NSLog(@"touchesEnded self.frame->%@",NSStringFromCGRect(self.frame));
    if (!self.hidden) {
        [self.imageCancel play];

        CipherAppDelegate *mainDelegate = (CipherAppDelegate *)[[UIApplication sharedApplication] delegate];
        Row *activeRow = [mainDelegate getActiveRow];
        CGPoint necessaryStartingPoint;
        if ([self.uniqueIdentifier isEqualToString:activeRow.game.mainDraggedImage1identifier]) necessaryStartingPoint = CGPointFromString(activeRow.game.mainDraggedImage1startingPoint);
        if ([self.uniqueIdentifier isEqualToString:activeRow.game.mainDraggedImage2identifier]) necessaryStartingPoint = CGPointFromString(activeRow.game.mainDraggedImage2startingPoint);
        if ([self.uniqueIdentifier isEqualToString:activeRow.game.mainDraggedImage3identifier]) necessaryStartingPoint = CGPointFromString(activeRow.game.mainDraggedImage3startingPoint);
        if ([self.uniqueIdentifier isEqualToString:activeRow.game.mainDraggedImage4identifier]) necessaryStartingPoint = CGPointFromString(activeRow.game.mainDraggedImage4startingPoint);
        if ([self.uniqueIdentifier isEqualToString:activeRow.game.mainDraggedImage5identifier]) necessaryStartingPoint = CGPointFromString(activeRow.game.mainDraggedImage5startingPoint);
        
        [UIView animateWithDuration:0.5
                              delay:0
                            options:0
                         animations:^{
                             self.frame = CGRectMake(necessaryStartingPoint.x, necessaryStartingPoint.y,
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
        //if (self.isCanceledTouches) { self.hidden = NO,self.isCanceledTouches = NO; }
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!self.hidden) {
        [self.imageCancel play];

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
