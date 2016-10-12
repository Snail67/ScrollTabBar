//
//  MineCollectionViewCell.m
//  Bilibili
//
//  Created by ane_it_ios on 16/9/3.
//  Copyright © 2016年 ane_it_ssk. All rights reserved.
//

#import "MineCollectionViewCell.h"

@implementation MineCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setItem:(MineItemEntity *)item {
    if (item) {
        self.logoImageView.image = [UIImage imageNamed:item.logoName];
        self.titleLabel.text = item.title;
    }
    else {
        self.logoImageView.image = NULL;
        self.titleLabel.text = NULL;
    }
}
@end
