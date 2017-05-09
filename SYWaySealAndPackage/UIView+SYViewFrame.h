//
//  UIView+SYViewFrame.h
//  CommonlyUsedFile
//
//  Created by 666gps on 2017/5/9.
//  Copyright © 2017年 666gps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SYViewFrame)
/**
 *  视图的frame的坐标x值
 */
@property (nonatomic, assign) CGFloat x;
/**
 *  视图的frame的坐标y值
 */
@property (nonatomic, assign) CGFloat y;
/**
 *  视图中心点的X值
 */
@property (nonatomic, assign) CGFloat centerX;
/**
 *  视图中心点的Y值
 */
@property (nonatomic, assign) CGFloat centerY;
/**
 *  视图的frame的宽度width
 */
@property (nonatomic, assign) CGFloat width;
/**
 *  视图的frame的高度height
 */
@property (nonatomic, assign) CGFloat height;
/**
 *  视图的size值
 */
@property (nonatomic, assign) CGSize size;
/**
 *  视图的origin值
 */
@property (nonatomic, assign) CGPoint origin;

@end
