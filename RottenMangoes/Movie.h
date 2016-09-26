//
//  Movie.h
//  RottenMangoes
//
//  Created by Cay Cornelius on 26/09/16.
//  Copyright © 2016 Cornelius.Media. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface Movie : NSObject

    @property (nonatomic, strong) NSString *title;
    @property (nonatomic, strong) NSURL *url;
    @property (nonatomic, strong) NSNumber *runtime;
    @property (nonatomic, strong) UIImage *image;
    
- (instancetype)initWithTitle:(NSString *)title andURL:(NSURL *)url andRuntime:(NSNumber *)runtime andImage:(UIImage *)image;
    
@end