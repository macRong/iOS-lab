//
//  ClassDemo.cpp
//  iOS-Sample
//
//  Created by macRong on 2018/4/25.
//  Copyright © 2018年 macRong. All rights reserved.
//

#include "ClassDemo.hpp"
#include <string>
#include <fstream>
#include <iostream>

/** 构造函数 */
Person::Person(void)
{
    printf("Person 构造函数开始\n");
}

/** 带参数构造函数*/
Person::Person(int age)
{
    age = age;
    printf("age=%d\n",age);
}

Person::~Person(void)
{
    printf("析构函数开始\n");
}

void Person::didload()
{
    Person person;
    strcpy(person.name, "张三");
    strcpy(person.address, "北京");

    printf("person.name=%s, person.address=%s\n",person.name,person.address);
}


// -------------------- cat -------------


Cat::Cat(int a):m_x(a)
{
    ptr = new int;
//    *ptr = a;
    ptr = &a;
    
   int aa = foMaxx(1, 2);
    
    printf("\n cat a=%d,mx=%d, &ptr=%p, aa=%d",a,m_x,ptr,aa);
}

Cat::Cat(Person &person)
{
    *ptr = person.age;
    
    printf("\n ======pter=%d",*ptr);
}

void fsleep(const Cat& cat)
{
    printf("____sleep");
}

inline int foMaxx(int x, int y)
{
    return ((x > y)? x : y);
}

void runcat(void)
{
    printf("_______runcat");    
}


// ------------------ space -----------

namespace FNameSpace {
    void run(void)
    {
        printf("run -------");
    }
}

template <typename T>
inline T const& Max (T const& a, T const& b)
{
    return a < b ? b:a;
}


template <typename A>
inline A const& Min(A const &a, A const &b)
{
    return a > b ? a : b;
}


// -------------------- Num ---------

Num::~Num(void)
{
    FNameSpace::run();

    
    printf("~num()");
}

using namespace std;
Num::Num(int a)
{
    int reA = Max(1, 2);
    printf("reA = %d\n",reA);
    
    
    char data[100];

    // --------------------
    Person *person = new Person[3];
    printf("person111=%p\n",person);

    delete [] person;
    
    // --------------------

    
    // 以写模式打开文件
    ofstream outfile;
    outfile.open("afile.dat");
    
    cout << "Writing to the file" << endl;
    cout << "Enter your name: ";
    cin.getline(data, 100);
    
    // 向文件写入用户输入的数据
    outfile << data << endl;
    
    cout << "Enter your age: ";
    cin >> data;
    cin.ignore();
    
    // 再次向文件写入用户输入的数据
    outfile << data << endl;
    
    // 关闭打开的文件
    outfile.close();
    
    // 以读模式打开文件
    ifstream infile;
    infile.open("afile.dat");
    
    cout << "Reading from the file" << endl;
    infile >> data;
    
    // 在屏幕上写入数据
    cout << data << endl;
    
    // 再次从文件读取数据，并显示它
    infile >> data;
    cout << data << endl;
    
    // 关闭打开的文件
    infile.close();
}
