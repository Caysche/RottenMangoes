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
    @property (nonatomic, strong) NSString *synopsis;
    @property (nonatomic, strong) NSURL *localImageURL;
    @property (nonatomic, strong) NSNumber *iD;
    @property (nonatomic, strong) NSURL *imageURL;
    
- (instancetype)initWithTitle:(NSString *)title andURL:(NSURL *)url andRuntime:(NSNumber *)runtime andSynopsis:(NSString *)synopsis andID:(NSNumber *)iD;
    
@end
