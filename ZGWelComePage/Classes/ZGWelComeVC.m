//
//  ZGWelComeVC.m
//  ZGDemo
//
//  Created by offcn_zcz32036 on 2018/4/24.
//  Copyright © 2018年 cn. All rights reserved.
//

#import "ZGWelComeVC.h"

@interface ZGWelComeVC ()<UIScrollViewDelegate>

@property (nonatomic, strong)NSArray *imageArr;
@property (nonatomic, strong)UIViewController *rootVC;

@end

@implementation ZGWelComeVC

- (void)viewDidLoad {
    [super viewDidLoad];

}
- (ZGWelComeVC *)initWithImageNameArray:(NSArray *)imageArr rootViewController:(UIViewController *)rootVC{
    if (self = [super init]) {
        _imageArr = imageArr;
        _rootVC = rootVC;
        [self setupSubviewsWithImageArr:imageArr];
    }
    return self;
}

- (void)dealloc{
    NSLog(@"dealloc welcomeVC");
}

- (void)setupSubviewsWithImageArr:(NSArray *)imageArr{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    scrollView.contentSize = CGSizeMake(imageArr.count * CGRectGetWidth(self.view.frame), 0);
    scrollView.bounces = NO;
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scrollView];

    for (int i = 0; i < imageArr.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageArr[i]]];
        imageView.frame = CGRectMake(CGRectGetWidth(self.view.frame) * i, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.backgroundColor = [UIColor whiteColor];
        imageView.userInteractionEnabled = YES;
        [scrollView addSubview:imageView];

        if (i == imageArr.count - 1) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:@"立即体验" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            button.layer.borderWidth = 2;
            button.layer.borderColor = [UIColor darkGrayColor].CGColor;
            button.layer.cornerRadius = 4;
            CGFloat buttonWidth = 100;
            button.frame = CGRectMake((CGRectGetWidth(self.view.frame) - buttonWidth)/2, CGRectGetHeight(self.view.frame) * 0.86, buttonWidth, 30);
            [button addTarget:self action:@selector(showRootControllerButtonClick) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:button];
            self.showRootControllerBtn = button;

        }
    }

    CGRect rect = CGRectMake(0, CGRectGetHeight(self.view.frame) * 0.9, CGRectGetWidth(self.view.frame), 15);
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:rect];
    pageControl.numberOfPages = imageArr.count;
    pageControl.hidesForSinglePage = YES;
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor darkGrayColor];
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
}

//  点击"立即体验"
- (void)showRootControllerButtonClick{
    // 再次使用app时, 不再出现欢迎页
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setBool:YES forKey:ZGWelcomeIsLaunchDefaultKey];
    [userDefault synchronize];

    [UIApplication sharedApplication].keyWindow.rootViewController = self.rootVC;
    CATransition *anim = [CATransition animation];
    anim.type = kCATransitionFade;
    anim.duration = 0.4;
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:anim forKey:nil];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat page = scrollView.contentOffset.x / CGRectGetWidth(self.view.frame);
    self.pageControl.currentPage = roundf(page);// 四舍五入
    if (page > (self.pageControl.numberOfPages - 1.5)) {
        self.pageControl.alpha = 0;
        self.pageControl.hidden = YES;
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            self.pageControl.alpha = 1;
        } completion:^(BOOL finished) {
            self.pageControl.hidden = NO;
        }];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
