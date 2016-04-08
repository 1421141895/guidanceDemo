//
//  TJGuideViewController.m
//  guidanceDemo
//
//  Created by 露萍沈 on 16/4/7.
//  Copyright © 2016年 SLP. All rights reserved.
//

#import "TJGuideViewController.h"
#import "AppDelegate.h"

#define SCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

#define PAGECONTROL_DISTANCE_BOTTOM   35
#define BASETAG                       1000

@interface TJGuideViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSArray *imageArr;

@end

@implementation TJGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //使用sourceTree的步骤的时候进行测试
    [self initialData];
    [self initialScrollView];
    [self initialImageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)imageArr
{
    if (nil == _imageArr) {
        _imageArr = [[NSArray alloc] init];
    }
    return _imageArr;
}


#pragma mark --- initial methods

- (void)initialData
{
    self.imageArr = @[@"图片搜索.jpg", @"动态图集.jpg", @"全景直播.jpg",  @"玩转生活.jpg", @"我是你的眼.jpg"];
}

- (void)initialScrollView
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH * self.imageArr.count, SCREEN_HEIGHT);
    
    [self.view addSubview:self.scrollView];
    
}

- (void)initialImageView
{
    NSInteger currentPosition = 0;
    
    for (NSInteger index = 0; index < self.imageArr.count; index ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0 + currentPosition, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        imageView.tag = BASETAG + index;
        imageView.image = [UIImage imageNamed:self.imageArr[index]];
        [self.scrollView addSubview:imageView];
        currentPosition += SCREEN_WIDTH;
    }
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - PAGECONTROL_DISTANCE_BOTTOM, SCREEN_WIDTH, PAGECONTROL_DISTANCE_BOTTOM)];
    self.pageControl.numberOfPages = self.imageArr.count;
    self.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    [self.view addSubview:self.pageControl];
}


#pragma mark -- target action

- (void)goMainView
{
    self.view = nil;
    [(AppDelegate *)[UIApplication sharedApplication].delegate loadMainView];
    
}

- (void)changePage:(UIPageControl *)pageControl
{
    NSInteger page = _pageControl.currentPage + 1;
    [_scrollView setContentOffset:CGPointMake(SCREEN_WIDTH* page, 0)];
}

#pragma mark --- scrollView delegate

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x > SCREEN_WIDTH * ([self.imageArr count] - 1)) {
        [self goMainView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int current = scrollView.contentOffset.x / SCREEN_WIDTH;
    self.pageControl.currentPage = current;
    [self.pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
}


@end
