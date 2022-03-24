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
    self.contentView.backgroundColor = [UIColor randomColor];
    
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self.contentView).inset(8);
    }];
}

#pragma mark - ——————————————— Public Funcation ——————————————

- (void)cellModel:(CTDebugCellModel *)model
{
    self.titleLabel.text = model.title;
}

#pragma mark - ——————————————— Private Funcation —————————————

#pragma mark - —————————————————— Touch Event ————————————————

#pragma mark - ———————————————— Setter/Getter ————————————————

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:12];
        _titleLabel.numberOfLines = 0;
    }
    
    return _titleLabel;
}

@end
