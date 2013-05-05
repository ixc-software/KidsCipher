//
//  AVButton.h
//  RabbitVsBear
//
//  Created by Oleksii Vynogradov on 3/29/12.
//  Copyright (c) 2012 IXC-USA Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@class DataViewController;

@interface AVImageView : UIImageView <AVAudioPlayerDelegate>{
    
    
    
    
}
//-(CGPoint) calculatePositionForPoint:(CGPoint)location;

@property (strong, nonatomic) AVAudioPlayer *imageStartTouching;
@property (strong, nonatomic) AVAudioPlayer *imagePuttedIntoRow;
@property (strong, nonatomic) AVAudioPlayer *imageCancel;

//@property (strong, nonatomic) NSString *imageName;

@property (readwrite) CGPoint offset;
@property (readwrite) BOOL isScalled;
@property (retain,nonatomic) NSString *uniqueIdentifier;

//@property (readwrite) CGPoint startDraggedPoint;
//@property (readwrite) BOOL isCanceledTouches;

//@property NSInteger currentPointInsideTableViewCell;

@end
