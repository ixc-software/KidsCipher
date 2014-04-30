//
//  CipherViewController.m
//  KidsCipher
//
//  Created by Oleksii Vynogradov on 4/29/13.
//  Copyright (c) 2013 IXC-USA Corp. All rights reserved.
//

#import "CipherViewController.h"
#import "CipherAppDelegate.h"
#import "Row.h"
#import "Game.h"
#import "GamesHistory.h"
#import "CipherInfoViewController.h"

@interface CipherViewController ()

@end

@implementation CipherViewController
#pragma mark - own view updated
-(void) updateAllViews {
    CipherAppDelegate *mainDelegate = (CipherAppDelegate *)[[UIApplication sharedApplication] delegate];
    Row *activeRowToGetAllRows = [mainDelegate getActiveRow];
    NSOrderedSet *allRows = activeRowToGetAllRows.game.rows;
#ifdef KidsCipherBoys
    self.safeImage.image = [UIImage imageNamed:@"Boy_Main_page_safe_close"];
#else
    self.safeImage.image = [UIImage imageNamed:@"Main_page_fon_safe"];
#endif
    NSNumber *level = [[NSUserDefaults standardUserDefaults] valueForKey:@"level"];

    [allRows enumerateObjectsUsingBlock:^(Row *activeRow, NSUInteger idx, BOOL *stop) {
        AVImageView *image1InsideRow = nil;
        AVImageView *image2InsideRow = nil;
        AVImageView *image3InsideRow = nil;
        AVImageView *image4InsideRow = nil;
        AVImageView *image5InsideRow = nil;
        UIView *hidingRowView = nil;
        CGRect frame1InsideRow;
        CGRect frame2InsideRow;
        CGRect frame3InsideRow;
        CGRect frame4InsideRow;
        
        UILabel *matchedColorsInsideRow;
        UILabel *matchedColorsAndPositionsInsideRow;
        
        UIImageView *rowCheckImage1 = nil;
        UIImageView *rowCheckImage2 = nil;
        UIImageView *rowCheckImage3 = nil;
        UIImageView *rowCheckImage4 = nil;
        
        switch (idx) {
            case 0:
                image1InsideRow = self.row1image1;
                image2InsideRow = self.row1image2;
                image3InsideRow = self.row1image3;
                image4InsideRow = self.row1image4;
                image5InsideRow = self.row1image5;
                frame1InsideRow = self.row1frame1.frame;
                frame2InsideRow = self.row1frame2.frame;
                frame3InsideRow = self.row1frame3.frame;
                frame4InsideRow = self.row1frame4.frame;
                hidingRowView = self.row1HidingView;
                matchedColorsInsideRow = self.row1MatchedColors;
                matchedColorsAndPositionsInsideRow = self.row1MatchedColorsAndPositions;
                rowCheckImage1 = self.row1CheckImage1;
                rowCheckImage2 = self.row1CheckImage2;
                rowCheckImage3 = self.row1CheckImage3;
                rowCheckImage4 = self.row1CheckImage4;
                break;
            case 1:
                image1InsideRow = self.row2image1;
                image2InsideRow = self.row2image2;
                image3InsideRow = self.row2image3;
                image4InsideRow = self.row2image4;
                image5InsideRow = self.row2image5;
                frame1InsideRow = self.row2frame1.frame;
                frame2InsideRow = self.row2frame2.frame;
                frame3InsideRow = self.row2frame3.frame;
                frame4InsideRow = self.row2frame4.frame;
                hidingRowView = self.row2HidingView;
                matchedColorsInsideRow = self.row2MatchedColors;
                matchedColorsAndPositionsInsideRow = self.row2MatchedColorsAndPositions;
                rowCheckImage1 = self.row2CheckImage1;
                rowCheckImage2 = self.row2CheckImage2;
                rowCheckImage3 = self.row2CheckImage3;
                rowCheckImage4 = self.row2CheckImage4;
                break;
            case 2:
                image1InsideRow = self.row3image1;
                image2InsideRow = self.row3image2;
                image3InsideRow = self.row3image3;
                image4InsideRow = self.row3image4;
                image5InsideRow = self.row3image5;
                frame1InsideRow = self.row3frame1.frame;
                frame2InsideRow = self.row3frame2.frame;
                frame3InsideRow = self.row3frame3.frame;
                frame4InsideRow = self.row3frame4.frame;
                hidingRowView = self.row3HidingView;
                matchedColorsInsideRow = self.row3MatchedColors;
                matchedColorsAndPositionsInsideRow = self.row3MatchedColorsAndPositions;
                rowCheckImage1 = self.row3CheckImage1;
                rowCheckImage2 = self.row3CheckImage2;
                rowCheckImage3 = self.row3CheckImage3;
                rowCheckImage4 = self.row3CheckImage4;

                break;
            case 3:
                image1InsideRow = self.row4image1;
                image2InsideRow = self.row4image2;
                image3InsideRow = self.row4image3;
                image4InsideRow = self.row4image4;
                image5InsideRow = self.row4image5;
                frame1InsideRow = self.row4frame1.frame;
                frame2InsideRow = self.row4frame2.frame;
                frame3InsideRow = self.row4frame3.frame;
                frame4InsideRow = self.row4frame4.frame;
                hidingRowView = self.row4HidingView;
                matchedColorsInsideRow = self.row4MatchedColors;
                matchedColorsAndPositionsInsideRow = self.row4MatchedColorsAndPositions;
                rowCheckImage1 = self.row4CheckImage1;
                rowCheckImage2 = self.row4CheckImage2;
                rowCheckImage3 = self.row4CheckImage3;
                rowCheckImage4 = self.row4CheckImage4;

                break;
            case 4:
                image1InsideRow = self.row5image1;
                image2InsideRow = self.row5image2;
                image3InsideRow = self.row5image3;
                image4InsideRow = self.row5image4;
                image5InsideRow = self.row5image5;
                frame1InsideRow = self.row5frame1.frame;
                frame2InsideRow = self.row5frame2.frame;
                frame3InsideRow = self.row5frame3.frame;
                frame4InsideRow = self.row5frame4.frame;
                hidingRowView = self.row5HidingView;
                matchedColorsInsideRow = self.row5MatchedColors;
                matchedColorsAndPositionsInsideRow = self.row5MatchedColorsAndPositions;
                rowCheckImage1 = self.row5CheckImage1;
                rowCheckImage2 = self.row5CheckImage2;
                rowCheckImage3 = self.row5CheckImage3;
                rowCheckImage4 = self.row5CheckImage4;

                break;
            case 5:
                image1InsideRow = self.row6image1;
                image2InsideRow = self.row6image2;
                image3InsideRow = self.row6image3;
                image4InsideRow = self.row6image4;
                image5InsideRow = self.row6image5;
                frame1InsideRow = self.row6frame1.frame;
                frame2InsideRow = self.row6frame2.frame;
                frame3InsideRow = self.row6frame3.frame;
                frame4InsideRow = self.row6frame4.frame;
                hidingRowView = self.row6HidingView;
                matchedColorsInsideRow = self.row6MatchedColors;
                matchedColorsAndPositionsInsideRow = self.row6MatchedColorsAndPositions;
                rowCheckImage1 = self.row6CheckImage1;
                rowCheckImage2 = self.row6CheckImage2;
                rowCheckImage3 = self.row6CheckImage3;
                rowCheckImage4 = self.row6CheckImage4;

                break;
            case 6:
                image1InsideRow = self.row7image1;
                image2InsideRow = self.row7image2;
                image3InsideRow = self.row7image3;
                image4InsideRow = self.row7image4;
                image5InsideRow = self.row7image5;
                frame1InsideRow = self.row7frame1.frame;
                frame2InsideRow = self.row7frame2.frame;
                frame3InsideRow = self.row7frame3.frame;
                frame4InsideRow = self.row7frame4.frame;
                hidingRowView = self.row7HidingView;
                matchedColorsInsideRow = self.row7MatchedColors;
                matchedColorsAndPositionsInsideRow = self.row7MatchedColorsAndPositions;
                rowCheckImage1 = self.row7CheckImage1;
                rowCheckImage2 = self.row7CheckImage2;
                rowCheckImage3 = self.row7CheckImage3;
                rowCheckImage4 = self.row7CheckImage4;

                break;
            case 7:
                image1InsideRow = self.row8image1;
                image2InsideRow = self.row8image2;
                image3InsideRow = self.row8image3;
                image4InsideRow = self.row8image4;
                image5InsideRow = self.row8image5;
                frame1InsideRow = self.row8frame1.frame;
                frame2InsideRow = self.row8frame2.frame;
                frame3InsideRow = self.row8frame3.frame;
                frame4InsideRow = self.row8frame4.frame;
                hidingRowView = self.row8HidingView;
                matchedColorsInsideRow = self.row8MatchedColors;
                matchedColorsAndPositionsInsideRow = self.row8MatchedColorsAndPositions;
                rowCheckImage1 = self.row8CheckImage1;
                rowCheckImage2 = self.row8CheckImage2;
                rowCheckImage3 = self.row8CheckImage3;
                rowCheckImage4 = self.row8CheckImage4;

                break;
            case 8:
                image1InsideRow = self.row9image1;
                image2InsideRow = self.row9image2;
                image3InsideRow = self.row9image3;
                image4InsideRow = self.row9image4;
                image5InsideRow = self.row9image5;
                frame1InsideRow = self.row9frame1.frame;
                frame2InsideRow = self.row9frame2.frame;
                frame3InsideRow = self.row9frame3.frame;
                frame4InsideRow = self.row9frame4.frame;
                hidingRowView = self.row9HidingView;
                matchedColorsInsideRow = self.row9MatchedColors;
                matchedColorsAndPositionsInsideRow = self.row9MatchedColorsAndPositions;
                rowCheckImage1 = self.row9CheckImage1;
                rowCheckImage2 = self.row9CheckImage2;
                rowCheckImage3 = self.row9CheckImage3;
                rowCheckImage4 = self.row9CheckImage4;

                break;
            case 9:
                image1InsideRow = self.row10image1;
                image2InsideRow = self.row10image2;
                image3InsideRow = self.row10image3;
                image4InsideRow = self.row10image4;
                image5InsideRow = self.row10image5;
                frame1InsideRow = self.row10frame1.frame;
                frame2InsideRow = self.row10frame2.frame;
                frame3InsideRow = self.row10frame3.frame;
                frame4InsideRow = self.row10frame4.frame;
                hidingRowView = self.row10HidingView;
                matchedColorsInsideRow = self.row10MatchedColors;
                matchedColorsAndPositionsInsideRow = self.row10MatchedColorsAndPositions;
                rowCheckImage1 = self.row10CheckImage1;
                rowCheckImage2 = self.row10CheckImage2;
                rowCheckImage3 = self.row10CheckImage3;
                rowCheckImage4 = self.row10CheckImage4;

                break;
   
            default:
                hidingRowView = nil;
                break;
        }
        
        if (activeRow.isFilled.boolValue) {
            image1InsideRow.userInteractionEnabled = NO;
            image2InsideRow.userInteractionEnabled = NO;
            image3InsideRow.userInteractionEnabled = NO;
            image4InsideRow.userInteractionEnabled = NO;
            image5InsideRow.userInteractionEnabled = NO;
            hidingRowView.hidden = NO;
            hidingRowView.alpha = 0.5;
            NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
            formatter.locale = [NSLocale currentLocale];
            NSNumber *activeRowNumberOfMatchedColor = activeRow.numberOfMatchedColor;
            if (!activeRowNumberOfMatchedColor) activeRowNumberOfMatchedColor= [NSNumber numberWithInt:0];
            NSNumber *activeRowNumberOfMatchedColorAndPosition = activeRow.numberOfMatchedColorAndPosition;
            if (!activeRowNumberOfMatchedColorAndPosition) activeRowNumberOfMatchedColorAndPosition= [NSNumber numberWithInt:0];

            matchedColorsInsideRow.text = [NSString stringWithFormat:@"%@",[formatter stringFromNumber:activeRowNumberOfMatchedColor]];
            matchedColorsAndPositionsInsideRow.text = [NSString stringWithFormat:@"%@",[formatter stringFromNumber:activeRowNumberOfMatchedColorAndPosition]];
            NSLog(@"activeRow idx-%lu isFilled->YES",(unsigned long)idx);
            if (level.unsignedIntegerValue == 2 || mainDelegate.isTraining) {
                NSNumber *frame1FilledNumber = activeRow.frame1FilledNumber;
                NSNumber *frame2FilledNumber = activeRow.frame2FilledNumber;
                NSNumber *frame3FilledNumber = activeRow.frame3FilledNumber;
                NSNumber *frame4FilledNumber = activeRow.frame4FilledNumber;
                
                NSNumber *combination1color = activeRow.game.combination1color;
                NSNumber *combination2color = activeRow.game.combination2color;
                NSNumber *combination3color = activeRow.game.combination3color;
                NSNumber *combination4color = activeRow.game.combination4color;
                
                if (frame1FilledNumber.integerValue == combination1color.integerValue) rowCheckImage1.hidden = NO;
                if (frame2FilledNumber.integerValue == combination2color.integerValue) rowCheckImage2.hidden = NO;
                if (frame3FilledNumber.integerValue == combination3color.integerValue) rowCheckImage3.hidden = NO;
                if (frame4FilledNumber.integerValue == combination4color.integerValue) rowCheckImage4.hidden = NO;
            }
            

        } else {
            if (idx == activeRowToGetAllRows.game.activeRowNumber.unsignedIntegerValue && activeRowToGetAllRows.game.isGameStarted.boolValue) {
                image1InsideRow.userInteractionEnabled = YES;
                image2InsideRow.userInteractionEnabled = YES;
                image3InsideRow.userInteractionEnabled = YES;
                image4InsideRow.userInteractionEnabled = YES;
                image5InsideRow.userInteractionEnabled = YES;
                hidingRowView.hidden = YES;
                hidingRowView.alpha = 0.0;
                //NSLog(@"activeRow.isFilled->NO, setting hidingRowView.hidden=NO hidingRowView->%@",hidingRowView);
            } else { hidingRowView.hidden = NO; hidingRowView.alpha = 1.0; }
            matchedColorsInsideRow.text = [NSString stringWithFormat:@"%@",@""];
            matchedColorsAndPositionsInsideRow.text = [NSString stringWithFormat:@"%@",@""];
            rowCheckImage1.hidden = YES;
            rowCheckImage2.hidden = YES;
            rowCheckImage3.hidden = YES;
            rowCheckImage4.hidden = YES;
        }
        
        
        image1InsideRow.hidden = YES;
        image2InsideRow.hidden = YES;
        image3InsideRow.hidden = YES;
        image4InsideRow.hidden = YES;
        image5InsideRow.hidden = YES;
       
        if (activeRow.frame1FilledNumber.integerValue > 0) {
 
            switch (activeRow.frame1FilledNumber.integerValue) {
                case 1:
                    image1InsideRow.frame = CGRectMake(frame1InsideRow.origin.x + (frame1InsideRow.size.width - image1InsideRow.frame.size.width) / 2,
                                                       frame1InsideRow.origin.y + (frame1InsideRow.size.height - image1InsideRow.frame.size.height) / 2,
                                                       image1InsideRow.frame.size.width,
                                                       image1InsideRow.frame.size.height);//frame1InsideRow;
                    image1InsideRow.hidden = NO;
                    if (idx == activeRowToGetAllRows.game.activeRowNumber.unsignedIntegerValue) self.image1OutsideTableView.hidden = YES;
                    break;
                case 2:
                    image2InsideRow.frame = CGRectMake(frame1InsideRow.origin.x + (frame1InsideRow.size.width - image2InsideRow.frame.size.width) / 2,
                                                       frame1InsideRow.origin.y + (frame1InsideRow.size.height - image2InsideRow.frame.size.height) / 2,
                                                       image2InsideRow.frame.size.width,
                                                       image2InsideRow.frame.size.height);//frame1InsideRow;
                    image2InsideRow.hidden = NO;
                    if (idx == activeRowToGetAllRows.game.activeRowNumber.unsignedIntegerValue) self.image2OutsideTableView.hidden = YES;
                    break;
                case 3:
                    image3InsideRow.frame = CGRectMake(frame1InsideRow.origin.x + (frame1InsideRow.size.width - image3InsideRow.frame.size.width) / 2,
                                                       frame1InsideRow.origin.y + (frame1InsideRow.size.height - image3InsideRow.frame.size.height) / 2,
                                                       image3InsideRow.frame.size.width,
                                                       image3InsideRow.frame.size.height);//frame1InsideRow;
                    image3InsideRow.hidden = NO;
                    if (idx == activeRowToGetAllRows.game.activeRowNumber.unsignedIntegerValue) self.image3OutsideTableView.hidden = YES;
                    break;
                case 4:
                    image4InsideRow.frame = CGRectMake(frame1InsideRow.origin.x + (frame1InsideRow.size.width - image4InsideRow.frame.size.width) / 2,
                                                       frame1InsideRow.origin.y + (frame1InsideRow.size.height - image4InsideRow.frame.size.height) / 2,
                                                       image4InsideRow.frame.size.width,
                                                       image4InsideRow.frame.size.height);//frame1InsideRow;
                    image4InsideRow.hidden = NO;
                    if (idx == activeRowToGetAllRows.game.activeRowNumber.unsignedIntegerValue) self.image4OutsideTableView.hidden = YES;
                    break;
                case 5:
                    image5InsideRow.frame = CGRectMake(frame1InsideRow.origin.x + (frame1InsideRow.size.width - image5InsideRow.frame.size.width) / 2,
                                                       frame1InsideRow.origin.y + (frame1InsideRow.size.height - image5InsideRow.frame.size.height) / 2,
                                                       image5InsideRow.frame.size.width,
                                                       image5InsideRow.frame.size.height);//frame1InsideRow;
                    image5InsideRow.hidden = NO;
                    if (idx == activeRowToGetAllRows.game.activeRowNumber.unsignedIntegerValue) self.image5OutsideTableView.hidden = YES;
                    break;
                    
                default:
                    break;
            }
        }
        
        if (activeRow.frame2FilledNumber.integerValue > 0) {
            switch (activeRow.frame2FilledNumber.integerValue) {
                case 1:
                    image1InsideRow.frame = CGRectMake(frame2InsideRow.origin.x + (frame2InsideRow.size.width - image1InsideRow.frame.size.width) / 2,
                                                       frame2InsideRow.origin.y + (frame2InsideRow.size.height - image1InsideRow.frame.size.height) / 2,
                                                       image1InsideRow.frame.size.width,
                                                       image1InsideRow.frame.size.height);//frame2InsideRow;
                    image1InsideRow.hidden = NO;
                    if (idx == activeRowToGetAllRows.game.activeRowNumber.unsignedIntegerValue) self.image1OutsideTableView.hidden = YES;
                    break;
                case 2:
                    image2InsideRow.frame = CGRectMake(frame2InsideRow.origin.x + (frame2InsideRow.size.width - image2InsideRow.frame.size.width) / 2,
                                                       frame2InsideRow.origin.y + (frame2InsideRow.size.height - image2InsideRow.frame.size.height) / 2,
                                                       image2InsideRow.frame.size.width,
                                                       image2InsideRow.frame.size.height);//frame2InsideRow;
                    image2InsideRow.hidden = NO;
                    if (idx == activeRowToGetAllRows.game.activeRowNumber.unsignedIntegerValue) self.image2OutsideTableView.hidden = YES;
                    break;
                case 3:
                    image3InsideRow.frame = CGRectMake(frame2InsideRow.origin.x + (frame2InsideRow.size.width - image3InsideRow.frame.size.width) / 2,
                                                       frame2InsideRow.origin.y + (frame2InsideRow.size.height - image3InsideRow.frame.size.height) / 2,
                                                       image3InsideRow.frame.size.width,
                                                       image3InsideRow.frame.size.height);//frame2InsideRow;
                    image3InsideRow.hidden = NO;
                    if (idx == activeRowToGetAllRows.game.activeRowNumber.unsignedIntegerValue) self.image3OutsideTableView.hidden = YES;
                    break;
                case 4:
                    image4InsideRow.frame = CGRectMake(frame2InsideRow.origin.x + (frame2InsideRow.size.width - image4InsideRow.frame.size.width) / 2,
                                                       frame2InsideRow.origin.y + (frame2InsideRow.size.height - image4InsideRow.frame.size.height) / 2,
                                                       image4InsideRow.frame.size.width,
                                                       image4InsideRow.frame.size.height);//frame2InsideRow;
                    image4InsideRow.hidden = NO;
                    if (idx == activeRowToGetAllRows.game.activeRowNumber.unsignedIntegerValue) self.image4OutsideTableView.hidden = YES;
                    break;
                case 5:
                    image5InsideRow.frame = CGRectMake(frame2InsideRow.origin.x + (frame2InsideRow.size.width - image5InsideRow.frame.size.width) / 2,
                                                       frame2InsideRow.origin.y + (frame2InsideRow.size.height - image5InsideRow.frame.size.height) / 2,
                                                       image5InsideRow.frame.size.width,
                                                       image5InsideRow.frame.size.height);//frame2InsideRow;
                    image5InsideRow.hidden = NO;
                    if (idx == activeRowToGetAllRows.game.activeRowNumber.unsignedIntegerValue) self.image5OutsideTableView.hidden = YES;
                    break;
                    
                default:
                    break;
            }
        }
        if (activeRow.frame3FilledNumber.integerValue > 0) {
            switch (activeRow.frame3FilledNumber.integerValue) {
                case 1:
                    image1InsideRow.frame = CGRectMake(frame3InsideRow.origin.x + (frame3InsideRow.size.width - image1InsideRow.frame.size.width) / 2,
                                                       frame3InsideRow.origin.y + (frame3InsideRow.size.height - image1InsideRow.frame.size.height) / 2,
                                                       image1InsideRow.frame.size.width,
                                                       image1InsideRow.frame.size.height);//frame3InsideRow;
                    image1InsideRow.hidden = NO;
                    if (idx == activeRowToGetAllRows.game.activeRowNumber.unsignedIntegerValue) self.image1OutsideTableView.hidden = YES;
                    break;
                case 2:
                    image2InsideRow.frame = CGRectMake(frame3InsideRow.origin.x + (frame3InsideRow.size.width - image2InsideRow.frame.size.width) / 2,
                                                       frame3InsideRow.origin.y + (frame3InsideRow.size.height - image2InsideRow.frame.size.height) / 2,
                                                       image2InsideRow.frame.size.width,
                                                       image2InsideRow.frame.size.height);//frame3InsideRow;
                    image2InsideRow.hidden = NO;
                    if (idx == activeRowToGetAllRows.game.activeRowNumber.unsignedIntegerValue) self.image2OutsideTableView.hidden = YES;
                    break;
                case 3:
                    image3InsideRow.frame = CGRectMake(frame3InsideRow.origin.x + (frame3InsideRow.size.width - image3InsideRow.frame.size.width) / 2,
                                                       frame3InsideRow.origin.y + (frame3InsideRow.size.height - image3InsideRow.frame.size.height) / 2,
                                                       image3InsideRow.frame.size.width,
                                                       image3InsideRow.frame.size.height);//frame3InsideRow;
                    image3InsideRow.hidden = NO;
                    if (idx == activeRowToGetAllRows.game.activeRowNumber.unsignedIntegerValue) self.image3OutsideTableView.hidden = YES;
                    break;
                case 4:
                    image4InsideRow.frame = CGRectMake(frame3InsideRow.origin.x + (frame3InsideRow.size.width - image4InsideRow.frame.size.width) / 2,
                                                       frame3InsideRow.origin.y + (frame3InsideRow.size.height - image4InsideRow.frame.size.height) / 2,
                                                       image4InsideRow.frame.size.width,
                                                       image4InsideRow.frame.size.height);//frame3InsideRow;
                    image4InsideRow.hidden = NO;
                    if (idx == activeRowToGetAllRows.game.activeRowNumber.unsignedIntegerValue) self.image4OutsideTableView.hidden = YES;
                    break;
                case 5:
                    image5InsideRow.frame = CGRectMake(frame3InsideRow.origin.x + (frame3InsideRow.size.width - image5InsideRow.frame.size.width) / 2,
                                                       frame3InsideRow.origin.y + (frame3InsideRow.size.height - image5InsideRow.frame.size.height) / 2,
                                                       image4InsideRow.frame.size.width,
                                                       image4InsideRow.frame.size.height);//frame3InsideRow;
                    image5InsideRow.hidden = NO;
                    if (idx == activeRowToGetAllRows.game.activeRowNumber.unsignedIntegerValue) self.image5OutsideTableView.hidden = YES;
                    break;
                    
                default:
                    break;
            }
        }
        
        if (activeRow.frame4FilledNumber.integerValue > 0) {
            switch (activeRow.frame4FilledNumber.integerValue) {
                case 1:
                    image1InsideRow.frame = CGRectMake(frame4InsideRow.origin.x + (frame4InsideRow.size.width - image1InsideRow.frame.size.width) / 2,
                                                       frame4InsideRow.origin.y + (frame4InsideRow.size.height - image1InsideRow.frame.size.height) / 2,
                                                       image1InsideRow.frame.size.width,
                                                       image1InsideRow.frame.size.height);//frame4InsideRow;
                    image1InsideRow.hidden = NO;
                    if (idx == activeRowToGetAllRows.game.activeRowNumber.unsignedIntegerValue) self.image1OutsideTableView.hidden = YES;
                    break;
                case 2:
                    image2InsideRow.frame = CGRectMake(frame4InsideRow.origin.x + (frame4InsideRow.size.width - image2InsideRow.frame.size.width) / 2,
                                                       frame4InsideRow.origin.y + (frame4InsideRow.size.height - image2InsideRow.frame.size.height) / 2,
                                                       image2InsideRow.frame.size.width,
                                                       image2InsideRow.frame.size.height);//frame4InsideRow;
                    image2InsideRow.hidden = NO;
                    if (idx == activeRowToGetAllRows.game.activeRowNumber.unsignedIntegerValue) self.image2OutsideTableView.hidden = YES;
                    break;
                case 3:
                    image3InsideRow.frame = CGRectMake(frame4InsideRow.origin.x + (frame4InsideRow.size.width - image3InsideRow.frame.size.width) / 2,
                                                       frame4InsideRow.origin.y + (frame4InsideRow.size.height - image3InsideRow.frame.size.height) / 2,
                                                       image3InsideRow.frame.size.width,
                                                       image3InsideRow.frame.size.height);//frame4InsideRow;
                    image3InsideRow.hidden = NO;
                    if (idx == activeRowToGetAllRows.game.activeRowNumber.unsignedIntegerValue) self.image3OutsideTableView.hidden = YES;
                    break;
                case 4:
                    image4InsideRow.frame = CGRectMake(frame4InsideRow.origin.x + (frame4InsideRow.size.width - image4InsideRow.frame.size.width) / 2,
                                                       frame4InsideRow.origin.y + (frame4InsideRow.size.height - image4InsideRow.frame.size.height) / 2,
                                                       image4InsideRow.frame.size.width,
                                                       image4InsideRow.frame.size.height);//frame4InsideRow;
                    image4InsideRow.hidden = NO;
                    if (idx == activeRowToGetAllRows.game.activeRowNumber.unsignedIntegerValue) self.image4OutsideTableView.hidden = YES;
                    break;
                case 5:
                    image5InsideRow.frame = CGRectMake(frame4InsideRow.origin.x + (frame4InsideRow.size.width - image5InsideRow.frame.size.width) / 2,
                                                       frame4InsideRow.origin.y + (frame4InsideRow.size.height - image5InsideRow.frame.size.height) / 2,
                                                       image5InsideRow.frame.size.width,
                                                       image5InsideRow.frame.size.height);//frame4InsideRow;
                    image5InsideRow.hidden = NO;
                    if (idx == activeRowToGetAllRows.game.activeRowNumber.unsignedIntegerValue) self.image5OutsideTableView.hidden = YES;
                    break;
                    
                default:
                    break;
            }
        }
        
        
    }];
    NSLog(@"activeRowToGetAllRows.game.combination1color->%@",activeRowToGetAllRows.game.combination1color);
    NSLog(@"activeRowToGetAllRows.game.combination2color->%@",activeRowToGetAllRows.game.combination2color);
    NSLog(@"activeRowToGetAllRows.game.combination3color->%@",activeRowToGetAllRows.game.combination3color);
    NSLog(@"activeRowToGetAllRows.game.combination4color->%@",activeRowToGetAllRows.game.combination4color);
    switch (activeRowToGetAllRows.game.combination1color.unsignedIntegerValue) {
        case 1:
            self.image1combination.frame = CGRectMake(self.frame1combination.frame.origin.x + (- self.image1combination.frame.size.width + self.frame1combination.frame.size.width) /2,
                                                      self.frame1combination.frame.origin.y + (- self.image1combination.frame.size.height + self.frame1combination.frame.size.height) /2,
                                                      self.image1combination.frame.size.width,
                                                      self.image1combination.frame.size.height);//
            self.image1combination.hidden = NO;
            break;
        case 2:
            self.image2combination.frame = CGRectMake(self.frame1combination.frame.origin.x + (- self.image2combination.frame.size.width + self.frame1combination.frame.size.width) /2,
                                                      self.frame1combination.frame.origin.y + (- self.image2combination.frame.size.height + self.frame1combination.frame.size.height) /2,
                                                      self.image2combination.frame.size.width,
                                                      self.image2combination.frame.size.height);//self.frame1combination.frame;
            self.image2combination.hidden = NO;
            break;
        case 3:
            self.image3combination.frame = CGRectMake(self.frame1combination.frame.origin.x + (- self.image3combination.frame.size.width + self.frame1combination.frame.size.width) /2,
                                                      self.frame1combination.frame.origin.y + (- self.image3combination.frame.size.height + self.frame1combination.frame.size.height) /2,
                                                      self.image3combination.frame.size.width,
                                                      self.image3combination.frame.size.height);//self.frame1combination.frame;
            self.image3combination.hidden = NO;
            break;
        case 4:
            self.image4combination.frame = CGRectMake(self.frame1combination.frame.origin.x + (- self.image4combination.frame.size.width + self.frame1combination.frame.size.width) /2,
                                                      self.frame1combination.frame.origin.y + (- self.image4combination.frame.size.height + self.frame1combination.frame.size.height) /2,
                                                      self.image4combination.frame.size.width,
                                                      self.image4combination.frame.size.height);//self.frame1combination.frame;
            self.image4combination.hidden = NO;
            break;
        case 5:
            self.image5combination.frame = CGRectMake(self.frame1combination.frame.origin.x + (- self.image5combination.frame.size.width + self.frame1combination.frame.size.width) /2,
                                                      self.frame1combination.frame.origin.y + (- self.image5combination.frame.size.height + self.frame1combination.frame.size.height) /2,
                                                      self.image5combination.frame.size.width,
                                                      self.image5combination.frame.size.height);//self.frame1combination.frame;
            self.image5combination.hidden = NO;
            break;
        default:
            break;
    }
    switch (activeRowToGetAllRows.game.combination2color.unsignedIntegerValue) {
        case 1:
            self.image1combination.frame = CGRectMake(self.frame2combination.frame.origin.x + (- self.image1combination.frame.size.width + self.frame2combination.frame.size.width) /2,
                                                      self.frame2combination.frame.origin.y + (- self.image1combination.frame.size.height + self.frame2combination.frame.size.height) /2,
                                                      self.image1combination.frame.size.width,
                                                      self.image1combination.frame.size.height);//self.frame2combination.frame;
            self.image1combination.hidden = NO;
            break;
        case 2:
            self.image2combination.frame = CGRectMake(self.frame2combination.frame.origin.x + (- self.image2combination.frame.size.width + self.frame2combination.frame.size.width) /2,
                                                      self.frame2combination.frame.origin.y + (- self.image2combination.frame.size.height + self.frame2combination.frame.size.height) /2,
                                                      self.image2combination.frame.size.width,
                                                      self.image2combination.frame.size.height);//self.frame2combination.frame;
            self.image2combination.hidden = NO;
            break;
        case 3:
            self.image3combination.frame = CGRectMake(self.frame2combination.frame.origin.x + (- self.image3combination.frame.size.width + self.frame2combination.frame.size.width) /2,
                                                      self.frame2combination.frame.origin.y + (- self.image3combination.frame.size.height + self.frame2combination.frame.size.height) /2,
                                                      self.image3combination.frame.size.width,
                                                      self.image3combination.frame.size.height);//self.frame2combination.frame;
            self.image3combination.hidden = NO;
            break;
        case 4:
            self.image4combination.frame = CGRectMake(self.frame2combination.frame.origin.x + (- self.image4combination.frame.size.width + self.frame2combination.frame.size.width) /2,
                                                      self.frame2combination.frame.origin.y + (- self.image4combination.frame.size.height + self.frame2combination.frame.size.height) /2,
                                                      self.image4combination.frame.size.width,
                                                      self.image4combination.frame.size.height);//self.frame2combination.frame;
            self.image4combination.hidden = NO;
            break;
        case 5:
            self.image5combination.frame = CGRectMake(self.frame2combination.frame.origin.x + (- self.image5combination.frame.size.width + self.frame2combination.frame.size.width) /2,
                                                      self.frame2combination.frame.origin.y + (- self.image5combination.frame.size.height + self.frame2combination.frame.size.height) /2,
                                                      self.image5combination.frame.size.width,
                                                      self.image5combination.frame.size.height);//self.frame2combination.frame;
            self.image5combination.hidden = NO;
            break;
            
        default:
            break;
    }
    switch (activeRowToGetAllRows.game.combination3color.unsignedIntegerValue) {
        case 1:
            self.image1combination.frame = CGRectMake(self.frame3combination.frame.origin.x + (- self.image1combination.frame.size.width + self.frame3combination.frame.size.width) /2,
                                                      self.frame3combination.frame.origin.y + (- self.image1combination.frame.size.height + self.frame3combination.frame.size.height) /2,
                                                      self.image1combination.frame.size.width,
                                                      self.image1combination.frame.size.height);//self.frame3combination.frame;
            self.image1combination.hidden = NO;
            break;
        case 2:
            self.image2combination.frame = CGRectMake(self.frame3combination.frame.origin.x + (- self.image2combination.frame.size.width + self.frame3combination.frame.size.width) /2,
                                                      self.frame3combination.frame.origin.y + (- self.image2combination.frame.size.height + self.frame3combination.frame.size.height) /2,
                                                      self.image2combination.frame.size.width,
                                                      self.image2combination.frame.size.height);//self.frame3combination.frame;
            self.image2combination.hidden = NO;
            break;
        case 3:
            self.image3combination.frame = CGRectMake(self.frame3combination.frame.origin.x + (- self.image3combination.frame.size.width + self.frame3combination.frame.size.width) /2,
                                                      self.frame3combination.frame.origin.y + (- self.image3combination.frame.size.height + self.frame3combination.frame.size.height) /2,
                                                      self.image3combination.frame.size.width,
                                                      self.image3combination.frame.size.height);//self.frame3combination.frame;
            self.image3combination.hidden = NO;
            break;
        case 4:
            self.image4combination.frame = CGRectMake(self.frame3combination.frame.origin.x + (- self.image4combination.frame.size.width + self.frame3combination.frame.size.width) /2,
                                                      self.frame3combination.frame.origin.y + (- self.image4combination.frame.size.height + self.frame3combination.frame.size.height) /2,
                                                      self.image4combination.frame.size.width,
                                                      self.image4combination.frame.size.height);//self.frame3combination.frame;
            self.image4combination.hidden = NO;
            break;
        case 5:
            self.image5combination.frame = CGRectMake(self.frame3combination.frame.origin.x + (- self.image5combination.frame.size.width + self.frame3combination.frame.size.width) /2,
                                                      self.frame3combination.frame.origin.y + (- self.image5combination.frame.size.height + self.frame3combination.frame.size.height) /2,
                                                      self.image5combination.frame.size.width,
                                                      self.image5combination.frame.size.height);//self.frame3combination.frame;
            self.image5combination.hidden = NO;
            break;
            
        default:
            break;
    }
    switch (activeRowToGetAllRows.game.combination4color.unsignedIntegerValue) {
        case 1:
            self.image1combination.frame = CGRectMake(self.frame4combination.frame.origin.x + (- self.image1combination.frame.size.width + self.frame4combination.frame.size.width) /2,
                                                      self.frame4combination.frame.origin.y + (- self.image1combination.frame.size.height + self.frame4combination.frame.size.height) /2,
                                                      self.image1combination.frame.size.width,
                                                      self.image1combination.frame.size.height);//self.frame4combination.frame;
            self.image1combination.hidden = NO;
            break;
        case 2:
            self.image2combination.frame = CGRectMake(self.frame4combination.frame.origin.x + (- self.image2combination.frame.size.width + self.frame4combination.frame.size.width) /2,
                                                      self.frame4combination.frame.origin.y + (- self.image2combination.frame.size.height + self.frame4combination.frame.size.height) /2,
                                                      self.image2combination.frame.size.width,
                                                      self.image2combination.frame.size.height);//self.frame4combination.frame;
            self.image2combination.hidden = NO;
            break;
        case 3:
            self.image3combination.frame = CGRectMake(self.frame4combination.frame.origin.x + (- self.image3combination.frame.size.width + self.frame4combination.frame.size.width) /2,
                                                      self.frame4combination.frame.origin.y + (- self.image3combination.frame.size.height + self.frame4combination.frame.size.height) /2,
                                                      self.image3combination.frame.size.width,
                                                      self.image3combination.frame.size.height);//self.frame4combination.frame;
            self.image3combination.hidden = NO;
            break;
        case 4:
            self.image4combination.frame = CGRectMake(self.frame4combination.frame.origin.x + (- self.image4combination.frame.size.width + self.frame4combination.frame.size.width) /2,
                                                      self.frame4combination.frame.origin.y + (- self.image4combination.frame.size.height + self.frame4combination.frame.size.height) /2,
                                                      self.image4combination.frame.size.width,
                                                      self.image4combination.frame.size.height);//self.frame4combination.frame;
            self.image4combination.hidden = NO;
            break;
        case 5:
            self.image5combination.frame = CGRectMake(self.frame4combination.frame.origin.x + (- self.image5combination.frame.size.width + self.frame4combination.frame.size.width) /2,
                                                      self.frame4combination.frame.origin.y + (- self.image5combination.frame.size.height + self.frame4combination.frame.size.height) /2,
                                                      self.image5combination.frame.size.width,
                                                      self.image5combination.frame.size.height);//self.frame4combination.frame;
            self.image5combination.hidden = NO;
            break;
            
        default:
            break;
    }
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.locale = [NSLocale currentLocale];
    self.attemptsNumber.text = [formatter stringFromNumber:activeRowToGetAllRows.game.activeRowNumber];
}

