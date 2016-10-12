//
//  MineCollectionView.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/29.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#define SSize   [UIScreen mainScreen].bounds.size

#import "MineCollectionView.h"
#import "MineCollectionViewCell.h"
#import "MineHeaderCollectionReusableView.h"

#import "UIView+Frame.h"
#import "Masonry.h"
//#import "ReactiveCocoa.h"

@interface MineCollectionView ()
<UICollectionViewDelegate, UICollectionViewDataSource>
{
    
}
@end

@implementation MineCollectionView

- (void)dealloc {
//    LogDEBUG(@"");
}

- (void)setGroups:(NSArray<MineGroupEntity *> *)groups {
    _groups = groups;
    [self reloadData];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.backgroundView.y < 0) {
        self.backgroundView.y = 0;
    }
}

- (instancetype)init {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.headerReferenceSize = CGSizeMake(SSize.width, 40);
    flowLayout.footerReferenceSize = CGSizeMake(SSize.width, 10);
    flowLayout.itemSize = CGSizeMake((SSize.width-1*5) / 4, (SSize.width-1*5) / 4);
    flowLayout.sectionInset = UIEdgeInsetsMake(1, 1, 1, 1);
    flowLayout.minimumLineSpacing = 1;
    flowLayout.minimumInteritemSpacing = 1;
    if (self = [super initWithFrame:CGRectZero collectionViewLayout:flowLayout]) {
        self.backgroundView = [[UIView alloc] init];
        self.backgroundView.backgroundColor = [UIColor colorWithWhite:(247)/255.0 alpha:1.0];
        self.backgroundView.layer.cornerRadius = 6;
        self.backgroundView.layer.masksToBounds = YES;
        self.layer.cornerRadius = 6;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor colorWithRed:(253)/255.0 green:(129)/255.0 blue:(164)/255.0 alpha:1.0];
        self.dataSource = self;
        self.delegate = self;
        self.alwaysBounceVertical = YES; 
        
        self.showsVerticalScrollIndicator = NO;
//        [self registerClass:[MineCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
        [self registerNib:[UINib nibWithNibName:@"MineCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"MineCollectionViewCell"];
        
        [self registerClass:[MineHeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
        [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"Footer"];
    }
    return self;
}

/**
 *  Number
 */
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.groups count];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger count = [self.groups[section].items count];
    return count % 4 == 0 ? count : count + (4-count%4);
}
/**
 *  Cell
 */
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        MineHeaderCollectionReusableView *  headerRV = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"Header" forIndexPath:indexPath]  ;
        
        headerRV.title =_groups[indexPath.section].title;
        
        return headerRV;
        
    }
    else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        return [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"Footer" forIndexPath:indexPath];
    }
    return NULL;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MineCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MineCollectionViewCell" forIndexPath:indexPath];
    
        if (indexPath.row < _groups[indexPath.section].items.count) {
            [cell setItem:self.groups[indexPath.section].items[indexPath.row]];
        }
        else {
            [cell setItem:NULL];
        }
    
    
    
    return cell;
}

/**
 *  Data
 */

//- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
//    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
//        
//        ((MineHeaderCollectionReusableView *)view).title = _groups[indexPath.section].title;
//        [collectionView.backgroundView addSubview:view];
//         
//        if (view.tag == 0) {
//            view.tag = 1;
//            [RACObserve(collectionView, contentOffset) subscribeNext:^( id x) {
//                CGFloat y = [x CGPointValue].y;
//                view.transform = CGAffineTransformMakeTranslation(0, -(y>0 ? y : 0));
//            }];
//        }
//    }
//}


//设置单元格cell的内容
//- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(MineCollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row < _groups[indexPath.section].items.count) {
//        [cell setItem:self.groups[indexPath.section].items[indexPath.row]];
//    }
//    else {
//        [cell setItem:NULL];
//    }
//}



/**
 *  Select
 */
//- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    return indexPath.row < _groups[indexPath.section].items.count;
//}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_handleDidSelectedItem) {
        _handleDidSelectedItem(indexPath) ;
    }
    
//    _handleDidSelectedItem ? _handleDidSelectedItem(indexPath) : NULL;
}

@end
