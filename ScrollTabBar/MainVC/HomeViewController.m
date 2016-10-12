//
//  HomeViewController.m
//  ScrollTabBar
//
//  Created by ane_it_ios on 16/8/21.
//  Copyright © 2016年 ane_it_ssk. All rights reserved.
//


#define kScreenWidth  CGRectGetWidth([[UIScreen mainScreen] bounds]) //屏幕宽

//字体
#define Font(fontSize) [UIFont fontWithName:@"ArialMT" size:fontSize]

#define ColorRGBA(r, g, b, a)               [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define ColorRGB(r, g, b)                 ColorRGBA((r), (g), (b), 1.0)
#define CRed ColorRGB(253,129,164)

#import "HomeViewController.h"
#import "ScrollTabBarController.h"

#import "LiveListViewController.h"
#import "RecommendListViewController.h"
#import "BangumiListViewController.h"
#import "ChaseBangVC.h"


#import "HomeHeaderView.h"
#import "TabBar.h"

#import "Masonry.h"

#import "UIView+Frame.h"


@interface HomeViewController () <UIGestureRecognizerDelegate,UIScrollViewDelegate>

@property (nonatomic,strong)HomeHeaderView *headerView;

@property (nonatomic,strong) UIScrollView *scrollView;
@end

@implementation HomeViewController

- (instancetype)init {
    if (self = [super init]) {
        self.tabBarItem.image = [UIImage imageNamed:@"home_home_tab"];
        self.tabBarItem.selectedImage = [UIImage imageNamed:@"home_home_tab_s"];
        self.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    }
    return self;
}
- (UIStatusBarStyle)preferredStatusBarStyle { //电池栏颜色
    return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)handlePan:(UIPanGestureRecognizer *)panGestureRecognizer {
    ScrollTabBarController *tabbar = (ScrollTabBarController *)self.tabBarController;
    [tabbar handlePanGesture:panGestureRecognizer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubviews];
}

- (void)loadSubviews {
    [self.view addSubview:UIView.new];//
    self.view.backgroundColor = CRed;
    
    self.scrollView =[[UIScrollView alloc] init];
    self.scrollView.delegate =self;
    self.scrollView.backgroundColor = CRed;  //CRed
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    //    self.scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    panGestureRecognizer.delegate = self; //添加滑动的手势
    [self.scrollView addGestureRecognizer:panGestureRecognizer];
    
    
    LiveListViewController *liveListController = [[LiveListViewController alloc] init];
    [self addChildViewController:liveListController];
    
    RecommendListViewController *recommendListController = [[RecommendListViewController alloc] init];
    [self addChildViewController:recommendListController];
    
    BangumiListViewController * bangumiListController = [[BangumiListViewController alloc] init];
    [self addChildViewController:bangumiListController];
    
    ChaseBangVC * chaseBangVC = [[ChaseBangVC alloc]init];
    [self addChildViewController:chaseBangVC];
    
    NSMutableArray *titles = [NSMutableArray arrayWithCapacity:self.childViewControllers.count] ;
    MASViewAttribute *constraint = self.scrollView.mas_left;
    
    for (UIViewController * controller in self.childViewControllers) {
        [titles addObject:controller.title];
        [self.scrollView addSubview:controller.view];
        [controller.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(constraint);
            make.top.equalTo(self.scrollView);
            make.width.equalTo(self.scrollView);
            make.height.equalTo(self.scrollView);
        }];
        constraint = controller.view.mas_right;
    }
    
    self.headerView = [[HomeHeaderView alloc]initWithTitles:titles];
    [self.view addSubview:self.headerView];
    
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view).offset =20;
        make.height.equalTo(@(44));
    }];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.headerView.mas_bottom);
        make.bottom.equalTo(@0);
    }];
    
    //    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.right.equalTo(constraint);
    //    }];
    
    self.scrollView.contentSize = CGSizeMake(kScreenWidth * 4, 0);
    [self.scrollView setContentOffset:CGPointMake(kScreenWidth, 0)];
    
    
    __weak typeof(self) weakself = self;
    [self.headerView setOnClickItem:^(NSInteger idx) {
        [weakself.scrollView setContentOffset:CGPointMake(weakself.scrollView.width * idx, 0) animated:YES];
        
    }];

    
    
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView; {
    self.headerView.contentOffset = scrollView.contentOffset.x / kScreenWidth;
}

#pragma mark UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer; {
    if (self.scrollView.contentOffset.x + self.scrollView.frame.size.width < self.scrollView.contentSize.width) {
        return NO;
    }
    UIPanGestureRecognizer *panGestureRecognizer = (UIPanGestureRecognizer *)gestureRecognizer;
    CGFloat translationX = [panGestureRecognizer translationInView:self.scrollView].x;
    if (translationX >= 0) {
        return NO;
    }
    return YES;
}


@end