-(BOOL)shouldAutorotate
{
    return self.isAutorotate;
}


- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    //[super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    CipherAppDelegate *mainDelegate = (CipherAppDelegate *)[[UIApplication sharedApplication] delegate];
    Row *activeRow = [mainDelegate getActiveRow];
    activeRow.game.mainDraggedImage1startingPoint = NSStringFromCGPoint(self.image1OutsideTableView.frame.origin);
    activeRow.game.mainDraggedImage2startingPoint = NSStringFromCGPoint(self.image2OutsideTableView.frame.origin);
    activeRow.game.mainDraggedImage3startingPoint = NSStringFromCGPoint(self.image3OutsideTableView.frame.origin);
    activeRow.game.mainDraggedImage4startingPoint = NSStringFromCGPoint(self.image4OutsideTableView.frame.origin);
    activeRow.game.mainDraggedImage5startingPoint = NSStringFromCGPoint(self.image5OutsideTableView.frame.origin);
   // UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    if (fromInterfaceOrientation == UIDeviceOrientationPortrait) {
        //NSLog(@"portrait");
#ifdef KidsCipherBoys
        self.mainPageBackground.image = [UIImage imageNamed:@"Boy_Main_page_fon_gorizont"];
        self.mainPageScrollBackground.image = [UIImage imageNamed:@"Boy_Main_page_fon_game_gorizont"];
