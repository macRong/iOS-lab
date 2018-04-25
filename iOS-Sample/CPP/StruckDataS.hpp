//
//  StruckDataS.hpp
//  iOS-Sample
//
//  Created by macRong on 2018/4/24.
//  Copyright © 2018年 macRong. All rights reserved.
//

#ifndef StruckDataS_hpp
#define StruckDataS_hpp

#include <stdio.h>

typedef struct Node {
    char *data;
    struct Node *next;
} node_t;

// load
void didload();

// length
int node_length(node_t *node);



#endif /* StruckDataS_hpp */
