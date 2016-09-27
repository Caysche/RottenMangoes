//
//  MapViewController.m
//  RottenMangoes
//
//  Created by Cay Cornelius on 27/09/16.
//  Copyright © 2016 Cornelius.Media. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import "LocationManager.h"
#import "Theatre.h"

#define zoominMapArea 2100

@interface MapViewController () <MKMapViewDelegate, SharedLocationDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (nonatomic) BOOL isInitallySetUp;
@property (nonatomic) LocationManager *locationManager;
@property (nonatomic) NSString *postalCode;
@property (nonatomic) NSMutableArray *theatresArray;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _isInitallySetUp = NO;
    _mapView.showsUserLocation = YES;
    
    self.theatresArray = [NSMutableArray array];
    
    self.locationManager = [LocationManager sharedManager];
    self.locationManager.delegate = self;
    [self.locationManager startLocationMonitoring];
    
    
    
    
}

-(void)passCurrentLocation:(CLLocation *)currentLocation{
    CLLocationCoordinate2D zoomLocation = CLLocationCoordinate2DMake(currentLocation.coordinate.latitude, currentLocation.coordinate.longitude);
    
    MKCoordinateRegion adjustedRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, zoominMapArea, zoominMapArea);
    
    [_mapView setRegion:adjustedRegion animated:YES];
    
}

-(void)passCurrentPostalCode:(NSString *)postalCode {
    self.postalCode = postalCode;
    
    
//        [FoursquareManager responseFrom4sq:currentLocation categoryId:@"4d4b7105d754a06377d81259" limit:@"10" block:^(NSArray *locationsArray, NSError *error) {
//    
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [_mapView addAnnotations:locationsArray];
//            });
//    
//        }];
    
    [self fetchTheatresData];
}

-(void)fetchTheatresData {
    NSString *urlString = [NSString stringWithFormat:@"http://lighthouse-movie-showtimes.herokuapp.com/theatres.json?address=%@&movie=%@", self.postalCode, self.movieTitle];
    NSLog(@"%@", urlString);
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (!error) {
            
            NSError *jsonError = nil;
            
            NSDictionary *theatreCollection = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            
            NSArray *theatres = theatreCollection[@"theatres"];
            
            for (NSDictionary *eachTheatre in theatres){
                
                Theatre *aTheatre = [[Theatre alloc] initWithCoordinate:CLLocationCoordinate2DMake([eachTheatre[@"lat"] doubleValue], [eachTheatre[@"lng"] doubleValue]) andTitle:eachTheatre[@"name"] andSubtitle:eachTheatre[@"address"]];
                
                aTheatre.iD = [eachTheatre[@"id"] intValue];
                aTheatre.name = eachTheatre[@"name"];
                aTheatre.address = eachTheatre[@"address"];
                aTheatre.lat = eachTheatre[@"lat"];
                aTheatre.lng = eachTheatre[@"lng"];
                
                // [[Theatre alloc] initWithTitle:[eachTheatre[@"id"] intValue] andName:eachTheatre[@"name"] andAddress:eachTheatre[@"address"] andLatitude:eachTheatre[@"lat"] andLongitude:eachTheatre[@"lng"]];
                
                [self.theatresArray addObject:aTheatre];
                
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [_mapView addAnnotations:_theatresArray];
            });
            
        }
        
    }];
    
    [dataTask resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

