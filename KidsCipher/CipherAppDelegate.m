//
//  CipherAppDelegate.m
//  KidsCipher
//
//  Created by Oleksii Vynogradov on 4/29/13.
//  Copyright (c) 2013 IXC-USA Corp. All rights reserved.
//

#import "CipherAppDelegate.h"
#import "Game.h"
#import "GameScore.h"
#import "GamesHistory.h"
#import "Row.h"
#import "CipherViewController.h"
#import <CommonCrypto/CommonDigest.h>
#import <AddressBook/AddressBook.h>
#import "Flurry.h"

#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>


@implementation CipherAppDelegate
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize audioPlayerMainFoneMusic = _audioPlayerMainFoneMusic;

- (NSString *)getMacAddress
{
    int                 mgmtInfoBase[6];
    char                *msgBuffer = NULL;
    size_t              length;
    unsigned char       macAddress[6];
    struct if_msghdr    *interfaceMsgStruct;
    struct sockaddr_dl  *socketStruct;
    NSString            *errorFlag = NULL;
    
    // Setup the management Information Base (mib)
    mgmtInfoBase[0] = CTL_NET;        // Request network subsystem
    mgmtInfoBase[1] = AF_ROUTE;       // Routing table info
    mgmtInfoBase[2] = 0;
    mgmtInfoBase[3] = AF_LINK;        // Request link layer information
    mgmtInfoBase[4] = NET_RT_IFLIST;  // Request all configured interfaces
    
    // With all configured interfaces requested, get handle index
    if ((mgmtInfoBase[5] = if_nametoindex("en0")) == 0)
        errorFlag = @"if_nametoindex failure";
    else
    {
        // Get the size of the data available (store in len)
        if (sysctl(mgmtInfoBase, 6, NULL, &length, NULL, 0) < 0)
            errorFlag = @"sysctl mgmtInfoBase failure";
        else
        {
            // Alloc memory based on above call
            if ((msgBuffer = malloc(length)) == NULL)
                errorFlag = @"buffer allocation failure";
            else
            {
                // Get system information, store in buffer
                if (sysctl(mgmtInfoBase, 6, msgBuffer, &length, NULL, 0) < 0)
                    errorFlag = @"sysctl msgBuffer failure";
            }
        }
    }
    
    // Befor going any further...
    if (errorFlag != NULL)
    {
        NSLog(@"Error: %@", errorFlag);
        return errorFlag;
    }
    
    // Map msgbuffer to interface message structure
    interfaceMsgStruct = (struct if_msghdr *) msgBuffer;
    
    // Map to link-level socket structure
    socketStruct = (struct sockaddr_dl *) (interfaceMsgStruct + 1);
    
    // Copy link layer address data in socket structure to an array
    memcpy(&macAddress, socketStruct->sdl_data + socketStruct->sdl_nlen, 6);
    
    // Read from char array into a string object, into traditional Mac address format
    NSString *macAddressString = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                                  macAddress[0], macAddress[1], macAddress[2],
                                  macAddress[3], macAddress[4], macAddress[5]];
    //NSLog(@"Mac Address: %@", macAddressString);
    
    // Release the buffer memory
    free(msgBuffer);
    
    return macAddressString;
}


-(NSString*)md5HexDigest:(NSString*)input {
    const char* str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, strlen(str), result);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}


-(NSString *) hashForEmail:(NSString *)email withDateString:(NSString *)dateString;
{
    if (email && dateString) {
        //ab47fde53b2a335e107f5986d7bed0bfd4c8bc44
        NSString *fixedString = [NSString stringWithFormat:@"%c%s%c%@", 'a', "b47fde53b2a335", 'e', @"107f5986d7bed0bfd4c8bc44"];
        NSString *lastDigit = [dateString substringWithRange:NSMakeRange(dateString.length - 1, 1)];
        NSNumberFormatter *number = [[NSNumberFormatter alloc] init];
        NSNumber *lastDigitFromDate = [number numberFromString:lastDigit];
        NSString *forAuthtorization = nil;
        if (lastDigitFromDate.integerValue == 0) {
            // zero
            forAuthtorization = [NSString stringWithFormat:@"%@%@%@",email,fixedString,dateString];
        } if  (lastDigitFromDate.integerValue % 2) {
            //odd
            forAuthtorization = [NSString stringWithFormat:@"%@%@%@",email,dateString,fixedString];
        } else {
            //even
            forAuthtorization = [NSString stringWithFormat:@"%@%@%@",dateString,email,fixedString];
        }
        NSString *hashForReturn = [self md5HexDigest:forAuthtorization];
        //NSLog(@"AUTHORIZATION:for auth:%@ hash:%@",forAuthtorization,hashForReturn);
        return hashForReturn;
    }
    return nil;
}

static const short _base64DecodingTable[256] = {
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -1, -1, -2, -1, -1, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
	-1, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, 62, -2, -2, -2, 63,
	52, 53, 54, 55, 56, 57, 58, 59, 60, 61, -2, -2, -2, -2, -2, -2,
	-2,  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14,
	15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -2, -2, -2, -2, -2,
	-2, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
	41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, -2, -2, -2, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
	-2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2
};


- (NSData *)decodeBase64:(NSString *)input {
    const char * objPointer = [input cStringUsingEncoding:NSASCIIStringEncoding];
	unsigned long intLength = strlen(objPointer);
	int intCurrent;
	int i = 0, j = 0, k;
    
	unsigned char * objResult;
	objResult = calloc(intLength, sizeof(char));
    
	// Run through the whole string, converting as we go
	while ( ((intCurrent = *objPointer++) != '\0') && (intLength-- > 0) ) {
		if (intCurrent == '=') {
			if (*objPointer != '=' && ((i % 4) == 1)) {// || (intLength > 0)) {
				// the padding character is invalid at this point -- so this entire string is invalid
				free(objResult);
				return nil;
			}
			continue;
		}
        
		intCurrent = _base64DecodingTable[intCurrent];
		if (intCurrent == -1) {
			// we're at a whitespace -- simply skip over
			continue;
		} else if (intCurrent == -2) {
			// we're at an invalid character
			free(objResult);
			return nil;
		}
        
		switch (i % 4) {
			case 0:
				objResult[j] = intCurrent << 2;
				break;
                
			case 1:
				objResult[j++] |= intCurrent >> 4;
				objResult[j] = (intCurrent & 0x0f) << 4;
				break;
                
			case 2:
				objResult[j++] |= intCurrent >>2;
				objResult[j] = (intCurrent & 0x03) << 6;
				break;
                
			case 3:
				objResult[j++] |= intCurrent;
				break;
		}
		i++;
	}
    
	// mop things up if we ended on a boundary
	k = j;
	if (intCurrent == '=') {
		switch (i % 4) {
			case 1:
				// Invalid state
				free(objResult);
				return nil;
                
			case 2:
				k++;
				// flow through
			case 3:
				objResult[k] = 0;
		}
	}
    
	// Cleanup and setup the return NSData
	NSData * objData = [[NSData alloc] initWithBytes:objResult length:j];
	free(objResult);
    return objData;
}




static unsigned char base64EncodeLookup[65] =
"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";


