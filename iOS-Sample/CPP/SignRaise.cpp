//
//  SignRaise.cpp
//  iOS-Sample
//
//  Created by macRong on 2018/5/30.
//  Copyright © 2018年 macRong. All rights reserved.
//

#include "SignRaise.hpp"
#include <iostream>
#include <csignal>
#include <unistd.h>

using namespace std;

void signalHandlerr(int signum)
{
    cout << "Interrupt signal (" << signum << ") received.\n";
    
    exit(signum);
}

void SignRaise::registerSign(void)
{
    signal(SIGINT, signalHandlerr);
    
    int i = 0;
    while (++i)
    {
        cout << "Going to sleep...." << endl;
        if ( i == 3 )
        {
            /** 生成信号 */
            raise(SIGINT);
        }
        
        sleep(1);
    }
}
