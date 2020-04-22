//
//  AIFMapNavigationView.h
//  AIFMapLib
//
//  Created by yuankai on 2020/2/13.
//  Copyright © 2020 yuankai. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AIFMapNavigationView : UIView
@property (nonatomic, copy) void(^backBlock)(void);//返回按钮点击
@property (nonatomic, copy) void(^searchBlock)(void);//搜索按钮点击
+ (AIFMapNavigationView *)getMapNaivigationView;

- (void)setSearchAddressShow:(BOOL)show;
@end

NS_ASSUME_NONNULL_END
