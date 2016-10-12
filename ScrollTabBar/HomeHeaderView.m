//
//  HomeHeaderView.m
//  bilibili fake
//
//  Created by cezr on 16/6/22.
//  Copyright © 2016年 云之彼端. All rights reserved.
//
#define ColorRGBA(r, g, b, a)               [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define ColorRGB(r, g, b)                 ColorRGBA((r), (g), (b), 1.0)
#define CRed ColorRGB(253,129,164)

#define SSize   [UIScreen mainScreen].bounds.size

#import "HomeHeaderView.h"

@interface HomeHeaderView ()

@end

@implementation HomeHeaderView

- (instancetype)initWithTitles:(NSArray<NSString *> *)titles {
    if (self = [super initWithTitles:titles style:TabBarStyleNormal]) {
        self.backgroundColor = CRed;
        self.tintColorRGB = @[@230,@230,@230];
        self.selTintColorRGB = @[@255, @255, @255];
        self.edgeInsets = UIEdgeInsetsMake(0, (SSize.width-50*titles.count)/2, 4, (SSize.width-50*titles.count)/2);
        self.spacing = 20;
    }
    return self;
}

@end
