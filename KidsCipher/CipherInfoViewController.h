//
//  CipherInfoViewController.h
//  KidsCipher
//
//  Created by Oleksii Vynogradov on 4/29/13.
//  Copyright (c) 2013 IXC-USA Corp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CipherInfoViewController : UIViewController <NSFetchedResultsControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (retain, nonatomic) UIPopoverController *pop;

@end
