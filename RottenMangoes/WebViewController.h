//
//  WebViewController.h
//  RottenMangoes
//
//  Created by Cay Cornelius on 26/09/16.
//  Copyright © 2016 Cornelius.Media. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@class Movie;

@interface WebViewController : UIViewController

@property (nonatomic, strong) Movie *movieItem;
    
@end
