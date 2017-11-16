//
//  main.m
//  Arr
//
//  Created by lilida on 2017/11/16.
//  Copyright © 2017年 shanyazhou. All rights reserved.
//

#include <stdio.h>
#include <mm_malloc.h>
#include <stdbool.h>

#pragma 变量的定义
struct arrayNode//确定一个数组，需要三个内容
{
    int *pBaseArr;//存储的是数组第一个元素的地址
    int len;//数组所能容纳的最大元素个数
    int cnt;//当前数组有效元素的个数
};

#pragma 函数的声明

/**
 数组的初始化
 */
void initArray(struct arrayNode *, int);

/**
 输出数组链表
 */
void showArray(struct arrayNode *);

bool isEmpty(struct arrayNode *);//判断是否是空的
bool isFull(struct arrayNode *);//判断是否满了

//在末尾添加元素。用bool值是因为可以判断是否添加成功。需要两个元素：链表指针+插入的值
bool append(struct arrayNode *, int);

//在post位置插入val元素，把插入的值返回给我
bool insertArray(struct arrayNode *, int post, int val);

//把post位置上的值删除，把插入的值返回给我
bool deleteArray(struct arrayNode *, int post, int *pVal);

int getArrayVal(struct arrayNode *, int post);//得到某个元素

void inversionArray(struct arrayNode *);//倒置

void sortArray(struct arrayNode *);

#pragma 主函数
int main(void)
{
    int val;
    struct arrayNode *pNode = (struct arrayNode *)malloc(sizeof(struct arrayNode));//分配内存空间，但并没有实际的值，里面存放的还是垃圾值
    
    initArray(pNode, 5);
    
//    showArray(pNode);

//    append(pNode, 3);
    
//规定：post从1开始，插入前面。例如 1 2 7 8，在第2个位置插入100，变为1 100 2 7 8
//    insertArray(pNode, 2, 100);
    
//    if (deleteArray(pNode, 4, &val)) {
//        printf("删除的元素值是：%d\n", val);
//    }else{
//        printf("删除失败\n");
//    }
    
//    int i = getArrayVal(pNode, 1);
//    printf("获取的值是%d\n",i);
    
    showArray(pNode);
    printf("排序后的数组是：");
    sortArray(pNode);
    showArray(pNode);
    
//    inversionArray(pNode);
//    printf("倒置后的数组是：");
//    showArray(pNode);
    return 0;
}

#pragma 函数的定义（实现）
void initArray(struct arrayNode *pNode, int len)
{
    pNode->pBaseArr = (int *)malloc(sizeof(int) * len);
    if(NULL == pNode->pBaseArr)
    {
        printf("分配内存失败");
        exit(-1);//整个程序结束
    }else{
        pNode->len = len;
        pNode->cnt = 0;
    }
    
    printf("请输入数组内容：\n");
    for (int i = 0; i<4; i++) {
        scanf("%d", &pNode->pBaseArr[i]);//&pNode->pArr[i]优先级问题
        pNode->cnt = i+1;
    }
    return;
}

void showArray(struct arrayNode * pNode)
{
    if(isEmpty(pNode))
    {
        printf("这是一个空数组\n");
        return;
    }
    
    for (int i = 0; i<pNode->cnt; i++) {
        printf("%d ", pNode->pBaseArr[i]);
    }
    printf("\n");
    return;
}

bool isEmpty(struct arrayNode * pNode)//判断是否是空的
{
    if (0 == pNode->cnt) {
        return true;
    }else{
        return false;
    }
}

bool isFull(struct arrayNode * pNode)//判断是否满了
{
    if (pNode->cnt == pNode->len) {
        return true;
    }else{
        return false;
    }
}

bool append(struct arrayNode * pNode, int val)
{
    if(isFull(pNode))
    {
        return false;
    }else{
        pNode->pBaseArr[pNode->cnt] = val;
        (pNode->cnt)++;
        return true;
    }
}

/**规定：post从1开始计算，插入到前面。例如 1 2 7 8，在第2个位置插入100，变为1 100 2 7 8*/
bool insertArray(struct arrayNode * pNode, int post, int val)//在post位置插入val元素
{
    //post需要做约束，不能乱传
    if(isFull(pNode) || post<1 || post>(pNode->cnt)+1)
    {
        return false;
    }else{
        for (int i = pNode->cnt; i>=post; i--) {
            pNode->pBaseArr[i] = pNode->pBaseArr[i-1];
        }
        pNode->pBaseArr[post-1] = val;
        (pNode->cnt)++;
        return true;
    }
}

/**规定：post从1开始计算。例如 1 2 7 8，把第2个位置的值删除，变为1 7 8*/
bool deleteArray(struct arrayNode * pNode, int post, int *pVal)
{
    if (isEmpty(pNode) || post<1 || post>pNode->cnt) {
        return false;
    }else{
        *pVal = pNode->pBaseArr[post-1];
        for (int i = post; i<pNode->cnt; i++) {
            pNode->pBaseArr[i-1] = pNode->pBaseArr[i];
        }
        (pNode->cnt)--;
        return true;
    }
}

int getArrayVal(struct arrayNode * pNode, int post)//得到某个元素
{
    int val;
    if (isEmpty(pNode) || post<1 || post>pNode->cnt) {
        return -111111111;
    }else{
        val = pNode->pBaseArr[post-1];
        return val;
    }
}

void sortArray(struct arrayNode * pNode)
{
    //1 2 3 4 5
    //采用 1：2 2：3 3：4 4：5
//    for (int i = 0; i<pNode->cnt - 1; i++) {
//        for (int j = 0; j<pNode->cnt - i - 1; j++) {
//            if (pNode->pBaseArr[j] > pNode->pBaseArr[j+1]) {
//                int t = pNode->pBaseArr[j];
//                pNode->pBaseArr[j] = pNode->pBaseArr[j+1];
//                pNode->pBaseArr[j+1] = t;
//            }
//
//        }
//    }
    
    //1 2 3 4 5
    //采用 1：2 1：3 1：4 1：5
    for (int i = 0; i<pNode->cnt; i++) {
        for (int j = i+1; j<pNode->cnt; j++) {
            if (pNode->pBaseArr[i] > pNode->pBaseArr[j]) {
                int t = pNode->pBaseArr[i];
                pNode->pBaseArr[i] = pNode->pBaseArr[j];
                pNode->pBaseArr[j] = t;
            }
            
        }
    }
    
    
    
    return;
}

void inversionArray(struct arrayNode * pNode)//倒置
{
    int i = 0;
    int j = pNode->cnt - 1;
    int t;
    while (i < j) {
        t = pNode->pBaseArr[i];
        pNode->pBaseArr[i] = pNode->pBaseArr[j];
        pNode->pBaseArr[j] = t;
        i++;
        j--;
    }
    return;
}
