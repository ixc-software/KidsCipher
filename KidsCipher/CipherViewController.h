//
//  CipherViewController.h
//  KidsCipher
//
//  Created by Oleksii Vynogradov on 4/29/13.
//  Copyright (c) 2013 IXC-USA Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AVImageView.h"

@interface CipherViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *gameTableView;
@property (readwrite) CGRect frameSelectedCell;
@property (weak, nonatomic) IBOutlet AVImageView *imageOneOutsideTableView;
@property (strong) AVImageView *imageOneInsideTableView;
@property (readwrite) CGRect frameOne;
@property (readwrite) CGRect frameOneInsideCell;

@property (retain) NSArray *currentCombination;

@end
