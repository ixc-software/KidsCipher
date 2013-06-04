//
//  CipherInfoViewCell.h
//  KidsCipher
//
//  Created by Oleksii Vynogradov on 5/3/13.
//  Copyright (c) 2013 IXC-USA Corp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CipherInfoViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *level;
@property (weak, nonatomic) IBOutlet UILabel *attemps;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UIImageView *levelStarFirst;
@property (weak, nonatomic) IBOutlet UIImageView *levelStarSecond;
@property (weak, nonatomic) IBOutlet UIImageView *levelStarThird;

@end
