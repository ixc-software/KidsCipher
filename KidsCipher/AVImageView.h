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

@property (strong, nonatomic) AVAudioPlayer *theAudio;

@property (strong, nonatomic) NSString *imageName;

@property (readwrite) CGPoint offset;
@property (readwrite) CGPoint startPoint;
@property (readwrite) BOOL isScalled;


@end
