//
//  CopyClassCpp.hpp
//  iOS-Sample
//
//  Created by macRong on 2018/5/11.
//  Copyright © 2018年 macRong. All rights reserved.
//


/** copy构造函数 */
#ifndef CopyClassCpp_hpp
#define CopyClassCpp_hpp

#include <stdio.h>

class Line
{
public:
    Line (int len);
    Line (const Line &obj);
    int add;
    ~Line();

private:
    int *ptr;
};


// -------------------------

class Box
{
public:
    double getVolume(void);
    void setWidth(double w);
    void setHeight(double h);
    Box operator*(const Box& b);
    
    double width;
    double height;
};

#endif /* CopyClassCpp_hpp */
