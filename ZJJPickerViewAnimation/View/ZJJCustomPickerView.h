//
//  ZJJCustomPickerView.h
//  ZJJPickerViewAnimation
//
//  Created by 张锦江 on 2017/8/16.
//  Copyright © 2017年 ZJJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PassPickSelected)(NSString *string);

@interface ZJJCustomPickerView : UIView

- (instancetype)init;

/**
 *allColumnsArray = @[@[第一列内容],@[第二列内容],...];
 */
@property (nonatomic, strong) NSArray *allColumnsArray;
@property (nonatomic, assign) PassPickSelected passString;

@end
