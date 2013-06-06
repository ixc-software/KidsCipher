//
//  CipherViewController.h
//  KidsCipher
//
//  Created by Oleksii Vynogradov on 4/29/13.
//  Copyright (c) 2013 IXC-USA Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AVImageView.h"
//#import "GameRow.h"

@interface CipherViewController : UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate>
//@property (weak, nonatomic) IBOutlet UITableView *gameTableView;
@property (readwrite) CGRect frameSelectedRow;

@property (retain, nonatomic) IBOutlet AVImageView *image1OutsideTableView;
@property (retain, nonatomic) IBOutlet AVImageView *image2OutsideTableView;
@property (retain, nonatomic) IBOutlet AVImageView *image3OutsideTableView;
@property (retain, nonatomic) IBOutlet AVImageView *image4OutsideTableView;
@property (retain, nonatomic) IBOutlet AVImageView *image5OutsideTableView;
@property (weak, nonatomic) IBOutlet AVImageView *image1combination;
@property (weak, nonatomic) IBOutlet AVImageView *image2combination;
@property (weak, nonatomic) IBOutlet AVImageView *image3combination;
@property (weak, nonatomic) IBOutlet AVImageView *image4combination;
@property (weak, nonatomic) IBOutlet AVImageView *image5combination;
@property (weak, nonatomic) IBOutlet UIButton *frame1combination;
@property (weak, nonatomic) IBOutlet UIButton *frame2combination;
@property (weak, nonatomic) IBOutlet UIButton *frame3combination;
@property (weak, nonatomic) IBOutlet UIButton *frame4combination;

@property (retain, nonatomic) IBOutlet UIButton *photoView;
@property (retain, nonatomic) UIPopoverController *pop;
@property (retain, nonatomic) IBOutlet UIScrollView *gamePlayScrollView;
/* --------------------------------- ROW 1 START --------------------- */
@property (retain, nonatomic) IBOutlet UIView *row1view;
@property (retain, nonatomic) IBOutlet UIButton *row1frame1;
@property (retain, nonatomic) IBOutlet UIButton *row1frame2;
@property (retain, nonatomic) IBOutlet UIButton *row1frame3;
@property (retain, nonatomic) IBOutlet UIButton *row1frame4;
@property (retain, nonatomic) IBOutlet AVImageView *row1image1;
@property (retain, nonatomic) IBOutlet AVImageView *row1image2;
@property (retain, nonatomic) IBOutlet AVImageView *row1image3;
@property (retain, nonatomic) IBOutlet AVImageView *row1image4;
@property (retain, nonatomic) IBOutlet AVImageView *row1image5;
@property (weak, nonatomic) IBOutlet UILabel *row1MatchedColorsAndPositions;
@property (weak, nonatomic) IBOutlet UILabel *row1MatchedColorsAndPositionsTitle;
@property (weak, nonatomic) IBOutlet UILabel *row1MatchedColors;
@property (weak, nonatomic) IBOutlet UILabel *row1MatchedColorsTitle;
@property (retain, nonatomic) IBOutlet UIView *row1HidingView;

/* --------------------------------- ROW 1 FINISH --------------------- */

/* --------------------------------- ROW 2 START --------------------- */
@property (weak, nonatomic) IBOutlet UIView *row2view;
@property (weak, nonatomic) IBOutlet UIButton *row2frame1;
@property (weak, nonatomic) IBOutlet UIButton *row2frame2;
@property (weak, nonatomic) IBOutlet UIButton *row2frame3;
@property (weak, nonatomic) IBOutlet UIButton *row2frame4;
@property (weak, nonatomic) IBOutlet AVImageView *row2image1;
@property (weak, nonatomic) IBOutlet AVImageView *row2image2;
@property (weak, nonatomic) IBOutlet AVImageView *row2image3;
@property (weak, nonatomic) IBOutlet AVImageView *row2image4;
@property (weak, nonatomic) IBOutlet AVImageView *row2image5;
@property (weak, nonatomic) IBOutlet UILabel *row2MatchedColorsAndPositions;
@property (weak, nonatomic) IBOutlet UILabel *row2MatchedColorsAndPositionsTitle;
@property (weak, nonatomic) IBOutlet UILabel *row2MatchedColors;
@property (weak, nonatomic) IBOutlet UILabel *row2MatchedColorsTitle;
@property (retain, nonatomic) IBOutlet UIView *row2HidingView;
/* --------------------------------- ROW 2 FINISH --------------------- */