#else
        self.mainPageBackground.image = [UIImage imageNamed:@"Main_page_fon_gorizont"];
        self.mainPageScrollBackground.image = [UIImage imageNamed:@"Main_page_fon_game_gorizont"];
#endif

    } else {
#ifdef KidsCipherBoys

        self.mainPageBackground.image = [UIImage imageNamed:@"Boy_Main_page_fon"];
        self.mainPageScrollBackground.image = [UIImage imageNamed:@"Boy_Main_page_fon_game"];
#else
        self.mainPageBackground.image = [UIImage imageNamed:@"Main_page_fon"];
        self.mainPageScrollBackground.image = [UIImage imageNamed:@"Main_page_fon_game"];

#endif

        //NSLog(@"UIDeviceOrientationLandscapeLeft");
    }
    [self.gamePlayScrollView scrollRectToVisible:self.row1view.frame animated:YES];
    
    [mainDelegate saveContext];
    [self updateAllViews];
    NSLog(@"didRotateFromInterfaceOrientation activeRow.game->%@",activeRow.game);
}
- (void)viewDidLoad
{
    self.isAutorotate = YES;
    [super viewDidLoad];
    CipherAppDelegate *mainDelegate = (CipherAppDelegate *)[[UIApplication sharedApplication] delegate];
    [mainDelegate registerViewController:@"CipherViewController" controller:self];
    self.gamePlayScrollView.contentSize =  CGSizeMake(self.gamePlayScrollView.contentSize.width, 1180);
    Row *activeRow = [mainDelegate getActiveRow];
    activeRow.game.mainDraggedImage1startingPoint = NSStringFromCGPoint(self.image1OutsideTableView.frame.origin);
    activeRow.game.mainDraggedImage2startingPoint = NSStringFromCGPoint(self.image2OutsideTableView.frame.origin);
    activeRow.game.mainDraggedImage3startingPoint = NSStringFromCGPoint(self.image3OutsideTableView.frame.origin);
    activeRow.game.mainDraggedImage4startingPoint = NSStringFromCGPoint(self.image4OutsideTableView.frame.origin);
    activeRow.game.mainDraggedImage5startingPoint = NSStringFromCGPoint(self.image5OutsideTableView.frame.origin);
    [mainDelegate saveContext];
    self.isViewDidLoadPassed = YES;
    
    self.attemptsTitle.text = NSLocalizedString(@"attemptsTitle", @"");
    self.gameTimeMainTitle.text = NSLocalizedString(@"gameTimeMainTitle", @"");
    self.gameTimeMinutesTitle.text = NSLocalizedString(@"gameTimeMinutesTitle", @"");
    self.gameTimeSecondsTitle.text = NSLocalizedString(@"gameTimeSecondsTitle", @"");
    self.combinationTitle.text = NSLocalizedString(@"combinationTitle", @"");
    self.beginTrainingButtonTitle.text = NSLocalizedString(@"beginTrainingButtonTitle", @"");
    self.beginGameButtonTitle.text = NSLocalizedString(@"beginGameButtonTitle", @"");
    self.startAgainButtonTitle.text = NSLocalizedString(@"gameWin", @"");
    self.startAgainButtonTitle.text = NSLocalizedString(@"gameLoosed", @"");

    self.row1MatchedColorsAndPositionsTitle.text = NSLocalizedString(@"rowMatchedColorsAndPositionsTitle", @"");
    self.row1MatchedColorsTitle.text = NSLocalizedString(@"rowMatchedColors", @"");
    self.row2MatchedColorsAndPositionsTitle.text = NSLocalizedString(@"rowMatchedColorsAndPositionsTitle", @"");
    self.row2MatchedColorsTitle.text = NSLocalizedString(@"rowMatchedColors", @"");
    self.row3MatchedColorsAndPositionsTitle.text = NSLocalizedString(@"rowMatchedColorsAndPositionsTitle", @"");
    self.row3MatchedColorsTitle.text = NSLocalizedString(@"rowMatchedColors", @"");
    self.row4MatchedColorsAndPositionsTitle.text = NSLocalizedString(@"rowMatchedColorsAndPositionsTitle", @"");
    self.row4MatchedColorsTitle.text = NSLocalizedString(@"rowMatchedColors", @"");
    self.row5MatchedColorsAndPositionsTitle.text = NSLocalizedString(@"rowMatchedColorsAndPositionsTitle", @"");
    self.row5MatchedColorsTitle.text = NSLocalizedString(@"rowMatchedColors", @"");
    self.row6MatchedColorsAndPositionsTitle.text = NSLocalizedString(@"rowMatchedColorsAndPositionsTitle", @"");
    self.row6MatchedColorsTitle.text = NSLocalizedString(@"rowMatchedColors", @"");
    self.row7MatchedColorsAndPositionsTitle.text = NSLocalizedString(@"rowMatchedColorsAndPositionsTitle", @"");
    self.row7MatchedColorsTitle.text = NSLocalizedString(@"rowMatchedColors", @"");
    self.row8MatchedColorsAndPositionsTitle.text = NSLocalizedString(@"rowMatchedColorsAndPositionsTitle", @"");
    self.row8MatchedColorsTitle.text = NSLocalizedString(@"rowMatchedColors", @"");
    self.row9MatchedColorsAndPositionsTitle.text = NSLocalizedString(@"rowMatchedColorsAndPositionsTitle", @"");
    self.row9MatchedColorsTitle.text = NSLocalizedString(@"rowMatchedColors", @"");
    self.row10MatchedColorsAndPositionsTitle.text = NSLocalizedString(@"rowMatchedColorsAndPositionsTitle", @"");
    self.row10MatchedColorsTitle.text = NSLocalizedString(@"rowMatchedColors", @"");

//    NSData *resizedData = [[NSUserDefaults standardUserDefaults] objectForKey:@"clientPicture"];//UIImagePNGRepresentation(resizedImage);
//    if (resizedData) {
//        [[self.photoView layer] setBorderColor:[[UIColor purpleColor] CGColor]];
//        [[self.photoView layer] setBorderWidth:1.75];
//        [[self.photoView layer] setCornerRadius:5];
//        [[self.photoView layer] setMasksToBounds:YES];
//        [self.photoView setImage:[UIImage imageWithData:resizedData] forState:UIControlStateNormal];
//    }

    [[self.introDescription layer] setBorderColor:[[UIColor redColor]CGColor]];
    [[self.introDescription layer] setBorderWidth:1.75];
    [[self.introDescription layer] setCornerRadius:5];
    [[self.introDescription layer] setMasksToBounds:YES];

    //NSLog(@"viewDidLoad self.image1OutsideTableView.startPointt->%@",NSStringFromCGPoint(self.image1OutsideTableView.frame.origin));
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    CipherAppDelegate *mainDelegate = (CipherAppDelegate *)[[UIApplication sharedApplication] delegate];
    Row *activeRow = [mainDelegate getActiveRow];
    activeRow.game.mainDraggedImage1identifier = self.image1OutsideTableView.uniqueIdentifier;
    activeRow.game.mainDraggedImage2identifier = self.image2OutsideTableView.uniqueIdentifier;
    activeRow.game.mainDraggedImage3identifier = self.image3OutsideTableView.uniqueIdentifier;
    activeRow.game.mainDraggedImage4identifier = self.image4OutsideTableView.uniqueIdentifier;
    activeRow.game.mainDraggedImage5identifier = self.image5OutsideTableView.uniqueIdentifier;
    activeRow.game.mainDraggedImage1startingPoint = NSStringFromCGPoint(self.image1OutsideTableView.frame.origin);
    activeRow.game.mainDraggedImage2startingPoint = NSStringFromCGPoint(self.image2OutsideTableView.frame.origin);
    activeRow.game.mainDraggedImage3startingPoint = NSStringFromCGPoint(self.image3OutsideTableView.frame.origin);
    activeRow.game.mainDraggedImage4startingPoint = NSStringFromCGPoint(self.image4OutsideTableView.frame.origin);
    activeRow.game.mainDraggedImage5startingPoint = NSStringFromCGPoint(self.image5OutsideTableView.frame.origin);
    NSData *resizedData = [[NSUserDefaults standardUserDefaults] objectForKey:@"clientPicture"];//UIImagePNGRepresentation(resizedImage);
    if (resizedData) {
        [[self.photoView layer] setBorderColor:[self.playerName.textColor CGColor]];
        [[self.photoView layer] setBorderWidth:1.75];
        [[self.photoView layer] setCornerRadius:5];
        [[self.photoView layer] setMasksToBounds:YES];
        [self.photoView setImage:[UIImage imageWithData:resizedData] forState:UIControlStateNormal];
    }

}
-(void)viewWillAppear:(BOOL)animated
{
    //[super viewWillAppear:animated];
    @autoreleasepool {
        
        
        [self updateAllViews];
        CipherAppDelegate *mainDelegate = (CipherAppDelegate *)[[UIApplication sharedApplication] delegate];
        Row *activeRow = [mainDelegate getActiveRow];
        if (activeRow.game.isGameStarted.boolValue)  mainDelegate.gameTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateGameTime:) userInfo:nil repeats:YES];
        //NSLog(@"gameTimerSeconds->%lu",(unsigned long)mainDelegate.gameTimerSeconds);
        NSString *name = [[NSUserDefaults standardUserDefaults] valueForKey:@"name"];
        self.playerName.text = name;
        UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
        if (orientation == UIDeviceOrientationPortrait ) {
            //NSLog(@"UIDeviceOrientationPortrait");
#ifdef KidsCipherBoys
            if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) self.mainPageBackground.image = [UIImage imageNamed:@"Boy_Main_page_fon_iphone"];
            else self.mainPageBackground.image = [UIImage imageNamed:@"Boy_Main_page_fon"];
            if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) self.mainPageScrollBackground.image = [UIImage imageNamed:@"Boy_Main_page_fon_game_iphone"];
            else self.mainPageScrollBackground.image = [UIImage imageNamed:@"Boy_Main_page_fon_game"];
