//
//  MPCrashInfo.m
//  DumbPatch_Example
//
//  Created by macRong on 2017/11/30.
//  Copyright © 2017年 MPCrashHandler. All rights reserved.
//

#import "MPCrashInfo.h"
#import <mach-o/ldsyms.h>
#include <mach-o/dyld.h>

@implementation MPCrashInfo



@end

NSString *mpException_getCurrentDate()
{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY/MM/dd hh:mm:ss SS"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    
    return dateString;
}

/** 获取UUID */
NSString *executableUUID()
{
    const uint8_t *command = (const uint8_t *)(&_mh_execute_header + 1);
    for (uint32_t idx = 0; idx < _mh_execute_header.ncmds; ++idx)
    {
        if (((const struct load_command *)command)->cmd == LC_UUID)
        {
            command += sizeof(struct load_command);
            return [NSString stringWithFormat:@"%02X%02X%02X%02X-%02X%02X-%02X%02X-%02X%02X-%02X%02X%02X%02X%02X%02X", command[0], command[1], command[2], command[3], command[4], command[5], command[6], command[7], command[8], command[9], command[10], command[11], command[12], command[13], command[14], command[15]];
            
        }
        else
        {
            command += ((const struct load_command *)command)->cmdsize;
            
        }
        
    }
    
    return nil;
}

uintptr_t get_load_address(void) { const struct mach_header *exe_header = NULL; for (uint32_t i = 0; i < _dyld_image_count(); i++) { const struct mach_header *header = _dyld_get_image_header(i); if (header->filetype == MH_EXECUTE) { exe_header = header; break; } } return (uintptr_t)exe_header; }





