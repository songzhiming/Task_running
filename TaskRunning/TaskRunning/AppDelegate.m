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


//



//  2个遍历
- (NSArray<NSNumber *> *)tasksRunning:(NSArray<NSNumber *> *)startasks
                             endTasks:(NSArray *)endTasks
                                times:(NSArray<NSNumber *> *)times
{
    NSMutableArray *tasksRunning = [NSMutableArray array];
    for (NSNumber *time in times) {
        int now = time.intValue;
        int j = 0;
        for (int i = 0; i < startasks.count; i++) {
            int start = [startasks[i] intValue];
            int end = [endTasks[i]intValue];
            if (start <= now && now< end) {
                j++;
            }
        }
        [tasksRunning addObject:@(j)];
    }
    return tasksRunning;
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
