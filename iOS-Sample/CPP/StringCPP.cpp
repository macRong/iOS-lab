//
//  StringCPP.cpp
//  iOS-Sample
//
//  Created by macRong on 2018/4/19.
//  Copyright © 2018年 macRong. All rights reserved.
//

#include "StringCPP.hpp"
#include <iostream>
#include <ctime>
#include <string>

using namespace std;

void stringDisposes(char *s1, char *s2)
{
    /** fist point */
    cout<< "s1="<< *s1 << ", s2=" << *s2 << endl;  // s1=h, s2=b
}

struct Plain {
    Plain *plain;
    string name;
    char address[50];
    char des[140];
 
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

void singnalHandleTest(int a)
{
    char arr[] = {'a','b','c'};
    free(arr);
}

void quoteSomePoint(int &a, int &b)
{
    a = 11;
    b = 22;
    
    cout<< &a << " :: " << &b<< endl;
}

void gettimes()
{
    time_t now = time(0);
     tm *tm = localtime(&now);
    char* dt = ctime(&now);
    cout << "本地日期和时间：" << dt << "sec="<<  tm -> tm_sec << endl;
}

void singlebad()
{
    Plain *pla;
    free(pla);
    pla -> name = "s";
}

struct Books
{
    char  title[50];
    char  author[50];
    char  subject[100];
    int   book_id;
};

void printStrBook( Books book)
{
    cout << "2222222" << book.title << "point=" << &book<< endl;
}


void cinTest()
{
//    char name[50];
//    cout << "请输入您的名称： ";
//    cin >> name;
//    cout << "您的名称是😆： " << name << endl;
    
    Books book;
    strcpy(book.title, "sdklksd");
    cout << "book.title=" << book.title  << "point="<< &book << endl;
    
    
    printStrBook(book);
}







