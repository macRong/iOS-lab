//
//  StruckDataS.cpp
//  iOS-Sample
//
//  Created by macRong on 2018/4/24.
//  Copyright © 2018年 macRong. All rights reserved.
//


/** 数据结构 */
#include "StruckDataS.hpp"
#include <iostream>

using namespace std;

// length
int node_length(node_t *head)
{
    int i = 0;
    for (i = 0; head; head = head->next, i ++) {}
    
    return i;
}

// print next.node
void list_display(node_t *head)
{
    for (; head; head = head->next)
    {
        printf("{%s }", head->data);
    }
}

// load
void didload()
{
    node_t d ={"d",NULL},c = {"c",&d}, b = {"b",&c} ,node = {"a", &b} ;
    int len = node_length(&node);
    cout<< "node.len= " << len << endl;
    
    list_display(&node);
}