#else
            if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) self.mainPageBackground.image = [UIImage imageNamed:@"Main_page_fon_gorizont"];
            else self.mainPageBackground.image = [UIImage imageNamed:@"Main_page_fon"];
                
            if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) self.mainPageScrollBackground.image = [UIImage imageNamed:@"Main_page_fon_game_gorizont"];
            else self.mainPageScrollBackground.image = [UIImage imageNamed:@"Main_page_fon_game"];
#endif
            
        } else {
#ifdef KidsCipherBoys
            
            if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) self.mainPageBackground.image = [UIImage imageNamed:@"Boy_Main_page_fon_gorizont"];
            else self.mainPageBackground.image = [UIImage imageNamed:@"Boy_Main_page_fon_gorizont"];
            if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) self.mainPageScrollBackground.image = [UIImage imageNamed:@"Boy_Main_page_fon_game_gorizont"];
            else  self.mainPageScrollBackground.image = [UIImage imageNamed:@"Boy_Main_page_fon_game_gorizont"];
#else
            if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) self.mainPageBackground.image = [UIImage imageNamed:@"Main_page_fon"];
            else self.mainPageBackground.image = [UIImage imageNamed:@"Main_page_fon_gorizont"];
            if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) self.mainPageScrollBackground.image = [UIImage imageNamed:@"Main_page_fon_game"];
            else self.mainPageScrollBackground.image = [UIImage imageNamed:@"Main_page_fon_game_gorizont"];
#endif
            
            //if (orientation == UIDeviceOrientationUnknown) NSLog(@"UIDeviceOrientationUnknown");
            //else NSLog(@"UIDeviceOrientationLandscapeLeft");
        }
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
            if(IS_IPHONE5){
                //move to your iphone5 storyboard
                self.mainPageGameBackground.frame = CGRectMake(14, 196, 290, 267);
                self.gamePlayScrollView.frame = CGRectMake(16, 200, 290, 251);
            }
            else{
                //move to your iphone4s storyboard
                self.mainPageGameBackground.frame = CGRectMake(14, 172, 290, 210);
                self.gamePlayScrollView.frame = CGRectMake(16, 176, 290, 200);
            }
        }
    }
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    CipherAppDelegate *mainDelegate = (CipherAppDelegate *)[[UIApplication sharedApplication] delegate];
    [mainDelegate.gameTimer invalidate];
//    CipherAppDelegate *mainDelegate = (CipherAppDelegate *)[[UIApplication sharedApplication] delegate];
//    mainDelegate.image1OutsideTableViewStartPoint = self.image1OutsideTableView.startPoint;
//    mainDelegate.image2OutsideTableViewStartPoint = self.image2OutsideTableView.startPoint;
//    mainDelegate.image3OutsideTableViewStartPoint = self.image3OutsideTableView.startPoint;
//    mainDelegate.image4OutsideTableViewStartPoint = self.image4OutsideTableView.startPoint;
//    mainDelegate.image5OutsideTableViewStartPoint = self.image5OutsideTableView.startPoint;
//    NSLog(@"viewDidDisappear mainDelegate.image1OutsideTableViewStartPoint->%@",NSStringFromCGPoint(mainDelegate.image1OutsideTableViewStartPoint));
}

- (void)didReceiveMemoryWarning
{
    //[super didReceiveMemoryWarning];
}


#pragma mark own actions

