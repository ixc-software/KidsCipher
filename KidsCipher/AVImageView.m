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

@implementation AVImageView
@synthesize imageName,theAudio;

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
    NSLog(@"touchesBegan");
    CipherAppDelegate *mainDelegate = (CipherAppDelegate *)[[UIApplication sharedApplication] delegate];
    CipherViewController *game = [mainDelegate.viewControllers valueForKey:@"CipherViewController"];
    if ([self isEqual:game.imageOneInsideTableView]) {
        NSLog(@"TOUCHED BEGAN INISDE TABLEVIEW CELL");
        [game.gameTableView setScrollEnabled:NO];
    }
    else {
        NSLog(@"TOUCHED BEGAN OUTSIDE TABLEVIEW CELL");
        [game.gameTableView setScrollEnabled:YES];

    }
//    CGPoint pt = [[touches anyObject] locationInView:self.superview];
//    self.center = pt;
//    
//    self.clipsToBounds = NO;
//    self.animationImages = [NSArray arrayWithArray:cardAnimationArray];
//    [cardAnimationArray release];
//    [self setAnimationRepeatCount:1];
//    self.animationDuration= 1;
//    [self startAnimating];
//    self.image = [UIImage imageNamed:cardMovedImageName];
    if (!self.hidden) {
        
        UITouch *aTouch = [touches anyObject];
        self.startPoint = self.frame.origin;
        
        //self.transform = CGAffineTransformScale(self.transform, 1.2, 1.2);
        CABasicAnimation *zoomOutMax = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        zoomOutMax.beginTime = CACurrentMediaTime();
        zoomOutMax.toValue = [NSNumber numberWithDouble:1.2];
        zoomOutMax.duration = 0.2;
        zoomOutMax.fillMode=kCAFillModeForwards;
        zoomOutMax.removedOnCompletion = NO;
        [self.layer addAnimation:zoomOutMax forKey:@"zoomOutMax"];
        
        CABasicAnimation *zoomOut = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        zoomOut.beginTime = CACurrentMediaTime()+0.2;
        zoomOut.toValue = [NSNumber numberWithDouble:1.1];
        zoomOut.duration = 0.2;
        zoomOut.fillMode=kCAFillModeForwards;
        zoomOut.removedOnCompletion=NO;
        [self.layer addAnimation:zoomOut forKey:@"zoomOut"];
        
        self.offset = [aTouch locationInView: self];
        //NSLog(@"touchesBegan");
        self.isScalled = NO;
    }
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

    if ([self isEqual:game.imageOneInsideTableView]) {
        //NSLog(@"TOUCHED Moved INISDE TABLEVIEW CELL");
        [game.gameTableView setScrollEnabled:NO];
        [UIView beginAnimations:@"Dragging A DraggableView" context:nil];
        self.frame = CGRectMake(location.x-self.offset.x, location.y-self.offset.y,
                                self.frame.size.width, self.frame.size.height);
        [UIView commitAnimations];
        bool isMovedObjectInsideCell = CGRectContainsRect(game.frameSelectedCell,self.frame);
        NSLog(@"TOUCHED Moved INISDE TABLEVIEW CELL game.frameSelectedCell->%@ self.frame->%@ isMovedObjectInsideCell->%@",NSStringFromCGRect(game.frameSelectedCell),NSStringFromCGRect(self.frame),[NSNumber numberWithBool:isMovedObjectInsideCell]);
        if (!isMovedObjectInsideCell) {
            self.hidden = YES;
            [self setNeedsDisplay];
            CGRect frameImageOutsideTableViewConvertedFromInsidedImage = [game.gameTableView convertRect:self.frame toView:game.view];
            game.imageOneOutsideTableView.frame = frameImageOutsideTableViewConvertedFromInsidedImage;
            game.imageOneOutsideTableView.hidden = NO;
            [self touchesCancelled:touches withEvent:event];
            NSLog(@"TOUCHED MOVED game.imageOneOutsideTableView.startPoint->%@",NSStringFromCGPoint(game.imageOneOutsideTableView.startPoint));
            [UIView beginAnimations:@"Return back first image outside tableview" context:nil];
            game.imageOneOutsideTableView.frame = CGRectMake(game.imageOneOutsideTableView.startPoint.x, game.imageOneOutsideTableView.startPoint.y,
                                    game.imageOneOutsideTableView.frame.size.width, game.imageOneOutsideTableView.frame.size.height);
            
            [UIView commitAnimations];
            game.imageOneOutsideTableView.isScalled = NO;
            CABasicAnimation *zoomNormal = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            //zoomNormal.beginTime = CACurrentMediaTime();
            zoomNormal.toValue = [NSNumber numberWithDouble:1.0];
            zoomNormal.duration = 0.1;
            zoomNormal.fillMode=kCAFillModeForwards;
            zoomNormal.removedOnCompletion=NO;
            [game.imageOneOutsideTableView.layer addAnimation:zoomNormal forKey:@"zoomNormal"];
            [game.gameTableView setScrollEnabled:YES];

        }
    } else {
        NSLog(@"TOUCHED Moved OUTSIDE TABLEVIEW CELL");
        [game.gameTableView setScrollEnabled:YES];
        
        
        CGRect frameOne = game.frameOne;
        //CGRect frameTwo = game.frameTwo;
        bool resultOne = CGRectContainsPoint(frameOne,location);
        NSLog(@"resultOne->%@ frameOne->%@ location->%@",[NSNumber numberWithBool:resultOne],NSStringFromCGRect(frameOne),NSStringFromCGPoint(location));

        //bool resultTwo = CGRectContainsPoint(frameTwo,location);
        if (resultOne) {
            self.hidden = YES;
            CGRect frameImageInsideCellConvertedFromOutsoidedImage = [game.view convertRect:self.frame toView:game.gameTableView];
            NSLog(@"frameImageInsideCellConvertedFromOutsoidedImage->%@",NSStringFromCGRect(frameImageInsideCellConvertedFromOutsoidedImage));
            game.imageOneInsideTableView.hidden = NO;
            game.imageOneInsideTableView.frame = frameImageInsideCellConvertedFromOutsoidedImage;
            [UIView beginAnimations:@"Dragging image inside cell" context:nil];
            game.imageOneInsideTableView.frame = CGRectMake(game.frameOneInsideCell.origin.x, game.frameOneInsideCell.origin.y,
                                              game.imageOneInsideTableView.frame.size.width, game.imageOneInsideTableView.frame.size.height);
            [UIView commitAnimations];
            game.imageOneInsideTableView.isScalled = NO;
            CABasicAnimation *zoomNormal = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            //zoomNormal.beginTime = CACurrentMediaTime();
            zoomNormal.toValue = [NSNumber numberWithDouble:1.0];
            zoomNormal.duration = 0.1;
            zoomNormal.fillMode=kCAFillModeForwards;
            zoomNormal.removedOnCompletion=NO;
            [game.imageOneInsideTableView.layer addAnimation:zoomNormal forKey:@"zoomNormal"];

            //NSLog(@"game.chooseOne->%@",game.chooseOne);
            [self touchesCancelled:touches withEvent:event];
            [game.gameTableView setScrollEnabled:YES];

        } else {
            
            [UIView beginAnimations:@"Dragging A DraggableView" context:nil];
            self.frame = CGRectMake(location.x-self.offset.x, location.y-self.offset.y,
                                    self.frame.size.width, self.frame.size.height);
            [UIView commitAnimations];
            
        }
        
    }

    //NSLog(@"resultOne->%@ resultTwo->%@",[NSNumber numberWithBool:resultOne],[NSNumber numberWithBool:resultTwo]);
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
    CipherAppDelegate *mainDelegate = (CipherAppDelegate *)[[UIApplication sharedApplication] delegate];
    CipherViewController *game = [mainDelegate.viewControllers valueForKey:@"CipherViewController"];
    [game.gameTableView setScrollEnabled:YES];

    //NSLog(@"touchesEnded");
    if (!self.hidden) {
        if ([self isEqual:game.imageOneInsideTableView]) {
            NSLog(@"TOUCHED END INISDE TABLEVIEW CELL");
            [game.gameTableView setScrollEnabled:NO];
        }
        else {
            NSLog(@"TOUCHED END OUTSIDE TABLEVIEW CELL");
            [game.gameTableView setScrollEnabled:YES];
            
        }

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
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    CipherAppDelegate *mainDelegate = (CipherAppDelegate *)[[UIApplication sharedApplication] delegate];
    CipherViewController *game = [mainDelegate.viewControllers valueForKey:@"CipherViewController"];
    [game.gameTableView setScrollEnabled:YES];

    if (!self.hidden) {
        if ([self isEqual:game.imageOneInsideTableView]) {
            NSLog(@"TOUCHED END INISDE TABLEVIEW CELL");
            [game.gameTableView setScrollEnabled:NO];
        }
        else {
            NSLog(@"TOUCHED END OUTSIDE TABLEVIEW CELL");
            [game.gameTableView setScrollEnabled:YES];
            
        }
        
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
@end
