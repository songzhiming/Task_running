//
//  AppDelegate.m
//  TaskRunning
//
//  Created by 宋志明 on 17/6/24.
//  Copyright © 2017年 宋志明. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSArray *test = [self tasksRunning:@[@(0),@(5),@(2)]
                              endTasks:@[@(4),@(7),@(8)]
                                 times:@[@(1),@(9),@(4),@(3)]];
    NSLog(@"test--%@",test);
    return YES;
}


// 先排序startasks 数组，再二分法找到少于query的。 
- (NSArray<NSNumber *> *)tasksRunning:(NSArray<NSNumber *> *)startasks
                             endTasks:(NSArray<NSNumber *> *)endTasks
                                times:(NSArray<NSNumber *> *)times
{
    // 先排序start，
    NSMutableArray *stasks = startasks.mutableCopy ;
    NSMutableArray *eTasks = endTasks.mutableCopy;
    NSMutableArray *tasksRunning = [NSMutableArray array];
    [self quickSortArray:stasks withEndTasks:eTasks withLeftIndex:0 andRightIndex:stasks.count - 1];
    //
    for (NSNumber *time in times) {
        int j = 0;
        NSInteger search = [self BinarySearch:stasks target:time.integerValue];
        for (NSInteger i = 0; i < search; i++) {
            NSInteger end = [endTasks[i] integerValue];
            if (time.integerValue < end) {
                j++;
            }
        }
        [tasksRunning addObject:@(j)];
    }
    return tasksRunning;
}
// 二分
- (NSInteger)BinarySearch:(NSArray<NSNumber *> *)array target:(NSInteger)key
{
    NSInteger left = 0;
    NSInteger right = [array count] - 1;
    NSInteger middle = [array count] / 2;
    if ([array.lastObject integerValue] <= key) {
        return array.count;
    }
    while (right >= left) {
        middle = left + ((right - left)/2);
        if ([array[middle] integerValue] >= key && [array[middle - 1] integerValue] <= key) {
            return middle;
        }
        if ([array[middle] integerValue] > key) {
            right = middle - 1;
        }else if ([array[middle] integerValue] < key) {
            left = middle + 1;
        }
    }
    return -1;
}

// 快排
- (void)quickSortArray:(NSMutableArray *)array
          withEndTasks:(NSMutableArray *)endTasks
         withLeftIndex:(NSInteger)leftIndex
         andRightIndex:(NSInteger)rightIndex
{
    if (leftIndex >= rightIndex) {//如果数组长度为0或1时返回
        return ;
    }
    NSInteger i = leftIndex;
    NSInteger j = rightIndex;
    NSInteger key = [array[i] integerValue];
    NSInteger endTask = [endTasks[i] integerValue];
    while (i < j) {
        while (i < j && [array[j] integerValue] >= key) {
            j--;
        }
        array[i] = array[j];
        endTasks[i] = endTasks[j];
        while (i < j && [array[i] integerValue] <= key) {
            i++;
        }
        array[j] = array[i];
        endTasks[j] = endTasks[i];
    }
    array[i] = @(key);
    endTasks[i] = @(endTask);
    [self quickSortArray:array withEndTasks:endTasks withLeftIndex:leftIndex andRightIndex:i-1];
    [self quickSortArray:array withEndTasks:endTasks withLeftIndex:i+1 andRightIndex:rightIndex];
}


// 2个遍历  耗时间长
//- (NSArray<NSNumber *> *)tasksRunning:(NSArray<NSNumber *> *)startasks
//                             endTasks:(NSArray<NSNumber *> *)endTasks
//                                times:(NSArray<NSNumber *> *)times
//{
//    NSMutableArray *tasksRunning = [NSMutableArray array];
//    for (NSNumber *time in times) {
//        int now = time.intValue;
//        int j = 0;
//        for (int i = 0; i < startasks.count; i++) {
//            int start = [startasks[i] intValue];
//            int end = [endTasks[i]intValue];
//            if (start <= now && now< end) {
//                j++;
//            }
//        }
//        [tasksRunning addObject:@(j)];
//    }
//    return tasksRunning;
//}





@end