- (IBAction)closeIntro:(id)sender {
    
}
-(void)updateGameTime:(id)sender
{
    CipherAppDelegate *mainDelegate = (CipherAppDelegate *)[[UIApplication sharedApplication] delegate];
    mainDelegate.gameTimerSeconds++;
    if (!mainDelegate.isTraining) {
        NSNumber *level = [[NSUserDefaults standardUserDefaults] valueForKey:@"level"];
        NSDate *date = nil;
        double maximumTime = 0;
        
        if (level.unsignedIntegerValue == 1) {
            maximumTime = 60 * 60;
            //date = [NSDate dateWithTimeIntervalSinceReferenceDate:60 * 60 - mainDelegate.gameTimerSeconds];
        }
        if (level.unsignedIntegerValue == 0) {
//#warning temporrary not 60 * 5
            maximumTime = 60 * 5;
            //date = [NSDate dateWithTimeIntervalSinceReferenceDate:60 * 5  - mainDelegate.gameTimerSeconds];
        }
        
        if (level.unsignedIntegerValue == 2) {
            //date = [NSDate dateWithTimeIntervalSinceReferenceDate:mainDelegate.gameTimerSeconds];
        }
        if (level.unsignedIntegerValue != 2) {
            NSTimeInterval intervalToCheck = maximumTime - mainDelegate.gameTimerSeconds;
            if (intervalToCheck < 0) {
                // game over
                NSLog(@"==================game over timer");
                self.startAgainButtonTitle.text = NSLocalizedString(@"gameLoosed", @"");

                [UIView animateWithDuration:0.5
                                      delay:0
                                    options:0
                                 animations:^{
#ifdef KidsCipherBoys
                                     self.safeImage.image = [UIImage imageNamed:@"Boy_Main_page_safe_close"];
#else
                                     self.safeImage.image = [UIImage imageNamed:@"Main_page_fon_safe"];
#endif
                                 } completion:^(BOOL finished) {
                                     [mainDelegate.gameWrongResult play];
                                     
                                     [UIView animateWithDuration:.5
                                                           delay:0
                                                         options:0
                                                      animations:^{
                                                          self.startAgainButton.alpha = 1.0;
                                                          self.startAgainButtonTitle.alpha = 1.0;
                                                          
                                                          
                                                      } completion:^(BOOL finished) {
                                                          
                                                          
                                                      }];
                                     
                                 }];
                
                [mainDelegate.audioPlayerMainFoneMusic stop];
                [mainDelegate.gameWrongResult play];
                [mainDelegate.gameTimer invalidate];
                [mainDelegate setAllRowFilledForGameSuccess];

                [self updateAllViews];
                [self.gamePlayScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
                mainDelegate.gameTimerSeconds = 0;
                self.frame1combination.hidden = YES;
                self.frame2combination.hidden = YES;
                self.frame3combination.hidden = YES;
                self.frame4combination.hidden = YES;

            } else {
                date = [NSDate dateWithTimeIntervalSinceReferenceDate:intervalToCheck];
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.locale = [NSLocale currentLocale];
                [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
                [formatter setDateFormat:@"mm:ss"];
                NSString *dateString = [formatter stringFromDate:date];
                NSArray *minutesAndSeconds = [dateString componentsSeparatedByString:@":"];
                NSString *minutes = [minutesAndSeconds objectAtIndex:0];
                NSString *seconds = [minutesAndSeconds objectAtIndex:1];
                self.gameTimeMinutes.text = minutes;
                self.gameTimeSeconds.text = seconds;
            }
        } else {
            date = [NSDate dateWithTimeIntervalSinceReferenceDate:mainDelegate.gameTimerSeconds];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.locale = [NSLocale currentLocale];
            [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
            [formatter setDateFormat:@"mm:ss"];
            NSString *dateString = [formatter stringFromDate:date];
            NSArray *minutesAndSeconds = [dateString componentsSeparatedByString:@":"];
            NSString *minutes = [minutesAndSeconds objectAtIndex:0];
            NSString *seconds = [minutesAndSeconds objectAtIndex:1];
            self.gameTimeMinutes.text = minutes;
            self.gameTimeSeconds.text = seconds;
            //NSLog(@"%@", [formatter stringFromDate:date]);
        }

        //}
    }
    //self.row1MatchedColors.text = [NSString stringWithFormat:@"%@",[formatter stringFromNumber:activeRow.numberOfMatchedColor]];

}

- (IBAction)changePhoto:(id)sender {
    // Place image picker on the screen
    //[self presentViewController:imagePickerController animated:YES completion:nil];
    //NSLog(@"changePhoto->");
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    //NSLog(@"imagePickerController->%@",imagePickerController);
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        [imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
    } else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    } else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    // image picker needs a delegate,
    [imagePickerController setDelegate:self];
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        
        [self presentModalViewController:imagePickerController animated:YES];
        //[self dismissModalViewControllerAnimated:NO];
    } else {
        self.pop = [[UIPopoverController alloc] initWithContentViewController:imagePickerController];
        [self.pop presentPopoverFromRect:self.photoView.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
}

-(void)showIntro;
{
    NSNumber *intro = [[NSUserDefaults standardUserDefaults] valueForKey:@"intro"];
//#warning tepmorary disabled
//    intro = nil;
//    if (intro && intro.boolValue) return;
    CGRect introFingerFrame = self.introFinger.frame;
    CGRect introDescriptionFrame = self.introDescription.frame;
    
    self.introFinger.frame = CGRectMake( 0 ,
                                        0 ,
                                        self.view.frame.size.width,
                                        self.view.frame.size.height);
    self.introDescription.frame = CGRectMake(0,
                                             0,
                                             self.view.frame.size.width,
                                             self.view.frame.size.height);
    if (intro && intro.boolValue) {
        self.introFinger.hidden = YES;
        self.introDescription.hidden = YES;
        
    } else {
        self.introFinger.hidden = NO;
        self.introDescription.hidden = NO;
    }
    self.introDescription.text = NSLocalizedString(@"introDescription1",@"");//@"Здесь зашифрована комбинация из цвета и места, которую вы попробуете разгадать.";

    [UIView animateWithDuration:.5
                          delay:0
                        options:0
                     animations:^{
                         self.beginGameButton.frame = self.informationButton.frame;
                         self.beginGameButtonTitle.frame = self.informationButton.frame;
                         self.beginTragingButton.frame = self.informationButton.frame;
                         self.beginTrainingButtonTitle.frame = self.informationButton.frame;
                         self.introFinger.frame = CGRectMake( (self.frame1combination.frame.origin.x + self.frame1combination.frame.size.width / 2) ,
                                                             (self.frame1combination.frame.origin.y + self.frame1combination.frame.size.height ) ,
                                                             introFingerFrame.size.width,
                                                             introFingerFrame.size.height);
                         self.introDescription.frame = CGRectMake((self.frame1combination.frame.origin.x + self.frame1combination.frame.size.width / 2 + self.introFinger.frame.size.width) ,
                                                                  (self.frame1combination.frame.origin.y + self.frame1combination.frame.size.height ),
                                                                  introDescriptionFrame.size.width,
                                                                  introDescriptionFrame.size.height);
                         self.introFinger.alpha = 1.0;
                         self.introDescription.alpha = 1.0;
                         
                     } completion:^(BOOL finished) {
                         self.beginGameButton.hidden = YES;
                         self.beginGameButtonTitle.hidden = YES;
                         self.beginTragingButton.hidden = YES;
                         self.beginTrainingButtonTitle.hidden = YES;
                         self.gamePlayScrollView.hidden = NO;
                         [self.beginGameButton setNeedsDisplay];
                         [self.beginGameButtonTitle setNeedsDisplay];
                         [self.beginTragingButton setNeedsDisplay];
                         [self.beginTrainingButtonTitle setNeedsDisplay];
                         [self.gamePlayScrollView setNeedsDisplay];
                         // place finger under combination
//#warning temporary removed

                         if (intro && intro.boolValue) {
                             return;
                         }
                         sleep(2);
                         
                         [UIView animateWithDuration:2
                                               delay:0
                                             options:0
                                          animations:^{
                                              // moving finger near combination
                                              self.introFinger.frame = CGRectMake(self.introFinger.frame.origin.x + (self.frame3combination.frame.origin.x - self.frame1combination.frame.origin.x - self.frame3combination.frame.size.width / 2) , self.introFinger.frame.origin.y, self.introFinger.frame.size.width, self.introFinger.frame.size.height);
                                              self.introDescription.frame = CGRectMake(self.introDescription.frame.origin.x + (self.frame3combination.frame.origin.x - self.frame1combination.frame.origin.x  - self.frame3combination.frame.size.width / 2),
                                                                                       self.introDescription.frame.origin.y,
                                                                                       self.introDescription.frame.size.width,
                                                                                       self.introDescription.frame.size.height);
                                          } completion:^(BOOL finished) {
                                              sleep(2);
                                               self.introDescription.text = @"";
                                              [UIView animateWithDuration:2
                                                                    delay:0
                                                                  options:0
                                                               animations:^{
                                                                   // moving to car
                                                                   CGFloat deltaSize = -(self.row1frame1.frame.size.width - self.image1OutsideTableView.frame.size.width)  /2 ;
                                                                   
                                                                   CGRect frame1 = self.image1OutsideTableView.frame;
                                                                   self.introFinger.frame = CGRectMake(frame1.origin.x - deltaSize, frame1.origin.y - deltaSize, self.introFinger.frame.size.width, self.introFinger.frame.size.height);
                                                                   self.introDescription.frame = CGRectMake(frame1.origin.x + self.introFinger.frame.size.width- deltaSize, frame1.origin.y- deltaSize, self.introDescription.frame.size.width, self.introDescription.frame.size.height);
                                                                   self.introCloseButton.frame = CGRectMake(frame1.origin.x + self.introFinger.frame.size.width +  self.introDescription.frame.size.width- deltaSize, frame1.origin.y- deltaSize, self.introCloseButton.frame.size.width, self.introCloseButton.frame.size.height);
                                                                   
                                                                   
                                                               } completion:^(BOOL finished) {
                                                                   self.introFinger.image = [UIImage imageNamed:@"tapFinger"];
                                                                   self.introDescription.text = NSLocalizedString(@"introDescription2",@"");//@"Перенесите фигурку на позицию в строке.";

                                                                   sleep(2);
                                                                   
                                                                   [UIView animateWithDuration:2
                                                                                         delay:0
                                                                                       options:0
                                                                                    animations:^{
                                                                                        // move car inside row;
                                                                                        CGFloat deltaSize = -(self.row1frame1.frame.size.width - self.image1OutsideTableView.frame.size.width)  /2 ;
                                                                                        
                                                                                        CGRect frame1 = [self.gamePlayScrollView convertRect:self.row1frame1.frame toView:self.view];
                                                                                        self.introFinger.frame = CGRectMake(frame1.origin.x - deltaSize, frame1.origin.y - deltaSize, self.introFinger.frame.size.width, self.introFinger.frame.size.height);
                                                                                        self.image1OutsideTableView.frame = CGRectMake(frame1.origin.x - deltaSize, frame1.origin.y - deltaSize, self.image1OutsideTableView.frame.size.width, self.image1OutsideTableView.frame.size.height);
                                                                                        self.introDescription.frame = CGRectMake(frame1.origin.x + self.introFinger.frame.size.width- deltaSize, frame1.origin.y- deltaSize, self.introDescription.frame.size.width, self.introDescription.frame.size.height);
                                                                                        self.introCloseButton.frame = CGRectMake(frame1.origin.x + self.introFinger.frame.size.width +  self.introDescription.frame.size.width- deltaSize, frame1.origin.y- deltaSize, self.introCloseButton.frame.size.width, self.introCloseButton.frame.size.height);
                                                                                    } completion:^(BOOL finished) {
                                                                                        self.introDescription.text = NSLocalizedString(@"introDescription3",@"");//@"Заполнив всю строку, обратите внимание на подсказки.";
                                                                                        self.introFinger.image = [UIImage imageNamed:@"pointer-finger-hi"];
                                                                                        sleep(2);
                                                                                        
                                                                                        
                                                                                        [UIView animateWithDuration:2
                                                                                                              delay:0
                                                                                                            options:0
                                                                                                         animations:^{
                                                                                                             // move to matched coloes
                                                                                                             CGFloat deltaSize = -30 ;
                                                                                                             
                                                                                                             CGRect frame1 = [self.gamePlayScrollView convertRect:self.row1MatchedColorsAndPositions.frame toView:self.view];
                                                                                                             self.introFinger.frame = CGRectMake(frame1.origin.x ,
                                                                                                                                                 frame1.origin.y - deltaSize,
                                                                                                                                                 self.introFinger.frame.size.width,
                                                                                                                                                 self.introFinger.frame.size.height);
                                                                                                             self.introDescription.frame = CGRectMake(frame1.origin.x + self.introFinger.frame.size.width,
                                                                                                                                                      frame1.origin.y- deltaSize,
                                                                                                                                                      self.introDescription.frame.size.width,
                                                                                                                                                      self.introDescription.frame.size.height);
                                                                                                             self.introCloseButton.frame = CGRectMake(frame1.origin.x + self.introFinger.frame.size.width +  self.introDescription.frame.size.width,
                                                                                                                                                      frame1.origin.y- deltaSize,
                                                                                                                                                      self.introCloseButton.frame.size.width,
                                                                                                                                                      self.introCloseButton.frame.size.height);
                                                                                                             
                                                                                                         } completion:^(BOOL finished) {
                                                                                                             sleep(2);
                                                                                                             CipherAppDelegate *mainDelegate = (CipherAppDelegate *)[[UIApplication sharedApplication] delegate];
                                                                                                             Row *activeRow = [mainDelegate getActiveRow];
                                                                                                             
                                                                                                             CGPoint frameToReturnMainImage1 = CGPointFromString(activeRow.game.mainDraggedImage1startingPoint);
                                                                                                             self.introDescription.text = NSLocalizedString(@"introDescription4",@"");//@"Здесь можно узнать про свои рекорды и всех рекордсменов.";

                                                                                                             [UIView animateWithDuration:0.5
                                                                                                                                   delay:0
                                                                                                                                 options:0
                                                                                                                              animations:^{
                                                                                                                                  
                                                                                                                                  self.image1OutsideTableView.frame = CGRectMake(frameToReturnMainImage1.x,
                                                                                                                                                                                 frameToReturnMainImage1.y,
                                                                                                                                                                                 self.image1OutsideTableView.frame.size.width,
                                                                                                                                                                                 self.image1OutsideTableView.frame.size.height);
                                                                                                                                  
                                                                                                                                  CGFloat deltaSize = -30 ;

                                                                                                                                  CGRect frame1 = self.informationButton.frame;
                                                                                                                                  self.introFinger.frame = CGRectMake(frame1.origin.x + frame1.size.width / 2 ,
                                                                                                                                                                      frame1.origin.y + frame1.size.width / 2,
                                                                                                                                                                      self.introFinger.frame.size.width,
                                                                                                                                                                      self.introFinger.frame.size.height);
                                                                                                                                  self.introDescription.frame = CGRectMake(frame1.origin.x - self.introFinger.frame.size.width - self.introDescription.frame.size.width - deltaSize,
                                                                                                                                                                           frame1.origin.y- deltaSize,
                                                                                                                                                                           self.introDescription.frame.size.width,
                                                                                                                                                                           self.introDescription.frame.size.height);

                                                                                                                                  
                                                                                                                              } completion:^(BOOL finished) {
                                                                                                                                  sleep(4);
                                                                                                                                  
                                                                                                                                  [UIView animateWithDuration:0.5
                                                                                                                                                        delay:0
                                                                                                                                                      options:0
                                                                                                                                                   animations:^{
                                                                                                                                                       self.introFinger.frame = CGRectMake( 0 ,
                                                                                                                                                                                           0 ,
                                                                                                                                                                                           self.view.frame.size.width,
                                                                                                                                                                                           self.view.frame.size.height);
                                                                                                                                                       self.introDescription.frame = CGRectMake(0,
                                                                                                                                                                                                0,
                                                                                                                                                                                                self.view.frame.size.width,
                                                                                                                                                                                                self.view.frame.size.height);
                                                                                                                                                       self.introFinger.alpha = 0.0;
                                                                                                                                                       self.introDescription.alpha = 0.0;
                                                                                                                                                   } completion:^(BOOL finished) {
                                                                                                                                                       
                                                                                                                                                       self.introFinger.hidden = NO;
                                                                                                                                                       self.introDescription.hidden = NO;
                                                                                                                                                       self.introFinger.frame = introFingerFrame;
                                                                                                                                                       self.introDescription.frame = introDescriptionFrame;
                                                                                                                                                       [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithBool:YES] forKey:@"intro"];
                                                                                                                                                       [[NSUserDefaults standardUserDefaults] synchronize];
                                                                                                                                                   }];
                                                                                                                              }];
                                                                                                         }];
                                                                                        
                                                                                    }];
                                                                   
                                                               }];
                                          }];
                     }];

}

- (IBAction)startGame:(id)sender {
    self.frame1combination.hidden = NO;
    self.frame2combination.hidden = NO;
    self.frame3combination.hidden = NO;
    self.frame4combination.hidden = NO;

#ifdef KidsCipherBoys
    self.frame1combination.imageView.image = [UIImage imageNamed:@"Boy_button_lock"];
    self.frame2combination.imageView.image = [UIImage imageNamed:@"Boy_button_lock"];
    self.frame3combination.imageView.image = [UIImage imageNamed:@"Boy_button_lock"];
    self.frame4combination.imageView.image = [UIImage imageNamed:@"Boy_button_lock"];
#else
    self.frame1combination.imageView.image = [UIImage imageNamed:@"button_lock"];
    self.frame2combination.imageView.image = [UIImage imageNamed:@"button_lock"];
    self.frame3combination.imageView.image = [UIImage imageNamed:@"button_lock"];
    self.frame4combination.imageView.image = [UIImage imageNamed:@"button_lock"];
#endif
    self.image1OutsideTableView.alpha = 1.0;
    self.image2OutsideTableView.alpha = 1.0;
    self.image3OutsideTableView.alpha = 1.0;
    self.image4OutsideTableView.alpha = 1.0;
    self.image5OutsideTableView.alpha = 1.0;


    self.row1HidingView.hidden = YES;
    self.row1HidingView.userInteractionEnabled = NO;
    CipherAppDelegate *mainDelegate = (CipherAppDelegate *)[[UIApplication sharedApplication] delegate];
    Row *activeRowToGetAllRows = [mainDelegate getActiveRow];
    activeRowToGetAllRows.game.isGameStarted = [NSNumber numberWithBool:YES];
    [mainDelegate saveContext];
    
    //    if (mainDelegate.gameTimer != nil) {
    //        [mainDelegate.gameTimer invalidate];
    //        //self.beginGameButtonTitle.text = @"Начать игру";
    //        //self.beginGameButtonTitle.text = NSLocalizedString(@"beginGameButtonTitle", @"");
    //        [mainDelegate setRandomCombinationForCurrentGame];
    //        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    //        formatter.locale = [NSLocale currentLocale];
    //        formatter.minimumIntegerDigits = 2;
    //        self.gameTimeMinutes.text = [formatter stringFromNumber:[NSNumber numberWithInt:0]];
    //        self.gameTimeSeconds.text = [formatter stringFromNumber:[NSNumber numberWithInt:0]];
    //        mainDelegate.gameTimer = nil;
    //        mainDelegate.gameTimerSeconds = 0;
    //
    //    } else {
    mainDelegate.gameTimerSeconds = 0;
    //[mainDelegate setRandomCombinationForCurrentGame];
    
    //self.beginGameButtonTitle.text = @"Остановить игру";
    //self.beginGameButtonTitle.text = NSLocalizedString(@"beginGameButtonTitleStop", @"");
    mainDelegate.gameTimer = nil;
    mainDelegate.gameTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateGameTime:) userInfo:nil repeats:YES];
    [self.gamePlayScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    
//    }

    mainDelegate.isTraining = NO;
#ifdef KidsCipherBoys
    self.safeImage.image = [UIImage imageNamed:@"Boy_Main_page_safe_close"];
#else
    self.safeImage.image = [UIImage imageNamed:@"Main_page_fon_safe"];
#endif

    [self updateAllViews];
    [self showIntro];

}
- (IBAction)startTraining:(id)sender {
    self.frame1combination.hidden = NO;
    self.frame2combination.hidden = NO;
    self.frame3combination.hidden = NO;
    self.frame4combination.hidden = NO;

    self.image1OutsideTableView.alpha = 1.0;
    self.image2OutsideTableView.alpha = 1.0;
    self.image3OutsideTableView.alpha = 1.0;
    self.image4OutsideTableView.alpha = 1.0;
    self.image5OutsideTableView.alpha = 1.0;

    self.row1HidingView.hidden = YES;
    self.row1HidingView.userInteractionEnabled = NO;
    CipherAppDelegate *mainDelegate = (CipherAppDelegate *)[[UIApplication sharedApplication] delegate];
    Row *activeRowToGetAllRows = [mainDelegate getActiveRow];
    activeRowToGetAllRows.game.isGameStarted = [NSNumber numberWithBool:YES];
    [mainDelegate saveContext];
//    if (mainDelegate.gameTimer != nil) {
//        [mainDelegate.gameTimer invalidate];
//        //self.beginTrainingButtonTitle.text = @"Тренировка";
//        //self.beginTrainingButtonTitle.text = NSLocalizedString(@"beginTrainingButtonTitle", @"");
//
//        [mainDelegate setRandomCombinationForCurrentGame];
//        [self updateAllViews];
//        mainDelegate.gameTimer = nil;
        mainDelegate.gameTimerSeconds = 0;
#ifdef KidsCipherBoys
        self.frame1combination.imageView.image = [UIImage imageNamed:@"Boy_button_lock"];
        self.frame2combination.imageView.image = [UIImage imageNamed:@"Boy_button_lock"];
        self.frame3combination.imageView.image = [UIImage imageNamed:@"Boy_button_lock"];
        self.frame4combination.imageView.image = [UIImage imageNamed:@"Boy_button_lock"];
#else
        self.frame1combination.imageView.image = [UIImage imageNamed:@"button_lock"];
        self.frame2combination.imageView.image = [UIImage imageNamed:@"button_lock"];
        self.frame3combination.imageView.image = [UIImage imageNamed:@"button_lock"];
        self.frame4combination.imageView.image = [UIImage imageNamed:@"button_lock"];
#endif
        

//    } else {
        //self.beginTrainingButtonTitle.text = @"Остановить тренировку";
        //self.beginTrainingButtonTitle.text = NSLocalizedString(@"beginTrainingButtonTitleStop", @"");

        mainDelegate.gameTimer = nil;
        mainDelegate.isTraining = YES;
        mainDelegate.gameTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateGameTime:) userInfo:nil repeats:YES];
        [self.gamePlayScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
//    }

    [self updateAllViews];
#ifdef KidsCipherBoys
    self.frame1combination.imageView.image = [UIImage imageNamed:@"Boy_button_training_lock_car"];
    self.frame2combination.imageView.image = [UIImage imageNamed:@"Boy_button_training_lock_car"];
    self.frame3combination.imageView.image = [UIImage imageNamed:@"Boy_button_training_lock_car"];
    self.frame4combination.imageView.image = [UIImage imageNamed:@"Boy_button_training_lock_car"];
    self.safeImage.image = [UIImage imageNamed:@"Boy_main_page_safe_ajar"];
#else
    self.frame1combination.imageView.image = [UIImage imageNamed:@"button_lock_training"];
    self.frame2combination.imageView.image = [UIImage imageNamed:@"button_lock_training"];
    self.frame3combination.imageView.image = [UIImage imageNamed:@"button_lock_training"];
    self.frame4combination.imageView.image = [UIImage imageNamed:@"button_lock_training"];
    self.safeImage.image = [UIImage imageNamed:@"Main_page_fon_safe_ajar"];
#endif

    [self showIntro];

}
- (IBAction)returnToMenu:(id)sender {
    CipherAppDelegate *mainDelegate = (CipherAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [mainDelegate setRandomCombinationForCurrentGame];
    
    self.beginGameButton.hidden = NO;
    self.beginGameButtonTitle.hidden = NO;
    self.beginTragingButton.hidden = NO;
    self.beginTrainingButtonTitle.hidden = NO;
    self.frame1combination.hidden = NO;
    self.frame2combination.hidden = NO;
    self.frame3combination.hidden = NO;
    self.frame4combination.hidden = NO;

    Row *activeRow = [mainDelegate getActiveRow];
    
    [UIView animateWithDuration:.5
                          delay:0
                        options:0
                     animations:^{
                         self.startAgainButton.alpha = 0.0;
                         self.startAgainButtonTitle.alpha = 0.0;
                         
                         NSString *beginGameButtonFrame = activeRow.game.beginGameButtonFrame;
                         NSString *beginGameButtonTitleFrame = activeRow.game.beginGameButtonTitleFrame;
                         NSString *beginTragingButtonFrame = activeRow.game.beginTragingButtonFrame;
                         NSString *beginTrainingButtonTitleFrame = activeRow.game.beginTrainingButtonTitleFrame;
                         self.beginGameButton.frame = CGRectFromString(beginGameButtonFrame);
                         self.beginGameButtonTitle.frame = CGRectFromString(beginGameButtonTitleFrame);
                         self.beginTragingButton.frame = CGRectFromString(beginTragingButtonFrame);
                         self.beginTrainingButtonTitle.frame = CGRectFromString(beginTrainingButtonTitleFrame);
                         
                     } completion:^(BOOL finished) {
                         
                         
                     }];
}
- (IBAction)showInformationView:(id)sender {
    CipherAppDelegate *mainDelegate = (CipherAppDelegate *)[[UIApplication sharedApplication] delegate];
    CipherInfoViewController *vc = [mainDelegate.viewControllers valueForKey:@"CipherInfoViewController"];
    if (!vc) {
        UIStoryboard *mainStoryboard = nil;
#ifdef KidsCipherGirls
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle: nil];
        else mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPad" bundle: nil];
#endif
#ifdef KidsCipherBoys
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard_Boys_iPhone" bundle: nil];
        else mainStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard_Boys_iPad" bundle: nil];
#endif
        vc = (CipherInfoViewController*)[mainStoryboard instantiateViewControllerWithIdentifier: @"CipherInfoViewController"];
    }
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:vc animated:YES];
}

