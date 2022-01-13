//
//  CTDebugCellModel.m
//  iOS-Sample
//
//  Created by macRong on 2022/1/6.
//

#import "CTDebugCellModel.h"

@implementation CTDebugCellModel

- (void)callBackAction
{
    if (self.actionBlock) {
        self.actionBlock(self);
    }
}

@end