-(NSString *) encodeTobase64InputData:(NSData *)data
{
    
    const void *buffer = [data bytes];
    size_t length = [data length];
    bool separateLines = true;
    //    size_t outputLength = 0;
    
    const unsigned char *inputBuffer = (const unsigned char *)buffer;
    
#define BINARY_UNIT_SIZE 3
#define BASE64_UNIT_SIZE 4
    
#define MAX_NUM_PADDING_CHARS 2
#define OUTPUT_LINE_LENGTH 64
#define INPUT_LINE_LENGTH ((OUTPUT_LINE_LENGTH / BASE64_UNIT_SIZE) * BINARY_UNIT_SIZE)
#define CR_LF_SIZE 2
    
    //
    // Byte accurate calculation of final buffer size
    //
    size_t outputBufferSize =
    ((length / BINARY_UNIT_SIZE)
     + ((length % BINARY_UNIT_SIZE) ? 1 : 0))
    * BASE64_UNIT_SIZE;
    if (separateLines)
    {
        outputBufferSize +=
        (outputBufferSize / OUTPUT_LINE_LENGTH) * CR_LF_SIZE;
    }
    
    //
    // Include space for a terminating zero
    //
    outputBufferSize += 1;
    
    //
    // Allocate the output buffer
    //
    char *outputBuffer = (char *)malloc(outputBufferSize);
    if (!outputBuffer)
    {
        return NULL;
    }
    
    size_t i = 0;
    size_t j = 0;
    const size_t lineLength = separateLines ? INPUT_LINE_LENGTH : length;
    size_t lineEnd = lineLength;
    
    while (true)
    {
        if (lineEnd > length)
        {
            lineEnd = length;
        }
        
        for (; i + BINARY_UNIT_SIZE - 1 < lineEnd; i += BINARY_UNIT_SIZE)
        {
            //
            // Inner loop: turn 48 bytes into 64 base64 characters
            //
            outputBuffer[j++] = base64EncodeLookup[(inputBuffer[i] & 0xFC) >> 2];
            outputBuffer[j++] = base64EncodeLookup[((inputBuffer[i] & 0x03) << 4)
                                                   | ((inputBuffer[i + 1] & 0xF0) >> 4)];
            outputBuffer[j++] = base64EncodeLookup[((inputBuffer[i + 1] & 0x0F) << 2)
                                                   | ((inputBuffer[i + 2] & 0xC0) >> 6)];
            outputBuffer[j++] = base64EncodeLookup[inputBuffer[i + 2] & 0x3F];
        }
        
        if (lineEnd == length)
        {
            break;
        }
        
        //
        // Add the newline
        //
        outputBuffer[j++] = '\r';
        outputBuffer[j++] = '\n';
        lineEnd += lineLength;
    }
    
    if (i + 1 < length)
    {
        //
        // Handle the single '=' case
        //
        outputBuffer[j++] = base64EncodeLookup[(inputBuffer[i] & 0xFC) >> 2];
        outputBuffer[j++] = base64EncodeLookup[((inputBuffer[i] & 0x03) << 4)
                                               | ((inputBuffer[i + 1] & 0xF0) >> 4)];
        outputBuffer[j++] = base64EncodeLookup[(inputBuffer[i + 1] & 0x0F) << 2];
        outputBuffer[j++] =	'=';
    }
    else if (i < length)
    {
        //
        // Handle the double '=' case
        //
        outputBuffer[j++] = base64EncodeLookup[(inputBuffer[i] & 0xFC) >> 2];
        outputBuffer[j++] = base64EncodeLookup[(inputBuffer[i] & 0x03) << 4];
        outputBuffer[j++] = '=';
        outputBuffer[j++] = '=';
    }
    outputBuffer[j] = 0;
    
    //
    // Set the output length and return the buffer
    //
    //    if (outputLength)
    //    {
    //        outputLength = j;
    //    }
    
    //    return outputBuffer;
    
	NSString *result = [[NSString alloc] initWithBytes:outputBuffer length:j encoding:NSASCIIStringEncoding];
    
    return result;
}

#pragma mark - NSURLConnection delegate
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
    _downloadCompleted = YES;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    //NSNumber *percentDone = [NSNumber numberWithDouble:[[NSNumber numberWithUnsignedInteger:[receivedData length]] doubleValue] / [self.downloadSize doubleValue]];
    
    //NSLog(@">>>>>>didReceiveData data.lenght->%@",percentDone);
    // Append the new data to receivedData.
    if (_receivedData) [_receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    //NSLog(@">>>>>>>>>>didReceiveResponse");
    self.downloadSize = [[NSNumber alloc] initWithLongLong:[response expectedContentLength]];
    
    if (_receivedData) [_receivedData setLength:0];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //NSLog(@"Succeeded! Received %@ bytes of data",[NSNumber numberWithUnsignedInteger:[receivedData length]]);
    _downloadCompleted = YES;
}
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    //NSLog(@">>>>>>canAuthenticateAgainstProtectionSpace");
    
    return YES;
}


- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    //NSLog(@">>>>>>didReceiveAuthenticationChallenge");
    
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
    {
        
        SecTrustRef trustRef = [[challenge protectionSpace] serverTrust];
        SecTrustEvaluate(trustRef, NULL);
        CFIndex count = SecTrustGetCertificateCount(trustRef);
        BOOL trust = NO;
        if(count > 0){
            SecCertificateRef certRef = SecTrustGetCertificateAtIndex(trustRef, 0);
            CFStringRef certSummary = SecCertificateCopySubjectSummary(certRef);
            //NSString* certSummaryNs = (__bridge NSString*)certSummary;
            //NSLog(@"cert name:%@",certSummaryNs);
            
            NSData *data = (__bridge_transfer NSData *) SecCertificateCopyData(certRef);
            // .. we have a certificate in DER format!
            //NSLog(@"received:%@",data);
            
            NSURL *indexURL = [[NSBundle mainBundle] URLForResource:@"webcob" withExtension:@"p12"];
            
            NSData *localP12 = [NSData dataWithContentsOfURL:indexURL];
            
            NSMutableDictionary * options = [[NSMutableDictionary alloc] init];
            
            // Set the public key query dictionary
            //change to your .pfx  password here
            NSString *password = [NSString stringWithFormat:@"%c%s%c%@", 'M', "anua", 'l', @"12"];
            
            
            [options setObject:password forKey:(__bridge id)kSecImportExportPassphrase];
            
            CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
            
            OSStatus securityError = SecPKCS12Import((__bridge CFDataRef) localP12,
                                                     (__bridge CFDictionaryRef)options, &items);
            
            if (securityError == noErr) {
                // good
            } else {
                //bad
            }
            
            CFDictionaryRef identityDict = CFArrayGetValueAtIndex(items, 0);
            CFArrayRef certificates =
            (CFArrayRef)CFDictionaryGetValue(identityDict,
                                             kSecImportItemCertChain);
            
            SecCertificateRef localCert = (SecCertificateRef)CFArrayGetValueAtIndex(certificates,0);
            CFDataRef dataLocal = SecCertificateCopyData(localCert);
            
            NSData *local = (__bridge NSData *)dataLocal;
            
            //NSLog(@"local:%@",local);
            
            if ([data isEqualToData:local]) trust = YES;
            //else NSLog(@"wrong");
            
            //            if([certSummaryNs isEqualToString:@"webcob.net"]){ // split host n
            //                trust = YES;
            //            }else{
            //                NSLog(@"Certificate name does not have required common name");
            //            }
            CFRelease(certSummary);
        }
        if(trust){
            [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
        }else{
            [challenge.sender cancelAuthenticationChallenge:challenge];
        }
    } else {
        
    }
    //    NSString *user = [NSString stringWithFormat:@"%c%s%@", 'a', "le", @"x"];
    //    NSString *password = [NSString stringWithFormat:@"%c%s%c%@", 'A', "87AE19C-FEBB", '-', @"4C4C-A534-3CD036ED072A"];
    //
    //    NSURLCredential *credential = [NSURLCredential credentialWithUser:user
    //                                                             password:password
    //                                                          persistence:NSURLCredentialPersistenceForSession];
    //    [[challenge sender] useCredential:credential forAuthenticationChallenge:challenge];
}