-(void)startCompletingCurrentRowAndOpenNext;
{
    //@synchronized (self) {
    //if (self.isRowCompletedProcessing && self.isRowCompletedProcessing.boolValue)  { NSLog(@"isRowCompletedProcessing, return");return; }
    //self.isRowCompletedProcessing = [NSNumber numberWithBool:YES];
    self.isAutorotate = NO;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^(void) {
        //sleep(1);
        CipherAppDelegate *mainDelegate = (CipherAppDelegate *)[[UIApplication sharedApplication] delegate];
        __block CGPoint frameToReturnMainImage1;
        __block CGPoint frameToReturnMainImage2;
        __block CGPoint frameToReturnMainImage3;
        __block CGPoint frameToReturnMainImage4;
        __block CGPoint frameToReturnMainImage5;

        dispatch_async(dispatch_get_main_queue(), ^(void) {
            
            Row *activeRow = [mainDelegate getActiveRow];
            Row *rowBeforeActiveRow = [mainDelegate getRowBeforeActiveRow];
            NSLog(@"==================rowBeforeActiveRow.game.activeRowNumber->%@ rowBeforeActiveRow.isFilled->%@",rowBeforeActiveRow.game.activeRowNumber,rowBeforeActiveRow.isFilled);
            
            //if (rowBeforeActiveRow.isFilled.boolValue) { NSLog(@"active line  filled, return");return; }
            //NSLog(@"newHistory->%@",newHistory);
            NSUInteger findedTruePositionsAndColors = 0;
            NSUInteger findedTrueColors = 0;
            
            NSNumber *frame1FilledNumber = activeRow.frame1FilledNumber;
            NSNumber *frame2FilledNumber = activeRow.frame2FilledNumber;
            NSNumber *frame3FilledNumber = activeRow.frame3FilledNumber;
            NSNumber *frame4FilledNumber = activeRow.frame4FilledNumber;
            
            NSNumber *combination1color = activeRow.game.combination1color;
            NSNumber *combination2color = activeRow.game.combination2color;
            NSNumber *combination3color = activeRow.game.combination3color;
            NSNumber *combination4color = activeRow.game.combination4color;
            
            if (frame1FilledNumber.integerValue == combination1color.integerValue) findedTruePositionsAndColors++;
            else if (frame1FilledNumber.integerValue == combination2color.integerValue ||
                     frame1FilledNumber.integerValue == combination3color.integerValue ||
                     frame1FilledNumber.integerValue == combination4color.integerValue ) findedTrueColors++;
            if (frame2FilledNumber.integerValue == combination2color.integerValue) findedTruePositionsAndColors++;
            else if (frame2FilledNumber.integerValue == combination1color.integerValue ||
                     frame2FilledNumber.integerValue == combination3color.integerValue ||
                     frame2FilledNumber.integerValue == combination4color.integerValue ) findedTrueColors++;
            if (frame3FilledNumber.integerValue == combination3color.integerValue) findedTruePositionsAndColors++;
            else if (frame3FilledNumber.integerValue == combination1color.integerValue ||
                     frame3FilledNumber.integerValue == combination2color.integerValue ||
                     frame3FilledNumber.integerValue == combination4color.integerValue ) findedTrueColors++;
            if (frame4FilledNumber.integerValue == combination4color.integerValue) findedTruePositionsAndColors++;
            else if (frame4FilledNumber.integerValue == combination1color.integerValue ||
                     frame4FilledNumber.integerValue == combination2color.integerValue ||
                     frame4FilledNumber.integerValue == combination3color.integerValue ) findedTrueColors++;
            activeRow.numberOfMatchedColor = [NSNumber numberWithUnsignedInteger:findedTrueColors];
            activeRow.numberOfMatchedColorAndPosition = [NSNumber numberWithUnsignedInteger:findedTruePositionsAndColors];
            NSUInteger activeRowNumber = activeRow.game.activeRowNumber.unsignedIntegerValue;
            UILabel *rowMatchedColors = nil;
            UILabel *rowMatchedColorsAndPositions = nil;
            NSNumber *level = [[NSUserDefaults standardUserDefaults] valueForKey:@"level"];

            UIImageView *rowCheckImage1 = nil;
            UIImageView *rowCheckImage2 = nil;
            UIImageView *rowCheckImage3 = nil;
            UIImageView *rowCheckImage4 = nil;

            switch (activeRowNumber) {
                case 0: {
                    rowMatchedColors = self.row1MatchedColors;
                    rowMatchedColorsAndPositions = self.row1MatchedColorsAndPositions;
                    rowCheckImage1 = self.row1CheckImage1;
                    rowCheckImage2 = self.row1CheckImage2;
                    rowCheckImage3 = self.row1CheckImage3;
                    rowCheckImage4 = self.row1CheckImage4;
                    break;
                }
                case 1: {
                    rowMatchedColors = self.row2MatchedColors;
                    rowMatchedColorsAndPositions = self.row2MatchedColorsAndPositions;
                    rowCheckImage1 = self.row2CheckImage1;
                    rowCheckImage2 = self.row2CheckImage2;
                    rowCheckImage3 = self.row2CheckImage3;
                    rowCheckImage4 = self.row2CheckImage4;

                    break;
                }
                case 2: {
                    rowMatchedColors = self.row3MatchedColors;
                    rowMatchedColorsAndPositions = self.row3MatchedColorsAndPositions;
                    rowCheckImage1 = self.row3CheckImage1;
                    rowCheckImage2 = self.row3CheckImage2;
                    rowCheckImage3 = self.row3CheckImage3;
                    rowCheckImage4 = self.row3CheckImage4;

                    break;
                }
                case 3: {
                    rowMatchedColors = self.row4MatchedColors;
                    rowMatchedColorsAndPositions = self.row4MatchedColorsAndPositions;
                    rowCheckImage1 = self.row4CheckImage1;
                    rowCheckImage2 = self.row4CheckImage2;
                    rowCheckImage3 = self.row4CheckImage3;
                    rowCheckImage4 = self.row4CheckImage4;

                    break;
                }
                case 4: {
                    rowMatchedColors = self.row5MatchedColors;
                    rowMatchedColorsAndPositions = self.row5MatchedColorsAndPositions;
                    rowCheckImage1 = self.row5CheckImage1;
                    rowCheckImage2 = self.row5CheckImage2;
                    rowCheckImage3 = self.row5CheckImage3;
                    rowCheckImage4 = self.row5CheckImage4;

                    break;
                }
                case 5: {
                    rowMatchedColors = self.row6MatchedColors;
                    rowMatchedColorsAndPositions = self.row6MatchedColorsAndPositions;
                    rowCheckImage1 = self.row6CheckImage1;
                    rowCheckImage2 = self.row6CheckImage2;
                    rowCheckImage3 = self.row6CheckImage3;
                    rowCheckImage4 = self.row6CheckImage4;

                    break;
                }
                case 6: {
                    rowMatchedColors = self.row7MatchedColors;
                    rowMatchedColorsAndPositions = self.row7MatchedColorsAndPositions;
                    rowCheckImage1 = self.row7CheckImage1;
                    rowCheckImage2 = self.row7CheckImage2;
                    rowCheckImage3 = self.row7CheckImage3;
                    rowCheckImage4 = self.row7CheckImage4;

                    break;
                }
                case 7: {
                    rowMatchedColors = self.row8MatchedColors;
                    rowMatchedColorsAndPositions = self.row8MatchedColorsAndPositions;
                    rowCheckImage1 = self.row8CheckImage1;
                    rowCheckImage2 = self.row8CheckImage2;
                    rowCheckImage3 = self.row8CheckImage3;
                    rowCheckImage4 = self.row8CheckImage4;

                    break;
                }
                case 8: {
                    rowMatchedColors = self.row9MatchedColors;
                    rowMatchedColorsAndPositions = self.row9MatchedColorsAndPositions;
                    rowCheckImage1 = self.row9CheckImage1;
                    rowCheckImage2 = self.row9CheckImage2;
                    rowCheckImage3 = self.row9CheckImage3;
                    rowCheckImage4 = self.row9CheckImage4;

                    break;
                }
                case 9: {
                    rowMatchedColors = self.row10MatchedColors;
                    rowMatchedColorsAndPositions = self.row10MatchedColorsAndPositions;
                    rowCheckImage1 = self.row10CheckImage1;
                    rowCheckImage2 = self.row10CheckImage2;
                    rowCheckImage3 = self.row10CheckImage3;
                    rowCheckImage4 = self.row10CheckImage4;

                    break;
                }
            }
            if (level.unsignedIntegerValue == 2 || mainDelegate.isTraining) {
                if (frame1FilledNumber.integerValue == combination1color.integerValue) rowCheckImage1.hidden = NO;
                if (frame2FilledNumber.integerValue == combination2color.integerValue) rowCheckImage2.hidden = NO;
                if (frame3FilledNumber.integerValue == combination3color.integerValue) rowCheckImage3.hidden = NO;
                if (frame4FilledNumber.integerValue == combination4color.integerValue) rowCheckImage4.hidden = NO;
            }
            NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
            formatter.locale = [NSLocale currentLocale];
            rowMatchedColors.text = [NSString stringWithFormat:@"%@",[formatter stringFromNumber:activeRow.numberOfMatchedColor]];
            rowMatchedColorsAndPositions.text = [NSString stringWithFormat:@"%@",[formatter stringFromNumber:activeRow.numberOfMatchedColorAndPosition]];
            //});
            activeRow.isFilled = [NSNumber numberWithBool:YES];
            activeRow.game.activeRowNumber = [NSNumber numberWithInteger:activeRow.game.activeRowNumber.integerValue + 1];
            [mainDelegate saveContext];
//            NSLog(@"==================activeRow.game.activeRowNumber->%@ activeRow.isFilled->%@",activeRow.game.activeRowNumber,activeRow.isFilled);
//#warning temporary fix
//            findedTruePositionsAndColors = 4;
            if (findedTruePositionsAndColors == 4) {
//                NSLog(@"==================game over");
                
                if (findedTruePositionsAndColors == 4) {
                    [mainDelegate.audioPlayerMainFoneMusic stop];
                    CGRect safeMain = self.safeImage.frame;
                    CGPoint safeCenter = self.safeImage.center;
                    [UIView animateWithDuration:.2
                                          delay:0
                                        options:0
                                     animations:^{
                                         self.safeImage.frame = CGRectMake(safeCenter.x, safeCenter.y, 0, 0);
                                     } completion:^(BOOL finished) {
                                         //self.safeImage.image = [UIImage imageNamed:@"Main_page_fon_safe_open"];
#ifdef KidsCipherBoys
                                         self.safeImage.image = [UIImage imageNamed:@"Boy_Main_page_fon_safe_open"];
#else
                                         self.safeImage.image = [UIImage imageNamed:@"Main_page_fon_safe_open"];
#endif
                                         self.startAgainButtonTitle.text = NSLocalizedString(@"gameWin", @"");

                                         [UIView animateWithDuration:.5
                                                               delay:0
                                                             options:0
                                                          animations:^{
                                                              self.safeImage.frame = safeMain;
                                                          } completion:^(BOOL finished) {
                                                              
                                                              [UIView animateWithDuration:.5
                                                                                    delay:0
                                                                                  options:0
                                                                               animations:^{
                                                                                   self.startAgainButton.alpha = 1.0;
                                                                                   self.startAgainButtonTitle.alpha = 1.0;
                                                                                   
                                                                                   
                                                                               } completion:^(BOOL finished) {
                                                                                   
                                                                                   
                                                                               }];
                                                              
                                                          }];
                                     }];

                    [mainDelegate.gameSuccessResult play];
                    self.frame1combination.hidden = YES;
                    self.frame2combination.hidden = YES;
                    self.frame3combination.hidden = YES;
                    self.frame4combination.hidden = YES;

                } else {
#ifdef KidsCipherBoys
                    self.safeImage.image = [UIImage imageNamed:@"Boy_Main_page_safe_close"];
#else
                    self.safeImage.image = [UIImage imageNamed:@"Main_page_fon_safe"];
#endif
                    [mainDelegate.audioPlayerMainFoneMusic stop];
                    [mainDelegate.gameWrongResult play];
#ifdef KidsCipherBoys
                    self.frame1combination.imageView.image = [UIImage imageNamed:@"Boy_button_lock"];
                    self.frame2combination.imageView.image = [UIImage imageNamed:@"Boy_button_lock"];
                    self.frame3combination.imageView.image = [UIImage imageNamed:@"Boy_button_lock"];
                    self.frame4combination.imageView.image = [UIImage imageNamed:@"Boy_button_lock"];
#else
                    self.frame1combination.imageView.image = [UIImage imageNamed:@"button_lock"];
                    self.frame2combination.imageView.image = [UIImage imageNamed:@"button_lock"];
                    self.frame3combination.imageView.image = [UIImage imageNamed:@"button_lock"];
                    self.frame4combination.imageView.image = [UIImage imageNamed:@"button_lock"];
#endif
                    self.frame1combination.hidden = YES;
                    self.frame2combination.hidden = YES;
                    self.frame3combination.hidden = YES;
                    self.frame4combination.hidden = YES;


                }
                [mainDelegate.gameTimer invalidate];
                //self.beginTrainingButtonTitle.text = NSLocalizedString(@"beginTrainingButtonTitle", @"");
                //self.beginGameButtonTitle.text = NSLocalizedString(@"beginGameButtonTitle", @"");
                //[mainDelegate setRandomCombinationForCurrentGame];
                
                [mainDelegate setAllRowFilledForGameSuccess];
                //if (activeRow.game.activeRowNumber.unsignedIntegerValue > 9) activeRow.game.activeRowNumber = [NSNumber numberWithInteger:9];
                //[mainDelegate saveContext];

                [self updateAllViews];
                if (!mainDelegate.isTraining) {
                    //NSManagedObjectContext *child = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
                    //child.parentContext = mainDelegate.managedObjectContext;
                    //child.undoManager = nil;

                    GamesHistory *newHistory = (GamesHistory *)[NSEntityDescription insertNewObjectForEntityForName:@"GamesHistory" inManagedObjectContext:mainDelegate.managedObjectContext];
                    NSData *pickedData = [[NSUserDefaults standardUserDefaults] objectForKey:@"clientPicture"];
                    if (pickedData) newHistory.photo = pickedData;
                    //else newHistory.photo = imageData;
                    //NSLog(@"pickedData->%@ ",[pickedData description],[imageData description]);
                    NSString *name = [[NSUserDefaults standardUserDefaults] valueForKey:@"name"];
                    NSNumber *level = [[NSUserDefaults standardUserDefaults] valueForKey:@"level"];
                    
                    newHistory.name = name;
                    newHistory.date = [NSDate date];
                    newHistory.difficultLevel = level;
                    newHistory.gameTime = [NSNumber numberWithInt:mainDelegate.gameTimerSeconds];
                    newHistory.attempts = [NSNumber numberWithInt:activeRowNumber+1];
//                    [child performBlockAndWait:^{
//                        NSError *childError = nil;
//                        [child save:&childError];
//                        if (childError)  NSLog(@"%@:%@ Child Error Received: %@", [self class], NSStringFromSelector(_cmd),
//                                               [childError localizedDescription]);
//                        childError = nil;
//
//                        [child obtainPermanentIDsForObjects:child.insertedObjects.allObjects error:&childError];
//                        if (childError)  NSLog(@"%@:%@ Child Error obtainPermanentIDsForObjects Received: %@", [self class], NSStringFromSelector(_cmd),
//                                               [childError localizedDescription]);
//                        [mainDelegate.managedObjectContext performBlockAndWait:^{
//                            NSError *parentError = nil;
//                            [mainDelegate.managedObjectContext save:&parentError];
//                            if (parentError)  NSLog(@"%@:%@ Parent Error Received: %@", [self class], NSStringFromSelector(_cmd),
//                                                    [childError localizedDescription]);
//                        }];
//                    }];

                    mainDelegate.gameTimer = nil;
                    mainDelegate.gameTimerSeconds = 0;
                    [mainDelegate saveContext];
                    [mainDelegate sendNewGamescore:newHistory.objectID];
                    [self.gamePlayScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
                    self.frame1combination.hidden = YES;
                    self.frame2combination.hidden = YES;
                    self.frame3combination.hidden = YES;
                    self.frame4combination.hidden = YES;

                }
            } else {
                switch (activeRow.game.activeRowNumber.unsignedIntegerValue) {
                    case 1: {
                        // 1 row finished
                        self.row1image1.userInteractionEnabled = NO;
                        self.row1image2.userInteractionEnabled = NO;
                        self.row1image3.userInteractionEnabled = NO;
                        self.row1image4.userInteractionEnabled = NO;
                        self.row1image5.userInteractionEnabled = NO;
                        
                        self.image1OutsideTableView.hidden = NO;
                        self.image2OutsideTableView.hidden = NO;
                        self.image3OutsideTableView.hidden = NO;
                        self.image4OutsideTableView.hidden = NO;
                        self.image5OutsideTableView.hidden = NO;
                        self.row1HidingView.hidden = NO;
                        self.row1HidingView.alpha = 0.3;
                        self.row2HidingView.hidden = YES;
                        self.row2HidingView.alpha = 0.0;
                        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
                        formatter.locale = [NSLocale currentLocale];
                        self.attemptsNumber.text = [formatter stringFromNumber:[NSNumber numberWithInt:1]];
                        //[self.gamePlayScrollView scrollRectToVisible:self.row2view.frame animated:YES];
                        CGFloat delta = 0;
                        CGFloat scrollHeight = self.gamePlayScrollView.frame.size.height;
                        CGFloat rowHeight = self.row2view.frame.size.height * 1.2;
                        if (scrollHeight > rowHeight) delta = self.row2view.frame.size.height / 1.5;
                        [self.gamePlayScrollView setContentOffset:CGPointMake(0, self.row2view.frame.origin.y - delta) animated:YES];
                        break;
                    }
                    case 2: {
                        self.row2image1.userInteractionEnabled = NO;
                        self.row2image2.userInteractionEnabled = NO;
                        self.row2image3.userInteractionEnabled = NO;
                        self.row2image4.userInteractionEnabled = NO;
                        self.row2image5.userInteractionEnabled = NO;
                        
                        self.image1OutsideTableView.hidden = NO;
                        self.image2OutsideTableView.hidden = NO;
                        self.image3OutsideTableView.hidden = NO;
                        self.image4OutsideTableView.hidden = NO;
                        self.image5OutsideTableView.hidden = NO;
                        self.row2HidingView.hidden = NO;
                        self.row2HidingView.alpha = 0.3;
                        self.row3HidingView.hidden = YES;
                        self.row3HidingView.alpha = 0.0;
                        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
                        formatter.locale = [NSLocale currentLocale];
                        self.attemptsNumber.text = [formatter stringFromNumber:[NSNumber numberWithInt:2]];
                        CGFloat delta = 0;
                        CGFloat scrollHeight = self.gamePlayScrollView.frame.size.height;
                        CGFloat rowHeight = self.row3view.frame.size.height * 1.2;
                        if (scrollHeight > rowHeight) delta = self.row3view.frame.size.height / 20;
                        [self.gamePlayScrollView setContentOffset:CGPointMake(0, self.row3view.frame.origin.y - delta) animated:YES];
                        break;
                    }
                    case 3: {
                        self.row3image1.userInteractionEnabled = NO;
                        self.row3image2.userInteractionEnabled = NO;
                        self.row3image3.userInteractionEnabled = NO;
                        self.row3image4.userInteractionEnabled = NO;
                        self.row3image5.userInteractionEnabled = NO;
                        
                        self.image1OutsideTableView.hidden = NO;
                        self.image2OutsideTableView.hidden = NO;
                        self.image3OutsideTableView.hidden = NO;
                        self.image4OutsideTableView.hidden = NO;
                        self.image5OutsideTableView.hidden = NO;
                        self.row3HidingView.hidden = NO;
                        self.row3HidingView.alpha = 0.3;
                        self.row4HidingView.hidden = YES;
                        self.row4HidingView.alpha = 0.0;
                        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
                        formatter.locale = [NSLocale currentLocale];
                        self.attemptsNumber.text = [formatter stringFromNumber:[NSNumber numberWithInt:3]];
                        CGFloat delta = 0;
                        CGFloat scrollHeight = self.gamePlayScrollView.frame.size.height;
                        CGFloat rowHeight = self.row4view.frame.size.height * 1.2;
                        if (scrollHeight > rowHeight) delta = self.row4view.frame.size.height / 2;
                        [self.gamePlayScrollView setContentOffset:CGPointMake(0, self.row4view.frame.origin.y - delta) animated:YES];
                        break;
                    }
                    case 4: {
                        self.row4image1.userInteractionEnabled = NO;
                        self.row4image2.userInteractionEnabled = NO;
                        self.row4image3.userInteractionEnabled = NO;
                        self.row4image4.userInteractionEnabled = NO;
                        self.row4image5.userInteractionEnabled = NO;
                        
                        self.image1OutsideTableView.hidden = NO;
                        self.image2OutsideTableView.hidden = NO;
                        self.image3OutsideTableView.hidden = NO;
                        self.image4OutsideTableView.hidden = NO;
                        self.image5OutsideTableView.hidden = NO;
                        self.row4HidingView.hidden = NO;
                        self.row4HidingView.alpha = 0.3;
                        self.row5HidingView.hidden = YES;
                        self.row5HidingView.alpha = 0.0;
                        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
                        formatter.locale = [NSLocale currentLocale];
                        self.attemptsNumber.text = [formatter stringFromNumber:[NSNumber numberWithInt:4]];
                        CGFloat delta = 0;
                        CGFloat scrollHeight = self.gamePlayScrollView.frame.size.height;
                        CGFloat rowHeight = self.row5view.frame.size.height * 1.2;
                        if (scrollHeight > rowHeight) delta = self.row5view.frame.size.height / 2;
                        [self.gamePlayScrollView setContentOffset:CGPointMake(0, self.row5view.frame.origin.y - delta) animated:YES];
                        break;
                    }
                    case 5: {
                        self.row5image1.userInteractionEnabled = NO;
                        self.row5image2.userInteractionEnabled = NO;
                        self.row5image3.userInteractionEnabled = NO;
                        self.row5image4.userInteractionEnabled = NO;
                        self.row5image5.userInteractionEnabled = NO;
                        
                        self.image1OutsideTableView.hidden = NO;
                        self.image2OutsideTableView.hidden = NO;
                        self.image3OutsideTableView.hidden = NO;
                        self.image4OutsideTableView.hidden = NO;
                        self.image5OutsideTableView.hidden = NO;
                        self.row5HidingView.hidden = NO;
                        self.row5HidingView.alpha = 0.3;
                        self.row6HidingView.hidden = YES;
                        self.row6HidingView.alpha = 0.0;
                        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
                        formatter.locale = [NSLocale currentLocale];
                        self.attemptsNumber.text = [formatter stringFromNumber:[NSNumber numberWithInt:5]];
                        CGFloat delta = 0;
                        CGFloat scrollHeight = self.gamePlayScrollView.frame.size.height;
                        CGFloat rowHeight = self.row6view.frame.size.height * 1.2;
                        if (scrollHeight > rowHeight) delta = self.row6view.frame.size.height / 2;
                        [self.gamePlayScrollView setContentOffset:CGPointMake(0, self.row6view.frame.origin.y - delta) animated:YES];
                        break;
                    }
                    case 6: {
                        self.row6image1.userInteractionEnabled = NO;
                        self.row6image2.userInteractionEnabled = NO;
                        self.row6image3.userInteractionEnabled = NO;
                        self.row6image4.userInteractionEnabled = NO;
                        self.row6image5.userInteractionEnabled = NO;
                        
                        self.image1OutsideTableView.hidden = NO;
                        self.image2OutsideTableView.hidden = NO;
                        self.image3OutsideTableView.hidden = NO;
                        self.image4OutsideTableView.hidden = NO;
                        self.image5OutsideTableView.hidden = NO;
                        self.row6HidingView.hidden = NO;
                        self.row6HidingView.alpha = 0.3;
                        self.row7HidingView.hidden = YES;
                        self.row7HidingView.alpha = 0.0;
                        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
                        formatter.locale = [NSLocale currentLocale];
                        self.attemptsNumber.text = [formatter stringFromNumber:[NSNumber numberWithInt:6]];
                        CGFloat delta = 0;
                        CGFloat scrollHeight = self.gamePlayScrollView.frame.size.height;
                        CGFloat rowHeight = self.row7view.frame.size.height * 1.2;
                        if (scrollHeight > rowHeight) delta = self.row7view.frame.size.height / 2;
                        [self.gamePlayScrollView setContentOffset:CGPointMake(0, self.row7view.frame.origin.y - delta) animated:YES];
                        break;
                    }
                    case 7: {
                        self.row7image1.userInteractionEnabled = NO;
                        self.row7image2.userInteractionEnabled = NO;
                        self.row7image3.userInteractionEnabled = NO;
                        self.row7image4.userInteractionEnabled = NO;
                        self.row7image5.userInteractionEnabled = NO;
                        
                        self.image1OutsideTableView.hidden = NO;
                        self.image2OutsideTableView.hidden = NO;
                        self.image3OutsideTableView.hidden = NO;
                        self.image4OutsideTableView.hidden = NO;
                        self.image5OutsideTableView.hidden = NO;
                        self.row7HidingView.hidden = NO;
                        self.row7HidingView.alpha = 0.3;
                        self.row8HidingView.hidden = YES;
                        self.row8HidingView.alpha = 0.0;
                        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
                        formatter.locale = [NSLocale currentLocale];
                        self.attemptsNumber.text = [formatter stringFromNumber:[NSNumber numberWithInt:7]];
                        CGFloat delta = 0;
                        CGFloat scrollHeight = self.gamePlayScrollView.frame.size.height;
                        CGFloat rowHeight = self.row8view.frame.size.height * 1.2;
                        if (scrollHeight > rowHeight) delta = self.row8view.frame.size.height / 2;
                        [self.gamePlayScrollView setContentOffset:CGPointMake(0, self.row8view.frame.origin.y - delta) animated:YES];
                        break;
                    }
                    case 8: {
                        self.row8image1.userInteractionEnabled = NO;
                        self.row8image2.userInteractionEnabled = NO;
                        self.row8image3.userInteractionEnabled = NO;
                        self.row8image4.userInteractionEnabled = NO;
                        self.row8image5.userInteractionEnabled = NO;
                        
                        self.image1OutsideTableView.hidden = NO;
                        self.image2OutsideTableView.hidden = NO;
                        self.image3OutsideTableView.hidden = NO;
                        self.image4OutsideTableView.hidden = NO;
                        self.image5OutsideTableView.hidden = NO;
                        self.row8HidingView.hidden = NO;
                        self.row8HidingView.alpha = 0.3;
                        self.row9HidingView.hidden = YES;
                        self.row9HidingView.alpha = 0.0;
                        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
                        formatter.locale = [NSLocale currentLocale];
                        self.attemptsNumber.text = [formatter stringFromNumber:[NSNumber numberWithInt:8]];
                        CGFloat delta = 0;
                        CGFloat scrollHeight = self.gamePlayScrollView.frame.size.height;
                        CGFloat rowHeight = self.row9view.frame.size.height * 1.2;
                        if (scrollHeight > rowHeight) delta = self.row9view.frame.size.height / 2;
                        [self.gamePlayScrollView setContentOffset:CGPointMake(0, self.row9view.frame.origin.y - delta) animated:YES];
                        break;
                    }
                    case 9: {
                        self.row9image1.userInteractionEnabled = NO;
                        self.row9image2.userInteractionEnabled = NO;
                        self.row9image3.userInteractionEnabled = NO;
                        self.row9image4.userInteractionEnabled = NO;
                        self.row9image5.userInteractionEnabled = NO;
                        
                        self.image1OutsideTableView.hidden = NO;
                        self.image2OutsideTableView.hidden = NO;
                        self.image3OutsideTableView.hidden = NO;
                        self.image4OutsideTableView.hidden = NO;
                        self.image5OutsideTableView.hidden = NO;
                        self.row9HidingView.hidden = NO;
                        self.row9HidingView.alpha = 0.3;
                        self.row10HidingView.hidden = YES;
                        self.row10HidingView.alpha = 0.0;
                        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
                        formatter.locale = [NSLocale currentLocale];
                        self.attemptsNumber.text = [formatter stringFromNumber:[NSNumber numberWithInt:9]];
                        CGFloat delta = 0;
                        CGFloat scrollHeight = self.gamePlayScrollView.frame.size.height;
                        CGFloat rowHeight = self.row10view.frame.size.height * 1.2;
                        if (scrollHeight > rowHeight) delta = self.row10view.frame.size.height / 2;
                        [self.gamePlayScrollView setContentOffset:CGPointMake(0, self.row10view.frame.origin.y - delta) animated:YES];
                        
                        break;
                    }
                        
                    case 10: {
                        NSLog(@"GAME OVER");
                        self.startAgainButtonTitle.text = NSLocalizedString(@"gameLoosed", @"");

                        [UIView animateWithDuration:0.5
                                              delay:0
                                            options:0
                                         animations:^{
#ifdef KidsCipherBoys
                                             self.safeImage.image = [UIImage imageNamed:@"Boy_Main_page_safe_close"];
#else
                                             self.safeImage.image = [UIImage imageNamed:@"Main_page_fon_safe"];
#endif
                                         } completion:^(BOOL finished) {
                                             [mainDelegate.gameWrongResult play];
                                             
                                             [UIView animateWithDuration:.5
                                                                   delay:0
                                                                 options:0
                                                              animations:^{
                                                                  self.startAgainButton.alpha = 1.0;
                                                                  self.startAgainButtonTitle.alpha = 1.0;
                                                                  
                                                                  
                                                              } completion:^(BOOL finished) {
                                                                  
                                                                  
                                                              }];
                                             
                                         }];
#ifdef KidsCipherBoys
                        self.frame1combination.imageView.image = [UIImage imageNamed:@"Boy_button_lock"];
                        self.frame2combination.imageView.image = [UIImage imageNamed:@"Boy_button_lock"];
                        self.frame3combination.imageView.image = [UIImage imageNamed:@"Boy_button_lock"];
                        self.frame4combination.imageView.image = [UIImage imageNamed:@"Boy_button_lock"];
#else
                        self.frame1combination.imageView.image = [UIImage imageNamed:@"button_lock"];
                        self.frame2combination.imageView.image = [UIImage imageNamed:@"button_lock"];
                        self.frame3combination.imageView.image = [UIImage imageNamed:@"button_lock"];
                        self.frame4combination.imageView.image = [UIImage imageNamed:@"button_lock"];
#endif
                        self.row10image1.userInteractionEnabled = NO;
                        self.row10image2.userInteractionEnabled = NO;
                        self.row10image3.userInteractionEnabled = NO;
                        self.row10image4.userInteractionEnabled = NO;
                        self.row10image5.userInteractionEnabled = NO;
                        
                        self.image1OutsideTableView.hidden = NO;
                        self.image2OutsideTableView.hidden = NO;
                        self.image3OutsideTableView.hidden = NO;
                        self.image4OutsideTableView.hidden = NO;
                        self.image5OutsideTableView.hidden = NO;
                        self.row10HidingView.hidden = NO;
                        self.row10HidingView.alpha = 0.3;
                        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
                        formatter.locale = [NSLocale currentLocale];
                        self.attemptsNumber.text = [formatter stringFromNumber:[NSNumber numberWithInt:9]];
                        CGFloat delta = 0;
                        CGFloat scrollHeight = self.gamePlayScrollView.frame.size.height;
                        CGFloat rowHeight = self.row10view.frame.size.height * 1.2;
                        if (scrollHeight > rowHeight) delta = self.row10view.frame.size.height / 2;
                        [self.gamePlayScrollView setContentOffset:CGPointMake(0, self.row10view.frame.origin.y - delta) animated:YES];

                        
                        [mainDelegate.gameTimer invalidate];
                        //self.beginTrainingButtonTitle.text = NSLocalizedString(@"beginTrainingButtonTitle", @"");
                        //self.beginGameButtonTitle.text = NSLocalizedString(@"beginGameButtonTitle", @"");
                        //[mainDelegate setRandomCombinationForCurrentGame];
                        [mainDelegate setAllRowFilledForGameSuccess];
                        activeRow.game.activeRowNumber = [NSNumber numberWithInteger:9];
                        [mainDelegate saveContext];
                        [self updateAllViews];

                        //mainDelegate.gameTimer = nil;
                        mainDelegate.gameTimerSeconds = 0;
                        self.frame1combination.hidden = YES;
                        self.frame2combination.hidden = YES;
                        self.frame3combination.hidden = YES;
                        self.frame4combination.hidden = YES;
                        

                        break;
                    }
                    default:
                        break;
                }
            }
            activeRow = [mainDelegate getActiveRow];

             frameToReturnMainImage1 = CGPointFromString(activeRow.game.mainDraggedImage1startingPoint);
            NSLog(@"activeRowNumber->%@ frameToReturnMainImage1->%@",activeRow.game.activeRowNumber,activeRow.game.mainDraggedImage1startingPoint);

            self.image1OutsideTableView.frame = CGRectMake(frameToReturnMainImage1.x,
                                                           frameToReturnMainImage1.y,
                                                           self.image1OutsideTableView.frame.size.width,
                                                           self.image1OutsideTableView.frame.size.height);
            self.image1OutsideTableView.alpha = 0.0;
             frameToReturnMainImage2 = CGPointFromString(activeRow.game.mainDraggedImage2startingPoint);
            self.image2OutsideTableView.frame = CGRectMake(frameToReturnMainImage2.x,
                                                           frameToReturnMainImage2.y,
                                                           self.image2OutsideTableView.frame.size.width,
                                                           self.image2OutsideTableView.frame.size.height);
            self.image2OutsideTableView.alpha = 0.0;

             frameToReturnMainImage3 = CGPointFromString(activeRow.game.mainDraggedImage3startingPoint);
            self.image3OutsideTableView.frame = CGRectMake(frameToReturnMainImage3.x,
                                                           frameToReturnMainImage3.y,
                                                           self.image3OutsideTableView.frame.size.width,
                                                           self.image3OutsideTableView.frame.size.height);
            self.image3OutsideTableView.alpha = 0.0;

             frameToReturnMainImage4 = CGPointFromString(activeRow.game.mainDraggedImage4startingPoint);
            self.image4OutsideTableView.frame = CGRectMake(frameToReturnMainImage4.x,
                                                           frameToReturnMainImage4.y,
                                                           self.image4OutsideTableView.frame.size.width,
                                                           self.image4OutsideTableView.frame.size.height);
            self.image4OutsideTableView.alpha = 0.0;

             frameToReturnMainImage5 = CGPointFromString(activeRow.game.mainDraggedImage5startingPoint);
            self.image5OutsideTableView.frame = CGRectMake(frameToReturnMainImage5.x,
                                                           frameToReturnMainImage5.y,
                                                           self.image5OutsideTableView.frame.size.width,
                                                           self.image5OutsideTableView.frame.size.height);
            self.image5OutsideTableView.alpha = 0.0;

            
            
        });
        
        sleep(2);
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            mainDelegate.isNewRowProcessing = NO;

            self.image1OutsideTableView.frame = CGRectMake(frameToReturnMainImage1.x,
                                                           frameToReturnMainImage1.y,
                                                           self.image1OutsideTableView.frame.size.width,
                                                           self.image1OutsideTableView.frame.size.height);
            self.image1OutsideTableView.alpha = 0.0;
            self.image2OutsideTableView.frame = CGRectMake(frameToReturnMainImage2.x,
                                                           frameToReturnMainImage2.y,
                                                           self.image2OutsideTableView.frame.size.width,
                                                           self.image2OutsideTableView.frame.size.height);
            self.image2OutsideTableView.alpha = 0.0;
            self.image3OutsideTableView.frame = CGRectMake(frameToReturnMainImage3.x,
                                                           frameToReturnMainImage3.y,
                                                           self.image3OutsideTableView.frame.size.width,
                                                           self.image3OutsideTableView.frame.size.height);
            self.image3OutsideTableView.alpha = 0.0;
            self.image4OutsideTableView.frame = CGRectMake(frameToReturnMainImage4.x,
                                                           frameToReturnMainImage4.y,
                                                           self.image4OutsideTableView.frame.size.width,
                                                           self.image4OutsideTableView.frame.size.height);
            self.image4OutsideTableView.alpha = 0.0;
            self.image5OutsideTableView.frame = CGRectMake(frameToReturnMainImage5.x,
                                                           frameToReturnMainImage5.y,
                                                           self.image5OutsideTableView.frame.size.width,
                                                           self.image5OutsideTableView.frame.size.height);
            self.image5OutsideTableView.alpha = 0.0;

            self.image1OutsideTableView.hidden = NO;
            self.image2OutsideTableView.hidden = NO;
            self.image3OutsideTableView.hidden = NO;
            self.image4OutsideTableView.hidden = NO;
            self.image5OutsideTableView.hidden = NO;

            [UIView animateWithDuration:0.5
                                  delay:0
                                options:0
                             animations:^{
                                 self.image1OutsideTableView.alpha = 1.0;
                                 self.image2OutsideTableView.alpha = 1.0;
                                 self.image3OutsideTableView.alpha = 1.0;
                                 self.image4OutsideTableView.alpha = 1.0;
                                 self.image5OutsideTableView.alpha = 1.0;
                                 
                             } completion:^(BOOL finished) {
                                 self.isAutorotate = YES;

                             }];
        });
        //self.isRowCompletedProcessing = [NSNumber numberWithBool:NO];
    });
    //}
    
}
#pragma mark - UIImagePickerController delegate
static CGRect swapWidthAndHeight(CGRect rect)
{
    CGFloat  swap = rect.size.width;
    rect.size.width  = rect.size.height;
    rect.size.height = swap;
    return rect;
}


