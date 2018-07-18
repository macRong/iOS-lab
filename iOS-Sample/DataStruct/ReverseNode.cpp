//
//  ReverseNode.cpp
//  iOS-Sample
//
//  Created by macRong on 2018/7/17.
//  Copyright © 2018年 macRong. All rights reserved.
//

#include "ReverseNode.hpp"
#include <iostream>
#include <stack>
#include <vector>

using namespace std;

/** creat Node */
ListNode *ReverseNode::creatNode(int count)
{
    ListNode *node = (ListNode *)malloc(sizeof(ListNode *));
    node -> val = 0;
    node -> next = NULL;
    ListNode *head = node;
    
    for (int i = 1; i < count; i ++)
    {
        ListNode *newNode = (ListNode *)malloc(sizeof(ListNode *));
        newNode -> val = i;
        newNode -> next = NULL;
        head -> next = newNode;
        head = newNode;
    }
    
    return node;
}

/** print reverse node */
vector<int> ReverseNode::printListFromTailToHead(struct ListNode* head)
{
    vector<int> result;
    
    stack<ListNode *> stackNode;
    
    ListNode *p = head;
    while (p != NULL)
    {
        stackNode.push(p);
        p = p -> next;
    }
    
    while (!stackNode.empty())
    {
        ListNode *node = stackNode.top();
        result.push_back(node -> val);
        stackNode.pop();
    }
    
    return result;
}


//    stack<int> nos;
//    nos.push(1);
//    nos.push(2);
//    nos.push(3);
//
//    while (!nos.empty())
//    {
//        int ag =nos.top();
//        printf("ag =%d",ag);
//        nos.pop();
//    }
