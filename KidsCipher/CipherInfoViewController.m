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

@property (nonatomic) NSFetchedResultsController *fetchedResultsController;

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

-(void)viewWillAppear:(BOOL)animated
{
    self.fetchedResultsController = [self newFetchedResultsControllerWithSearch:@""];
}
#pragma mark - own actions
- (IBAction)changePhoto:(id)sender {
    
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
    NSLog(@"row->%@",row);

    UIImage *image = [UIImage imageWithData:photoData];
    cell.photo.image = image;
    cell.name.text = row.name;
    cell.date.text = row.date.description;
    cell.level.text = [NSString stringWithFormat:@"level:%@",row.difficultLevel];
    cell.time.text = [NSString stringWithFormat:@"time:%@",row.gameTime];
    cell.attemps.text = [NSString stringWithFormat:@"attemps:%@",row.attempts];
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
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"GamesHistory" inManagedObjectContext:mainDelegate.managedObjectContext];
    [fetchRequest setEntity:entity];
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

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //NSLog(@"didFinishPickingMediaWithInfo->%@",info);
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *originalImage, *editedImage, *rotatedImage;
        editedImage = (UIImage *)[info objectForKey:UIImagePickerControllerEditedImage];
        originalImage = (UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];
        if (editedImage) rotatedImage = [self rotate:UIImageOrientationRight image:editedImage];
        else rotatedImage = [self rotate:UIImageOrientationRight image:originalImage];
        //UIImage *picked = [info valueForKey:UIImagePickerControllerOriginalImage];
        NSData *pickedData = UIImagePNGRepresentation(rotatedImage);
        //NSData *imageData = [[NSData alloc] initWithData:UIImageJPEGRepresentation((picked), 0.5)];
        //int imageSize = imageData.length;
        //NSLog(@"SIZE OF IMAGE: %i ", imageSize);
        if (pickedData) {
            [[NSUserDefaults standardUserDefaults] setObject:pickedData forKey:@"clientPicture"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            self.myPhoto.imageView.image = rotatedImage;
        }
    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //NSLog(@"didFinishPickingMediaWithInfo->%@",info);
    [picker dismissViewControllerAnimated:YES completion:^{
        NSData *pickedData = [[NSUserDefaults standardUserDefaults] objectForKey:@"clientPicture"];
        if (pickedData) self.myPhoto.imageView.image = [UIImage imageWithData:pickedData];
        else self.myPhoto.imageView.image = [UIImage imageNamed:@"ava.png"];
    }];
    
}

@end
