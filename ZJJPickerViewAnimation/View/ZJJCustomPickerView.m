//
//  ZJJCustomPickerView.m
//  ZJJPickerViewAnimation
//
//  Created by 张锦江 on 2017/8/16.
//  Copyright © 2017年 ZJJ. All rights reserved.
//

#define   SCREEN_RECT         [UIScreen mainScreen].bounds
#define   SCREEN_WIDTH        SCREEN_RECT.size.width
#define   SCREEN_HEIGHT       SCREEN_RECT.size.height
#define   BOTTOM_HEIGHT       (SCREEN_HEIGHT/3 + 40)
#define   UN_VISABLE_FRAME    CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, BOTTOM_HEIGHT)
#define   VISABLE_FRAME       CGRectMake(0, SCREEN_HEIGHT-BOTTOM_HEIGHT, SCREEN_WIDTH, BOTTOM_HEIGHT)

#import "ZJJCustomPickerView.h"

@interface ZJJCustomPickerView () <UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *finishBtn;
@property (nonatomic, strong) UIPickerView *pickerView;

@end

@implementation ZJJCustomPickerView

- (instancetype)init {
    self = [super initWithFrame:SCREEN_RECT];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self creatView];
    }
    return self;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:UN_VISABLE_FRAME];
        _bottomView.backgroundColor = [UIColor whiteColor];
        _bottomView.layer.cornerRadius = 10.0f;
        _bottomView.clipsToBounds = YES;
    }
    return _bottomView;
}

- (UIButton *)finishBtn {
    if (!_finishBtn) {
        _finishBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _finishBtn.frame = CGRectMake(SCREEN_WIDTH-60, 0, 60, 40);
        _finishBtn.backgroundColor = [UIColor whiteColor];
        [_finishBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_finishBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_finishBtn addTarget:self action:@selector(finishClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _finishBtn;
}
- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, BOTTOM_HEIGHT-40)];
        _pickerView.showsSelectionIndicator = YES;
        _pickerView.backgroundColor = [UIColor whiteColor];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}
- (void)creatView {
    [self addSubview:self.bottomView];
    [self.bottomView addSubview:self.finishBtn];
    [self.bottomView addSubview:self.pickerView];
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5];
        self.bottomView.frame = VISABLE_FRAME;
    }];
}

- (void)moveAwaySelfView {
    [UIView animateWithDuration:0.2 animations:^{
        self.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0];
        self.bottomView.frame = UN_VISABLE_FRAME;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
#pragma mark - 完成按钮点击事件
- (void)finishClick {
    NSString *selectedContent = @"";
    for (NSInteger index = 0; index<self.allColumnsArray.count; index++) {
        NSInteger selectedIndex = [self.pickerView selectedRowInComponent:index];
        NSString *everyColumnContent = self.allColumnsArray[index][selectedIndex];
        if ([selectedContent isEqualToString:@""]) {
            selectedContent = everyColumnContent;
        }else {
            selectedContent = [NSString stringWithFormat:@"%@-%@",selectedContent,everyColumnContent];
        }
    }
    if (self.passString) {
        self.passString(selectedContent);
    }
    [self moveAwaySelfView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self moveAwaySelfView];
}

#pragma mark - pickerView 代理方法
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.allColumnsArray.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSArray *columnArray = self.allColumnsArray[component];
    return columnArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSArray *columnArray = self.allColumnsArray[component];
    return columnArray[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