/* --------------------------------- ROW 3 START --------------------- */
@property (weak, nonatomic) IBOutlet UIView *row3view;
@property (weak, nonatomic) IBOutlet UIButton *row3frame1;
@property (weak, nonatomic) IBOutlet UIButton *row3frame2;
@property (weak, nonatomic) IBOutlet UIButton *row3frame3;
@property (weak, nonatomic) IBOutlet UIButton *row3frame4;
@property (weak, nonatomic) IBOutlet AVImageView *row3image1;
@property (weak, nonatomic) IBOutlet AVImageView *row3image2;
@property (weak, nonatomic) IBOutlet AVImageView *row3image3;
@property (weak, nonatomic) IBOutlet AVImageView *row3image4;
@property (weak, nonatomic) IBOutlet AVImageView *row3image5;
@property (weak, nonatomic) IBOutlet UILabel *row3MatchedColorsAndPositions;
@property (weak, nonatomic) IBOutlet UILabel *row3MatchedColorsAndPositionsTitle;
@property (weak, nonatomic) IBOutlet UILabel *row3MatchedColors;
@property (weak, nonatomic) IBOutlet UILabel *row3MatchedColorsTitle;
@property (retain, nonatomic) IBOutlet UIView *row3HidingView;
/* --------------------------------- ROW 3 FINISH --------------------- */

/* --------------------------------- ROW 4 START --------------------- */
@property (weak, nonatomic) IBOutlet UIView *row4view;
@property (weak, nonatomic) IBOutlet UIButton *row4frame1;
@property (weak, nonatomic) IBOutlet UIButton *row4frame2;
@property (weak, nonatomic) IBOutlet UIButton *row4frame3;
@property (weak, nonatomic) IBOutlet UIButton *row4frame4;
@property (weak, nonatomic) IBOutlet AVImageView *row4image1;
@property (weak, nonatomic) IBOutlet AVImageView *row4image2;
@property (weak, nonatomic) IBOutlet AVImageView *row4image3;
@property (weak, nonatomic) IBOutlet AVImageView *row4image4;
@property (weak, nonatomic) IBOutlet AVImageView *row4image5;
@property (weak, nonatomic) IBOutlet UILabel *row4MatchedColorsAndPositions;
@property (weak, nonatomic) IBOutlet UILabel *row4MatchedColorsAndPositionsTitle;
@property (weak, nonatomic) IBOutlet UILabel *row4MatchedColors;
@property (weak, nonatomic) IBOutlet UILabel *row4MatchedColorsTitle;
@property (retain, nonatomic) IBOutlet UIView *row4HidingView;
/* --------------------------------- ROW 4 FINISH --------------------- */

/* --------------------------------- ROW 5 START --------------------- */
@property (weak, nonatomic) IBOutlet UIView *row5view;
@property (weak, nonatomic) IBOutlet UIButton *row5frame1;
@property (weak, nonatomic) IBOutlet UIButton *row5frame2;
@property (weak, nonatomic) IBOutlet UIButton *row5frame3;
@property (weak, nonatomic) IBOutlet UIButton *row5frame4;
@property (weak, nonatomic) IBOutlet AVImageView *row5image1;
@property (weak, nonatomic) IBOutlet AVImageView *row5image2;
@property (weak, nonatomic) IBOutlet AVImageView *row5image3;
@property (weak, nonatomic) IBOutlet AVImageView *row5image4;
@property (weak, nonatomic) IBOutlet AVImageView *row5image5;
@property (weak, nonatomic) IBOutlet UILabel *row5MatchedColorsAndPositions;
@property (weak, nonatomic) IBOutlet UILabel *row5MatchedColorsAndPositionsTitle;
@property (weak, nonatomic) IBOutlet UILabel *row5MatchedColors;
@property (weak, nonatomic) IBOutlet UILabel *row5MatchedColorsTitle;
@property (retain, nonatomic) IBOutlet UIView *row5HidingView;
/* --------------------------------- ROW 5 FINISH --------------------- */

