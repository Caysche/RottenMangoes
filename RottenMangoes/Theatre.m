//
//  Theatre.m
//  RottenMangoes
//
//  Created by Cay Cornelius on 27/09/16.
//  Copyright © 2016 Cornelius.Media. All rights reserved.
//

#import "Theatre.h"

@implementation Theatre

- (instancetype)initWithTitle:(int)iD andName:(NSString *)name andAddress:(NSString *)address andLatitude:(NSNumber *)latitude andLongitude:(NSNumber *)longitude
{
    self = [super init];
    if (self) {
        _iD = iD;
        _name = name;
        _address = address;
        _lat = latitude;
        _lng = longitude;
    }
    return self;
}

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)aCoordinate andTitle:(NSString * _Nullable)aTitle andSubtitle:(NSString * _Nullable)aSubtitle
{
    self = [super init];
    if (self) {
        _coordinate = aCoordinate;
        _title = aTitle;
        _subtitle = aSubtitle;
    }
    return self;
}

@end
