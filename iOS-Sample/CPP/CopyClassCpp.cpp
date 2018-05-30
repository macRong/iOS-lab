//
//  CopyClassCpp.cpp
//  iOS-Sample
//
//  Created by macRong on 2018/5/11.
//  Copyright © 2018年 macRong. All rights reserved.
//

#include "CopyClassCpp.hpp"

Line::Line (int len)
{
    printf("构造\n");
    ptr = new int;
    *ptr = len;
}

Line::Line (const Line &obj)
{
    printf("copy构造\n");
    ptr = new int ;
    *ptr = *obj.ptr;
}

Line::~Line()
{
    printf("释放 = %p add=%d \n",this,add);
    delete ptr;
}



// --------------------------------------


class stDor: public Line
{
    static int age;
    
    void run()
    {
        printf("run");
    }
    
};

int stDor::age = 11;



// -------------------------------------

double Box::getVolume(void)
{
    return width * height;
}

void Box::setWidth(double w)
{
    width = w;
}

void Box::setHeight(double h)
{
    height = h;
}

// 重载 + 运算符，用于把两个 Box 对象相加
Box Box::operator*(const Box& b)
{
    Box box;
    box.width = this->width + b.width;
    box.height = this->height + b.height;
    return box;
}





