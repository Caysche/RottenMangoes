//
//  CustomCollectionViewCell.m
//  RottenMangoes
//
//  Created by Cay Cornelius on 26/09/16.
//  Copyright © 2016 Cornelius.Media. All rights reserved.
//

#import "CustomCollectionViewCell.h"
#import "Movie.h"

@implementation CustomCollectionViewCell
    
-(void)prepareForReuse {
    [super prepareForReuse];
    
    self.imageView.image = nil;
    
    [self.downloadTask suspend];
}

-(void)setMovie:(Movie *)movie {
    _movie = movie;
    [self performDownloadTask];
}
    
- (void)performDownloadTask {
    NSURLSession *session = [NSURLSession sharedSession];
    
    self.downloadTask = [session downloadTaskWithURL:self.movie.imageURL completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            UIImage * downloadedImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
            
            dispatch_async(dispatch_get_main_queue(), ^ {
                _movie.localImageURL = location;
                self.imageView.image = downloadedImage;
            });
        }
    }];
    
    
    [self.downloadTask resume];
}
@end