/* --------------------------------- ROW 6 START --------------------- */
@property (weak, nonatomic) IBOutlet UIView *row6view;
@property (weak, nonatomic) IBOutlet UIButton *row6frame1;
@property (weak, nonatomic) IBOutlet UIButton *row6frame2;
@property (weak, nonatomic) IBOutlet UIButton *row6frame3;
@property (weak, nonatomic) IBOutlet UIButton *row6frame4;
@property (weak, nonatomic) IBOutlet AVImageView *row6image1;
@property (weak, nonatomic) IBOutlet AVImageView *row6image2;
@property (weak, nonatomic) IBOutlet AVImageView *row6image3;
@property (weak, nonatomic) IBOutlet AVImageView *row6image4;
@property (weak, nonatomic) IBOutlet AVImageView *row6image5;
@property (weak, nonatomic) IBOutlet UILabel *row6MatchedColorsAndPositions;
@property (weak, nonatomic) IBOutlet UILabel *row6MatchedColorsAndPositionsTitle;
@property (weak, nonatomic) IBOutlet UILabel *row6MatchedColors;
@property (weak, nonatomic) IBOutlet UILabel *row6MatchedColorsTitle;
@property (retain, nonatomic) IBOutlet UIView *row6HidingView;
/* --------------------------------- ROW 6 FINISH --------------------- */

/* --------------------------------- ROW 7 START --------------------- */
@property (weak, nonatomic) IBOutlet UIView *row7view;
@property (weak, nonatomic) IBOutlet UIButton *row7frame1;
@property (weak, nonatomic) IBOutlet UIButton *row7frame2;
@property (weak, nonatomic) IBOutlet UIButton *row7frame3;
@property (weak, nonatomic) IBOutlet UIButton *row7frame4;
@property (weak, nonatomic) IBOutlet AVImageView *row7image1;
@property (weak, nonatomic) IBOutlet AVImageView *row7image2;
@property (weak, nonatomic) IBOutlet AVImageView *row7image3;
@property (weak, nonatomic) IBOutlet AVImageView *row7image4;
@property (weak, nonatomic) IBOutlet AVImageView *row7image5;
@property (weak, nonatomic) IBOutlet UILabel *row7MatchedColorsAndPositions;
@property (weak, nonatomic) IBOutlet UILabel *row7MatchedColorsAndPositionsTitle;
@property (weak, nonatomic) IBOutlet UILabel *row7MatchedColors;
@property (weak, nonatomic) IBOutlet UILabel *row7MatchedColorsTitle;
@property (retain, nonatomic) IBOutlet UIView *row7HidingView;
/* --------------------------------- ROW 7 FINISH --------------------- */

/* --------------------------------- ROW 8 START --------------------- */
@property (weak, nonatomic) IBOutlet UIView *row8view;
@property (weak, nonatomic) IBOutlet UIButton *row8frame1;
@property (weak, nonatomic) IBOutlet UIButton *row8frame2;
@property (weak, nonatomic) IBOutlet UIButton *row8frame3;
@property (weak, nonatomic) IBOutlet UIButton *row8frame4;
@property (weak, nonatomic) IBOutlet AVImageView *row8image1;
@property (weak, nonatomic) IBOutlet AVImageView *row8image2;
@property (weak, nonatomic) IBOutlet AVImageView *row8image3;
@property (weak, nonatomic) IBOutlet AVImageView *row8image4;
@property (weak, nonatomic) IBOutlet AVImageView *row8image5;
@property (weak, nonatomic) IBOutlet UILabel *row8MatchedColorsAndPositions;
@property (weak, nonatomic) IBOutlet UILabel *row8MatchedColorsAndPositionsTitle;
@property (weak, nonatomic) IBOutlet UILabel *row8MatchedColors;
@property (weak, nonatomic) IBOutlet UILabel *row8MatchedColorsTitle;
@property (retain, nonatomic) IBOutlet UIView *row8HidingView;
/* --------------------------------- ROW 8 FINISH --------------------- */

