//
//  AIFPointCoorInfo.h
//  AIFMapLib
//
//  Created by yuankai on 2020/4/22.
//  Copyright © 2020 yuankai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AIFPointCoorInfo <NSObject>
+ (CLLocationCoordinate2D)coordinate:(id)point;
@end

NS_ASSUME_NONNULL_END
