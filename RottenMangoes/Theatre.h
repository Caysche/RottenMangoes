//
//  Theatre.h
//  RottenMangoes
//
//  Created by Cay Cornelius on 27/09/16.
//  Copyright © 2016 Cornelius.Media. All rights reserved.
//

#import <Foundation/Foundation.h>
@import MapKit;

@interface Theatre : NSObject <MKAnnotation>

@property (nonatomic) int iD;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *address;
@property (nonatomic) NSNumber *lat;
@property (nonatomic) NSNumber *lng;

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly, copy) NSString *subtitle;


- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)aCoordinate andTitle:(NSString *)aTitle andSubtitle:(NSString *)aSubtitle;

- (instancetype)initWithTitle:(int)iD andName:(NSString *)name andAddress:(NSString *)address andLatitude:(NSString *)latitude andLongitude:(NSString *)longitude;


@end
