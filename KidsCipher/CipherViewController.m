//
//  CipherViewController.m
//  KidsCipher
//
//  Created by Oleksii Vynogradov on 4/29/13.
//  Copyright (c) 2013 IXC-USA Corp. All rights reserved.
//

#import "CipherViewController.h"
#import "CipherAppDelegate.h"
#import "CipherViewCell.h"
#import "GameRow.h"
#define YELLOW 1
#define RED 2
#define GREEN 3
#define BLUE 4
#define ORANGE 5
#define WHITE 6

@interface CipherViewController ()
@property (retain) NSMutableArray *currentChooses;
@property (nonatomic, retain) NSIndexPath *nextRowToFill;

@end

@implementation CipherViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    CipherAppDelegate *mainDelegate = (CipherAppDelegate *)[[UIApplication sharedApplication] delegate];
    [mainDelegate registerViewController:@"CipherViewController" controller:self];
    self.currentCombination = [NSArray arrayWithObjects:
                               [NSNumber numberWithInt:arc4random() % 5+1],
                               [NSNumber numberWithInt:arc4random() % 5+1],
                               [NSNumber numberWithInt:arc4random() % 5+1],
                               [NSNumber numberWithInt:arc4random() % 5+1],
                               [NSNumber numberWithInt:arc4random() % 5+1],
                               [NSNumber numberWithInt:arc4random() % 5+1],
                               nil];
    self.currentChooses = [NSMutableArray arrayWithObjects:
                           [[GameRow alloc] init],
                           [[GameRow alloc] init],
                           [[GameRow alloc] init],
                           [[GameRow alloc] init],
                           [[GameRow alloc] init],
                           [[GameRow alloc] init],
                           [[GameRow alloc] init],
                           [[GameRow alloc] init],
                           [[GameRow alloc] init],
                           [[GameRow alloc] init],
                           nil];
    self.nextRowToFill = [NSIndexPath indexPathForRow:0 inSection:0];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegates
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableViewLocal cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CipherViewCell";
    CipherViewCell *cell = [tableViewLocal dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.controller = self;
    cell.indexPath = indexPath;
    GameRow *currentRow = [self.currentChooses objectAtIndex:indexPath.row];
    NSMutableArray *chooses = currentRow.choosedColorsForEveryPoint;
    __block BOOL isChoosedAllColors = NO;
    __block NSUInteger matchedDigitsCount = 0;
    [chooses enumerateObjectsUsingBlock:^(NSNumber *pointChoose, NSUInteger idx, BOOL *stop) {
        if (pointChoose.integerValue > 0) {
            NSString *colorName = nil;
            switch (pointChoose.integerValue) {
                case YELLOW:
                    colorName = @"YELLOW";
                    break;
                case RED:
                    colorName = @"RED";
                    break;
                case GREEN:
                    colorName = @"GREEN";
                    break;
                case BLUE:
                    colorName = @"BLUE";
                    break;
                case ORANGE:
                    colorName = @"ORANGE";
                    break;
                case WHITE:
                    colorName = @"WHITE";
                    break;
                    
                default:
                    break;
            }
            NSNumber *currentCombination = [self.currentCombination objectAtIndex:idx];
            NSLog(@"verifiy for idx->%lu currentCombination->%@ compared with pointChoose->%@",(unsigned long)idx,currentCombination,pointChoose);
            if (currentCombination.integerValue == pointChoose.integerValue) matchedDigitsCount++;
            
            switch (idx) {
                case 0:
                    cell.chooseFirst.titleLabel.text = colorName;
                    break;
                case 1:
                    cell.chooseSecond.titleLabel.text = colorName;
                    break;
                case 2:
                    cell.chooseThird.titleLabel.text = colorName;
                    break;
                case 3:
                    cell.chooseFourth.titleLabel.text = colorName;
                    break;
//                case 4:
//                    cell.chooseFifth.titleLabel.text = colorName;
//                    break;
//                case 5:
//                    cell.chooseSixth.titleLabel.text = colorName;
                    break;
                    
                default:
                    break;
            }
            isChoosedAllColors = YES;
        } else isChoosedAllColors = NO;
    }];
    if (isChoosedAllColors || indexPath.row == 0 || self.nextRowToFill.row == indexPath.row) {
        cell.hidingView.alpha = 0.0,
        cell.hidingView.userInteractionEnabled = NO;
        self.frameOne = [self.gameTableView convertRect:cell.chooseFirst.frame toView:self.view];
        self.frameOneInsideCell = cell.chooseFirst.frame;
        //self.frameTwo = [self.gameTableView convertRect:cell.chooseSecond.frame toView:self.view];
        self.frameSelectedCell = cell.frame;
        
        self.imageOneInsideTableView = cell.chooseOne;
        if (isChoosedAllColors) {
            
            self.nextRowToFill = [NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section];
            NSLog(@"matched->%lu",(unsigned long)matchedDigitsCount);
            for (int i=1; i<matchedDigitsCount+1; i++) {
                switch (i) {
                    case 1:
                        //cell.resultFirst.titleLabel.text = @"M";
                        break;
                    case 2:
                        //cell.resultSecond.titleLabel.text = @"M";
                        break;
                    case 3:
                        //cell.resultThird.titleLabel.text = @"M";
                        break;
                    case 4:
                        //cell.resultFourth.titleLabel.text = @"M";
                        break;
                    case 5:
                        //cell.resultFifth.titleLabel.text = @"M";
                        break;
                    case 6:
                        //cell.resultSixs.titleLabel.text = @"M";
                        break;
                        
                    default:
                        break;
                }
            }
        }
    }
    else { cell.hidingView.alpha = 0.5,cell.hidingView.userInteractionEnabled = YES;}
    return cell;
}

@end
