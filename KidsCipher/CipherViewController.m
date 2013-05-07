//
//  CipherViewController.m
//  KidsCipher
//
//  Created by Oleksii Vynogradov on 4/29/13.
//  Copyright (c) 2013 IXC-USA Corp. All rights reserved.
//

#import "CipherViewController.h"
#import "CipherAppDelegate.h"
#import "Row.h"
#import "Game.h"
#import "GamesHistory.h"

@interface CipherViewController ()
@property (retain, nonatomic) IBOutlet UIView *row1HidingView;
@property (retain, nonatomic) IBOutlet UIView *row2HidingView;

@end

@implementation CipherViewController
#pragma mark - own view updated
-(void) updateAllViews {
    CipherAppDelegate *mainDelegate = (CipherAppDelegate *)[[UIApplication sharedApplication] delegate];
    Row *activeRowToGetAllRows = [mainDelegate getActiveRow];
    NSOrderedSet *allRows = activeRowToGetAllRows.game.rows;
    [allRows enumerateObjectsUsingBlock:^(Row *activeRow, NSUInteger idx, BOOL *stop) {
        AVImageView *image1InsideRow = nil;
        AVImageView *image2InsideRow = nil;
        AVImageView *image3InsideRow = nil;
        AVImageView *image4InsideRow = nil;
        AVImageView *image5InsideRow = nil;
        UIView *hidingRowView = nil;
        CGRect frame1InsideRow;
        CGRect frame2InsideRow;
        CGRect frame3InsideRow;
        CGRect frame4InsideRow;
        switch (idx) {
            case 0:
                image1InsideRow = self.row1image1;
                image2InsideRow = self.row1image2;
                image3InsideRow = self.row1image3;
                image4InsideRow = self.row1image4;
                image5InsideRow = self.row1image5;
                frame1InsideRow = self.row1frame1.frame;
                frame2InsideRow = self.row1frame2.frame;
                frame3InsideRow = self.row1frame3.frame;
                frame4InsideRow = self.row1frame4.frame;
                hidingRowView = self.row1HidingView;
                break;
            case 1:
                image1InsideRow = self.row2image1;
                image2InsideRow = self.row2image2;
                image3InsideRow = self.row2image3;
                image4InsideRow = self.row2image4;
                image5InsideRow = self.row2image5;
                frame1InsideRow = self.row2frame1.frame;
                frame2InsideRow = self.row2frame2.frame;
                frame3InsideRow = self.row2frame3.frame;
                frame4InsideRow = self.row2frame4.frame;
                hidingRowView = self.row2HidingView;
                break;
                
            default:
                hidingRowView = nil;
                break;
        }
        
        if (activeRow.isFilled.boolValue) {
            image1InsideRow.userInteractionEnabled = NO;
            image2InsideRow.userInteractionEnabled = NO;
            image3InsideRow.userInteractionEnabled = NO;
            image4InsideRow.userInteractionEnabled = NO;
            image5InsideRow.userInteractionEnabled = NO;
            hidingRowView.hidden = NO;
            hidingRowView.alpha = 0.5;
            
            //NSLog(@"activeRow.isFilled->YES, setting hidingRowView.hidden=NO hidingRowView->%@",hidingRowView);
            
        } else {
            if (idx == activeRowToGetAllRows.game.activeRowNumber.unsignedIntegerValue && activeRowToGetAllRows.game.isGameStarted.boolValue) {
                image1InsideRow.userInteractionEnabled = YES;
                image2InsideRow.userInteractionEnabled = YES;
                image3InsideRow.userInteractionEnabled = YES;
                image4InsideRow.userInteractionEnabled = YES;
                image5InsideRow.userInteractionEnabled = YES;
                hidingRowView.hidden = YES;
                hidingRowView.alpha = 0.0;
                //NSLog(@"activeRow.isFilled->NO, setting hidingRowView.hidden=NO hidingRowView->%@",hidingRowView);
            } //else { hidingRowView.hidden = NO; hidingRowView.alpha = 0.5; }
        }
        
        if (activeRow.frame1FilledNumber.integerValue > 0) {
            switch (activeRow.frame1FilledNumber.integerValue) {
                case 1:
                    image1InsideRow.frame = frame1InsideRow;
                    image1InsideRow.hidden = NO;
                    if (idx == activeRowToGetAllRows.game.activeRowNumber.unsignedIntegerValue) self.image1OutsideTableView.hidden = YES;
                    break;
                case 2:
                    image2InsideRow.frame = frame1InsideRow;
                    image2InsideRow.hidden = NO;
                    if (idx == activeRowToGetAllRows.game.activeRowNumber.unsignedIntegerValue) self.image2OutsideTableView.hidden = YES;
                    break;
                case 3:
                    image3InsideRow.frame = frame1InsideRow;
                    image3InsideRow.hidden = NO;
                    if (idx == activeRowToGetAllRows.game.activeRowNumber.unsignedIntegerValue) self.image3OutsideTableView.hidden = YES;
                    break;
                case 4:
                    image4InsideRow.frame = frame1InsideRow;
                    image4InsideRow.hidden = NO;
                    if (idx == activeRowToGetAllRows.game.activeRowNumber.unsignedIntegerValue) self.image4OutsideTableView.hidden = YES;
                    break;
                case 5:
                    image5InsideRow.frame = frame1InsideRow;
                    image5InsideRow.hidden = NO;
                    if (idx == activeRowToGetAllRows.game.activeRowNumber.unsignedIntegerValue) self.image5OutsideTableView.hidden = YES;
                    break;
                    
                default:
                    break;
            }
        }
        
        if (activeRow.frame2FilledNumber.integerValue > 0) {
            switch (activeRow.frame2FilledNumber.integerValue) {
                case 1:
                    image1InsideRow.frame = frame2InsideRow;
                    image1InsideRow.hidden = NO;
                    if (idx == activeRowToGetAllRows.game.activeRowNumber.unsignedIntegerValue) self.image1OutsideTableView.hidden = YES;
                    break;
                case 2:
                    image2InsideRow.frame = frame2InsideRow;
                    image2InsideRow.hidden = NO;
                    if (idx == activeRowToGetAllRows.game.activeRowNumber.unsignedIntegerValue) self.image2OutsideTableView.hidden = YES;
                    break;
                case 3:
                    image3InsideRow.frame = frame2InsideRow;
                    image3InsideRow.hidden = NO;
                    if (idx == activeRowToGetAllRows.game.activeRowNumber.unsignedIntegerValue) self.image3OutsideTableView.hidden = YES;
                    break;
                case 4:
                    image4InsideRow.frame = frame2InsideRow;
                    image4InsideRow.hidden = NO;
                    if (idx == activeRowToGetAllRows.game.activeRowNumber.unsignedIntegerValue) self.image4OutsideTableView.hidden = YES;
                    break;
                case 5:
                    image5InsideRow.frame = frame2InsideRow;
                    image5InsideRow.hidden = NO;
                    if (idx == activeRowToGetAllRows.game.activeRowNumber.unsignedIntegerValue) self.image5OutsideTableView.hidden = YES;
                    break;
                    
                default:
                    break;
            }
        }
        if (activeRow.frame3FilledNumber.integerValue > 0) {
            switch (activeRow.frame3FilledNumber.integerValue) {
                case 1:
                    image1InsideRow.frame = frame3InsideRow;
                    image1InsideRow.hidden = NO;
                    if (idx == activeRowToGetAllRows.game.activeRowNumber.unsignedIntegerValue) self.image1OutsideTableView.hidden = YES;
                    break;
                case 2:
                    image2InsideRow.frame = frame3InsideRow;
                    image2InsideRow.hidden = NO;
                    if (idx == activeRowToGetAllRows.game.activeRowNumber.unsignedIntegerValue) self.image2OutsideTableView.hidden = YES;
                    break;
                case 3:
                    image3InsideRow.frame = frame3InsideRow;
                    image3InsideRow.hidden = NO;
                    if (idx == activeRowToGetAllRows.game.activeRowNumber.unsignedIntegerValue) self.image3OutsideTableView.hidden = YES;
                    break;
                case 4:
                    image4InsideRow.frame = frame3InsideRow;
                    image4InsideRow.hidden = NO;
                    if (idx == activeRowToGetAllRows.game.activeRowNumber.unsignedIntegerValue) self.image4OutsideTableView.hidden = YES;
                    break;
                case 5:
                    image5InsideRow.frame = frame3InsideRow;
                    image5InsideRow.hidden = NO;
                    if (idx == activeRowToGetAllRows.game.activeRowNumber.unsignedIntegerValue) self.image5OutsideTableView.hidden = YES;
                    break;
                    
                default:
                    break;
            }
        }
        
        if (activeRow.frame4FilledNumber.integerValue > 0) {
            switch (activeRow.frame4FilledNumber.integerValue) {
                case 1:
                    image1InsideRow.frame = frame4InsideRow;
                    image1InsideRow.hidden = NO;
                    if (idx == activeRowToGetAllRows.game.activeRowNumber.unsignedIntegerValue) self.image1OutsideTableView.hidden = YES;
                    break;
                case 2:
                    image2InsideRow.frame = frame4InsideRow;
                    image2InsideRow.hidden = NO;
                    if (idx == activeRowToGetAllRows.game.activeRowNumber.unsignedIntegerValue) self.image2OutsideTableView.hidden = YES;
                    break;
                case 3:
                    image3InsideRow.frame = frame4InsideRow;
                    image3InsideRow.hidden = NO;
                    if (idx == activeRowToGetAllRows.game.activeRowNumber.unsignedIntegerValue) self.image3OutsideTableView.hidden = YES;
                    break;
                case 4:
                    image4InsideRow.frame = frame4InsideRow;
                    image4InsideRow.hidden = NO;
                    if (idx == activeRowToGetAllRows.game.activeRowNumber.unsignedIntegerValue) self.image4OutsideTableView.hidden = YES;
                    break;
                case 5:
                    image5InsideRow.frame = frame4InsideRow;
                    image5InsideRow.hidden = NO;
                    if (idx == activeRowToGetAllRows.game.activeRowNumber.unsignedIntegerValue) self.image5OutsideTableView.hidden = YES;
                    break;
                    
                default:
                    break;
            }
        }
        
        
    }];
    NSLog(@"activeRowToGetAllRows.game.combination1color->%@",activeRowToGetAllRows.game.combination1color);
    NSLog(@"activeRowToGetAllRows.game.combination2color->%@",activeRowToGetAllRows.game.combination2color);
    NSLog(@"activeRowToGetAllRows.game.combination3color->%@",activeRowToGetAllRows.game.combination3color);
    NSLog(@"activeRowToGetAllRows.game.combination4color->%@",activeRowToGetAllRows.game.combination4color);
    switch (activeRowToGetAllRows.game.combination1color.unsignedIntegerValue) {
        case 1:
            self.image1combination.frame = self.frame1combination.frame;
            self.image1combination.hidden = NO;
            break;
        case 2:
            self.image2combination.frame = self.frame1combination.frame;
            self.image2combination.hidden = NO;
            break;
        case 3:
            self.image3combination.frame = self.frame1combination.frame;
            self.image3combination.hidden = NO;
            break;
        case 4:
            self.image4combination.frame = self.frame1combination.frame;
            self.image4combination.hidden = NO;
            break;
        case 5:
            self.image5combination.frame = self.frame1combination.frame;
            self.image5combination.hidden = NO;
            break;
        default:
            break;
    }
    switch (activeRowToGetAllRows.game.combination2color.unsignedIntegerValue) {
        case 1:
            self.image1combination.frame = self.frame2combination.frame;
            self.image1combination.hidden = NO;
            break;
        case 2:
            self.image2combination.frame = self.frame2combination.frame;
            self.image2combination.hidden = NO;
            break;
        case 3:
            self.image3combination.frame = self.frame2combination.frame;
            self.image3combination.hidden = NO;
            break;
        case 4:
            self.image4combination.frame = self.frame2combination.frame;
            self.image4combination.hidden = NO;
            break;
        case 5:
            self.image5combination.frame = self.frame2combination.frame;
            self.image5combination.hidden = NO;
            break;
            
        default:
            break;
    }
    switch (activeRowToGetAllRows.game.combination3color.unsignedIntegerValue) {
        case 1:
            self.image1combination.frame = self.frame3combination.frame;
            self.image1combination.hidden = NO;
            break;
        case 2:
            self.image2combination.frame = self.frame3combination.frame;
            self.image2combination.hidden = NO;
            break;
        case 3:
            self.image3combination.frame = self.frame3combination.frame;
            self.image3combination.hidden = NO;
            break;
        case 4:
            self.image4combination.frame = self.frame3combination.frame;
            self.image4combination.hidden = NO;
            break;
        case 5:
            self.image5combination.frame = self.frame3combination.frame;
            self.image5combination.hidden = NO;
            break;
            
        default:
            break;
    }
    switch (activeRowToGetAllRows.game.combination4color.unsignedIntegerValue) {
        case 1:
            self.image1combination.frame = self.frame4combination.frame;
            self.image1combination.hidden = NO;
            break;
        case 2:
            self.image2combination.frame = self.frame4combination.frame;
            self.image2combination.hidden = NO;
            break;
        case 3:
            self.image3combination.frame = self.frame4combination.frame;
            self.image3combination.hidden = NO;
            break;
        case 4:
            self.image4combination.frame = self.frame4combination.frame;
            self.image4combination.hidden = NO;
            break;
        case 5:
            self.image5combination.frame = self.frame4combination.frame;
            self.image5combination.hidden = NO;
            break;
            
        default:
            break;
    }

}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    CipherAppDelegate *mainDelegate = (CipherAppDelegate *)[[UIApplication sharedApplication] delegate];
    Row *activeRow = [mainDelegate getActiveRow];
    activeRow.game.mainDraggedImage1startingPoint = NSStringFromCGPoint(self.image1OutsideTableView.frame.origin);
    activeRow.game.mainDraggedImage2startingPoint = NSStringFromCGPoint(self.image2OutsideTableView.frame.origin);
    activeRow.game.mainDraggedImage3startingPoint = NSStringFromCGPoint(self.image3OutsideTableView.frame.origin);
    activeRow.game.mainDraggedImage4startingPoint = NSStringFromCGPoint(self.image4OutsideTableView.frame.origin);
    activeRow.game.mainDraggedImage5startingPoint = NSStringFromCGPoint(self.image5OutsideTableView.frame.origin);
    [mainDelegate saveContext];
    //NSLog(@"didRotateFromInterfaceOrientation activeRow.game->%@",activeRow.game);
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    CipherAppDelegate *mainDelegate = (CipherAppDelegate *)[[UIApplication sharedApplication] delegate];
    [mainDelegate registerViewController:@"CipherViewController" controller:self];
    self.gamePlayScrollView.contentSize =  CGSizeMake(320, 1000);
    //NSLog(@"viewDidLoad");
    Row *activeRow = [mainDelegate getActiveRow];
    //NSLog(@"activeRow->%@",activeRow);
    //NSLog(@"game->%@",activeRow.game);

    activeRow.game.mainDraggedImage1startingPoint = NSStringFromCGPoint(self.image1OutsideTableView.frame.origin);
    activeRow.game.mainDraggedImage2startingPoint = NSStringFromCGPoint(self.image2OutsideTableView.frame.origin);
    activeRow.game.mainDraggedImage3startingPoint = NSStringFromCGPoint(self.image3OutsideTableView.frame.origin);
    activeRow.game.mainDraggedImage4startingPoint = NSStringFromCGPoint(self.image4OutsideTableView.frame.origin);
    activeRow.game.mainDraggedImage5startingPoint = NSStringFromCGPoint(self.image5OutsideTableView.frame.origin);
    [mainDelegate saveContext];

    //self.nextRowToFill = [NSIndexPath indexPathForRow:0 inSection:0];
    //NSLog(@"viewDidLoad self.image1OutsideTableView.startPointt->%@",NSStringFromCGPoint(self.image1OutsideTableView.frame.origin));
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    CipherAppDelegate *mainDelegate = (CipherAppDelegate *)[[UIApplication sharedApplication] delegate];
    Row *activeRow = [mainDelegate getActiveRow];
    activeRow.game.mainDraggedImage1identifier = self.image1OutsideTableView.uniqueIdentifier;
    activeRow.game.mainDraggedImage2identifier = self.image2OutsideTableView.uniqueIdentifier;
    activeRow.game.mainDraggedImage3identifier = self.image3OutsideTableView.uniqueIdentifier;
    activeRow.game.mainDraggedImage4identifier = self.image4OutsideTableView.uniqueIdentifier;
    activeRow.game.mainDraggedImage5identifier = self.image5OutsideTableView.uniqueIdentifier;
    activeRow.game.mainDraggedImage1startingPoint = NSStringFromCGPoint(self.image1OutsideTableView.frame.origin);
    activeRow.game.mainDraggedImage2startingPoint = NSStringFromCGPoint(self.image2OutsideTableView.frame.origin);
    activeRow.game.mainDraggedImage3startingPoint = NSStringFromCGPoint(self.image3OutsideTableView.frame.origin);
    activeRow.game.mainDraggedImage4startingPoint = NSStringFromCGPoint(self.image4OutsideTableView.frame.origin);
    activeRow.game.mainDraggedImage5startingPoint = NSStringFromCGPoint(self.image5OutsideTableView.frame.origin);
    //NSLog(@"viewDidAppear activeRow.game->%@",activeRow.game);
}
-(void)viewWillAppear:(BOOL)animated
{
    [self updateAllViews];
}

