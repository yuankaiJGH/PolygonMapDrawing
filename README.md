# PolygonMapDrawing
简书:https://www.jianshu.com/p/c19e9271d925

在地图上根据手指触碰的点,获得这些点的集合,包括多边形合法性检测

[TOC]
##AIFPolygonDrawingMapView(应用于路径绘制)
思路:superView添加一个mapView展示地图,再添加一个pointView用于展示点及点与点之间的连线。superView监听点击及拖动手势(拖动手势与地图本身的移动缩放手势冲突),所以要在手势代理方法里做一个过滤
``` objectivec
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    //高德地图无法屏蔽点击手势,这么处理
    if ([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]) {
        return YES;
    }
    return NO;
}
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]) {
        if (!self.beginDraw) {
            return NO;
        }
        //未闭合
        if (self.closeOutline) {
            return NO;
        }
        [self.mapView updateMapViewGesEnabled:NO];
        return YES;
    }
    
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        //判断是否在分段点上,是refresh--
        for (AIFBaseDrawPointObject *value in self.drawEditPointArray) {
            CGPoint dotPoint = value.point;
            CGPoint point = [touch locationInView:self.view];
            CGFloat distance = sqrt(pow((dotPoint.x - point.x), 2) + pow((dotPoint.y - point.y), 2));
            if (distance <= kDotViewCircle+20) {
                self.currentDrawPoint = value;
                //关闭mapView手势
                [self.mapView updateMapViewGesEnabled:NO];
                return YES;
            }
            self.currentDrawPoint = nil;
        }
    }
    [self.mapView updateMapViewGesEnabled:YES];
    return NO;
}
```

撤回功能
每次操作后会创建一个**AIFBaseDrawViewStateObject**对象,保存,撤回时取出上一个obj覆盖当前数据即可

superView监听到点击及拖动手势后保存我们需要的数据,具体实现逻辑参考**AIIFPolygonDrawingViewController**

##AIFLocationManager
定位权限相关
```objectivec
+ (BOOL)isAPPLocationAuthorizationStatus;//获取当前APP定位权限状态,定位功能是否可用
+ (void)showLocationAuthorizationError;//无定位权限是的弹框提示,点击跳转设置页面
+ (void)requestLocationAuthorization;//请求使用APP时的定位权限
```

定位相关业务
```objectivec

+ (id)shareInstance;//获取LocationManager单例对象

//获取到当前位置的详细信息
- (void)getCurrentPhoneLocationSuccess:(void(^)(NSString *country, NSString *province,NSString *city,NSString *county,NSString *addressName,id addressObject,CLLocationCoordinate2D coordinate))success fail:(void(^)(void))fail;

//根据经纬度获取地址信息
- (void)getAddressInfoByCoordinate:(CLLocationCoordinate2D)coordinate success:(void(^)(NSString *country, NSString *province,NSString *city,NSString *county,NSString *addressName,id addressObject))success fail:(void(^)(void))fail;

//根据文字地址获取经纬度
- (void)getCoordByAddress:(NSString *)address success:(void(^)(CLLocationCoordinate2D coord))success fail:(void(^)(void))fail;

```

##AIFMapTool
一些线段相交的算法,用于检测多边形是否合法
```objectivec
/**
 根据经纬度判断线段是否相交
 return NO:不相交
 */
+ (BOOL)isIntersectByCoorLine1:(NSArray *)line1 line2:(NSArray *)line2;
/**
 根据经纬度判断两多边形边界是否相交
 return NO:不相交
 */
+ (BOOL)isPolygonsIntersectantByCoorPolygon1:(NSArray *)polygon1 polygon2:(NSArray *)polygon2;
/**
 根据经纬度判断polygon1所有顶点是不是在polygon2里面
 return NO:不在
 */
+ (BOOL)isPolygonInPolygon1:(NSArray *)polygon1 polygon2:(NSArray *)polygon2;
/**
 根据CGPoint判断线段是否相交
 */
+ (BOOL)isIntersectByPointLine1:(NSArray<AIFBaseDrawPointObject *> *)line1 line2:(NSArray<AIFBaseDrawPointObject *> *)line2;
```

面积计算
```objectivec
/**
 计算多边形区域面积
 */
+ (double)aif_calculcatePolygonArea:(NSArray*)points;
```
##AIFDistributionMapView(应用于全国分布)
对MapView的封装,annotationView等样式定制化程度比较高通过Block的方式暴露在外面,另外实现了地图类型切换,一键定位到当前位置的功能
```objectivec
//行政区域边界样式
- (void)aifRendererForOverlay:(MAOverlayRenderer *(^)(MAMapView *mapView,id<MAOverlay> overlay))block;
//标注点样式
- (void)aifViewForAnnotation:(MAAnnotationView *(^)(MAMapView *mapView,id<MAAnnotation> annotation))block;
//地图缩放操作回调
- (void)aifMapDidZoomByUser:(void (^)(MAMapView *mapView,BOOL wasUserAction))block;
//标注点点击事件
- (void)aifDidSelectAnnotationView:(void (^)(MAMapView *mapView,MAAnnotationView* annotationView))block;
```
分布图功能请运行demo并参考**AIFDistributionMapViewController**具体实现
