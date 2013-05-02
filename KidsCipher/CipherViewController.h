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

@property (retain, nonatomic) IBOutlet UIButton *photoView;
@property (retain, nonatomic) UIPopoverController *pop;

@property (retain) NSArray *currentCombination;
//@property (nonatomic, retain) NSIndexPath *nextRowToFill;
@property (readwrite) NSUInteger selectedRowNumber;
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
-(void)startCompletingCurrentRowAndOpenNext;

@end
