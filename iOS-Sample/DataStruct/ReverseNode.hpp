//
//  ReverseNode.hpp
//  iOS-Sample
//
//  Created by macRong on 2018/7/17.
//  Copyright © 2018年 macRong. All rights reserved.
//


/** 反转链表 */
#ifndef ReverseNode_hpp
#define ReverseNode_hpp

#include <stdio.h>
#include <stack>

using namespace std;
/** Node Struct */
struct ListNode {
    int val;
    struct ListNode *next;
    
    /** 构造函数 */
    ListNode(int x) :
    val(x),next(NULL){}
};

class ReverseNode
{
public:
    /** creat Node */
    ListNode *creatNode(int count);
    /** print reverse node */
    vector<int> printListFromTailToHead(struct ListNode* head);

};







#endif /* ReverseNode_hpp */


/** use
 
 ReverseNode *node =new ReverseNode;
 ListNode *listNode = node-> creatNode(10);
 vector<int> t = node->printListFromTailToHead(listNode);
 
 delete  node;
 
 */
 
