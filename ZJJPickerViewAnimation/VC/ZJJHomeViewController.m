//
//  ZJJHomeViewController.m
//  ZJJPickerViewAnimation
//
//  Created by 张锦江 on 2017/8/16.
//  Copyright © 2017年 ZJJ. All rights reserved.
//

#import "ZJJHomeViewController.h"
#import "ZJJCustomPickerView.h"

@interface ZJJHomeViewController () {
    UIView *_lastView;
}

@end

@implementation ZJJHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"首页";
    [self setUpUI];
 
}

- (void)setUpUI {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(100, 100, 100, 50);
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"出来吧!" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(pickerOut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)pickerOut {
    [_lastView removeFromSuperview];
    ZJJCustomPickerView *custom = [[ZJJCustomPickerView alloc] init];
    custom.allColumnsArray = @[@[@"10",@"11",@"12",@"13",@"14"],
                               @[@"20",@"21",@"22",@"23",@"24",@"25"],
                               @[@"30",@"31",@"32"]
                               ];
    custom.passString = ^(NSString *string) {
        NSLog(@"收到的是string=%@",string);
    };
    [[[[UIApplication sharedApplication] delegate] window] addSubview:custom];
    _lastView = custom;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
