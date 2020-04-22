//
//  AIFMapNavigationView.m
//  AIFMapLib
//
//  Created by yuankai on 2020/2/13.
//  Copyright © 2020 yuankai. All rights reserved.
//

#import "AIFMapNavigationView.h"
#import "CommonHeader.h"


@interface AIFMapNavigationView ()
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIButton *searchBtn;
@property (nonatomic, strong) UIImageView *searchIcon;
@property (nonatomic, strong) UIImageView *searchBGImageView;
@property (nonatomic, strong) UILabel *searchLabel;
@property (nonatomic, strong) UIView *searchContentView;
@property (nonatomic, strong) UIView *verticalLine;

@property (assign, nonatomic) BOOL showSearchAddressShow;
@end

@implementation AIFMapNavigationView

#pragma mark - events
+ (AIFMapNavigationView *)getMapNaivigationView{
    AIFMapNavigationView *view = [[AIFMapNavigationView alloc]initWithFrame:CGRectMake(0, STATUSBARHEIGHT + 10, SCREEN_WIDTH, 40)];
    return view;
}

- (void)setSearchAddressShow:(BOOL)show{
    _showSearchAddressShow = show;
    self.searchContentView.hidden = !show;
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *view = [super hitTest:point withEvent:event];
    if (!_showSearchAddressShow && view == self) {
        return nil;
    }
    return view;
}

#pragma mark - setupUI
- (void)setupUI{
    [self addSubview:self.backBtn];
    [self addSubview:self.searchContentView];
    [self.searchContentView addSubview:self.searchBGImageView];
    [self.searchContentView addSubview:self.searchIcon];
    [self.searchContentView addSubview:self.searchLabel];
    [self.searchContentView addSubview:self.searchBtn];
    [self.searchContentView addSubview:self.verticalLine];
    
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.offset(34*iPhone6BasicWidth);
        make.left.equalTo(self.mas_left).offset(17*iPhone6BasicWidth);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.searchContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.backBtn.mas_right).offset(12*iPhone6BasicWidth);
        make.right.equalTo(self.mas_right).offset(-16*iPhone6BasicWidth);
    }];
    
    [self.searchBGImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.searchContentView);
    }];
    
    [self.searchIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.searchContentView).offset(10*iPhone6BasicWidth);
        make.centerY.equalTo(self.searchContentView);
        make.width.height.mas_equalTo(15*iPhone6BasicWidth);
    }];
    
    [self.searchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.searchIcon.mas_right).offset(13*iPhone6BasicWidth);
        make.right.equalTo(self.searchContentView.mas_right).offset(-13*iPhone6BasicWidth);
        make.centerY.equalTo(self.searchContentView);
    }];
    
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.searchContentView);
    }];
    
}

- (void)backBtnAction:(UIButton *)sender{
    if (self.backBlock) {
        self.backBlock();
    }
}

- (void)searchBtnAction:(UIButton *)sender{
    if (self.searchBlock) {
        self.searchBlock();
    }
}
#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (UIButton *)backBtn{
    if (!_backBtn) {
        UIButton *button = [[UIButton alloc]init];
        [button setBackgroundImage:[UIImage imageNamed:@"WorkPlatform_backshadow"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(backBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _backBtn = button;
    }
    return _backBtn;
}

- (UIButton *)searchBtn{
    if (!_searchBtn) {
        UIButton *button = [[UIButton alloc]init];
        
        [button addTarget:self action:@selector(searchBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _searchBtn = button;
    }
    return _searchBtn;
}

- (UIImageView *)searchIcon{
    if (!_searchIcon) {
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"WorkPlatform_selectMapSearch"]];
        _searchIcon = imageView;
    }
    return _searchIcon;
}

- (UIImageView *)searchBGImageView{
    if (!_searchBGImageView) {
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"search_bg"]];
        _searchBGImageView = imageView;
    }
    return _searchBGImageView;
}

- (UILabel *)searchLabel{
    if (!_searchLabel) {
        UILabel *label = [UILabel new];
        
        label.textColor = [UIConfig colorFromHexRGB:@"a0a0a0"];
        label.font = [UIFont systemFontOfSize:15];
        label.text = @"搜索定位基地位置";
        _searchLabel = label;
    }
    return _searchLabel;
}

- (UIView *)searchContentView{
    if (!_searchContentView) {
        UIView *view = [[UIView alloc]init];
        _searchContentView = view;
    }
    return _searchContentView;
}


- (UIView *)verticalLine{
    if (!_verticalLine) {
        UIView *view = [[UIView alloc] init];
        view.hidden = YES;
        view.backgroundColor = [UIColor colorWithRed:212/255.0 green:212/255.0 blue:212/255.0 alpha:1.0];
        _verticalLine = view;
    }
    return _verticalLine;
}
@end