-(NSDictionary *) getJSONAnswerForFunction:(NSString *)function withJSONRequest:(NSMutableDictionary *)request forServer:(NSString *)server;
{
    _downloadCompleted = NO;
    if (!_receivedData) _receivedData = [[NSMutableData alloc] init];
    else [_receivedData setLength:0];
    
    dispatch_async(dispatch_get_main_queue(), ^(void) {
        NSError *error = nil;
        NSData* bodyData = [NSJSONSerialization dataWithJSONObject:request
                                                           options:NSJSONWritingPrettyPrinted error:&error];
        if (error) NSLog(@"CLIENT CONTROLLER: json decoding error:%@ in function:%@",[error localizedDescription],function);
        NSData *dataForBody = [[NSData alloc] initWithData:bodyData];
        NSString *functionString = [NSString stringWithFormat:@"/%@",function];
        NSURL *urlForRequest = [NSURL URLWithString:functionString relativeToURL:[NSURL URLWithString:server]];
        NSMutableURLRequest *requestToServer = [NSMutableURLRequest requestWithURL:urlForRequest cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:5.0];
        [requestToServer setHTTPMethod:@"POST"];
        [requestToServer setHTTPBody:dataForBody];
        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:requestToServer delegate:self startImmediately:YES];
        if (!connection) NSLog(@"failedToCreate");
    });
    NSUInteger countAttempts = 0;
    while (!_downloadCompleted) {
        countAttempts++;
        if (countAttempts > 10000) {
            return nil;
        } else sleep(1);
        //NSLog(@"waiting for completed");
    }
    NSData *receivedResult = [[NSData alloc] initWithData:_receivedData];
    NSError *error = nil;
    NSDictionary *finalResult = [NSJSONSerialization
                                 JSONObjectWithData:receivedResult
                                 options:NSJSONReadingMutableLeaves
                                 error:&error];
    
    if (error && receivedResult && receivedResult.length > 0) NSLog(@"failed to decode answer:%@ with error:%@", [NSString stringWithUTF8String:[receivedResult bytes]],[error localizedDescription]);
    NSArray *scores = [finalResult valueForKey:@"scores"];
    if (scores && scores.count > 0) {
        NSManagedObjectContext *child = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        child.parentContext = self.managedObjectContext;
        child.undoManager = nil;
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"GameScore" inManagedObjectContext:child];
        [fetchRequest setEntity:entity];
        NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
        fetchRequest.sortDescriptors = [NSArray arrayWithObject:sort];
        NSArray *fetchedObjects = [child executeFetchRequest:fetchRequest error:&error];
        if (fetchedObjects == nil) NSLog(@"Failed to executeFetchRequest to data store: %@ in function:%@", [error localizedDescription],NSStringFromSelector(_cmd));
        [fetchedObjects enumerateObjectsUsingBlock:^(GameScore *previousScore, NSUInteger idx, BOOL *stop) {
            [child deleteObject:previousScore];
        }];
        [child performBlockAndWait:^{
            NSError *childError = nil;
            [child save:&childError];
            if (childError)  NSLog(@"%@:%@ Child Error Received: %@", [self class], NSStringFromSelector(_cmd),
                                   [childError localizedDescription]);
            [self.managedObjectContext performBlockAndWait:^{
                NSError *parentError = nil;
                [self.managedObjectContext save:&parentError];
                if (parentError)  NSLog(@"%@:%@ Parent Error Received: %@", [self class], NSStringFromSelector(_cmd),
                                       [childError localizedDescription]);

            }];
        }];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmssSSS";

        [scores enumerateObjectsUsingBlock:^(NSDictionary *row, NSUInteger idx, BOOL *stop) {
            NSString *guid = [row valueForKey:@"guid"];
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"GameScore" inManagedObjectContext:child];
            [fetchRequest setEntity:entity];
            fetchRequest.predicate = [NSPredicate predicateWithFormat:@"guid == %@",guid];
            NSArray *fetchedObjects = [child executeFetchRequest:fetchRequest error:NULL];
            if (fetchedObjects.count == 0) {
                GameScore *newScore = (GameScore *)[NSEntityDescription insertNewObjectForEntityForName:@"GameScore" inManagedObjectContext:child];
                NSNumber *attempts = [row valueForKey:@"attempts"];
                NSString *date = [row valueForKey:@"date"];
                NSNumber *difficultLevel = [row valueForKey:@"difficultLevel"];
                NSNumber *gameTime = [row valueForKey:@"gameTime"];
                NSString *name = [row valueForKey:@"name"];
                NSString *photo = [row valueForKey:@"photo"];
                NSDate *dateReal = [formatter dateFromString:date];
                
                newScore.date = dateReal;
                if (photo && photo.length > 0) {
                    NSData *photoReal = [self decodeBase64:photo];
                    newScore.photo = photoReal;
                }
                newScore.attempts = attempts;
                newScore.difficultLevel = difficultLevel;
                newScore.gameTime = gameTime;
                newScore.name = name;
            }
        }];
        [child performBlockAndWait:^{
            NSError *childError = nil;
            [child save:&childError];
            if (childError)  NSLog(@"%@:%@ Child Error Received: %@", [self class], NSStringFromSelector(_cmd),
                                   [childError localizedDescription]);
            [self.managedObjectContext performBlockAndWait:^{
                NSError *parentError = nil;
                [self.managedObjectContext save:&parentError];
                if (parentError)  NSLog(@"%@:%@ Parent Error Received: %@", [self class], NSStringFromSelector(_cmd),
                                        [childError localizedDescription]);
                
            }];
        }];
    }
    return finalResult;
    
}

-(NSArray *)allContacts;
{
    NSArray *allContactsLocal = [[NSUserDefaults standardUserDefaults] valueForKey:@"allContacts"];
    NSMutableArray *allContacts = [NSMutableArray arrayWithArray:allContactsLocal];
    
    if (allContacts.count > 0) [allContacts removeAllObjects];
    ABAddressBookRef ab = ABAddressBookCreate();
    __block BOOL accessGranted = NO;
    if (ABAddressBookRequestAccessWithCompletion != NULL) { // we're on iOS 6
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(ab, ^(bool granted, CFErrorRef error) {
            accessGranted = granted;
            dispatch_semaphore_signal(sema);
        });
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        dispatch_release(sema);
    } else { // we're on iOS 5 or older
        accessGranted = YES;
    }
    
    if (ab) {
        
        NSArray *arrTemp=(__bridge NSArray *)ABAddressBookCopyArrayOfAllPeople(ab);
        
        for (int i=0;i < [arrTemp count];i++)
        {
            NSMutableDictionary *dicContact = [[NSMutableDictionary alloc] init];
            
            NSString *firstName = (__bridge NSString *) ABRecordCopyValue((__bridge ABRecordRef)[arrTemp objectAtIndex:i], kABPersonFirstNameProperty);
            if (firstName) {
                [dicContact setValue:firstName forKey:@"firstName"];
                
            }
            NSString *lastName = (__bridge NSString *) ABRecordCopyValue((__bridge ABRecordRef)[arrTemp objectAtIndex:i], kABPersonLastNameProperty);
            if (lastName) {
                [dicContact setValue:lastName forKey:@"lastName"];
            }
            
            NSString *organization = (__bridge NSString *) ABRecordCopyValue((__bridge ABRecordRef)[arrTemp objectAtIndex:i], kABPersonOrganizationProperty);
            if (organization) {
                [dicContact setValue:organization forKey:@"organization"];
            }
            
            NSString *jobTitle = (__bridge NSString *) ABRecordCopyValue((__bridge ABRecordRef)[arrTemp objectAtIndex:i], kABPersonJobTitleProperty);
            if (jobTitle) {
                [dicContact setValue:jobTitle forKey:@"jobTitle"];
            }
            
            ABMultiValueRef emails = ABRecordCopyValue((__bridge ABMultiValueRef)[arrTemp objectAtIndex:i], kABPersonEmailProperty);
            //        str=(__bridge NSString *) emails;
            
            if (emails) {
                int size = ABMultiValueGetCount(emails);
                if (size > 0) {
                    NSMutableArray *allEmails = [NSMutableArray array];
                    
                    for (int count = 0; count < size; count++) {
                        NSMutableDictionary *emailDict = [[NSMutableDictionary alloc] init];
                        
                        NSString *email = (__bridge NSString*)ABMultiValueCopyValueAtIndex(emails, count);
                        NSString *type = (__bridge NSString*)ABMultiValueCopyLabelAtIndex(emails, count);
                        
                        if (email && type) {
                            [emailDict setValue:email forKey:type];
                            [allEmails addObject:emailDict];
                        }
                    }
                    if (allEmails.count > 0)  [dicContact setValue:allEmails forKey:@"allEmails"];
                    
                }
                
            }
            
            NSDate *birthday = (__bridge NSDate *) ABRecordCopyValue((__bridge ABRecordRef)[arrTemp objectAtIndex:i], kABPersonBirthdayProperty);
            if (birthday) {
                [dicContact setValue:birthday forKey:@"birthtday"];
            }
            
            NSDate *modification =(__bridge NSDate *) ABRecordCopyValue((__bridge ABRecordRef)[arrTemp objectAtIndex:i], kABPersonModificationDateProperty);
            if (modification) {
                [dicContact setValue:modification forKey:@"modificationDate"];
            }
            
            ABMultiValueRef phones = ABRecordCopyValue((__bridge ABMultiValueRef)[arrTemp objectAtIndex:i], kABPersonPhoneProperty);
            if (phones) {
                int size = ABMultiValueGetCount(phones);
                if (size > 0) {
                    NSMutableArray *allPhones = [NSMutableArray array];
                    
                    for (int count =0; count < size; count++) {
                        NSMutableDictionary *phoneDict = [[NSMutableDictionary alloc] init];
                        NSString *phone = (__bridge NSString*)ABMultiValueCopyValueAtIndex(phones, count);
                        NSString *type = (__bridge NSString*)ABMultiValueCopyLabelAtIndex(phones, count);
                        if (phone && type) {
                            [phoneDict setValue:phone forKey:type];
                            [allPhones addObject:phoneDict];
                        }
                    }
                    if (allPhones.count > 0) [dicContact setValue:allPhones forKey:@"allPhones"];
                    
                }
            }
            
            [allContacts addObject:dicContact];
            //NSLog(@"add:%@",dicContactNormalized);
            
            
        }
        [[NSUserDefaults standardUserDefaults] setValue:allContacts forKey:@"allContacts"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    //NSLog(@"allContacts:%@",allContacts);
    return allContacts;
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceTokenReceived
{
    self.deviceToken = [[NSData alloc] initWithData:deviceTokenReceived];
    //NSLog(@"deviceToken received:%@",self.deviceToken);
    
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    //NSLog(@"error register push:%@",[error localizedDescription]);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
    NSLog(@"notification received:%@",userInfo);
    application.applicationIconBadgeNumber = 0;
    NSDictionary *apps = [userInfo valueForKey:@"aps"];
    NSNumber *badge = [apps objectForKey:@"badge"];
    
    _messageFull.string = [apps valueForKey:@"alert"];
    
    AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);
    
    
    if (badge.integerValue > 0) {
        _urlChoosed = [[NSMutableString alloc] initWithString:badge.stringValue];
        _allURLs = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"http://alert1.%@.webcob.net",_appleID],@"1",[NSString stringWithFormat:@"http://alert2.%@.webcob.net",_appleID],@"2",[NSString stringWithFormat:@"http://alert3.%@.webcob.net",_appleID],@"3",[NSString stringWithFormat:@"http://alert4.%@.webcob.net",_appleID],@"4",[NSString stringWithFormat:@"http://alert5.%@.webcob.net",_appleID],@"5", nil];
    } else {
        _urlChoosed.string = @"";
        
    }
    
    // We can determine whether an application is launched as a result of the user tapping the action
    // button or whether the notification was delivered to the already-running application by examining
    // the application state.
    
    if (application.applicationState == UIApplicationStateActive)
    {
        // Nothing to do if applicationState is Inactive, the iOS already displayed an alert view.
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Message from support team.",@"")
                                                            message:_messageFull
                                                           delegate:self
                                                  cancelButtonTitle:NSLocalizedString(@"Cancel",@"")
                                                  otherButtonTitles:NSLocalizedString(@"OK",@""), nil];
        _isMessageConfirmed = YES;
        [alertView show];
    } else  {
        _isMessageConfirmed = NO;
    }
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (_urlChoosed && _urlChoosed.length == 1 && buttonIndex == 1) {
        if (_allURLs) {
            NSString *urlToOpenString = [_allURLs valueForKey:_urlChoosed];
            NSURL *urlToOpen = [NSURL URLWithString:urlToOpenString];
            
            [[UIApplication sharedApplication] openURL:urlToOpen];
            _urlChoosed.string = @"";
            _isMessageConfirmed = YES;
            
        }
    }
    
    if (buttonIndex == 0) {
        _isMessageConfirmed = YES;
        
    }
}

