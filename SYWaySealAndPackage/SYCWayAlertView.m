//
//  SYCWayAlertView.m
//  CommonlyUsedFile
//
//  Created by 666gps on 2017/5/9.
//  Copyright © 2017年 666gps. All rights reserved.
//

void TTAlert1(NSString * message,UIViewController * view){
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIAlertController * alter1 = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alter1 addAction:action1];
        [view presentViewController:alter1 animated:YES completion:nil];
    }else{
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                         message:message
                                                        delegate:nil
                                               cancelButtonTitle:@"确定"
                                               otherButtonTitles:nil];
        [alert show];
    }
}
void TTAlert2(NSString * message){
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                     message:message
                                                    delegate:nil
                                           cancelButtonTitle:@"确定"
                                           otherButtonTitles:nil];
    [alert show];
}