/* --------------------------------- ROW 9 START --------------------- */
@property (weak, nonatomic) IBOutlet UIView *row9view;
@property (weak, nonatomic) IBOutlet UIButton *row9frame1;
@property (weak, nonatomic) IBOutlet UIButton *row9frame2;
@property (weak, nonatomic) IBOutlet UIButton *row9frame3;
@property (weak, nonatomic) IBOutlet UIButton *row9frame4;
@property (weak, nonatomic) IBOutlet AVImageView *row9image1;
@property (weak, nonatomic) IBOutlet AVImageView *row9image2;
@property (weak, nonatomic) IBOutlet AVImageView *row9image3;
@property (weak, nonatomic) IBOutlet AVImageView *row9image4;
@property (weak, nonatomic) IBOutlet AVImageView *row9image5;
@property (weak, nonatomic) IBOutlet UILabel *row9MatchedColorsAndPositions;
@property (weak, nonatomic) IBOutlet UILabel *row9MatchedColorsAndPositionsTitle;
@property (weak, nonatomic) IBOutlet UILabel *row9MatchedColors;
@property (weak, nonatomic) IBOutlet UILabel *row9MatchedColorsTitle;
@property (retain, nonatomic) IBOutlet UIView *row9HidingView;
/* --------------------------------- ROW 9 FINISH --------------------- */

/* --------------------------------- ROW 10 START --------------------- */
@property (weak, nonatomic) IBOutlet UIView *row10view;
@property (weak, nonatomic) IBOutlet UIButton *row10frame1;
@property (weak, nonatomic) IBOutlet UIButton *row10frame2;
@property (weak, nonatomic) IBOutlet UIButton *row10frame3;
@property (weak, nonatomic) IBOutlet UIButton *row10frame4;
@property (weak, nonatomic) IBOutlet AVImageView *row10image1;
@property (weak, nonatomic) IBOutlet AVImageView *row10image2;
@property (weak, nonatomic) IBOutlet AVImageView *row10image3;
@property (weak, nonatomic) IBOutlet AVImageView *row10image4;
@property (weak, nonatomic) IBOutlet AVImageView *row10image5;
@property (weak, nonatomic) IBOutlet UILabel *row10MatchedColorsAndPositions;
@property (weak, nonatomic) IBOutlet UILabel *row10MatchedColorsAndPositionsTitle;
@property (weak, nonatomic) IBOutlet UILabel *row10MatchedColors;
@property (weak, nonatomic) IBOutlet UILabel *row10MatchedColorsTitle;
@property (retain, nonatomic) IBOutlet UIView *row10HidingView;
/* --------------------------------- ROW 10 FINISH --------------------- */


//@property (retain, nonatomic) NSTimer *gameTimer;
//@property (retain) NSDate *gameStartTime;
//@property (readwrite) NSUInteger gameTimerSeconds;

@property (weak, nonatomic) IBOutlet UILabel *playerName;
@property (weak, nonatomic) IBOutlet UILabel *attemptsTitle;
@property (weak, nonatomic) IBOutlet UILabel *attemptsNumber;
@property (weak, nonatomic) IBOutlet UILabel *gameTimeMainTitle;
@property (weak, nonatomic) IBOutlet UILabel *gameTimeMinutes;
@property (weak, nonatomic) IBOutlet UILabel *gameTimeMinutesTitle;
@property (weak, nonatomic) IBOutlet UILabel *gameTimeSeconds;
@property (weak, nonatomic) IBOutlet UILabel *gameTimeSecondsTitle;

@property (weak, nonatomic) IBOutlet UILabel *beginGameButtonTitle;
@property (weak, nonatomic) IBOutlet UILabel *beginTrainingButtonTitle;
@property (weak, nonatomic) IBOutlet UILabel *combinationTitle;
-(void)startCompletingCurrentRowAndOpenNext;
@property (weak, nonatomic) IBOutlet UIImageView *mainPageBackground;
@property (weak, nonatomic) IBOutlet UIImageView *mainPageScrollBackground;
@property (weak, nonatomic) IBOutlet UIImageView *safeImage;

@property (readwrite) BOOL isViewDidLoadPassed;

@property (readwrite) BOOL isAutorotate;

//@property (nonatomic) NSNumber *isRowCompletedProcessing;

@end
