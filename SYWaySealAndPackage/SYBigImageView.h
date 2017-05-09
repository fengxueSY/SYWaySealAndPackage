//
//  SYBigImageView.h
//  CommonlyUsedFile
//
//  Created by 666gps on 2017/5/9.
//  Copyright © 2017年 666gps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static CGRect oldframe;
@interface SYBigImageView : NSObject
/**
 *  @brief  浏览头像
 *
 *  @param  avatarImageView    头像所在的imageView
 */
+(void)showImage:(UIImageView*)avatarImageView;
@end