-(UIImage*)rotate:(UIImageOrientation)orient image:(UIImage *)image
{
    CGRect             bnds = CGRectZero;
    UIImage*           copy = nil;
    CGContextRef       ctxt = nil;
    CGImageRef         imag = image.CGImage;
    CGRect             rect = CGRectZero;
    CGAffineTransform  tran = CGAffineTransformIdentity;
    
    rect.size.width  = CGImageGetWidth(imag);
    rect.size.height = CGImageGetHeight(imag);
    
    bnds = rect;
    
    switch (orient)
    {
        case UIImageOrientationUp:
            // would get you an exact copy of the original
            assert(false);
            return nil;
            
        case UIImageOrientationUpMirrored:
            tran = CGAffineTransformMakeTranslation(rect.size.width, 0.0);
            tran = CGAffineTransformScale(tran, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown:
            tran = CGAffineTransformMakeTranslation(rect.size.width,
                                                    rect.size.height);
            tran = CGAffineTransformRotate(tran, M_PI);
            break;
            
        case UIImageOrientationDownMirrored:
            tran = CGAffineTransformMakeTranslation(0.0, rect.size.height);
            tran = CGAffineTransformScale(tran, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeft:
            bnds = swapWidthAndHeight(bnds);
            tran = CGAffineTransformMakeTranslation(0.0, rect.size.width);
            tran = CGAffineTransformRotate(tran, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeftMirrored:
            bnds = swapWidthAndHeight(bnds);
            tran = CGAffineTransformMakeTranslation(rect.size.height,
                                                    rect.size.width);
            tran = CGAffineTransformScale(tran, -1.0, 1.0);
            tran = CGAffineTransformRotate(tran, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRight:
            bnds = swapWidthAndHeight(bnds);
            tran = CGAffineTransformMakeTranslation(rect.size.height, 0.0);
            tran = CGAffineTransformRotate(tran, M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored:
            bnds = swapWidthAndHeight(bnds);
            tran = CGAffineTransformMakeScale(-1.0, 1.0);
            tran = CGAffineTransformRotate(tran, M_PI / 2.0);
            break;
            
        default:
            // orientation value supplied is invalid
            assert(false);
            return nil;
    }
    
    UIGraphicsBeginImageContext(bnds.size);
    ctxt = UIGraphicsGetCurrentContext();
    
    switch (orient)
    {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextScaleCTM(ctxt, -1.0, 1.0);
            CGContextTranslateCTM(ctxt, -rect.size.height, 0.0);
            break;
            
        default:
            CGContextScaleCTM(ctxt, 1.0, -1.0);
            CGContextTranslateCTM(ctxt, 0.0, -rect.size.height);
            break;
    }
    
    CGContextConcatCTM(ctxt, tran);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), rect, imag);
    
    copy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return copy;
}

-(UIImage*)resizedImage:(UIImage *)image toSize:(CGSize)dstSize
{
	CGImageRef imgRef = image.CGImage;
	// the below values are regardless of orientation : for UIImages from Camera, width>height (landscape)
	CGSize  srcSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef)); // not equivalent to self.size (which is dependant on the imageOrientation)!
    
	CGFloat scaleRatio = dstSize.width / srcSize.width;
	UIImageOrientation orient = image.imageOrientation;
	CGAffineTransform transform = CGAffineTransformIdentity;
	switch(orient) {
            
		case UIImageOrientationUp: //EXIF = 1
			transform = CGAffineTransformIdentity;
			break;
            
		case UIImageOrientationUpMirrored: //EXIF = 2
			transform = CGAffineTransformMakeTranslation(srcSize.width, 0.0);
			transform = CGAffineTransformScale(transform, -1.0, 1.0);
			break;
            
		case UIImageOrientationDown: //EXIF = 3
			transform = CGAffineTransformMakeTranslation(srcSize.width, srcSize.height);
			transform = CGAffineTransformRotate(transform, M_PI);
			break;
            
		case UIImageOrientationDownMirrored: //EXIF = 4
			transform = CGAffineTransformMakeTranslation(0.0, srcSize.height);
			transform = CGAffineTransformScale(transform, 1.0, -1.0);
			break;
            
		case UIImageOrientationLeftMirrored: //EXIF = 5
			dstSize = CGSizeMake(dstSize.height, dstSize.width);
			transform = CGAffineTransformMakeTranslation(srcSize.height, srcSize.width);
			transform = CGAffineTransformScale(transform, -1.0, 1.0);
			transform = CGAffineTransformRotate(transform, 3.0 * M_PI_2);
			break;
            
		case UIImageOrientationLeft: //EXIF = 6
			dstSize = CGSizeMake(dstSize.height, dstSize.width);
			transform = CGAffineTransformMakeTranslation(0.0, srcSize.width);
			transform = CGAffineTransformRotate(transform, 3.0 * M_PI_2);
			break;
            
		case UIImageOrientationRightMirrored: //EXIF = 7
			dstSize = CGSizeMake(dstSize.height, dstSize.width);
			transform = CGAffineTransformMakeScale(-1.0, 1.0);
			transform = CGAffineTransformRotate(transform, M_PI_2);
			break;
            
		case UIImageOrientationRight: //EXIF = 8
			dstSize = CGSizeMake(dstSize.height, dstSize.width);
			transform = CGAffineTransformMakeTranslation(srcSize.height, 0.0);
			transform = CGAffineTransformRotate(transform, M_PI_2);
			break;
            
		default:
			[NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
	}
    
	/////////////////////////////////////////////////////////////////////////////
	// The actual resize: draw the image on a new context, applying a transform matrix
	UIGraphicsBeginImageContextWithOptions(dstSize, NO, 0.0);
    
	CGContextRef context = UIGraphicsGetCurrentContext();
    
	if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
		CGContextScaleCTM(context, -scaleRatio, scaleRatio);
		CGContextTranslateCTM(context, -srcSize.height, 0);
	} else {
		CGContextScaleCTM(context, scaleRatio, -scaleRatio);
		CGContextTranslateCTM(context, 0, -srcSize.height);
	}
    
	CGContextConcatCTM(context, transform);
    
	// we use srcSize (and not dstSize) as the size to specify is in user space (and we use the CTM to apply a scaleRatio)
	CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, srcSize.width, srcSize.height), imgRef);
	UIImage* resizedImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
    
	return resizedImage;
}

