//
//  CTDebugCollectionViewCell.m
//  iOS-Sample
//
//  Created by macRong on 2022/1/5.
//

#import "CTDebugCollectionViewCell.h"

@interface CTDebugCollectionViewCell()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation CTDebugCollectionViewCell


#pragma mark - ——————————————————— LifeCycle ——————————————————

- (void)dealloc
{
    
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if ([super initWithFrame:frame]) {
        
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
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
}

#pragma mark - ——————————————— Public Funcation ——————————————

#pragma mark - ——————————————— Private Funcation —————————————

#pragma mark - —————————————————— Touch Event ————————————————

#pragma mark - ———————————————— Setter/Getter ————————————————

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"text12";
    }
    
    return _titleLabel;
}

@end