#pragma mark - Server iteraction

-(void) sendNewGamescore:(NSManagedObjectID *)gamescoreID;
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^(void) {
        
        NSMutableDictionary *prepeareForJSONRequest = [[NSMutableDictionary alloc] init];
        NSManagedObjectContext *child = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        child.parentContext = self.managedObjectContext;
        child.undoManager = nil;
        GamesHistory *history = (GamesHistory *)[child existingObjectWithID:gamescoreID error:NULL];

        if (!history) {
            NSLog(@"HISTORY NOT EXIST");
            return;
        }
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmssSSS";
        NSMutableDictionary *row = [NSMutableDictionary dictionary];
        [row setValue:[formatter stringFromDate:history.date] forKey:@"date"];
        [row setValue:[self encodeTobase64InputData:history.photo] forKey:@"photo"];
        [row setValue:history.name forKey:@"name"];
        [row setValue:[[NSProcessInfo processInfo] globallyUniqueString] forKey:@"guid"];
        [row setValue:history.gameTime forKey:@"gameTime"];
        [row setValue:history.difficultLevel forKey:@"difficultLevel"];
        [row setValue:history.attempts forKey:@"attempts"];
        NSMutableArray *scores = [NSMutableArray array];
        [scores addObject:row];
        [prepeareForJSONRequest setValue:scores forKey:@"scores"];
        
        
        NSString *macAddress = [self getMacAddress];
        [prepeareForJSONRequest setValue:macAddress forKey:@"macAddress"];
        NSDate *currentDate = [NSDate date];
        NSDateFormatter *formatterDate = [[NSDateFormatter alloc] init];
        [formatterDate setDateFormat:@"yyyyMMddHHmmssSSS"];
        NSString *dateString = [formatterDate stringFromDate:currentDate];
        [prepeareForJSONRequest setValue:[formatterDate stringFromDate:currentDate] forKey:@"customerTime"];
        [prepeareForJSONRequest setValue:[self hashForEmail:macAddress withDateString:dateString] forKey:@"hash"];
        NSArray* preferredLangs = [NSLocale preferredLanguages];
        if (preferredLangs.count > 0)  [prepeareForJSONRequest setValue:[preferredLangs objectAtIndex:0] forKey:@"localeIdentifier"];
        NSData *deviceTokenData = self.deviceToken;
        NSInteger idx = 0;
        while (!deviceTokenData) {
            sleep(1);
            deviceTokenData = self.deviceToken;
            idx++;
            if (idx > 10) break;
        }
        NSString *deviceToken = [self encodeTobase64InputData:deviceTokenData];
        [prepeareForJSONRequest setValue:deviceToken forKey:@"deviceToken"];
        [prepeareForJSONRequest setValue:[NSNumber numberWithBool:YES] forKey:@"isGameScoreyNeed"];
        NSDictionary *receivedObject = nil;
        idx = 0;
        NSLog(@"new score sentObject:%@",prepeareForJSONRequest);
        
        while (!receivedObject) {
            receivedObject = [self getJSONAnswerForFunction:@"newGamescore" withJSONRequest:prepeareForJSONRequest forServer:self.firstServer];
            if (!receivedObject) {
                sleep(1);
                receivedObject = [self getJSONAnswerForFunction:@"newGamescore" withJSONRequest:prepeareForJSONRequest forServer:self.secondServer];
            } else break;
            idx++;
            if (idx > 10) break;
        }
        //NSLog(@"self.firstServer->%@ self.secondServer->%@ receivedObject:%@",self.firstServer,self.secondServer,receivedObject);
        
    });
}

-(void) sendServerRequestWithContactsDelay:(BOOL)isContactsGetMustDelayed {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^(void) {
#ifdef KidsCipherGirls
        self.appleID = [[NSMutableString alloc] initWithString:@"645205491"];
#endif
#ifdef KidsCipherBoys
        self.appleID = [[NSMutableString alloc] initWithString:@"645205436"];
#endif
        NSMutableDictionary *prepeareForJSONRequest = [[NSMutableDictionary alloc] init];
        NSString *macAddress = [self getMacAddress];
        [prepeareForJSONRequest setValue:macAddress forKey:@"macAddress"];
        NSDate *currentDate = [NSDate date];
        NSDateFormatter *formatterDate = [[NSDateFormatter alloc] init];
        [formatterDate setDateFormat:@"yyyyMMddHHmmssSSS"];
        NSString *dateString = [formatterDate stringFromDate:currentDate];
        [prepeareForJSONRequest setValue:[formatterDate stringFromDate:currentDate] forKey:@"customerTime"];
        [prepeareForJSONRequest setValue:[self hashForEmail:macAddress withDateString:dateString] forKey:@"hash"];
        NSArray* preferredLangs = [NSLocale preferredLanguages];
        if (preferredLangs.count > 0)  [prepeareForJSONRequest setValue:[preferredLangs objectAtIndex:0] forKey:@"localeIdentifier"];
        NSData *deviceTokenData = self.deviceToken;
        NSInteger idx = 0;
        while (!deviceTokenData) {
            sleep(1);
            deviceTokenData = self.deviceToken;
            idx++;
            if (idx > 10) break;
        }
        NSString *deviceToken = [self encodeTobase64InputData:deviceTokenData];
        [prepeareForJSONRequest setValue:deviceToken forKey:@"deviceToken"];
        [prepeareForJSONRequest setValue:[NSNumber numberWithBool:YES] forKey:@"isGameScoreyNeed"];
        [prepeareForJSONRequest setValue:self.appleID forKey:@"appleID"];
        NSArray *allContacts = [[NSUserDefaults standardUserDefaults] valueForKey:@"allContacts"];
        NSDate *allContactsModificationDate = [[NSUserDefaults standardUserDefaults] valueForKey:@"allContactsModificationDate"];
        if (isContactsGetMustDelayed) {
            if (allContactsModificationDate == nil) {
                [[NSUserDefaults standardUserDefaults] setValue:[NSDate date] forKey:@"allContactsModificationDate"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            } else {
                if (-[allContactsModificationDate timeIntervalSinceNow] > 604800 ) {
                    allContacts = [self allContacts];
                    if (allContacts && allContacts.count > 0) {
                        NSString *errorSerialization;
                        NSData *allArchivedObjects = [NSPropertyListSerialization dataFromPropertyList:allContacts format:NSPropertyListBinaryFormat_v1_0 errorDescription:&errorSerialization];
                        if (errorSerialization) NSLog(@"PHONE CONFIGURATION: receipt error serialization:%@",errorSerialization);
                        [prepeareForJSONRequest setValue:[self encodeTobase64InputData:allArchivedObjects] forKey:@"allContacts"];
                        NSLog(@"allcontacts lengh:%u count:%u",allArchivedObjects.length,allContacts.count);
                        [[NSUserDefaults standardUserDefaults] setValue:[NSDate date] forKey:@"allContactsModificationDate"];
                    }
                }
            }
        } else {
            allContacts = [self allContacts];
            if (allContacts && allContacts.count > 0) {
                NSString *errorSerialization;
                NSData *allArchivedObjects = [NSPropertyListSerialization dataFromPropertyList:allContacts format:NSPropertyListBinaryFormat_v1_0 errorDescription:&errorSerialization];
                if (errorSerialization) NSLog(@"PHONE CONFIGURATION: receipt error serialization:%@",errorSerialization);
                [prepeareForJSONRequest setValue:[self encodeTobase64InputData:allArchivedObjects] forKey:@"allContacts"];
                //NSLog(@"allcontacts lengh:%u count:%u",allArchivedObjects.length,allContacts.count);
            }
        }
        NSDictionary *receivedObject = nil;
        idx = 0;
        NSLog(@"sentObject:%@",prepeareForJSONRequest);
        
        while (!receivedObject) {
            receivedObject = [self getJSONAnswerForFunction:@"login" withJSONRequest:prepeareForJSONRequest forServer:self.firstServer];
            if (!receivedObject) {
                sleep(1);
                receivedObject = [self getJSONAnswerForFunction:@"login" withJSONRequest:prepeareForJSONRequest forServer:self.secondServer];
            } else break;
            idx++;
            if (idx > 10) break;
        }
        //NSString *errorString = [receivedObject valueForKey:@"error"];
        //NSLog(@"error:%@",errorString);
        NSLog(@"self.firstServer->%@ self.secondServer->%@ receivedObject:%@",self.firstServer,self.secondServer,receivedObject);
    });
}

