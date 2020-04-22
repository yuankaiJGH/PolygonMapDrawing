//
//  AIFBaseMapDrawTopInfoView.h
//  AIFMapLib
//
//  Created by yuankai on 2020/2/12.
//  Copyright © 2020 yuankai. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AIFBaseMapDrawTopInfoView : UIView
@property (nonatomic, copy) void(^confirmBlock)(void);//确认按钮点击
@property (strong, nonatomic) UILabel *areaLabel;
@property (strong, nonatomic) UILabel *perimeterLabel;
@property (strong, nonatomic) UIButton *confirmBtn;
+ (AIFBaseMapDrawTopInfoView *)getMapDrawTopView;
@end

NS_ASSUME_NONNULL_END
