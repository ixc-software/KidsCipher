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
@property (weak, nonatomic) IBOutlet UIButton *chooseFirst;
@property (weak, nonatomic) IBOutlet UIButton *chooseSecond;
@property (weak, nonatomic) IBOutlet UIButton *chooseThird;
@property (weak, nonatomic) IBOutlet UIButton *chooseFourth;
@property (weak, nonatomic) IBOutlet AVImageView *chooseOne;
@property (strong) id controller;
@property (strong) NSIndexPath *indexPath;

@end
