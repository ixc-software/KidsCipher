//
//  CipherViewCell.h
//  KidsCipher
//
//  Created by Oleksii Vynogradov on 4/29/13.
//  Copyright (c) 2013 IXC-USA Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AVImageView.h"

@interface CipherViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *hidingView;
@property (weak, nonatomic) IBOutlet UIButton *frame1;
@property (weak, nonatomic) IBOutlet UIButton *frame2;
@property (weak, nonatomic) IBOutlet UIButton *frame3;
@property (weak, nonatomic) IBOutlet UIButton *frame4;
@property (unsafe_unretained) IBOutlet AVImageView *image1InsideTableView;
@property (unsafe_unretained) IBOutlet AVImageView *image2InsideTableView;
@property (unsafe_unretained) IBOutlet AVImageView *image3InsideTableView;
@property (unsafe_unretained) IBOutlet AVImageView *image4InsideTableView;
@property (unsafe_unretained) IBOutlet AVImageView *image5InsideTableView;
@property (strong) id controller;
@property (strong) NSIndexPath *indexPath;

@end
