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
@property (retain, nonatomic) IBOutlet UIView *row1HidingView;
@property (retain, nonatomic) IBOutlet UIView *row2HidingView;

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
//    mainDelegate.image1OutsideTableViewStartPoint = self.image1OutsideTableView.startPoint;
//    mainDelegate.image2OutsideTableViewStartPoint = self.image2OutsideTableView.startPoint;
//    mainDelegate.image3OutsideTableViewStartPoint = self.image3OutsideTableView.startPoint;
//    mainDelegate.image4OutsideTableViewStartPoint = self.image4OutsideTableView.startPoint;
//    mainDelegate.image5OutsideTableViewStartPoint = self.image5OutsideTableView.startPoint;
//    NSLog(@"mainDelegate.image1OutsideTableViewStartPoint->%@",NSStringFromCGPoint(mainDelegate.image1OutsideTableViewStartPoint));
    self.row1HidingView.hidden = YES;
    self.row1HidingView.userInteractionEnabled = NO;
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
    NSLog(@"viewWillAppear mainDelegate.image1OutsideTableViewStartPoint->%@ self.image1OutsideTableView.frame->%@",NSStringFromCGPoint(mainDelegate.image1OutsideTableViewStartPoint),NSStringFromCGRect(self.image1OutsideTableView.frame));
}

-(void)viewDidDisappear:(BOOL)animated
{
    CipherAppDelegate *mainDelegate = (CipherAppDelegate *)[[UIApplication sharedApplication] delegate];
    mainDelegate.image1OutsideTableViewStartPoint = self.image1OutsideTableView.startPoint;
    mainDelegate.image2OutsideTableViewStartPoint = self.image2OutsideTableView.startPoint;
    mainDelegate.image3OutsideTableViewStartPoint = self.image3OutsideTableView.startPoint;
    mainDelegate.image4OutsideTableViewStartPoint = self.image4OutsideTableView.startPoint;
    mainDelegate.image5OutsideTableViewStartPoint = self.image5OutsideTableView.startPoint;
    NSLog(@"viewDidDisappear mainDelegate.image1OutsideTableViewStartPoint->%@",NSStringFromCGPoint(mainDelegate.image1OutsideTableViewStartPoint));
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

-(void)startCompletingCurrentRowAndOpenNext;
{
    
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



- (void)viewDidUnload {
    [self setRow1image2:nil];
    [self setRow1image3:nil];
    [self setRow1image4:nil];
    [self setRow1image5:nil];
    [self setRow1frame2:nil];
    [self setRow1frame3:nil];
    [self setRow1frame4:nil];
    [self setRow1HidingView:nil];
    [self setRow2HidingView:nil];
    [super viewDidUnload];
}
@end
