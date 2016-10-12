//
//  MineCollectionViewCell.h
//  Bilibili
//
//  Created by ane_it_ios on 16/9/3.
//  Copyright © 2016年 ane_it_ssk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MineItemEntity.h"

@interface MineCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *logoImageView;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;


//@property (nonatomic,retain)MineItemEntity *item;

- (void)setItem:(MineItemEntity *)item;

@end