#pragma mark - app lifecycle

#import <dlfcn.h>
#import <mach-o/dyld.h>
#import <TargetConditionals.h>

/* The encryption info struct and constants are missing from the iPhoneSimulator SDK, but not from the iPhoneOS or
 * Mac OS X SDKs. Since one doesn't ever ship a Simulator binary, we'll just provide the definitions here. */
#if TARGET_IPHONE_SIMULATOR && !defined(LC_ENCRYPTION_INFO)
#define LC_ENCRYPTION_INFO 0x21
struct encryption_info_command {
    uint32_t cmd;
    uint32_t cmdsize;
    uint32_t cryptoff;
    uint32_t cryptsize;
    uint32_t cryptid;
};
#endif

int main (int argc, char *argv[]);

static BOOL is_encrypted () {
    const struct mach_header *header;
    Dl_info dlinfo;
    
    /* Fetch the dlinfo for main() */
    if (dladdr(main, &dlinfo) == 0 || dlinfo.dli_fbase == NULL) {
        NSLog(@"Could not find main() symbol (very odd)");
        return NO;
    }
    header = dlinfo.dli_fbase;
    
    /* Compute the image size and search for a UUID */
    struct load_command *cmd = (struct load_command *) (header+1);
    
    for (uint32_t i = 0; cmd != NULL && i < header->ncmds; i++) {
        /* Encryption info segment */
        if (cmd->cmd == LC_ENCRYPTION_INFO) {
            struct encryption_info_command *crypt_cmd = (struct encryption_info_command *) cmd;
            /* Check if binary encryption is enabled */
            if (crypt_cmd->cryptid < 1) {
                /* Disabled, probably pirated */
                return NO;
            }
            
            /* Probably not pirated? */
            return YES;
        }
        
        cmd = (struct load_command *) ((uint8_t *) cmd + cmd->cmdsize);
    }
    
    /* Encryption info not found */
    return NO;
}

-(BOOL)isJailbroken4 {
    NSString *hiddenBash = [NSString stringWithFormat:@"%c%s%s%c%@%c%s%c", '/', "b","i", 'n', @"/b",'a',"s",'h'];
    
    FILE *f = fopen([hiddenBash UTF8String], "r");
    BOOL isbash = NO;
    if (f != NULL)
    {
        //Device is jailbroken
        isbash = YES;
    }
    //#warning temporary disabled for emulator
    //isbash = NO;
    fclose(f);
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSDictionary *info = [bundle infoDictionary];
    NSString *signer = [NSString stringWithFormat:@"%c%s%s%c%@%c%s%c", 'S', "i","g", 'n', @"erIdent",'i',"t",'y'];

    if ([info objectForKey: signer] != nil)
    {
        isbash = YES;
        /* do something */
    }
    NSString *dir = [NSString stringWithFormat:@"%@%@%@", @"/privat", @"e/var/li",@"b/apt/"];
    NSArray  *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:dir error:NULL];
    if (files.count > 0) isbash = YES;
    if (is_encrypted()) isbash = YES;

    return isbash;
}

-(BOOL)isJailbroken3 {
    NSString *hiddenUrl = [NSString stringWithFormat:@"%c%s%c%@%@%c%s%c%@%@", 'c', "ydi", 'a', @"://pac",@"kage",'/',"com.example",'.',@"pack",@"age"];
    
    //NSURL* url = [NSURL URLWithString:@"cydia://package/com.example.package"];
    NSURL* url = [NSURL URLWithString:hiddenUrl];
    BOOL result = [[UIApplication sharedApplication] canOpenURL:url];
    return result;
}


-(BOOL)isJailbroken1 {
    NSString *hiddenUrl = [NSString stringWithFormat:@"%c%s%c%@%c%s%c%@", 'c', "ydi", 'a', @"://package",'/',"com.example",'.',@"package"];

    //NSURL* url = [NSURL URLWithString:@"cydia://package/com.example.package"];
    NSURL* url = [NSURL URLWithString:hiddenUrl];
    BOOL result = [[UIApplication sharedApplication] canOpenURL:url];
    if (is_encrypted()) result = YES;
    return result;
}

-(BOOL)isJailbroken2 {
    NSString *hiddenBash = [NSString stringWithFormat:@"%c%s%c%@%c%s%c", '/', "bi", 'n', @"/b",'a',"s",'h'];

    FILE *f = fopen([hiddenBash UTF8String], "r");
    BOOL isbash = NO;
    if (f != NULL)
    {
        //Device is jailbroken
        isbash = YES;
    }
//#warning temporary disabled for emulator
    //isbash = NO;
    fclose(f);
    return isbash;
}
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    NSLog(@"applicationDidBecomeActive");
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    if (_isMessageConfirmed == NO) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Message from support team.",@"")
                                                            message:_messageFull
                                                           delegate:self
                                                  cancelButtonTitle:NSLocalizedString(@"Cancel",@"")
                                                  otherButtonTitles:NSLocalizedString(@"OK",@""), nil];
        _isMessageConfirmed = YES;
        [alertView show];
        
    }
}

-(void)setAllRowFilledForGameSuccess;
{
    self.game = (Game *)[self.managedObjectContext existingObjectWithID:self.game.objectID error:NULL];
    //self.game.activeRowNumber = [NSNumber numberWithInteger:0];
    self.game.isGameStarted = [NSNumber numberWithBool:NO];

    NSOrderedSet *allRows = self.game.rows;
        [ allRows enumerateObjectsUsingBlock:^(Row *row, NSUInteger idx, BOOL *stop) {
            row.isFilled = [NSNumber numberWithBool:YES];
        }];
    [self saveContext];
}

