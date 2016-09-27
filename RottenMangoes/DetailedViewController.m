//
//  DetailedViewController.m
//  RottenMangoes
//
//  Created by Cay Cornelius on 26/09/16.
//  Copyright © 2016 Cornelius.Media. All rights reserved.
//

#import "DetailedViewController.h"
#import "Movie.h"
#import "WebViewController.h"
#import "MapViewController.h"

@interface DetailedViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UILabel *runtimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *review1Label;
@property (weak, nonatomic) IBOutlet UILabel *review2Label;
@property (weak, nonatomic) IBOutlet UILabel *review3Label;

@end

@implementation DetailedViewController

- (void)setMovieItem:(id)newMovieItem {
    if (_movieItem != newMovieItem) {
        _movieItem = newMovieItem;
        
        // Update the view.
        [self configureView];
    }
}
    
- (void)configureView {
    // Update the user interface for the detail item.
    if (self.movieItem) {
        self.titleLabel.text = self.movieItem.title;
        self.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.movieItem.localImageURL]];
        self.synopsisLabel.text = self.movieItem.synopsis;
        self.synopsisLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.synopsisLabel.numberOfLines = 5;
        self.runtimeLabel.text = [NSString stringWithFormat:@"%@ min", self.movieItem.runtime];
        
        // Get reviews
        
        NSString *urlString = [NSString stringWithFormat:@"http://api.rottentomatoes.com/api/public/v1.0/movies/%@/reviews.json?apikey=sr9tdu3checdyayjz85mff8j&page_limit=3", self.movieItem.iD];
        
        NSURLSession *session = [NSURLSession sharedSession];
        
        NSURLSessionTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            if (!error) {
                
                NSError *jsonError = nil;
                
                NSDictionary *reviewCollection = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                
                NSArray *reviews = reviewCollection[@"reviews"];
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    self.review1Label.text = reviews[0][@"quote"];
                    self.review2Label.text = reviews[1][@"quote"];
                    self.review3Label.text = reviews[2][@"quote"];
                    
                });
                
                
            }
            
        }];
        
        [dataTask resume];

    }
//    if (self.)
}
    
    
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

    
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showWeb"]) {
        
        WebViewController *webViewController = (WebViewController *)[segue destinationViewController];
        
        [webViewController setMovieItem:self.movieItem];
        
    } else if ([[segue identifier] isEqualToString:@"showMap"]) {
        
        MapViewController *mapViewController = (MapViewController *)[segue destinationViewController];
        
        [mapViewController setMovieTitle:self.movieItem.title];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
