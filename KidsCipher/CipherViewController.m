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

@interface CipherViewController ()

@end

@implementation CipherViewController

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    self.image1OutsideTableView.startPoint = self.image1OutsideTableView.frame.origin;
    self.image2OutsideTableView.startPoint = self.image2OutsideTableView.frame.origin;
    self.image3OutsideTableView.startPoint = self.image3OutsideTableView.frame.origin;
    self.image4OutsideTableView.startPoint = self.image4OutsideTableView.frame.origin;
    self.image5OutsideTableView.startPoint = self.image5OutsideTableView.frame.origin;
//    NSLog(@"didRotateFromInterfaceOrientation self.image1OutsideTableView->%@\n self.image1OutsideTableView.startPointt->%@",self.image1OutsideTableView,NSStringFromCGPoint(self.image1OutsideTableView.frame.origin));
}
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
    self.gamePlayScrollView.contentSize =  CGSizeMake(320, 1000);
    self.frameSelectedRow = self.row1view.frame;
    //self.nextRowToFill = [NSIndexPath indexPathForRow:0 inSection:0];
    //NSLog(@"viewDidLoad self.image1OutsideTableView.startPointt->%@",NSStringFromCGPoint(self.image1OutsideTableView.frame.origin));
}
-(void)viewWillAppear:(BOOL)animated
{
    CipherAppDelegate *mainDelegate = (CipherAppDelegate *)[[UIApplication sharedApplication] delegate];
    self.image1OutsideTableView.startPoint = mainDelegate.image1OutsideTableViewStartPoint;
    self.image2OutsideTableView.startPoint = mainDelegate.image2OutsideTableViewStartPoint;
    self.image3OutsideTableView.startPoint = mainDelegate.image3OutsideTableViewStartPoint;
    self.image4OutsideTableView.startPoint = mainDelegate.image4OutsideTableViewStartPoint;
    self.image5OutsideTableView.startPoint = mainDelegate.image5OutsideTableViewStartPoint;
}