-(void)viewDidDisappear:(BOOL)animated
{
//    CipherAppDelegate *mainDelegate = (CipherAppDelegate *)[[UIApplication sharedApplication] delegate];
//    mainDelegate.image1OutsideTableViewStartPoint = self.image1OutsideTableView.startPoint;
//    mainDelegate.image2OutsideTableViewStartPoint = self.image2OutsideTableView.startPoint;
//    mainDelegate.image3OutsideTableViewStartPoint = self.image3OutsideTableView.startPoint;
//    mainDelegate.image4OutsideTableViewStartPoint = self.image4OutsideTableView.startPoint;
//    mainDelegate.image5OutsideTableViewStartPoint = self.image5OutsideTableView.startPoint;
//    NSLog(@"viewDidDisappear mainDelegate.image1OutsideTableViewStartPoint->%@",NSStringFromCGPoint(mainDelegate.image1OutsideTableViewStartPoint));
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



#pragma mark own actions
- (IBAction)changePhoto:(id)sender {
    // Place image picker on the screen
    //[self presentViewController:imagePickerController animated:YES completion:nil];
    //NSLog(@"changePhoto->");
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    //NSLog(@"imagePickerController->%@",imagePickerController);
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        [imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
    } else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    } else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    // image picker needs a delegate,
    [imagePickerController setDelegate:self];
    self.pop = [[UIPopoverController alloc] initWithContentViewController:imagePickerController];
    [self.pop presentPopoverFromRect:self.photoView.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}
- (IBAction)startGame:(id)sender {
    self.row1HidingView.hidden = YES;
    self.row1HidingView.userInteractionEnabled = NO;
    CipherAppDelegate *mainDelegate = (CipherAppDelegate *)[[UIApplication sharedApplication] delegate];
    Row *activeRowToGetAllRows = [mainDelegate getActiveRow];
    activeRowToGetAllRows.game.isGameStarted = [NSNumber numberWithBool:YES];
    [mainDelegate saveContext];
    [self updateAllViews];
}
- (IBAction)startTraining:(id)sender {
    self.row1HidingView.hidden = YES;
    self.row1HidingView.userInteractionEnabled = NO;
    CipherAppDelegate *mainDelegate = (CipherAppDelegate *)[[UIApplication sharedApplication] delegate];
    Row *activeRowToGetAllRows = [mainDelegate getActiveRow];
    activeRowToGetAllRows.game.isGameStarted = [NSNumber numberWithBool:YES];
    [mainDelegate saveContext];
    [self updateAllViews];
}

-(void)startCompletingCurrentRowAndOpenNext;
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^(void) {
        sleep(1);
        CipherAppDelegate *mainDelegate = (CipherAppDelegate *)[[UIApplication sharedApplication] delegate];
        Row *activeRow = [mainDelegate getActiveRow];
        Row *rowBeforeActiveRow = [mainDelegate getRowBeforeActiveRow];
        if (rowBeforeActiveRow && rowBeforeActiveRow.isFilled.boolValue == YES ) { NSLog(@"previous line not filled, return");return; }
        GamesHistory *newHistory = (GamesHistory *)[NSEntityDescription insertNewObjectForEntityForName:@"GamesHistory" inManagedObjectContext:mainDelegate.managedObjectContext];
        NSData *pickedData = [[NSUserDefaults standardUserDefaults] objectForKey:@"clientPicture"];
        NSData *imageData = UIImagePNGRepresentation([UIImage imageNamed:@"ava.png"]);

        if (pickedData) newHistory.photo = pickedData;
        else newHistory.photo = imageData;
        //NSLog(@"pickedData->%@ ",[pickedData description],[imageData description]);
        newHistory.name = @"Test";
        newHistory.date = [NSDate date];
        newHistory.difficultLevel = [NSNumber numberWithInt:1];
        newHistory.gameTime = [NSNumber numberWithInt:1234];
        newHistory.attempts = [NSNumber numberWithInt:2];
        //NSLog(@"newHistory->%@",newHistory);
        NSUInteger findedTruePositionsAndColors = 0;
        NSUInteger findedTrueColors = 0;
        
        NSNumber *frame1FilledNumber = activeRow.frame1FilledNumber;
        NSNumber *frame2FilledNumber = activeRow.frame2FilledNumber;
        NSNumber *frame3FilledNumber = activeRow.frame3FilledNumber;
        NSNumber *frame4FilledNumber = activeRow.frame4FilledNumber;
        
        NSNumber *combination1color = activeRow.game.combination1color;
        NSNumber *combination2color = activeRow.game.combination2color;
        NSNumber *combination3color = activeRow.game.combination3color;
        NSNumber *combination4color = activeRow.game.combination4color;
        
        if (frame1FilledNumber.integerValue == combination1color.integerValue) findedTruePositionsAndColors++;
        else if (frame1FilledNumber.integerValue == combination2color.integerValue ||
                 frame1FilledNumber.integerValue == combination3color.integerValue ||
                 frame1FilledNumber.integerValue == combination4color.integerValue ) findedTrueColors++;
        if (frame2FilledNumber.integerValue == combination2color.integerValue) findedTruePositionsAndColors++;
        else if (frame2FilledNumber.integerValue == combination2color.integerValue ||
                 frame2FilledNumber.integerValue == combination3color.integerValue ||
                 frame2FilledNumber.integerValue == combination4color.integerValue ) findedTrueColors++;
        if (frame3FilledNumber.integerValue == combination3color.integerValue) findedTruePositionsAndColors++;
        else if (frame3FilledNumber.integerValue == combination2color.integerValue ||
                 frame3FilledNumber.integerValue == combination3color.integerValue ||
                 frame3FilledNumber.integerValue == combination4color.integerValue ) findedTrueColors++;
        if (frame4FilledNumber.integerValue == combination4color.integerValue) findedTruePositionsAndColors++;
        else if (frame4FilledNumber.integerValue == combination2color.integerValue ||
                 frame4FilledNumber.integerValue == combination3color.integerValue ||
                 frame4FilledNumber.integerValue == combination4color.integerValue ) findedTrueColors++;
        activeRow.numberOfMatchedColor = [NSNumber numberWithUnsignedInteger:findedTrueColors];
        activeRow.numberOfMatchedColorAndPosition = [NSNumber numberWithUnsignedInteger:findedTruePositionsAndColors];
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            self.row1MatchedColors.text = [NSString stringWithFormat:@"Почти угадал:%@",activeRow.numberOfMatchedColor];
            self.row1MatchedColorsAndPositions.text = [NSString stringWithFormat:@"Угадал:%@",activeRow.numberOfMatchedColorAndPosition];
        });
        activeRow.isFilled = [NSNumber numberWithBool:YES];
        activeRow.game.activeRowNumber = [NSNumber numberWithInteger:activeRow.game.activeRowNumber.integerValue + 1];
        [mainDelegate saveContext];
        activeRow = [mainDelegate getActiveRow];
        if (activeRow.game.activeRowNumber.integerValue > 9) {
            NSLog(@"==================game over");
        }
        //NSLog(@"activeRowNumber->%@ activeRow->%@",activeRow.game.activeRowNumber,activeRow);
        CGPoint frameToReturnMainImage1 = CGPointFromString(activeRow.game.mainDraggedImage1startingPoint);
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            self.image1OutsideTableView.frame = CGRectMake(frameToReturnMainImage1.x,
                                                           frameToReturnMainImage1.y,
                                                           self.image1OutsideTableView.frame.size.width,
                                                           self.image1OutsideTableView.frame.size.height);
            CGPoint frameToReturnMainImage2 = CGPointFromString(activeRow.game.mainDraggedImage2startingPoint);
            self.image2OutsideTableView.frame = CGRectMake(frameToReturnMainImage2.x,
                                                           frameToReturnMainImage2.y,
                                                           self.image2OutsideTableView.frame.size.width,
                                                           self.image2OutsideTableView.frame.size.height);
            CGPoint frameToReturnMainImage3 = CGPointFromString(activeRow.game.mainDraggedImage3startingPoint);
            self.image3OutsideTableView.frame = CGRectMake(frameToReturnMainImage3.x,
                                                           frameToReturnMainImage3.y,
                                                           self.image3OutsideTableView.frame.size.width,
                                                           self.image3OutsideTableView.frame.size.height);
            CGPoint frameToReturnMainImage4 = CGPointFromString(activeRow.game.mainDraggedImage4startingPoint);
            self.image4OutsideTableView.frame = CGRectMake(frameToReturnMainImage4.x,
                                                           frameToReturnMainImage4.y,
                                                           self.image4OutsideTableView.frame.size.width,
                                                           self.image4OutsideTableView.frame.size.height);
            CGPoint frameToReturnMainImage5 = CGPointFromString(activeRow.game.mainDraggedImage5startingPoint);
            self.image5OutsideTableView.frame = CGRectMake(frameToReturnMainImage5.x,
                                                           frameToReturnMainImage5.y,
                                                           self.image5OutsideTableView.frame.size.width,
                                                           self.image5OutsideTableView.frame.size.height);
            
            switch (activeRow.game.activeRowNumber.unsignedIntegerValue) {
                case 1:
                    // first row finished
                    self.row1image1.userInteractionEnabled = NO;
                    self.row1image2.userInteractionEnabled = NO;
                    self.row1image3.userInteractionEnabled = NO;
                    self.row1image4.userInteractionEnabled = NO;
                    self.row1image5.userInteractionEnabled = NO;
                    
                    self.image1OutsideTableView.hidden = NO;
                    self.image2OutsideTableView.hidden = NO;
                    self.image3OutsideTableView.hidden = NO;
                    self.image4OutsideTableView.hidden = NO;
                    self.image5OutsideTableView.hidden = NO;
                    self.row1HidingView.hidden = NO;
                    self.row1HidingView.alpha = 0.5;
                    self.row2HidingView.hidden = YES;
                    self.row2HidingView.alpha = 0.0;
                    break;
                    
                default:
                    break;
            }
        });
    });
    
    
}
#pragma mark - UIImagePickerController delegate
static CGRect swapWidthAndHeight(CGRect rect)
{
    CGFloat  swap = rect.size.width;
    rect.size.width  = rect.size.height;
    rect.size.height = swap;
    return rect;
}


