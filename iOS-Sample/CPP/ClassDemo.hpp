//
//  ClassDemo.hpp
//  iOS-Sample
//
//  Created by macRong on 2018/4/25.
//  Copyright © 2018年 macRong. All rights reserved.
//

#ifndef ClassDemo_hpp
#define ClassDemo_hpp

#include <stdio.h>

class Person
{
public:
    char name[16];
    char address[33];
    int age;
    
    Person();
    Person(int age);
    ~Person();

    
    void didload();
};


class Cat {
public:
    int m_x;
    Cat(int a);
    Cat(Person &person);
    int foMax(int x, int y);
    friend void fsleep(const Cat& cat);
    friend void runcat();
    friend Person;
    
    
private:
    int *ptr;
    char name[22];
};


#endif /* ClassDemo_hpp */