-(void)viewDidDisappear:(BOOL)animated
{
    CipherAppDelegate *mainDelegate = (CipherAppDelegate *)[[UIApplication sharedApplication] delegate];
    mainDelegate.image1OutsideTableViewStartPoint = self.image1OutsideTableView.startPoint;
    mainDelegate.image2OutsideTableViewStartPoint = self.image2OutsideTableView.startPoint;
    mainDelegate.image3OutsideTableViewStartPoint = self.image3OutsideTableView.startPoint;
    mainDelegate.image4OutsideTableViewStartPoint = self.image4OutsideTableView.startPoint;
    mainDelegate.image5OutsideTableViewStartPoint = self.image5OutsideTableView.startPoint;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDelegates


#pragma mark own actions
- (IBAction)changePhoto:(id)sender {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        [imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
    }
    
    // image picker needs a delegate,
    [imagePickerController setDelegate:self];
    self.pop = [[UIPopoverController alloc] initWithContentViewController:imagePickerController];
    [self.pop presentPopoverFromRect:[sender frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    // Place image picker on the screen
    //[self presentViewController:imagePickerController animated:YES completion:nil];

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
            self.photoView.imageView.image = rotatedImage;
        }
    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //NSLog(@"didFinishPickingMediaWithInfo->%@",info);
    [picker dismissViewControllerAnimated:YES completion:^{
        NSData *pickedData = [[NSUserDefaults standardUserDefaults] objectForKey:@"clientPicture"];
        if (pickedData) self.photoView.imageView.image = [UIImage imageWithData:pickedData];
        else self.photoView.imageView.image = [UIImage imageNamed:@"ava.png"];
    }];
    
}



//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 10;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableViewLocal cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    CipherAppDelegate *mainDelegate = (CipherAppDelegate *)[[UIApplication sharedApplication] delegate];
//    static NSString *CellIdentifier = @"CipherViewCell";
//    CipherViewCell *cell = [tableViewLocal dequeueReusableCellWithIdentifier:CellIdentifier];
//    cell.controller = self;
//    cell.indexPath = indexPath;
////    NSLog(@"cell.image1InsideTableView.currentPointInsideTableViewCell->%ld cell.image1InsideTableView.hidden->%c",(long)cell.image1InsideTableView.currentPointInsideTableViewCell,cell.image1InsideTableView.hidden);
////    NSLog(@"cell.image2InsideTableView.currentPointInsideTableViewCell->%ld cell.image2InsideTableView.hidden->%c",(long)cell.image2InsideTableView.currentPointInsideTableViewCell,cell.image2InsideTableView.hidden);
////    NSLog(@"cell.image3InsideTableView.currentPointInsideTableViewCell->%ld cell.image3InsideTableView.hidden->%c",(long)cell.image3InsideTableView.currentPointInsideTableViewCell,cell.image3InsideTableView.hidden);
////    NSLog(@"cell.image4InsideTableView.currentPointInsideTableViewCell->%ld cell.image4InsideTableView.hidden->%c",(long)cell.image4InsideTableView.currentPointInsideTableViewCell,cell.image4InsideTableView.hidden);
////    NSLog(@"cell.image5InsideTableView.currentPointInsideTableViewCell->%ld cell.image5InsideTableView.hidden->%c",(long)cell.image5InsideTableView.currentPointInsideTableViewCell,cell.image5InsideTableView.hidden);
//    if (self.nextRowToFill.row >= indexPath.row) {
//        NSMutableArray *choosedColorsForEveryPoint = [mainDelegate.currentChoosesArray objectAtIndex:self.nextRowToFill.row];
//        cell.image1InsideTableView.hidden = YES;
//        cell.image2InsideTableView.hidden = YES;
//        cell.image3InsideTableView.hidden = YES;
//        cell.image4InsideTableView.hidden = YES;
//        cell.image5InsideTableView.hidden = YES;
//        [choosedColorsForEveryPoint enumerateObjectsUsingBlock:^(NSNumber *picNumber, NSUInteger idx, BOOL *stop) {
//            NSLog(@"indexPath.row->%ld idx->%lu picNumber->%@",(long)indexPath.row,(unsigned long)idx,picNumber);
//            switch (picNumber.unsignedIntegerValue) {
//                case 1:
//                    cell.image1InsideTableView.hidden = NO;
//                    if (self.nextRowToFill.row == indexPath.row) self.image1OutsideTableView.hidden = YES;
//                    else self.image1OutsideTableView.hidden = NO;
//                    cell.image1InsideTableView.currentPointInsideTableViewCell = idx;
//                    switch (idx) {
//                        case 0:
//                            cell.image1InsideTableView.frame = CGRectMake(cell.frame1.frame.origin.x, cell.frame1.frame.origin.y, cell.image1InsideTableView.frame.size.width, cell.image1InsideTableView.frame.size.height);
//                            break;
//                        case 1:
//                            cell.image1InsideTableView.frame = CGRectMake(cell.frame2.frame.origin.x, cell.frame2.frame.origin.y, cell.image1InsideTableView.frame.size.width, cell.image1InsideTableView.frame.size.height);
//                            break;
//                        case 2:
//                            cell.image1InsideTableView.frame = CGRectMake(cell.frame3.frame.origin.x, cell.frame3.frame.origin.y, cell.image1InsideTableView.frame.size.width, cell.image1InsideTableView.frame.size.height);
//                            break;
//                        case 3:
//                            cell.image1InsideTableView.frame = CGRectMake(cell.frame4.frame.origin.x, cell.frame4.frame.origin.y, cell.image1InsideTableView.frame.size.width, cell.image1InsideTableView.frame.size.height);
//                            break;
//
//                        default:
//                            break;
//                    }
//                    break;
//                case 2:
//                    cell.image2InsideTableView.hidden = NO;
//                    if (self.nextRowToFill.row == indexPath.row) self.image2OutsideTableView.hidden = YES;
//                    else self.image2OutsideTableView.hidden = NO;
//                    cell.image2InsideTableView.currentPointInsideTableViewCell = idx;
//                    switch (idx) {
//                        case 0:
//                            cell.image2InsideTableView.frame = CGRectMake(cell.frame1.frame.origin.x, cell.frame1.frame.origin.y, cell.image2InsideTableView.frame.size.width, cell.image2InsideTableView.frame.size.height);
//                            break;
//                        case 1:
//                            cell.image2InsideTableView.frame = CGRectMake(cell.frame2.frame.origin.x, cell.frame2.frame.origin.y, cell.image2InsideTableView.frame.size.width, cell.image2InsideTableView.frame.size.height);
//                            break;
//                        case 2:
//                            cell.image2InsideTableView.frame = CGRectMake(cell.frame3.frame.origin.x, cell.frame3.frame.origin.y, cell.image2InsideTableView.frame.size.width, cell.image2InsideTableView.frame.size.height);
//                            break;
//                        case 3:
//                            cell.image2InsideTableView.frame = CGRectMake(cell.frame4.frame.origin.x, cell.frame4.frame.origin.y, cell.image2InsideTableView.frame.size.width, cell.image2InsideTableView.frame.size.height);
//                            break;
//
//                        default:
//                            break;
//                    }
//                    break;
//                case 3:
//                    cell.image3InsideTableView.hidden = NO;
//                    if (self.nextRowToFill.row == indexPath.row) self.image3OutsideTableView.hidden = YES;
//                    else self.image3OutsideTableView.hidden = NO;
//                    cell.image3InsideTableView.currentPointInsideTableViewCell = idx;
//                    switch (idx) {
//                        case 0:
//                            cell.image3InsideTableView.frame = CGRectMake(cell.frame1.frame.origin.x, cell.frame1.frame.origin.y, cell.image3InsideTableView.frame.size.width, cell.image2InsideTableView.frame.size.height);
//                            break;
//                        case 1:
//                            cell.image3InsideTableView.frame = CGRectMake(cell.frame2.frame.origin.x, cell.frame2.frame.origin.y, cell.image3InsideTableView.frame.size.width, cell.image2InsideTableView.frame.size.height);
//                            break;
//                        case 2:
//                            cell.image3InsideTableView.frame = CGRectMake(cell.frame3.frame.origin.x, cell.frame3.frame.origin.y, cell.image3InsideTableView.frame.size.width, cell.image2InsideTableView.frame.size.height);
//                            break;
//                        case 3:
//                            cell.image3InsideTableView.frame = CGRectMake(cell.frame4.frame.origin.x, cell.frame4.frame.origin.y, cell.image3InsideTableView.frame.size.width, cell.image2InsideTableView.frame.size.height);
//                            break;
//
//                        default:
//                            break;
//                    }
//
//                    break;
//                case 4:
//                    cell.image4InsideTableView.hidden = NO;
//                    if (self.nextRowToFill.row == indexPath.row) self.image4OutsideTableView.hidden = YES;
//                    else self.image4OutsideTableView.hidden = NO;
//                    cell.image4InsideTableView.currentPointInsideTableViewCell = idx;
//                    switch (idx) {
//                        case 0:
//                            cell.image4InsideTableView.frame = CGRectMake(cell.frame1.frame.origin.x, cell.frame1.frame.origin.y, cell.image4InsideTableView.frame.size.width, cell.image4InsideTableView.frame.size.height);
//                            break;
//                        case 1:
//                            cell.image4InsideTableView.frame = CGRectMake(cell.frame2.frame.origin.x, cell.frame2.frame.origin.y, cell.image4InsideTableView.frame.size.width, cell.image4InsideTableView.frame.size.height);
//                            break;
//                        case 2:
//                            cell.image4InsideTableView.frame = CGRectMake(cell.frame3.frame.origin.x, cell.frame3.frame.origin.y, cell.image4InsideTableView.frame.size.width, cell.image4InsideTableView.frame.size.height);
//                            break;
//                        case 3:
//                            cell.image4InsideTableView.frame = CGRectMake(cell.frame4.frame.origin.x, cell.frame4.frame.origin.y, cell.image4InsideTableView.frame.size.width, cell.image4InsideTableView.frame.size.height);
//                            break;
//
//                        default:
//                            break;
//                    }
//
//                    break;
//                case 5:
//                    cell.image5InsideTableView.hidden = NO;
//                    cell.image5InsideTableView.currentPointInsideTableViewCell = idx;
//                    if (self.nextRowToFill.row == indexPath.row) self.image5OutsideTableView.hidden = YES;
//                    else self.image5OutsideTableView.hidden = NO;
//                    switch (idx) {
//                        case 0:
//                            cell.image5InsideTableView.frame = CGRectMake(cell.frame1.frame.origin.x, cell.frame1.frame.origin.y, cell.image5InsideTableView.frame.size.width, cell.image4InsideTableView.frame.size.height);
//                            break;
//                        case 1:
//                            cell.image5InsideTableView.frame = CGRectMake(cell.frame2.frame.origin.x, cell.frame2.frame.origin.y, cell.image5InsideTableView.frame.size.width, cell.image4InsideTableView.frame.size.height);
//                            break;
//                        case 2:
//                            cell.image5InsideTableView.frame = CGRectMake(cell.frame3.frame.origin.x, cell.frame3.frame.origin.y, cell.image5InsideTableView.frame.size.width, cell.image4InsideTableView.frame.size.height);
//                            break;
//                        case 3:
//                            cell.image5InsideTableView.frame = CGRectMake(cell.frame4.frame.origin.x, cell.frame4.frame.origin.y, cell.image5InsideTableView.frame.size.width, cell.image4InsideTableView.frame.size.height);
//                            break;
//
//                        default:
//                            break;
//                    }
//
//                    break;
//
//                default:
//                    break;
//            }
//        }];
//        cell.hidingView.alpha = 0.0,
//        cell.hidingView.userInteractionEnabled = NO;
//        if (self.nextRowToFill.row == indexPath.row) {
//            self.frameSelectedCell = cell.frame;
//            NSLog(@"self.frameSelectedCell->%@",NSStringFromCGRect(self.frameSelectedCell));
//        } else {
//            cell.image1InsideTableView.userInteractionEnabled = NO;
//            cell.image2InsideTableView.userInteractionEnabled = NO;
//            cell.image3InsideTableView.userInteractionEnabled = NO;
//            cell.image4InsideTableView.userInteractionEnabled = NO;
//            cell.image5InsideTableView.userInteractionEnabled = NO;
//            if (self.image1OutsideTableView.isCanceledTouches) self.image1OutsideTableView.isCanceledTouches = NO;
//            if (self.image2OutsideTableView.isCanceledTouches) self.image2OutsideTableView.isCanceledTouches = NO;
//            if (self.image3OutsideTableView.isCanceledTouches) self.image3OutsideTableView.isCanceledTouches = NO;
//            if (self.image4OutsideTableView.isCanceledTouches) self.image4OutsideTableView.isCanceledTouches = NO;
//            if (self.image5OutsideTableView.isCanceledTouches) self.image5OutsideTableView.isCanceledTouches = NO;
//        }
//    } else {
//        cell.hidingView.alpha = 0.5,cell.hidingView.userInteractionEnabled = YES;
//        cell.image1InsideTableView.hidden = YES;
//        cell.image2InsideTableView.hidden = YES;
//        cell.image3InsideTableView.hidden = YES;
//        cell.image4InsideTableView.hidden = YES;
//        cell.image5InsideTableView.hidden = YES;
//    }
//    return cell;
//}



- (void)viewDidUnload {
    [self setRow1image2:nil];
    [self setRow1image3:nil];
    [self setRow1image4:nil];
    [self setRow1image5:nil];
    [self setRow1frame2:nil];
    [self setRow1frame3:nil];
    [self setRow1frame4:nil];
    [super viewDidUnload];
}
@end
