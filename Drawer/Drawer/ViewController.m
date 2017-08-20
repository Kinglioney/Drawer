//
//  ViewController.m
//  侧滑抽屉效果
//
//  Created by apple on 2017/8/18.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
@interface ViewController ()
@property (strong, nonatomic)  UIButton *pushBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.view.backgroundColor = [UIColor whiteColor];
    self.pushBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [self.pushBtn setCenter:CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2)];
    [self.pushBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.pushBtn setTitle:@"Push" forState:UIControlStateNormal];
    [self.pushBtn addTarget:self action:@selector(pushSecondVC:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: self.pushBtn];
    
}
- (IBAction)pushSecondVC:(id)sender {
    SecondViewController *secondVC = [[SecondViewController alloc]init];
    [self.navigationController pushViewController:secondVC animated:YES];
}




@end