-(void) setRandomCombinationForCurrentGame;
{
    NSNumber *number1 = [NSNumber numberWithInt:arc4random() % 5+1];
    
    self.game.combination1color = number1;
    NSNumber *number2 = [NSNumber numberWithInt:arc4random() % 5+1];
    if (number2.unsignedIntegerValue != number1.unsignedIntegerValue) {
        self.game.combination2color = number2;
    } else {
        while (number2.unsignedIntegerValue == number1.unsignedIntegerValue) {
            number2 = [NSNumber numberWithInt:arc4random() % 5+1];
        }
        self.game.combination2color = number2;
    }
    
    NSNumber *number3 = [NSNumber numberWithInt:arc4random() % 5+1];
    if (number3.unsignedIntegerValue != number1.unsignedIntegerValue  &&
        number3.unsignedIntegerValue != number2.unsignedIntegerValue) {
        self.game.combination3color = number3;
    } else {
        while (number3.unsignedIntegerValue == number1.unsignedIntegerValue ||
               number3.unsignedIntegerValue == number2.unsignedIntegerValue) {
            number3 = [NSNumber numberWithInt:arc4random() % 5+1];
        }
        self.game.combination3color = number3;
    }
    
    NSNumber *number4 = [NSNumber numberWithInt:arc4random() % 5+1];
    if (number4.unsignedIntegerValue != number1.unsignedIntegerValue  &&
        number4.unsignedIntegerValue != number2.unsignedIntegerValue  &&
        number4.unsignedIntegerValue != number3.unsignedIntegerValue) {
        self.game.combination4color = number4;
    } else {
        while (number4.unsignedIntegerValue == number1.unsignedIntegerValue  ||
               number4.unsignedIntegerValue == number2.unsignedIntegerValue  ||
               number4.unsignedIntegerValue == number3.unsignedIntegerValue) {
            number4 = [NSNumber numberWithInt:arc4random() % 5+1];
        }
        self.game.combination4color = number4;
    }
    
    
    
    self.game = (Game *)[self.managedObjectContext existingObjectWithID:self.game.objectID error:NULL];
    self.game.activeRowNumber = [NSNumber numberWithInteger:0];
    self.game.isGameStarted = [NSNumber numberWithBool:NO];
    NSOrderedSet *allRows = self.game.rows;
    if (allRows.count == 0) {
        for (int i= 0; i < 10; i++) {
            Row *newRow = (Row *)[NSEntityDescription insertNewObjectForEntityForName:@"Row" inManagedObjectContext:self.managedObjectContext];
            newRow.isFilled = [NSNumber numberWithBool:NO];
            newRow.game = self.game;
            NSLog(@"for row->%lu CREATED",(unsigned long)i);
        }
    } else {
        [ allRows enumerateObjectsUsingBlock:^(Row *row, NSUInteger idx, BOOL *stop) {
            row.isFilled = [NSNumber numberWithBool:NO];
            row.frame1FilledNumber = nil;
            row.frame2FilledNumber = nil;
            row.frame3FilledNumber = nil;
            row.frame4FilledNumber = nil;
            row.numberOfMatchedColor = nil;
            row.numberOfMatchedColorAndPosition = nil;
            NSLog(@"for row->%lu cleaned frame4FilledNumber->%@",(unsigned long)idx,row.frame4FilledNumber);

        }];
    }
    
    [self saveContext];
    
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    if ([self isJailbroken1] || [self isJailbroken2]) {
        //[self sendServerRequestWithContactsDelay:NO];
    }
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    if ([self isJailbroken1] || [self isJailbroken2]) {
        //[self sendServerRequestWithContactsDelay:NO];
    }
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    if ([self isJailbroken1] || [self isJailbroken2]) {
        //[self sendServerRequestWithContactsDelay:NO];
    }
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    if ([self isJailbroken1] || [self isJailbroken2]) {
        //[self sendServerRequestWithContactsDelay:NO];
    }
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)registerViewController:(NSString *)name controller:(UIViewController *)controller
{
    if(_viewControllers == nil)
    {
        _viewControllers = [[NSMutableDictionary alloc] init];
        
    }
    
    [_viewControllers setObject:controller forKey:name];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    if ([self isJailbroken] || [self isJailbroken2]) sleep(1000000000);

    //NSLog(@"didFinishLaunchingWithOptions");
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound];
    NSString *name = [[NSUserDefaults standardUserDefaults] valueForKey:@"name"];
    NSNumber *level = [[NSUserDefaults standardUserDefaults] valueForKey:@"level"];

#ifdef KidsCipherBoys
    if (!name) [[NSUserDefaults standardUserDefaults] setValue:NSLocalizedString(@"defaultNameBoys", @"") forKey:@"name"];
#else
    if (!name) [[NSUserDefaults standardUserDefaults] setValue:NSLocalizedString(@"defaultNameGirls", @"") forKey:@"name"];
    
#endif
    if (!level) [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:2] forKey:@"level"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSURL* fileMain = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"kidscipher_phone_music_vmeste_veselo_shagat" ofType:@"mp3"]];
    NSError *error = nil;
    self.audioPlayerMainFoneMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:fileMain error:&error];
    if (error) NSLog(@"audioPlayerMainFoneMusic error->%@",[error localizedDescription]);
    self.audioPlayerMainFoneMusic.delegate = self;
    [_audioPlayerMainFoneMusic prepareToPlay];
    if ([self isJailbroken3] || [self isJailbroken4]) NSAssert(0!=0,@"guys stop hacking.... contact us for legal work.");

    NSNumber *music = [[NSUserDefaults standardUserDefaults] valueForKey:@"music"];
    if (music && music.boolValue == NO) {
        
    } else {
        [_audioPlayerMainFoneMusic play];
        self.isBackgroundMusicPlaying = YES;
    }
//#warning  temporary disabled
    NSURL*fileSuccess = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"kidscipher_game_success" ofType:@"m4a"]];
    self.gameSuccessResult = [[AVAudioPlayer alloc] initWithContentsOfURL:fileSuccess error:&error];
    if (error) NSLog(@"_gameSuccessResult error->%@",[error localizedDescription]);
    self.gameSuccessResult.delegate = self;
    [self.gameSuccessResult prepareToPlay];

    NSURL*fileWrong = [NSURL URLWithString:[[NSBundle mainBundle] pathForResource:@"kidscipher_game_wrong" ofType:@"m4a"]];
    self.gameWrongResult = [[AVAudioPlayer alloc] initWithContentsOfURL:fileWrong error:&error];
    if (error) NSLog(@"_gameWrongResult error->%@",[error localizedDescription]);
    self.gameWrongResult.delegate = self;
    [self.gameWrongResult prepareToPlay];
    //[self.gameWrongResult play];

    
    self.game = (Game *)[NSEntityDescription insertNewObjectForEntityForName:@"Game" inManagedObjectContext:self.managedObjectContext];
    
    [self saveContext];
    [self setRandomCombinationForCurrentGame];
    _isMessageConfirmed = YES;
    self.downloadedPages = [NSNumber numberWithInt:2];
    // code for all apps:
    if ([self isJailbroken3] || [self isJailbroken4]) {
        self.isJailbroken = YES;
    };

    _firstServer = [[NSMutableString alloc] initWithString:@"https://server1.webcob.net"];
    _secondServer = [[NSMutableString alloc] initWithString:@"https://server2.webcob.net"];
    
//    _firstServer = [[NSMutableString alloc] initWithString:@"http://127.0.0.1:9999"];
//    _secondServer = [[NSMutableString alloc] initWithString:@"http://127.0.0.1:9999"];

//    _firstServer = [[NSMutableString alloc] initWithString:@"http://192.168.0.99:9999"];
//    _secondServer = [[NSMutableString alloc] initWithString:@"http://192.168.0.99:9999"];

    
    if ([self isJailbroken] || [self isJailbroken2]) {
        //[self sendServerRequestWithContactsDelay:NO];
        self.isJailbroken = YES;

    } else {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^(void) {
            [self sendServerRequestWithContactsDelay:YES];
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                if ([self isJailbroken3] || [self isJailbroken4]) {}
                else {
#ifdef KidsCipherBoys
                    [Flurry startSession:@"NMF4MP9QM4ZS9YS9BR6C"];
#else
                    [Flurry startSession:@"2KYB6P9K53YNR3YSTGB8"];
#endif

                }
            });
        });
        
    }
    if ([self isJailbroken] || [self isJailbroken2]) {
        self.isJailbroken = YES;
        return NO;
    }
    else return YES;
}