-(UIImage*)resizedImage:(UIImage *)image toFitInSize:(CGSize)boundingSize scaleIfSmaller:(BOOL)scale
{
	// get the image size (independant of imageOrientation)
	CGImageRef imgRef = image.CGImage;
	CGSize srcSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef)); // not equivalent to self.size (which depends on the imageOrientation)!
    
	// adjust boundingSize to make it independant on imageOrientation too for farther computations
	UIImageOrientation orient = image.imageOrientation;
	switch (orient) {
		case UIImageOrientationLeft:
		case UIImageOrientationRight:
		case UIImageOrientationLeftMirrored:
		case UIImageOrientationRightMirrored:
			boundingSize = CGSizeMake(boundingSize.height, boundingSize.width);
			break;
        default:
            // NOP
            break;
	}
    
	// Compute the target CGRect in order to keep aspect-ratio
	CGSize dstSize;
    
	if ( !scale && (srcSize.width < boundingSize.width) && (srcSize.height < boundingSize.height) ) {
		//NSLog(@"Image is smaller, and we asked not to scale it in this case (scaleIfSmaller:NO)");
		dstSize = srcSize; // no resize (we could directly return 'self' here, but we draw the image anyway to take image orientation into account)
	} else {
		CGFloat wRatio = boundingSize.width / srcSize.width;
		CGFloat hRatio = boundingSize.height / srcSize.height;
        
		if (wRatio < hRatio) {
			//NSLog(@"Width imposed, Height scaled ; ratio = %f",wRatio);
			dstSize = CGSizeMake(boundingSize.width, floorf(srcSize.height * wRatio));
		} else {
			//NSLog(@"Height imposed, Width scaled ; ratio = %f",hRatio);
			dstSize = CGSizeMake(floorf(srcSize.width * hRatio), boundingSize.height);
		}
	}
    
	return [self resizedImage:image toSize:dstSize];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"didFinishPickingMediaWithInfo->%@",info);
    UIImage *originalImage, *editedImage, *rotatedImage;
    editedImage = (UIImage *)[info objectForKey:UIImagePickerControllerEditedImage];
    originalImage = (UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];
    if (editedImage) rotatedImage = [self rotate:UIImageOrientationRight image:editedImage];
    else rotatedImage = [self rotate:UIImageOrientationRight image:originalImage];
    UIImage *resizedImage = [self resizedImage:rotatedImage toFitInSize:CGSizeMake(132, 132) scaleIfSmaller:YES];
    NSData *resizedData = UIImagePNGRepresentation(resizedImage);
    //UIImage *picked = [info valueForKey:UIImagePickerControllerOriginalImage];
    //NSData *pickedData = UIImagePNGRepresentation(rotatedImage);
    //NSData *imageData = [[NSData alloc] initWithData:UIImageJPEGRepresentation((picked), 0.5)];
    //int imageSize = resizedData.length;
    //NSLog(@"SIZE OF IMAGE: %i ", imageSize);
    if (resizedData) {
        [[NSUserDefaults standardUserDefaults] setObject:resizedData forKey:@"clientPicture"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[self.photoView layer] setBorderColor:[self.playerName.textColor CGColor]];
        [[self.photoView layer] setBorderWidth:1.75];
        [[self.photoView layer] setCornerRadius:5];
        [[self.photoView layer] setMasksToBounds:YES];
        [self.photoView setImage:[UIImage imageWithData:resizedData] forState:UIControlStateNormal];

    }
    [picker dismissModalViewControllerAnimated:YES];
    if (self.pop) [self.pop dismissPopoverAnimated:YES];

}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //NSLog(@"imagePickerControllerDidCancel->");
    NSData *pickedData = [[NSUserDefaults standardUserDefaults] objectForKey:@"clientPicture"];
    if (pickedData) {
        [[self.photoView layer] setBorderColor:[[UIColor purpleColor] CGColor]];
        [[self.photoView layer] setBorderWidth:1.75];
        [[self.photoView layer] setCornerRadius:5];
        [[self.photoView layer] setMasksToBounds:YES];
        [self.photoView setImage:[UIImage imageWithData:pickedData] forState:UIControlStateNormal];
    }
    else {
        
#ifdef KidsCipherBoys
        self.photoView.imageView.image = [UIImage imageNamed:@"button_avatar_boy"];
#else
        self.photoView.imageView.image = [UIImage imageNamed:@"button_avatar"];
        
#endif

        [[self.photoView layer] setBorderWidth:0];
        [[self.photoView layer] setCornerRadius:0];
    }
    [picker dismissModalViewControllerAnimated:YES];
    if (self.pop) [self.pop dismissPopoverAnimated:YES];

}

- (void)viewDidUnload {
    [self setRow1HidingView:nil];
    [self setRow2HidingView:nil];
    [self setRow1MatchedColorsAndPositions:nil];
    [self setRow1MatchedColors:nil];
    [self setRow2view:nil];
    [self setRow2frame2:nil];
    [self setRow2frame3:nil];
    [self setRow2frame4:nil];
    [self setRow2image1:nil];
    [self setRow2image2:nil];
    [self setRow2image4:nil];
    [self setRow2image5:nil];
    [self setRow1MatchedColorsAndPositions:nil];
    [self setImage1combination:nil];
    [self setImage2combination:nil];
    [self setImage3combination:nil];
    [self setImage4combination:nil];
    [self setImage5combination:nil];
    [self setFrame1combination:nil];
    [self setFrame2combination:nil];
    [self setFrame3combination:nil];
    [self setFrame4combination:nil];
    [self setPlayerName:nil];
    [self setAttemptsTitle:nil];
    [self setAttemptsNumber:nil];
    [self setGameTimeMainTitle:nil];
    [self setGameTimeMinutes:nil];
    [self setGameTimeMinutesTitle:nil];
    [self setGameTimeSeconds:nil];
    [self setGameTimeSecondsTitle:nil];
    [self setBeginGameButtonTitle:nil];
    [self setBeginTrainingButtonTitle:nil];
    [self setCombinationTitle:nil];
    [self setRow1MatchedColorsTitle:nil];
    [self setRow1MatchedColorsAndPositionsTitle:nil];
    [self setRow2MatchedColorsAndPositionsTitle:nil];
    [self setRow2MatchedColorsTitle:nil];
    [self setMainPageBackground:nil];
    [self setMainPageScrollBackground:nil];
    [self setSafeImage:nil];
    [self setMainPageGameBackground:nil];
    [self setRow1CheckImage1:nil];
    [self setRow1CheckImage2:nil];
    [self setRow1CheckImage3:nil];
    [self setRow1CheckImage4:nil];
    [self setIntroFinger:nil];
    [self setIntroDescription:nil];
    [self setIntroCloseButton:nil];
    [self setBeginGameButton:nil];
    [self setBeginTragingButton:nil];
    [self setInformationButton:nil];
    [self setStartAgainButton:nil];
    [self setStartAgainButtonTitle:nil];
    [super viewDidUnload];
}
@end
