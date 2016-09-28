//
//  LocationManager.m
//  RottenMangoes
//
//  Created by Cay Cornelius on 27/09/16.
//  Copyright © 2016 Cornelius.Media. All rights reserved.
//

#import "LocationManager.h"
@import UIKit;



@interface LocationManager() <CLLocationManagerDelegate>

@property (nonatomic) CLLocationManager *locationManager;
@property (nonatomic) CLPlacemark *placemark;
@property (nonatomic) NSString *postalCode;

@end

@implementation LocationManager

+ (id)sharedManager {
    static LocationManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        
    }
    return self;
}


- (void)startLocationMonitoring{
    if ([CLLocationManager locationServicesEnabled]) {
        
        if ((!([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusRestricted)) || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined){
            [self setUpLocationManager];
            
        }else{
            
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Location services are disabled, Please go into Settings > Privacy > Location to enable them for Play" message:@"" preferredStyle:UIAlertControllerStyleAlert];
            
            
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //
                
                
            }];
            
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //
                
                
            }];
            
            
            [alertController addAction:ok];
            [alertController addAction:cancel];
            
        }
        
    }
    
}


-(void)setUpLocationManager {
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        _locationManager.distanceFilter = 10; //have to move 10m before location manager checks again
        
        _locationManager.delegate = self;
        [_locationManager requestWhenInUseAuthorization];
        
    }
    
    [_locationManager startUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    CLLocation * loc = [locations lastObject];
    
    NSTimeInterval locationAge = -[loc.timestamp timeIntervalSinceNow];
    if (locationAge > 10.0){
        return;
    }
    
    if (loc.horizontalAccuracy < 0){
        return;
    }
    
    if (self.currentLocation == nil || self.currentLocation.horizontalAccuracy >= loc.horizontalAccuracy){
        
        self.currentLocation = loc;
        [self.delegate passCurrentLocation:self.currentLocation];
        
        if (loc.horizontalAccuracy <= self.locationManager.desiredAccuracy) {
            [self stopLocationManager];
        }
    }
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    [geocoder reverseGeocodeLocation:self.currentLocation completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (!(error))
         {
             CLPlacemark *placemark = [placemarks objectAtIndex:0];
             self.postalCode = [[NSString alloc]initWithString:placemark.postalCode];
             [self.delegate passCurrentPostalCode:self.postalCode];
         }
         else
         {
             NSLog(@"Geocode failed with error %@", error); // Error handling must required
         }
     }];
    
    
    
}

-(void)stopLocationManager{
    if ([CLLocationManager locationServicesEnabled]) {
        if (_locationManager) {
            [_locationManager stopUpdatingLocation];
            NSLog(@"Stop Regular Location Manager");
        }
    }
}


@end
