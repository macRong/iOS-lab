//
//  StringCPP.cpp
//  iOS-Sample
//
//  Created by macRong on 2018/4/19.
//  Copyright © 2018年 macRong. All rights reserved.
//

#include "StringCPP.hpp"
#include <iostream>

using namespace std;

void stringDisposes(char *s1, char *s2)
{
    /** fist point */
    cout<< "s1="<< *s1 << ", s2=" << *s2 << endl;  // s1=h, s2=b
}

struct Plain {
    Plain *plain;
    
};

void dispose(char s1[], char s2[])
{
  int same =  strcmp(s1, s2);
    cout<< "s1="<< s1 << &s1<<", s2=" << s2 << &s2 << " same=" << same << endl;
}

int strcmp(const char *str1,const char *str2)
{
    while(*str1 == *str2)
    {
        if(*str1 == '\0')
        {
            return 0;
        }
        
        str1++;
        str2++;
    }
    
    cout << "str1=" << *str1 << " str2=" << *str2 << endl;
    
    return *str1 - *str2;
}
