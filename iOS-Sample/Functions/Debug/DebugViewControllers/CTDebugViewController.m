//
//  CTDebugViewController.m
//  iOS-Sample
//
//  Created by macRong on 2022/1/5.
//

#import "CTDebugViewController.h"

@interface CTDebugViewController ()

@end

@implementation CTDebugViewController

#pragma mark -  ——————————————————— LifeCycle ———————————————————

- (void)dealloc
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // 初始化变量
    [self initVars];

    // 初始化界面
    [self initViews];
    
    // 数据请求
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -  ————————————————— init and config ——————————————

/** 初始化变量 */
- (void)initVars
{
    
}

/** 初始化界面 */
- (void)initViews
{
    [self initNavView];
    [self initMainViews];
}

/** 初始化Nav导航栏 */
- (void)initNavView
{
    
}

/** 创建相关子view */
- (void)initMainViews
{

}

#pragma mark - ———————————————————— Override —————————————————


#pragma mark - ————————————— Net Connection Event ————————————

/** 数据加载 */
- (void)loadData
{
    
}

#pragma mark - ——————————————— Public Funcation ———————————————


#pragma mark - ————————— ————— Private Funcation ——————————————


#pragma mark - —————————————————— Touch Event —————————————————


#pragma mark - ————————————————— Delegate Event ———————————————


#pragma mark - ————————————————— Setter/Getter ————————————————


@end
