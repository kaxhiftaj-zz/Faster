//
//  HistoryCell.m
//  UberforX Provider
//
//  Created by My Mac on 11/15/14.
//  Copyright (c) 2014 Deep Gami. All rights reserved.
//

#import "HistoryCell.h"
#import "UIView+Utils.h"

@implementation HistoryCell

- (void)awakeFromNib {
    [self.imgOwner applyRoundedCornersFullWithColor:[UIColor whiteColor]];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
