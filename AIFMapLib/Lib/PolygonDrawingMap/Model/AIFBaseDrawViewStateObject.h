//
//  AIFBaseDrawViewStateObject.h
//  AIFMapLib
//
//  Created by yuankai on 2020/2/12.
//  Copyright © 2020 yuankai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN


//绘制的点在屏幕上的cgpoint和地图中的经纬度要互转
@interface AIFBaseDrawPointObject : NSObject
@property (assign, nonatomic) CGPoint point;
@property (assign, nonatomic) int pointType;//0小点 1大点
@property (assign, nonatomic) CLLocationCoordinate2D coor;
@end

//保存当前路径信息的类
@interface AIFBaseDrawViewStateObject : NSObject
@property (copy, nonatomic) NSArray *orignalPoints;
@property (assign, nonatomic) BOOL close;
@property (assign, nonatomic ,readonly) BOOL legitimate;//当前图形是否合法
@property (copy, nonatomic) NSArray *editPoints;
@property (copy, nonatomic) NSString *colorStr;

- (void)checkLegitimate;
@end

NS_ASSUME_NONNULL_END
