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
@property (weak, nonatomic) IBOutlet UILabel *row1MatchedColors;

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
@property (weak, nonatomic) IBOutlet UILabel *row2MatchedColors;

-(void)startCompletingCurrentRowAndOpenNext;

@end
