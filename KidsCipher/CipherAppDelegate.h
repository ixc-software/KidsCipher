//
//  CipherAppDelegate.h
//  KidsCipher
//
//  Created by Oleksii Vynogradov on 4/29/13.
//  Copyright (c) 2013 IXC-USA Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"
#import <AVFoundation/AVFoundation.h>
#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)

@interface CipherAppDelegate : UIResponder <UIApplicationDelegate,AVAudioPlayerDelegate>
@property (retain, nonatomic) AVAudioPlayer* audioPlayerMainFoneMusic;
//@property (strong, nonatomic) AVAudioPlayer *gameZeroResult;
@property (retain, nonatomic) AVAudioPlayer *gameWrongResult;
@property (retain, nonatomic) AVAudioPlayer *gameSuccessResult;

@property (strong, nonatomic) UIWindow *window;
@property (retain,nonatomic) NSMutableDictionary *viewControllers;
- (void)registerViewController:(NSString *)name controller:(UIViewController *)controller;
//@property (readwrite) CGPoint image1OutsideTableViewStartPoint;
//@property (readwrite) CGPoint image2OutsideTableViewStartPoint;
//@property (readwrite) CGPoint image3OutsideTableViewStartPoint;
//@property (readwrite) CGPoint image4OutsideTableViewStartPoint;
//@property (readwrite) CGPoint image5OutsideTableViewStartPoint;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (retain,nonatomic) Game *game;

@property (retain) NSMutableString *firstServer;
@property (retain) NSMutableString *secondServer;
@property (retain) NSMutableString *urlChoosed;
@property (retain) NSMutableDictionary *allURLs;

@property (retain) NSMutableString *appleID;

@property (readwrite) BOOL isMessageConfirmed;
@property (readwrite) BOOL downloadCompleted;
@property (retain, nonatomic) NSMutableData *receivedData;
@property (retain) NSNumber *downloadSize;
@property (retain) NSNumber *downloadedPages;
@property (nonatomic, retain) NSData *deviceToken;
@property (retain) NSMutableString *messageFull;
@property (retain, nonatomic) NSTimer *gameTimer;
@property (readwrite) BOOL isTraining;
@property (readwrite) NSUInteger gameTimerSeconds;

@property (readwrite) BOOL isNewRowProcessing;

-(void)setAllRowFilledForGameSuccess;

@property (readwrite) BOOL isBackgroundMusicPlaying;

//@property (readwrite) BOOL isJailbroken;

-(Row *)getActiveRow;
-(Row *)getRowBeforeActiveRow;

- (void)saveContext;
-(void) setRandomCombinationForCurrentGame;
-(void) sendNewGamescore:(NSManagedObjectID *)gamescoreID;

@end
