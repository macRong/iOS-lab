//
//  SEOViewController.m
//  iOS-Sample
//
//  Created by macRong on 2018/8/2.
//  Copyright © 2018年 macRong. All rights reserved.
//

#import "SEOViewController.h"
#import <AFNetworking.h>
#import "SEOTableViewCell.h"

@interface SEOViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArrary;

@end

static int requestCount = 0;

static int requestMax = 4;  // 每次最多访问个数
static int currentIndex = 0; // 当前访问的index

@implementation SEOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)cleanCache
{
    [self.dataArrary removeAllObjects];
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    int cacheSizeMemory = 1*1024*1024;
    int cacheSizeDisk = 5*1024*1024;
    NSURLCache *sharedCache = [[NSURLCache alloc] initWithMemoryCapacity:
                               cacheSizeMemory diskCapacity:cacheSizeDisk diskPath:@"nsurlcache"];
    [NSURLCache setSharedURLCache:sharedCache];
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

- (IBAction)startAction:(id)sender
{
    [self cleanCache];
    
    UIButton *btn = (UIButton *)sender;
    NSString *str = [NSString stringWithFormat:@"请求：%d次",requestCount++];
    [btn setTitle:str forState:UIControlStateNormal];
    
    NSArray *urls = @[
                      @"https://www.baidu.com/s?wd=shengshui.com",
                      @"https://www.baidu.com/s?wd=圣水笔记",
                      @"http://www.123cha.com/alexa/shengshui.com",
                      @"http://www.alexa.cn/shengshui.com",
                      @"http://seo.addpv.com/SuperLink/shengshui.com",
                      @"http://seo.dmeng.net/seolink.html?domain=shengshui.com&index=40&time=30",
                      @"http://www.wealink.com/zhaopin/kw-shengshui.com/city-1031-%E5%8C%97%E4%BA%AC/",
                      @"https://www.aizhan.com/cha/shengshui.com/",
                      @"http://so.chinaz.com/cse/search?q=shengshui.com&s=13215756937974215344&nsid=0",
                      @"http://seo.chinaz.com/?q=shengshui.com",
                      @"https://www.so.com/s?ie=utf-8&src=360sou_home&_re=0&q=shengshui.com",
                      @"http://www.chinaso.com/?q=shengshui.com",
                      @"http://www.chinaso.com/search/pagesearch.htm?q=shengshui.com",
                      @"http://www.sogou.com/web?query=site:shengshui.com",
                      @"http://s.weibo.com/weibo/shengshui.com&Refer=index?sudaref=www.6ke.com.cn&display=0&retcode=6102",
                      @"http://v.sogou.com/v?p=17040600&query=shengshui.com",
                      @"https://www.douban.com/search?q=shengshui.com",
                      @"http://www.haitao.com/?k=shengshui.com",
                      @"http://www.shengshui.com/?SEOViewController",
                      @"https://www.so.com/s?ie=utf-8&src=360sou_home&_re=0&q=shengshui.com",
                      @"https://www.baidu.com/s?bs=%CA%A5%CB%AE%B1%CA%BC%C7&f=8&rsv_bp=1&wd=%CA%A5%CB%AE%B1%CA%BC%C7&inputT=358",
                      @"https://auction.ename.com/index/search?keyword=shengshui.com",
                      @"https://wanwang.aliyun.com/domain/searchresult/?keyword=shengshui.com&suffix=.com#/?keyword=shengshui&suffix=com",
                      @"http://search.tianya.cn/bbs?q=shengshui.com",
                      @"http://wh.58.com/sou/?key=shengshui.com",
                      @"http://wh.58.com/sou/?key=圣水笔记",
                      @"https://icp.aizhan.com/shengshui.com/",
                      @"https://link.aizhan.com/?url=shengshui.com&vt=c",
                      @"https://s.taobao.com/search?initiative_id=staobaoz_20171111&q=shengshui.com",
                      @"http://ks.pconline.com.cn/?q=shengshui.com",
                      @"http://www.haitao.com/?k=shengshui.com",
                      @"http://so.jiaodong.net/cse/search?s=12073135703999628942&q=shengshui.com&keywords=lusongsong.com&x=31&y=14",
                      @"https://whois.aizhan.com/shengshui.com/",
                      @"http://search.kankan.com/search.php?keyword=shengshui.com",
                      @"http://tool.chinaz.com/speedtest.aspx?host=shengshui.com",
                      @"http://whois.chinaz.com/reverse?ddlSearchMode=4&host=shengshui.com",
                      @"http://tool.chinaz.com/dns/?type=1&host=shengshui.com&ip=",
                      @"http://ip.chinaz.com/shengshui.com",
                      @"http://pr.chinaz.com/shengshui.com",
                      @"http://ip.chinaz.com/?ip=shengshui.com",
                      @"http://tool.chinaz.com/history/?ht=0&h=shengshui.com",
                      @"https://news.so.com/ns?q=shengshui.com&src=tab_www",
                      @"https://www.qidian.com/search?kw=shengshui.com",
                      @"http://beyondvincent.com/?search=shengshui.com",
                      @"https://nshipster.cn/?search=shengshui.com",
                      @"https://nianxi.net/?search=shengshui.com",
                      @"http://wufawei.com/feed/?search=shengshui.com",
                      @"https://xiangwangfeng.com/?search=shengshui.com",
                      @"http://billwang1990.github.io/?search=shengshui.com",
                      @"http://tang3w.com/?search=shengshui.com",
                      @"http://wonderffee.github.io/?search=shengshui.com",
                      @"https://imtx.me/?search=shengshui.com",
                      @"http://onamae.com/?search=shengshui.com",
                      @"http://answerhuang.duapp.com/?search=shengshui.com",
                      @"http://joeyio.com/?search=shengshui.com",
                      @"http://gracelancy.com?search=shengshui.com",
                      @"http://foggry.com/?search=shengshui.com",
                      @"http://feed.cnblogs.com/?search=shengshui.com",
                      @"http://www.heyuan110.com/?feed=rss2/?search=shengshui.com",
                      @"shiningio.com/?search=shengshui.com",
                      @"helloitworks.com/?search=shengshui.com",
                      @"http://msching.github.io/?search=shengshui.com",
                      @"http://hotobear.com/?search=shengshui.com",
                      @"https://andelf.github.io/?search=shengshui.com",
                      @"http://adad184.com/?search=shengshui.com",
                      @"https://blog.callmewhy.com/?search=shengshui.com",
                      @"http://www.iosxxx.com/?search=shengshui.com",
                      @"http://blog.leichunfeng.com/?search=shengshui.com",
                      @"http://fengjian0106.github.io/?search=shengshui.com",
                      @"http://www.tanhao.me/?search=shengshui.com",
                      @"http://www.olinone.com/?search=shengshui.com",
                      @"http://tutuge.me/?search=shengshui.com",
                      @"https://blog.callmewhy.com/?search=shengshui.com",
                      @"http://helloitworks.com/?search=shengshui.com",
                      @"http://studentdeng.github.io/?search=shengshui.com",
                      @"http://blog.sunnyxx.com/?search=shengshui.com",
                      @"http://zhowkev.in/?search=shengshui.com",
                      @"http://blog.devtang.com/atom.xml/?search=shengshui.com",
                      @"https://onevcat.com/atom.xml/?search=shengshui.com",
                      @"https://so.csdn.net/so/search/s.do?q=shengshui.com&t=blog&u=jiaxin_1105/?search=shengshui.com",
                      @"http://www.oldboyedu.com/Public/lnh/kec/index1.html?search=shengshui.com",
                      @"http://www.178linux.com/?search=shengshui.com",
                      @"https://blog.linuxeye.cn/?search=shengshui.com",
                      @"http://www.ha97.com/?search=shengshui.com",
                      @"https://birdteam.net/?search=shengshui.com",
                      @"http://www.linux-ren.org/?search=shengshui.com",
                      @"http://blog.itpub.net/?search=shengshui.com",
                      @"http://www.phplaozhang.com/?search=shengshui.com",
                      @"https://www.tomorrow.wiki/?search=shengshui.com",
                      @"http://www.jinshizu.com/?search=shengshui.com",
                      @"https://wsblog.cc/?search=shengshui.com",
                      @"http://www.dongxin6.cn/?search=shengshui.com",
                      @"https://www.huhexian.com/?search=shengshui.com",
                      @"http://www.zhangyue93.com/?search=shengshui.com",
                      @"http://www.youlizhe.com/?search=shengshui.com",
                      @"https://www.ganzq.cn/?search=shengshui.com",
                      @"http://www.liangzaiseo.com/?search=shengshui.com",
                      @"http://www.treeit.net/?search=shengshui.com",
                      @"http://jeray.wang/?search=shengshui.com",
                      @"https://i.jeray.wang/?search=shengshui.com",
                      @"http://www.ziyou11.com/?search=shengshui.com",
                      @"http://wenshixin.gitee.io/blog/?search=shengshui.com",
                      @"http://fanmimi.com/?search=shengshui.com",
                      @"http://www.guolianfu.com/?search=shengshui.com",
                      @"http://licancan.com/?search=shengshui.com",
                      @"http://www.ygways.cn/?search=shengshui.com",
                      @"http://www.dxs12580.com/?search=shengshui.com",
                      @"https://www.arefly.com/?search=shengshui.com",
                      @"http://www.jermey.cn/?search=shengshui.com",
                      @"https://zeekmagazine.com/?search=shengshui.com",
                      @"http://b.hq216.cn/?search=shengshui.com",
                      @"https://dlspaces.com/?search=shengshui.com",
                      @"https://www.huhexian.com/?search=shengshui.com",
                      @"http://www.phpblog.cn/?search=shengshui.com",
                      @"https://www.emlog.net/?search=shengshui.com",
                      @"http://www.blogjava.net/amigoxie/?search=shengshui.com",
//                      @"?search=shengshui.com",
//                      @"?search=shengshui.com",
//                      @"?search=shengshui.com",
//                      @"?search=shengshui.com",
//                      @"?search=shengshui.com",
//                      @"?search=shengshui.com",
//                      @"?search=shengshui.com",
//                      @"?search=shengshui.com",
//                      @"?search=shengshui.com",
//                      @"?search=shengshui.com",
//                      @"?search=shengshui.com",
                      ];
    
     __block NSMutableArray *arr = @[].mutableCopy;
    int imax = 0 ;
    for (int i = currentIndex; i <= urls.count; i ++)
    {
        imax ++;
     
        if (urls.count > i)
        {
            [arr addObject: urls[i]];
            if (imax == requestMax)
            {
                currentIndex += requestMax;
            }
        }
        
        if (imax == requestMax)
        {
            break;
        }
    }
    
    [self reuqestWeb:arr];
    
    // 全部走完时间   在重新请求
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (currentIndex >= urls.count)
        {
            currentIndex = 0;
        }
        
        [self startAction:sender];
    });
}