-(UIImage*)rotate:(UIImageOrientation)orient image:(UIImage *)image
{
    CGRect             bnds = CGRectZero;
    UIImage*           copy = nil;
    CGContextRef       ctxt = nil;
    CGImageRef         imag = image.CGImage;
    CGRect             rect = CGRectZero;
    CGAffineTransform  tran = CGAffineTransformIdentity;
    
    rect.size.width  = CGImageGetWidth(imag);
    rect.size.height = CGImageGetHeight(imag);
    
    bnds = rect;
    
    switch (orient)
    {
        case UIImageOrientationUp:
            // would get you an exact copy of the original
            assert(false);
            return nil;
            
        case UIImageOrientationUpMirrored:
            tran = CGAffineTransformMakeTranslation(rect.size.width, 0.0);
            tran = CGAffineTransformScale(tran, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown:
            tran = CGAffineTransformMakeTranslation(rect.size.width,
                                                    rect.size.height);
            tran = CGAffineTransformRotate(tran, M_PI);
            break;
            
        case UIImageOrientationDownMirrored:
            tran = CGAffineTransformMakeTranslation(0.0, rect.size.height);
            tran = CGAffineTransformScale(tran, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeft:
            bnds = swapWidthAndHeight(bnds);
            tran = CGAffineTransformMakeTranslation(0.0, rect.size.width);
            tran = CGAffineTransformRotate(tran, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeftMirrored:
            bnds = swapWidthAndHeight(bnds);
            tran = CGAffineTransformMakeTranslation(rect.size.height,
                                                    rect.size.width);
            tran = CGAffineTransformScale(tran, -1.0, 1.0);
            tran = CGAffineTransformRotate(tran, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRight:
            bnds = swapWidthAndHeight(bnds);
            tran = CGAffineTransformMakeTranslation(rect.size.height, 0.0);
            tran = CGAffineTransformRotate(tran, M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored:
            bnds = swapWidthAndHeight(bnds);
            tran = CGAffineTransformMakeScale(-1.0, 1.0);
            tran = CGAffineTransformRotate(tran, M_PI / 2.0);
            break;
            
        default:
            // orientation value supplied is invalid
            assert(false);
            return nil;
    }
    
    UIGraphicsBeginImageContext(bnds.size);
    ctxt = UIGraphicsGetCurrentContext();
    
    switch (orient)
    {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextScaleCTM(ctxt, -1.0, 1.0);
            CGContextTranslateCTM(ctxt, -rect.size.height, 0.0);
            break;
            
        default:
            CGContextScaleCTM(ctxt, 1.0, -1.0);
            CGContextTranslateCTM(ctxt, 0.0, -rect.size.height);
            break;
    }
    
    CGContextConcatCTM(ctxt, tran);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), rect, imag);
    
    copy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return copy;
}

-(UIImage*)resizedImage:(UIImage *)image toSize:(CGSize)dstSize
{
	CGImageRef imgRef = image.CGImage;
	// the below values are regardless of orientation : for UIImages from Camera, width>height (landscape)
	CGSize  srcSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef)); // not equivalent to self.size (which is dependant on the imageOrientation)!
    
	CGFloat scaleRatio = dstSize.width / srcSize.width;
	UIImageOrientation orient = image.imageOrientation;
	CGAffineTransform transform = CGAffineTransformIdentity;
	switch(orient) {
            
		case UIImageOrientationUp: //EXIF = 1
			transform = CGAffineTransformIdentity;
			break;
            
		case UIImageOrientationUpMirrored: //EXIF = 2
			transform = CGAffineTransformMakeTranslation(srcSize.width, 0.0);
			transform = CGAffineTransformScale(transform, -1.0, 1.0);
			break;
            
		case UIImageOrientationDown: //EXIF = 3
			transform = CGAffineTransformMakeTranslation(srcSize.width, srcSize.height);
			transform = CGAffineTransformRotate(transform, M_PI);
			break;
            
		case UIImageOrientationDownMirrored: //EXIF = 4
			transform = CGAffineTransformMakeTranslation(0.0, srcSize.height);
			transform = CGAffineTransformScale(transform, 1.0, -1.0);
			break;
            
		case UIImageOrientationLeftMirrored: //EXIF = 5
			dstSize = CGSizeMake(dstSize.height, dstSize.width);
			transform = CGAffineTransformMakeTranslation(srcSize.height, srcSize.width);
			transform = CGAffineTransformScale(transform, -1.0, 1.0);
			transform = CGAffineTransformRotate(transform, 3.0 * M_PI_2);
			break;
            
		case UIImageOrientationLeft: //EXIF = 6
			dstSize = CGSizeMake(dstSize.height, dstSize.width);
			transform = CGAffineTransformMakeTranslation(0.0, srcSize.width);
			transform = CGAffineTransformRotate(transform, 3.0 * M_PI_2);
			break;
            
		case UIImageOrientationRightMirrored: //EXIF = 7
			dstSize = CGSizeMake(dstSize.height, dstSize.width);
			transform = CGAffineTransformMakeScale(-1.0, 1.0);
			transform = CGAffineTransformRotate(transform, M_PI_2);
			break;
            
		case UIImageOrientationRight: //EXIF = 8
			dstSize = CGSizeMake(dstSize.height, dstSize.width);
			transform = CGAffineTransformMakeTranslation(srcSize.height, 0.0);
			transform = CGAffineTransformRotate(transform, M_PI_2);
			break;
            
		default:
			[NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
	}
    
	/////////////////////////////////////////////////////////////////////////////
	// The actual resize: draw the image on a new context, applying a transform matrix
	UIGraphicsBeginImageContextWithOptions(dstSize, NO, 0.0);
    
	CGContextRef context = UIGraphicsGetCurrentContext();
    
	if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
		CGContextScaleCTM(context, -scaleRatio, scaleRatio);
		CGContextTranslateCTM(context, -srcSize.height, 0);
	} else {
		CGContextScaleCTM(context, scaleRatio, -scaleRatio);
		CGContextTranslateCTM(context, 0, -srcSize.height);
	}
    
	CGContextConcatCTM(context, transform);
    
	// we use srcSize (and not dstSize) as the size to specify is in user space (and we use the CTM to apply a scaleRatio)
	CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, srcSize.width, srcSize.height), imgRef);
	UIImage* resizedImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
    
	return resizedImage;
}

