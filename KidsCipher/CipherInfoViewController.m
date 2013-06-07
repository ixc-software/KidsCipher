//
//  CipherInfoViewController.m
//  KidsCipher
//
//  Created by Oleksii Vynogradov on 4/29/13.
//  Copyright (c) 2013 IXC-USA Corp. All rights reserved.
//

#import "CipherInfoViewController.h"
#import "CipherAppDelegate.h"
#import "CipherInfoViewCell.h"
#import "GameScore.h"
#import "GamesHistory.h"

@interface CipherInfoViewController ()
@property (weak, nonatomic) IBOutlet UIButton *myPhoto;
@property (weak, nonatomic) IBOutlet UITextField *myNameEditor;
@property (weak, nonatomic) IBOutlet UILabel *myName;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *myScoreOrGameScore;
@property (weak, nonatomic) IBOutlet UISegmentedControl *difficultLevelSelector;
@property (weak, nonatomic) IBOutlet UILabel *difficultLevelLabel;

@property (nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (weak, nonatomic) IBOutlet UIImageView *mainPageBackground;
@property (weak, nonatomic) IBOutlet UIImageView *mainPageScrollBackground;
@property (weak, nonatomic) IBOutlet UILabel *returnToGameLabel;
@property (weak, nonatomic) IBOutlet UILabel *recordsNameTitle;
@property (weak, nonatomic) IBOutlet UILabel *recordsDateTitle;
@property (weak, nonatomic) IBOutlet UILabel *recordsLevelTitle;
@property (weak, nonatomic) IBOutlet UILabel *recordTimeTitle;
@property (weak, nonatomic) IBOutlet UILabel *recordsAttempstTitle;


@property (weak, nonatomic) IBOutlet UILabel *changeToBoyTitle;
@property (weak, nonatomic) IBOutlet UILabel *musicSwitchTitle;
@property (weak, nonatomic) IBOutlet UILabel *levelTitle;
@property (weak, nonatomic) IBOutlet UILabel *changeToGirlTitle;

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
    
    self.returnToGameLabel.text = NSLocalizedString(@"returnToGameLabel", @"");
    self.myName.text = NSLocalizedString(@"myName", @"");
    self.myNameEditor.placeholder = NSLocalizedString(@"myNameEditor", @"");

    [self.myScoreOrGameScore setTitle:NSLocalizedString(@"myScoreOrGameScore0", @"") forSegmentAtIndex:0];
    [self.myScoreOrGameScore setTitle:NSLocalizedString(@"myScoreOrGameScore1", @"") forSegmentAtIndex:1];

    self.recordsNameTitle.text = NSLocalizedString(@"recordsNameTitle", @"");
    self.recordsDateTitle.text = NSLocalizedString(@"recordsDateTitle", @"");
    self.recordTimeTitle.text = NSLocalizedString(@"recordTimeTitle", @"");
    self.recordsLevelTitle.text = NSLocalizedString(@"recordsLevelTitle", @"");
    self.recordsAttempstTitle.text = NSLocalizedString(@"recordsAttempstTitle", @"");

    self.changeToBoyTitle.text = NSLocalizedString(@"changeToBoyTitle", @"");
    self.changeToGirlTitle.text = NSLocalizedString(@"changeToGirlTitle", @"");
    self.musicSwitchTitle.text = NSLocalizedString(@"musicSwitchTitle", @"");
    self.levelTitle.text = NSLocalizedString(@"difficultLevelLabel", @"");

    [self.difficultLevelSelector setTitle:NSLocalizedString(@"difficultLevelSelector0", @"") forSegmentAtIndex:0];
    [self.difficultLevelSelector setTitle:NSLocalizedString(@"difficultLevelSelector1", @"") forSegmentAtIndex:1];
    [self.difficultLevelSelector setTitle:NSLocalizedString(@"difficultLevelSelector2", @"") forSegmentAtIndex:2];

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
    [self setMyScoreOrGameScore:nil];
    [self setDifficultLevelSelector:nil];
    [self setDifficultLevelLabel:nil];
    [self setMainPageBackground:nil];
    [self setMainPageScrollBackground:nil];
    [self setReturnToGameLabel:nil];
    [self setRecordsNameTitle:nil];
    [self setRecordsDateTitle:nil];
    [self setRecordsLevelTitle:nil];
    [self setRecordTimeTitle:nil];
    [self setRecordsAttempstTitle:nil];
    [self setChangeToBoyTitle:nil];
    [self setMusicSwitchTitle:nil];
    [self setLevelTitle:nil];
    [self setChangeToGirlTitle:nil];
    [super viewDidUnload];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIDeviceOrientationPortrait) {
        NSLog(@"UIDeviceOrientationPortrait");
        self.mainPageBackground.image = [UIImage imageNamed:@"button_fon_V"];
        self.mainPageScrollBackground.image = [UIImage imageNamed:@"button_fon_all_records"];
    } else {
        self.mainPageBackground.image = [UIImage imageNamed:@"button_fon_G"];
        self.mainPageScrollBackground.image = [UIImage imageNamed:@"button_fon_all_records_G"];
        if (orientation == UIDeviceOrientationUnknown) NSLog(@"UIDeviceOrientationUnknown");
        else NSLog(@"UIDeviceOrientationLandscapeLeft");
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    self.fetchedResultsController = [self newFetchedResultsControllerWithSearch:@""];
    NSString *name = [[NSUserDefaults standardUserDefaults] valueForKey:@"name"];
    self.myNameEditor.text = name;
    NSNumber *level = [[NSUserDefaults standardUserDefaults] valueForKey:@"level"];
    switch (level.unsignedIntegerValue) {
        case 0:
            self.difficultLevelSelector.selectedSegmentIndex = 0;
            break;
        case 1:
            self.difficultLevelSelector.selectedSegmentIndex = 1;
            break;
        case 2:
            self.difficultLevelSelector.selectedSegmentIndex = 2;
            break;
            
        default:
            break;
    }

}
#pragma mark - own actions
- (IBAction)changeMyPhoto:(id)sender {
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
    [self.pop presentPopoverFromRect:self.myPhoto.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (IBAction)myScoreOrTotalScoreChangeStart:(id)sender {
    self.fetchedResultsController = [self newFetchedResultsControllerWithSearch:@""];
    [self.tableView reloadData];
}
- (IBAction)difficultLevelStart:(id)sender {
//#warning finish
    NSNumber *level = [[NSUserDefaults standardUserDefaults] valueForKey:@"level"];
    switch ([sender selectedSegmentIndex]) {
        case 0:
            level = [NSNumber numberWithInt:0];
            break;
        case 1:
            level = [NSNumber numberWithInt:1];
            break;
        case 2:
            level = [NSNumber numberWithInt:2];
            break;
            
        default:
            break;
    }
    
    [[NSUserDefaults standardUserDefaults] setValue:level forKey:@"level"];

}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    if (orientation == UIDeviceOrientationPortrait) {
        NSLog(@"portrait");
        self.mainPageBackground.image = [UIImage imageNamed:@"button_fon_V"];
        self.mainPageScrollBackground.image = [UIImage imageNamed:@"button_fon_all_records"];
    } else {
        self.mainPageBackground.image = [UIImage imageNamed:@"button_fon_G"];
        self.mainPageScrollBackground.image = [UIImage imageNamed:@"button_fon_all_records_G"];
        NSLog(@"landscape");
        
    }
    [self.tableView reloadData];
    [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];

}
- (IBAction)musicChangeStart:(id)sender {
//#warning finish
    CipherAppDelegate *mainDelegate = (CipherAppDelegate *)[[UIApplication sharedApplication] delegate];
    if ([mainDelegate.audioPlayerMainFoneMusic isPlaying]) [mainDelegate.audioPlayerMainFoneMusic stop];
    else [mainDelegate.audioPlayerMainFoneMusic play];
}

- (IBAction)changeToBoyStart:(id)sender {
#warning finish

}
#pragma mark - UITableViewDelegates
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger count = [[[self fetchedResultsController] sections] count];
    //NSLog(@"number of sections:%d",count);
    return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfoCoreData = [[[self fetchedResultsController] sections] objectAtIndex:section];
    NSInteger numSpecificsInSection = [sectionInfoCoreData numberOfObjects];
    //NSLog(@"number of rows:%d in section:%d",numSpecificsInSection,section);
    return numSpecificsInSection;
}
- (UITableViewCell *)tableView:(UITableView *)tableViewLocal cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CipherInfoViewCell";
    CipherInfoViewCell *cell = [tableViewLocal dequeueReusableCellWithIdentifier:CellIdentifier];
    GamesHistory *row = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    NSData *photoData = row.photo;
    if (photoData) {
        UIImage *image = [UIImage imageWithData:photoData];
        cell.photo.image = image;
    } else {
        UIImage *image = [UIImage imageNamed:@"button_avatar"];
        cell.photo.image = image;
    }
    cell.name.text = row.name;

    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.locale = [NSLocale currentLocale];
    df.dateFormat = @"yyyy-MM-dd";
    cell.date.text = [df stringFromDate:row.date];

    switch (row.difficultLevel.unsignedIntegerValue) {
        case 2:
            cell.level.text = NSLocalizedString(@"difficultLevelSelector2", @"");
            cell.levelStarFirst.image = [UIImage imageNamed:@"button_level_star_yellow"];
            cell.levelStarSecond.image = [UIImage imageNamed:@"button_level_star_transparent"];
            cell.levelStarThird.image = [UIImage imageNamed:@"button_level_star_transparent"];
            break;
        case 1:
            cell.level.text = NSLocalizedString(@"difficultLevelSelector1", @"");
            cell.levelStarFirst.image = [UIImage imageNamed:@"button_level_star_yellow"];
            cell.levelStarSecond.image = [UIImage imageNamed:@"button_level_star_yellow"];
            cell.levelStarThird.image = [UIImage imageNamed:@"button_level_star_transparent"];
            break;

        case 0:
            cell.level.text = NSLocalizedString(@"difficultLevelSelector0", @"");
            cell.levelStarFirst.image = [UIImage imageNamed:@"button_level_star_yellow"];
            cell.levelStarSecond.image = [UIImage imageNamed:@"button_level_star_yellow"];
            cell.levelStarThird.image = [UIImage imageNamed:@"button_level_star_yellow"];
            break;

        default:
            break;
    }

    cell.time.text = [NSString stringWithFormat:@"%@ %@",row.gameTime,NSLocalizedString(@"gameTimeSecondsTitle", @"")];
    cell.attemps.text = [NSString stringWithFormat:@"%@",row.attempts];
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIDeviceOrientationPortrait) {
        cell.backgroundCell.image = [UIImage imageNamed:@"button_field_record"];
    } else {
        cell.backgroundCell.image = [UIImage imageNamed:@"button_field_record_G"];
        
    }

    return cell;
}

