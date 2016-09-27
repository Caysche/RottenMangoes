//
//  LocationManager.h
//  RottenMangoes
//
//  Created by Cay Cornelius on 27/09/16.
//  Copyright © 2016 Cornelius.Media. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;
#import <MobileCoreServices/MobileCoreServices.h>

@protocol SharedLocationDelegate <NSObject>

-(void) passCurrentLocation:(CLLocation*) currentLocation;
-(void)passCurrentPostalCode:(NSString *)postalCode;

@end


@interface LocationManager : NSObject

@property (nonatomic) CLLocation *currentLocation;

@property (nonatomic, weak) id<SharedLocationDelegate> delegate;

- (void)startLocationMonitoring;


+ (id)sharedManager;

@end