-(UIImage*)resizedImage:(UIImage *)image toFitInSize:(CGSize)boundingSize scaleIfSmaller:(BOOL)scale
{
	// get the image size (independant of imageOrientation)
	CGImageRef imgRef = image.CGImage;
	CGSize srcSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef)); // not equivalent to self.size (which depends on the imageOrientation)!
    
	// adjust boundingSize to make it independant on imageOrientation too for farther computations
	UIImageOrientation orient = image.imageOrientation;
	switch (orient) {
		case UIImageOrientationLeft:
		case UIImageOrientationRight:
		case UIImageOrientationLeftMirrored:
		case UIImageOrientationRightMirrored:
			boundingSize = CGSizeMake(boundingSize.height, boundingSize.width);
			break;
        default:
            // NOP
            break;
	}
    
	// Compute the target CGRect in order to keep aspect-ratio
	CGSize dstSize;
    
	if ( !scale && (srcSize.width < boundingSize.width) && (srcSize.height < boundingSize.height) ) {
		//NSLog(@"Image is smaller, and we asked not to scale it in this case (scaleIfSmaller:NO)");
		dstSize = srcSize; // no resize (we could directly return 'self' here, but we draw the image anyway to take image orientation into account)
	} else {
		CGFloat wRatio = boundingSize.width / srcSize.width;
		CGFloat hRatio = boundingSize.height / srcSize.height;
        
		if (wRatio < hRatio) {
			//NSLog(@"Width imposed, Height scaled ; ratio = %f",wRatio);
			dstSize = CGSizeMake(boundingSize.width, floorf(srcSize.height * wRatio));
		} else {
			//NSLog(@"Height imposed, Width scaled ; ratio = %f",hRatio);
			dstSize = CGSizeMake(floorf(srcSize.width * hRatio), boundingSize.height);
		}
	}
    
	return [self resizedImage:image toSize:dstSize];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"didFinishPickingMediaWithInfo->%@",info);
    [self.pop dismissPopoverAnimated:YES];
    UIImage *originalImage, *editedImage, *rotatedImage;
    editedImage = (UIImage *)[info objectForKey:UIImagePickerControllerEditedImage];
    originalImage = (UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];
    if (editedImage) rotatedImage = [self rotate:UIImageOrientationRight image:editedImage];
    else rotatedImage = [self rotate:UIImageOrientationRight image:originalImage];
    UIImage *resizedImage = [self resizedImage:rotatedImage toFitInSize:CGSizeMake(132, 132) scaleIfSmaller:YES];
    NSData *resizedData = UIImagePNGRepresentation(resizedImage);
    //UIImage *picked = [info valueForKey:UIImagePickerControllerOriginalImage];
    //NSData *pickedData = UIImagePNGRepresentation(rotatedImage);
    //NSData *imageData = [[NSData alloc] initWithData:UIImageJPEGRepresentation((picked), 0.5)];
    int imageSize = resizedData.length;
    NSLog(@"SIZE OF IMAGE: %i ", imageSize);
    if (resizedData) {
        [[NSUserDefaults standardUserDefaults] setObject:resizedData forKey:@"clientPicture"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        self.photoView.imageView.image = resizedImage;
    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"imagePickerControllerDidCancel->");
    [self.pop dismissPopoverAnimated:YES];
    NSData *pickedData = [[NSUserDefaults standardUserDefaults] objectForKey:@"clientPicture"];
    if (pickedData) self.photoView.imageView.image = [UIImage imageWithData:pickedData];
    else self.photoView.imageView.image = [UIImage imageNamed:@"ava.png"];
}

- (void)viewDidUnload {
    [self setRow1HidingView:nil];
    [self setRow2HidingView:nil];
    [self setRow1MatchedColorsAndPositions:nil];
    [self setRow1MatchedColors:nil];
    [self setRow2view:nil];
    [self setRow2frame2:nil];
    [self setRow2frame3:nil];
    [self setRow2frame4:nil];
    [self setRow2image1:nil];
    [self setRow2image2:nil];
    [self setRow2image4:nil];
    [self setRow2image5:nil];
    [self setRow1MatchedColorsAndPositions:nil];
    [self setImage1combination:nil];
    [self setImage2combination:nil];
    [self setImage3combination:nil];
    [self setImage4combination:nil];
    [self setImage5combination:nil];
    [self setFrame1combination:nil];
    [self setFrame2combination:nil];
    [self setFrame3combination:nil];
    [self setFrame4combination:nil];
    [super viewDidUnload];
}
@end