- (NSFetchedResultsController *)newFetchedResultsControllerWithSearch:(NSString *)searchString
{
    //NSLog(@"fetch controller start:%@",[NSDate date]);
    CipherAppDelegate *mainDelegate = (CipherAppDelegate *)[[UIApplication sharedApplication] delegate];

    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
    //NSSortDescriptor *sortDescriptor2 = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    //NSPredicate *filterPredicate = nil;
    //if (filterSegment.selectedSegmentIndex == 0) filterPredicate = [NSPredicate predicateWithFormat:@"isRegistered == %@",[NSNumber numberWithBool:YES]];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    if (self.myScoreOrGameScore.selectedSegmentIndex == 0) {
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"GamesHistory" inManagedObjectContext:mainDelegate.managedObjectContext];
        [fetchRequest setEntity:entity];
    } else {
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"GameScore" inManagedObjectContext:mainDelegate.managedObjectContext];
        [fetchRequest setEntity:entity];
    }
//    NSMutableArray *predicateArray = [NSMutableArray array];
//    if(searchString.length) {
//        NSPredicate *predicateFirstName = [NSPredicate predicateWithFormat:@"(firstName CONTAINS[cd] %@)",searchString];
//        NSPredicate *predicateLastName = [NSPredicate predicateWithFormat:@"(lastName CONTAINS[cd] %@)",searchString];
//        [predicateArray addObject:predicateFirstName];
//        [predicateArray addObject:predicateLastName];
//        if (filterPredicate) filterPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:[NSArray arrayWithObjects:filterPredicate,[NSCompoundPredicate orPredicateWithSubpredicates:predicateArray], nil]];
//        filterPredicate = [NSCompoundPredicate orPredicateWithSubpredicates:predicateArray];
//    }
//    if (filterPredicate) [fetchRequest setPredicate:filterPredicate];
//    [fetchRequest setFetchBatchSize:20];
    [fetchRequest setSortDescriptors:sortDescriptors];
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                                                managedObjectContext:mainDelegate.managedObjectContext
                                                                                                  sectionNameKeyPath:nil
                                                                                                           cacheName:nil];
    aFetchedResultsController.delegate = self;
    NSError *error = nil;
    if (![aFetchedResultsController performFetch:&error])
    {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    return aFetchedResultsController;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    //NSLog(@"change sections");
    switch(type)
    {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    switch(type)
    {
        case NSFetchedResultsChangeInsert:
        {
            //NSLog(@"INSERT to indexpath :%@",newIndexPath);
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObjects:newIndexPath,nil] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
        case NSFetchedResultsChangeDelete:
        {
            NSLog(@"DELETE : %@",indexPath);
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
        case NSFetchedResultsChangeUpdate:
        {
            //NSLog(@"UPDATE :%@",indexPath);
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
        case NSFetchedResultsChangeMove:
        {
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObjects:newIndexPath,nil] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    //NSLog(@"controllerDidChangeContent");
    [self.tableView endUpdates];
}

#pragma mark - UITextField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [[NSUserDefaults standardUserDefaults] setValue:textField.text forKey:@"name"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.myNameEditor resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [[NSUserDefaults standardUserDefaults] setValue:textField.text forKey:@"name"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.myNameEditor resignFirstResponder];

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
        self.myPhoto.imageView.image = resizedImage;
    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"imagePickerControllerDidCancel->");
    [self.pop dismissPopoverAnimated:YES];
    NSData *pickedData = [[NSUserDefaults standardUserDefaults] objectForKey:@"clientPicture"];
    if (pickedData) self.myPhoto.imageView.image = [UIImage imageWithData:pickedData];
    else {
#ifdef KidsCipherBoys
        self.myPhoto.imageView.image = [UIImage imageNamed:@"button_avatar_boy"];
#else
        self.myPhoto.imageView.image = [UIImage imageNamed:@"button_avatar"];
        
#endif

    }
}

@end
