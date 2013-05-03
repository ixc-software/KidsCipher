//
//  CipherInfoViewController.m
//  KidsCipher
//
//  Created by Oleksii Vynogradov on 4/29/13.
//  Copyright (c) 2013 IXC-USA Corp. All rights reserved.
//

#import "CipherInfoViewController.h"
#import "CipherAppDelegate.h"

@interface CipherInfoViewController ()
@property (weak, nonatomic) IBOutlet UIButton *myPhoto;
@property (weak, nonatomic) IBOutlet UITextField *myNameEditor;
@property (weak, nonatomic) IBOutlet UILabel *myName;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CipherInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CipherAppDelegate *mainDelegate = (CipherAppDelegate *)[[UIApplication sharedApplication] delegate];
    [mainDelegate registerViewController:@"CipherInfoViewController" controller:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setMyPhoto:nil];
    [self setMyNameEditor:nil];
    [self setMyName:nil];
    [self setTableView:nil];
    [super viewDidUnload];
}

#pragma mark - own actions
- (IBAction)changePhoto:(id)sender {
    
}

@end
