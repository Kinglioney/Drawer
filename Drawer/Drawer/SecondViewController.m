//
//  SecondViewController.m
//  侧滑抽屉效果
//
//  Created by apple on 2017/8/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "SecondViewController.h"

#import "RightViewController.h"
#define kRightViewControllerWidth 0.4*self.view.frame.size.width

@interface SecondViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UIView *rightView;
@property (nonatomic, assign) CGFloat mainViewX;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    [self creatChildView];

    [self addGesture];

    // 通过KVO来监听mainView的frame的变化，从而判断maimView是左滑还是右滑。
    [self.mainView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [_mainView removeObserver:self forKeyPath:@"frame"];
}
- (void)creatChildView
{
    _rightView = [[UIView alloc] initWithFrame:self.view.bounds];
    _rightView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_rightView];

    _mainView = [[UIView alloc] initWithFrame:self.view.bounds];
    _mainView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_mainView];
}
- (void)addGesture
{
    // 添加一个滑动手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self.view addGestureRecognizer:pan];

    //给mainView添加一个点击手势
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.mainView addGestureRecognizer:tapGes];

}
#pragma mark - 手势动作的响应方法
- (void)tapAction:(UITapGestureRecognizer *)tapGesture{

    [UIView animateWithDuration:0.3 animations:^{
        // 改变mainView的frame
        _mainView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }];


}


- (void)panAction:(UIPanGestureRecognizer *)panGesture
{
    switch (panGesture.state) {

            case UIGestureRecognizerStateChanged:
        {
            // 获取平移手势移动后, 在相对坐标中的偏移量
            CGPoint point = [panGesture translationInView:self.view];

            // 声明xNew变量用point.x赋值
            CGFloat xNew = point.x;
            CGFloat mainViewX = xNew + _mainView.frame.origin.x;

            //用成员变量保存mainview的X坐标值
            _mainViewX = mainViewX;

            if (xNew < 0 ) {//左滑动
                [UIView animateWithDuration:0.3 animations:^{
                    // 改变mainView的frame
                    _mainView.frame = CGRectMake(_mainViewX, 0, self.view.frame.size.width, self.view.frame.size.height);
                }];
            }else{//右滑动就恢复原状
                [UIView animateWithDuration:0.3 animations:^{
                    // 改变mainView的frame
                    _mainView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
                }];
            }

                



        }
            break;
            case UIGestureRecognizerStateEnded:
        {
            if(_mainViewX > -kRightViewControllerWidth+10){
                [UIView animateWithDuration:0.3 animations:^{
                    // 改变mainView的frame
                    _mainView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
                }];
            }else{
                [UIView animateWithDuration:0.3 animations:^{
                    // 改变mainView的frame
                    _mainView.frame = CGRectMake(-kRightViewControllerWidth, 0, self.view.frame.size.width, self.view.frame.size.height);
                }];

            }

        }
            break;
            
        default:
            break;
    }

    // 设置手势移动后的point
    [panGesture setTranslation:CGPointZero inView:panGesture.view];

}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if (_mainView.frame.origin.x > 0) {
        _rightView.hidden = YES;

    }else {
        _rightView.hidden = NO;

    }
}

@end
