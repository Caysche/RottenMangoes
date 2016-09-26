//
//  Movie.m
//  RottenMangoes
//
//  Created by Cay Cornelius on 26/09/16.
//  Copyright © 2016 Cornelius.Media. All rights reserved.
//

#import "Movie.h"

@implementation Movie

- (instancetype)initWithTitle:(NSString *)title andURL:(NSURL *)url andRuntime:(NSNumber *)runtime andImage:(UIImage *)image
    {
        self = [super init];
        if (self) {
            _title = title;
            _url = url;
            _runtime = runtime;
            _image = image;
        }
        return self;
    }
    
@end
