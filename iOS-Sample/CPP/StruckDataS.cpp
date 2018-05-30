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


// ---------------------------------- Stack ----------

template <class T>
class Stack
{
private:
    vector<T> elems;      // 元素
    
public:
    void push(T const&);  // 入栈
    void pop();           // 出栈
    T top() const;       // 返回栈顶元素
    
    // 如果为空则返回真。
    bool empty() const
    {
        return elems.empty();
    }
};

template <class T>
void Stack<T>::push (T const& elem)
{
    // 追加传入元素的副本
    elems.push_back(elem);
}

template <class T>
void Stack<T>::pop ()
{
    if (elems.empty())
    {
        throw out_of_range("Stack<>::pop(): empty stack");
    }
    
    // 删除最后一个元素
    elems.pop_back();
}

template <class T>
T Stack<T>::top () const
{
    if (elems.empty())
    {
        throw out_of_range("Stack<>::top(): empty stack");
    }
    
    // 返回最后一个元素的副本
    return elems.back();
}






