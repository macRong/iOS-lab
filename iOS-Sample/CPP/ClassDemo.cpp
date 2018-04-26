//
//  ClassDemo.cpp
//  iOS-Sample
//
//  Created by macRong on 2018/4/25.
//  Copyright © 2018年 macRong. All rights reserved.
//

#include "ClassDemo.hpp"
#include <string>


/** 构造函数 */
Person::Person(void)
{
    printf("Person 构造函数开始");
}

/** 带参数构造函数*/
Person::Person(int age)
{
    age = age;
    printf("age=%d",age);
}

Person::~Person(void)
{
    printf("析构函数开始");
}

void Person::didload()
{
    Person person;
    strcpy(person.name, "张三");
    strcpy(person.address, "北京");

    printf("person.name=%s, person.address=%s",person.name,person.address);
}


// -------------------- cat -------------

Cat::Cat(int a):m_x(a)
{
    printf("cat a=%d,mx=%d",a,m_x);
}

Cat::Cat(const Person &person)
{
    *ptr = person.age;
    
    printf("======pter=%d",*ptr);
}

