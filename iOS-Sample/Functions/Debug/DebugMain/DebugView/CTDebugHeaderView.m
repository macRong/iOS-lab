//
//  CTDebugHeaderView.m
//  iOS-Sample
//
//  Created by macRong on 2022/1/6.
//

#import "CTDebugHeaderView.h"

@interface CTDebugHeaderView()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation CTDebugHeaderView

#pragma mark -  —————————————————— LifeCycle ——————————————————

- (void)dealloc
{
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
    {
        [self initVars];
        [self initViews];
    }
    
    return self;
}

/** 变量初始化 */
- (void)initVars
{
    
}

/** 创建相关子view */
- (void)initViews
{
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}


#pragma mark - ——————————————— Public Funcation ———————————————

- (void)loadUIForTitle:(NSString *)title
{
    self.titleLabel.text = title;
}

#pragma mark - ——————————————— Private Funcation ——————————————

#pragma mark - —————————————————— Touch Event  ————————————————

#pragma mark - ———————————————— Setter/Getter  ————————————————

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _titleLabel;
}

@end