- (void)reuqestWeb:(NSArray *)arr
{
    __block NSMutableArray *tempArr = @[].mutableCopy;
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (tempArr.count <= 4)
        {
            [tempArr addObject:obj];
            if (tempArr.count == 4)
            {
                [self.dataArrary addObject:tempArr];
                tempArr = @[].mutableCopy;
            }
        }
    }];
    
    [self.tableView reloadData];
}

//- (void)requestSomes:(NSArray *)arr
//{
//    [arr enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
//        AFHTTPResponseSerializer *serializer = [AFHTTPResponseSerializer new];
//        serializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json",nil];
//        manager.responseSerializer = serializer;
//
//        NSURL *URL = [NSURL URLWithString:obj];
//        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
//
//        NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
//            if (error) {
//                NSLog(@"❌Error: %@, url=%@", error,URL.absoluteString);
//                errorCount++;
//            } else {
//                NSLog(@"✅ %@ %@", response, responseObject);
//                successCount ++;
//            }
//        }];
//        [dataTask resume];
//    }];
//}


#pragma mark - TableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArrary.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *idetifier = @"SEOTableViewCellID";
    SEOTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idetifier forIndexPath:indexPath];
    [cell loadWebData:self.dataArrary[indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64.0f;
}



- (IBAction)seoAction:(id)sender
{
    
}


#pragma mark - Setter/Getter

- (NSMutableArray *)dataArrary
{
    if (!_dataArrary)
    {
        _dataArrary = @[].mutableCopy;
    }
    
    return _dataArrary;
}


@end
