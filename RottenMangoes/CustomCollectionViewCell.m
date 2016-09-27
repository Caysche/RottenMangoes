//
//  CustomCollectionViewCell.m
//  RottenMangoes
//
//  Created by Cay Cornelius on 26/09/16.
//  Copyright © 2016 Cornelius.Media. All rights reserved.
//

#import "CustomCollectionViewCell.h"

@implementation CustomCollectionViewCell
    
-(void)prepareForReuse {
    [super prepareForReuse];
    
    self.imageView.image = nil;
    
    [self.downloadTask suspend];
}

@end
