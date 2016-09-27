//
//  CustomCollectionViewController.m
//  RottenMangoes
//
//  Created by Cay Cornelius on 26/09/16.
//  Copyright © 2016 Cornelius.Media. All rights reserved.
//

#import "CustomCollectionViewController.h"
#import "Movie.h"
#import "CustomCollectionViewCell.h"
#import "DetailedViewController.h"

@interface CustomCollectionViewController ()
    
    @property (nonatomic, strong, readonly) NSURL *rottenTomatoesAPIURL;
    @property (nonatomic, strong) NSMutableArray *imageURLArray;
    @property (assign) int pageNumber;
    @property (nonatomic, strong) NSMutableArray *moviesArray;

@end

@implementation CustomCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageNumber = 1;
    self.moviesArray = [NSMutableArray array];
    self.imageURLArray = [NSMutableArray array];
    [self getMovieData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

    
#pragma mark - Get the rotten tomatoes data through their API
    
- (void)getMovieData {
    NSString *urlString = [NSString stringWithFormat:@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json?apikey=sr9tdu3checdyayjz85mff8j&page_limit=50&page=%d", self.pageNumber];

    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (!error) {
            
            NSError *jsonError = nil;
            
            NSDictionary *movieCollection = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            
            NSArray *movies = movieCollection[@"movies"];
            
            for (NSDictionary *eachMovie in movies){
                
                NSString *title = eachMovie[@"title"];
                NSURL *url = [NSURL URLWithString:eachMovie[@"links"][@"alternate"]];
                NSNumber *runtime = eachMovie[@"runtime"];
                NSURL *imageURL = [NSURL URLWithString:eachMovie[@"posters"][@"original"]];
                NSString *synopsis = eachMovie[@"synopsis"];
                NSNumber *iD = eachMovie[@"id"];
                
                Movie* aMovie = [[Movie alloc] initWithTitle:title andURL:url andRuntime:runtime andSynopsis:synopsis andID:iD];
                
                NSLog(@"aMovie is %@", aMovie.title);
                
                [self.moviesArray addObject:aMovie];
                [self.imageURLArray addObject:imageURL];
                
            }
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.collectionView reloadData];
                
            });
            
        }
        
    }];
    
    [dataTask resume];
    self.pageNumber++;
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.moviesArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell
    
    Movie *movie = self.moviesArray[indexPath.item];
    
    movie.imageURL = self.imageURLArray[indexPath.item];
    
    cell.movie = movie;

    
    return cell;

}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == [self.moviesArray count] - 1) {
        [self getMovieData];
    }
}
    
#pragma mark - Segue
    
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];
        Movie *movieItem = self.moviesArray[indexPath.row];
        DetailedViewController *detailedViewController = (DetailedViewController *)[segue destinationViewController];
        [detailedViewController setMovieItem:movieItem];
    }
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
