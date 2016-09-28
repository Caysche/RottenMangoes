//
//  MapTableViewCell.h
//  RottenMangoes
//
//  Created by Cay Cornelius on 27/09/16.
//  Copyright © 2016 Cornelius.Media. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Theatre;

@interface MapTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@property (nonatomic) Theatre *theatre;


@end