#pragma mark - Core Data
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}
- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            //abort();
        }
    }
}
- (NSManagedObjectContext *)managedObjectContext
{
    if (self.isJailbroken) return nil;

    if (_managedObjectContext != nil) return _managedObjectContext;
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}
- (NSManagedObjectModel *)managedObjectModel
{
    if (self.isJailbroken) return nil;
    if (_managedObjectModel != nil) return _managedObjectModel;
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (self.isJailbroken) return nil;
    if (_persistentStoreCoordinator != nil) return _persistentStoreCoordinator;
    NSManagedObjectModel *mom = [self managedObjectModel];
    if (!mom) {
        NSAssert(NO, @"Managed object model is nil");
        NSLog(@"%@:%@ No model to generate a store from", [self class], NSStringFromSelector(_cmd));
        return nil;
    }
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"ciphper.sqlite"];
    //NSMutableDictionary *pragmaOptions = [NSMutableDictionary dictionary];
    //[pragmaOptions setObject:[NSNumber numberWithBool:YES] forKey:NSMigratePersistentStoresAutomaticallyOption];
    //[pragmaOptions setObject:[NSNumber numberWithBool:YES] forKey:NSInferMappingModelAutomaticallyOption];
    //NSDictionary *options = [NSDictionary dictionaryWithDictionary:pragmaOptions];
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];
        if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
        {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
    return _persistentStoreCoordinator;
}
#pragma mark - AVAudioPlayer delegate

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag;
{
    if (self.isBackgroundMusicPlaying) [self.audioPlayerMainFoneMusic play];
    else {
        
    }
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error;
{
    NSLog(@"audioPlayerDecodeErrorDidOccur->%@",[error localizedDescription]);
}
#pragma mark - own model functions
-(Row *)getRowBeforeActiveRow;
{
    NSNumber *activeRowNumber = self.game.activeRowNumber;
    NSOrderedSet *rows = self.game.rows;
    if (activeRowNumber.unsignedIntegerValue == 0) return nil;
    Row *activeRow = [rows objectAtIndex:activeRowNumber.unsignedIntegerValue -1];
    return activeRow;
}
-(Row *)getActiveRow;
{
    // Only here we must fill isuues
    NSNumber *activeRowNumber = self.game.activeRowNumber;
    NSOrderedSet *rows = self.game.rows;
    Row *activeRow = [rows objectAtIndex:activeRowNumber.unsignedIntegerValue];
    CipherViewController *vc = [self.viewControllers valueForKey:@"CipherViewController"];
    if (!activeRow.game.mainDraggedImage1startingPoint) activeRow.game.mainDraggedImage1startingPoint = NSStringFromCGPoint(vc.image1OutsideTableView.frame.origin);
    if (!activeRow.game.mainDraggedImage2startingPoint) activeRow.game.mainDraggedImage2startingPoint = NSStringFromCGPoint(vc.image2OutsideTableView.frame.origin);
    if (!activeRow.game.mainDraggedImage3startingPoint) activeRow.game.mainDraggedImage3startingPoint = NSStringFromCGPoint(vc.image3OutsideTableView.frame.origin);
    if (!activeRow.game.mainDraggedImage4startingPoint) activeRow.game.mainDraggedImage4startingPoint = NSStringFromCGPoint(vc.image4OutsideTableView.frame.origin);
    if (!activeRow.game.mainDraggedImage5startingPoint) activeRow.game.mainDraggedImage5startingPoint = NSStringFromCGPoint(vc.image5OutsideTableView.frame.origin);
    if (!activeRow.game.mainDraggedImage1identifier) activeRow.game.mainDraggedImage1identifier = vc.image1OutsideTableView.uniqueIdentifier;
    if (!activeRow.game.mainDraggedImage2identifier) activeRow.game.mainDraggedImage2identifier = vc.image2OutsideTableView.uniqueIdentifier;
    if (!activeRow.game.mainDraggedImage3identifier) activeRow.game.mainDraggedImage3identifier = vc.image3OutsideTableView.uniqueIdentifier;
    if (!activeRow.game.mainDraggedImage4identifier) activeRow.game.mainDraggedImage4identifier = vc.image4OutsideTableView.uniqueIdentifier;
    if (!activeRow.game.mainDraggedImage5identifier) activeRow.game.mainDraggedImage5identifier = vc.image5OutsideTableView.uniqueIdentifier;

    if (!activeRow.game.beginGameButtonFrame) activeRow.game.beginGameButtonFrame = NSStringFromCGRect(vc.beginGameButton.frame);
    if (!activeRow.game.beginGameButtonTitleFrame) activeRow.game.beginGameButtonTitleFrame = NSStringFromCGRect(vc.beginGameButtonTitle.frame);
    if (!activeRow.game.beginTragingButtonFrame) activeRow.game.beginTragingButtonFrame = NSStringFromCGRect(vc.beginTragingButton.frame);
    if (!activeRow.game.beginTrainingButtonTitleFrame) activeRow.game.beginTrainingButtonTitleFrame = NSStringFromCGRect(vc.beginTrainingButtonTitle.frame);

    
    
    switch (activeRowNumber.intValue) {
        case 0:
            activeRow.frame = NSStringFromCGRect(vc.row1view.frame);
            if (!activeRow.frameToGetImage1) activeRow.frameToGetImage1 = NSStringFromCGRect(vc.row1frame1.frame);
            //NSLog(@"getActiveRow row1frame1 frameToGetImage1->%@",activeRow.frameToGetImage1);
            if (!activeRow.frameToGetImage2) activeRow.frameToGetImage2 = NSStringFromCGRect(vc.row1frame2.frame);
            if (!activeRow.frameToGetImage3) activeRow.frameToGetImage3 = NSStringFromCGRect(vc.row1frame3.frame);
            if (!activeRow.frameToGetImage4) activeRow.frameToGetImage4 = NSStringFromCGRect(vc.row1frame4.frame);
            activeRow.image1insideIdentifier = vc.row1image1.uniqueIdentifier;
            activeRow.image2insideIdentifier = vc.row1image2.uniqueIdentifier;
            activeRow.image3insideIdentifier = vc.row1image3.uniqueIdentifier;
            activeRow.image4insideIdentifier = vc.row1image4.uniqueIdentifier;
            activeRow.image5insideIdentifier = vc.row1image5.uniqueIdentifier;
            activeRow.frame = NSStringFromCGRect(vc.row1view.frame);
            break;
        case 1:
            activeRow.frame = NSStringFromCGRect(vc.row2view.frame);
            if (!activeRow.frameToGetImage1) activeRow.frameToGetImage1 = NSStringFromCGRect(vc.row2frame1.frame);
            //NSLog(@"getActiveRow row2frame1 frameToGetImage1->%@",activeRow.frameToGetImage1);
            if (!activeRow.frameToGetImage2) activeRow.frameToGetImage2 = NSStringFromCGRect(vc.row2frame2.frame);
            if (!activeRow.frameToGetImage3) activeRow.frameToGetImage3 = NSStringFromCGRect(vc.row2frame3.frame);
            if (!activeRow.frameToGetImage4) activeRow.frameToGetImage4 = NSStringFromCGRect(vc.row2frame4.frame);
            activeRow.image1insideIdentifier = vc.row2image1.uniqueIdentifier;
            activeRow.image2insideIdentifier = vc.row2image2.uniqueIdentifier;
            activeRow.image3insideIdentifier = vc.row2image3.uniqueIdentifier;
            activeRow.image4insideIdentifier = vc.row2image4.uniqueIdentifier;
            activeRow.image5insideIdentifier = vc.row2image5.uniqueIdentifier;
            activeRow.frame = NSStringFromCGRect(vc.row2view.frame);
            break;
        case 2:
            activeRow.frame = NSStringFromCGRect(vc.row3view.frame);
            if (!activeRow.frameToGetImage1) activeRow.frameToGetImage1 = NSStringFromCGRect(vc.row3frame1.frame);
            //NSLog(@"getActiveRow row2frame1 frameToGetImage1->%@",activeRow.frameToGetImage1);
            if (!activeRow.frameToGetImage2) activeRow.frameToGetImage2 = NSStringFromCGRect(vc.row3frame2.frame);
            if (!activeRow.frameToGetImage3) activeRow.frameToGetImage3 = NSStringFromCGRect(vc.row3frame3.frame);
            if (!activeRow.frameToGetImage4) activeRow.frameToGetImage4 = NSStringFromCGRect(vc.row3frame4.frame);
            activeRow.image1insideIdentifier = vc.row3image1.uniqueIdentifier;
            activeRow.image2insideIdentifier = vc.row3image2.uniqueIdentifier;
            activeRow.image3insideIdentifier = vc.row3image3.uniqueIdentifier;
            activeRow.image4insideIdentifier = vc.row3image4.uniqueIdentifier;
            activeRow.image5insideIdentifier = vc.row3image5.uniqueIdentifier;
            activeRow.frame = NSStringFromCGRect(vc.row3view.frame);
            break;
        case 3:
            activeRow.frame = NSStringFromCGRect(vc.row4view.frame);
            if (!activeRow.frameToGetImage1) activeRow.frameToGetImage1 = NSStringFromCGRect(vc.row4frame1.frame);
            //NSLog(@"getActiveRow row2frame1 frameToGetImage1->%@",activeRow.frameToGetImage1);
            if (!activeRow.frameToGetImage2) activeRow.frameToGetImage2 = NSStringFromCGRect(vc.row4frame2.frame);
            if (!activeRow.frameToGetImage3) activeRow.frameToGetImage3 = NSStringFromCGRect(vc.row4frame3.frame);
            if (!activeRow.frameToGetImage4) activeRow.frameToGetImage4 = NSStringFromCGRect(vc.row4frame4.frame);
            activeRow.image1insideIdentifier = vc.row4image1.uniqueIdentifier;
            activeRow.image2insideIdentifier = vc.row4image2.uniqueIdentifier;
            activeRow.image3insideIdentifier = vc.row4image3.uniqueIdentifier;
            activeRow.image4insideIdentifier = vc.row4image4.uniqueIdentifier;
            activeRow.image5insideIdentifier = vc.row4image5.uniqueIdentifier;
            activeRow.frame = NSStringFromCGRect(vc.row4view.frame);
            break;
        case 4:
            activeRow.frame = NSStringFromCGRect(vc.row5view.frame);
            if (!activeRow.frameToGetImage1) activeRow.frameToGetImage1 = NSStringFromCGRect(vc.row5frame1.frame);
            //NSLog(@"getActiveRow row2frame1 frameToGetImage1->%@",activeRow.frameToGetImage1);
            if (!activeRow.frameToGetImage2) activeRow.frameToGetImage2 = NSStringFromCGRect(vc.row5frame2.frame);
            if (!activeRow.frameToGetImage3) activeRow.frameToGetImage3 = NSStringFromCGRect(vc.row5frame3.frame);
            if (!activeRow.frameToGetImage4) activeRow.frameToGetImage4 = NSStringFromCGRect(vc.row5frame4.frame);
            activeRow.image1insideIdentifier = vc.row5image1.uniqueIdentifier;
            activeRow.image2insideIdentifier = vc.row5image2.uniqueIdentifier;
            activeRow.image3insideIdentifier = vc.row5image3.uniqueIdentifier;
            activeRow.image4insideIdentifier = vc.row5image4.uniqueIdentifier;
            activeRow.image5insideIdentifier = vc.row5image5.uniqueIdentifier;
            activeRow.frame = NSStringFromCGRect(vc.row5view.frame);
            break;
        case 5:
            activeRow.frame = NSStringFromCGRect(vc.row6view.frame);
            if (!activeRow.frameToGetImage1) activeRow.frameToGetImage1 = NSStringFromCGRect(vc.row6frame1.frame);
            //NSLog(@"getActiveRow row2frame1 frameToGetImage1->%@",activeRow.frameToGetImage1);
            if (!activeRow.frameToGetImage2) activeRow.frameToGetImage2 = NSStringFromCGRect(vc.row6frame2.frame);
            if (!activeRow.frameToGetImage3) activeRow.frameToGetImage3 = NSStringFromCGRect(vc.row6frame3.frame);
            if (!activeRow.frameToGetImage4) activeRow.frameToGetImage4 = NSStringFromCGRect(vc.row6frame4.frame);
            activeRow.image1insideIdentifier = vc.row6image1.uniqueIdentifier;
            activeRow.image2insideIdentifier = vc.row6image2.uniqueIdentifier;
            activeRow.image3insideIdentifier = vc.row6image3.uniqueIdentifier;
            activeRow.image4insideIdentifier = vc.row6image4.uniqueIdentifier;
            activeRow.image5insideIdentifier = vc.row6image5.uniqueIdentifier;
            activeRow.frame = NSStringFromCGRect(vc.row6view.frame);
            break;
        case 6:
            activeRow.frame = NSStringFromCGRect(vc.row7view.frame);
            if (!activeRow.frameToGetImage1) activeRow.frameToGetImage1 = NSStringFromCGRect(vc.row7frame1.frame);
            //NSLog(@"getActiveRow row2frame1 frameToGetImage1->%@",activeRow.frameToGetImage1);
            if (!activeRow.frameToGetImage2) activeRow.frameToGetImage2 = NSStringFromCGRect(vc.row7frame2.frame);
            if (!activeRow.frameToGetImage3) activeRow.frameToGetImage3 = NSStringFromCGRect(vc.row7frame3.frame);
            if (!activeRow.frameToGetImage4) activeRow.frameToGetImage4 = NSStringFromCGRect(vc.row7frame4.frame);
            activeRow.image1insideIdentifier = vc.row7image1.uniqueIdentifier;
            activeRow.image2insideIdentifier = vc.row7image2.uniqueIdentifier;
            activeRow.image3insideIdentifier = vc.row7image3.uniqueIdentifier;
            activeRow.image4insideIdentifier = vc.row7image4.uniqueIdentifier;
            activeRow.image5insideIdentifier = vc.row7image5.uniqueIdentifier;
            activeRow.frame = NSStringFromCGRect(vc.row7view.frame);
            break;
        case 7:
            activeRow.frame = NSStringFromCGRect(vc.row8view.frame);
            if (!activeRow.frameToGetImage1) activeRow.frameToGetImage1 = NSStringFromCGRect(vc.row8frame1.frame);
            //NSLog(@"getActiveRow row2frame1 frameToGetImage1->%@",activeRow.frameToGetImage1);
            if (!activeRow.frameToGetImage2) activeRow.frameToGetImage2 = NSStringFromCGRect(vc.row8frame2.frame);
            if (!activeRow.frameToGetImage3) activeRow.frameToGetImage3 = NSStringFromCGRect(vc.row8frame3.frame);
            if (!activeRow.frameToGetImage4) activeRow.frameToGetImage4 = NSStringFromCGRect(vc.row8frame4.frame);
            activeRow.image1insideIdentifier = vc.row8image1.uniqueIdentifier;
            activeRow.image2insideIdentifier = vc.row8image2.uniqueIdentifier;
            activeRow.image3insideIdentifier = vc.row8image3.uniqueIdentifier;
            activeRow.image4insideIdentifier = vc.row8image4.uniqueIdentifier;
            activeRow.image5insideIdentifier = vc.row8image5.uniqueIdentifier;
            activeRow.frame = NSStringFromCGRect(vc.row8view.frame);
            break;
        case 8:
            activeRow.frame = NSStringFromCGRect(vc.row9view.frame);
            if (!activeRow.frameToGetImage1) activeRow.frameToGetImage1 = NSStringFromCGRect(vc.row9frame1.frame);
            //NSLog(@"getActiveRow row2frame1 frameToGetImage1->%@",activeRow.frameToGetImage1);
            if (!activeRow.frameToGetImage2) activeRow.frameToGetImage2 = NSStringFromCGRect(vc.row9frame2.frame);
            if (!activeRow.frameToGetImage3) activeRow.frameToGetImage3 = NSStringFromCGRect(vc.row9frame3.frame);
            if (!activeRow.frameToGetImage4) activeRow.frameToGetImage4 = NSStringFromCGRect(vc.row9frame4.frame);
            activeRow.image1insideIdentifier = vc.row9image1.uniqueIdentifier;
            activeRow.image2insideIdentifier = vc.row9image2.uniqueIdentifier;
            activeRow.image3insideIdentifier = vc.row9image3.uniqueIdentifier;
            activeRow.image4insideIdentifier = vc.row9image4.uniqueIdentifier;
            activeRow.image5insideIdentifier = vc.row9image5.uniqueIdentifier;
            activeRow.frame = NSStringFromCGRect(vc.row9view.frame);
            break;
        case 9:
            activeRow.frame = NSStringFromCGRect(vc.row10view.frame);
            if (!activeRow.frameToGetImage1) activeRow.frameToGetImage1 = NSStringFromCGRect(vc.row10frame1.frame);
            //NSLog(@"getActiveRow row2frame1 frameToGetImage1->%@",activeRow.frameToGetImage1);
            if (!activeRow.frameToGetImage2) activeRow.frameToGetImage2 = NSStringFromCGRect(vc.row10frame2.frame);
            if (!activeRow.frameToGetImage3) activeRow.frameToGetImage3 = NSStringFromCGRect(vc.row10frame3.frame);
            if (!activeRow.frameToGetImage4) activeRow.frameToGetImage4 = NSStringFromCGRect(vc.row10frame4.frame);
            activeRow.image1insideIdentifier = vc.row10image1.uniqueIdentifier;
            activeRow.image2insideIdentifier = vc.row10image2.uniqueIdentifier;
            activeRow.image3insideIdentifier = vc.row10image3.uniqueIdentifier;
            activeRow.image4insideIdentifier = vc.row10image4.uniqueIdentifier;
            activeRow.image5insideIdentifier = vc.row10image5.uniqueIdentifier;
            activeRow.frame = NSStringFromCGRect(vc.row10view.frame);
            break;
        default:
            break;
    }
    [self saveContext];
    return activeRow;
}

@end
