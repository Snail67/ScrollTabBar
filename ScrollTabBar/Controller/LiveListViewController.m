//
//  LiveListViewController.m
//  Bilibili
//
//  Created by ane_it_ios on 16/9/7.
//  Copyright © 2016年 ane_it_ssk. All rights reserved.
//

#import "LiveListViewController.h"

#import "HistoryVC.h"
@interface LiveListViewController ()

@end

@implementation LiveListViewController

- (instancetype)init {
    if (self = [super init]) {
        self.title = @"直播";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    UIButton * btn  = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.bounds = CGRectMake(0, 0, 74, 44);
    btn.center = self.view.center ;
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"测试" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnClick:(UIButton*)btn {
    HistoryVC * historyVC = [HistoryVC new];
    
    [self.navigationController pushViewController:historyVC animated:YES];
    
    
}

@end
