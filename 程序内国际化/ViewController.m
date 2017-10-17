//
//  ViewController.m
//  程序内国际化
//
//  Created by x on 17/10/17.
//  Copyright © 2017年 cesiumai. All rights reserved.
//

#import "ViewController.h"

#import "XMLanguageManager.h"

@interface ViewController ()<UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIButton *btn;

@property (weak, nonatomic) IBOutlet UILabel *label1;


@property (weak, nonatomic) IBOutlet UILabel *label2;

@property (weak, nonatomic) IBOutlet UILabel *label4;


@property (weak, nonatomic) IBOutlet UILabel *label3;


@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
 
    
    [self setupText];
    
    
    
    
}
- (IBAction)btnClick:(id)sender {
    
    
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:JJLocalizedString(@"changLanguage", nil) delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:JJLocalizedString(@"equalSystem", nil),JJLocalizedString(@"English", nil),JJLocalizedString(@"Chinese", nil), nil];
    
    [sheet showInView:self.view];
    
}

- (void)setupText
{
    [_btn setTitle:JJLocalizedString(@"changLanguage", nil) forState:UIControlStateNormal];
    
    [_label1 setText:JJLocalizedString(@"Cat", nil)];
    
    [_label2 setText:JJLocalizedString(@"Dog", nil)];

    
    [_label3 setText:JJLocalizedString(@"Pig", nil)];

    
    [_label4 setText:JJLocalizedString(@"Animal", nil)];

    
}

#pragma mark ------- UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{

    switch (buttonIndex) {
        case 0:
            
            //!< 选择与系统保持一致，判断当前的偏好设置是否是与系统保持一致，不一致的时候才进行切换
            if (![XMLanguageManager shareInstance].equalSystem) {
                
                [XMLanguageManager shareInstance].currentLanguage = @"Joyce";
                
                [self setupText];//!< 更新文字
            }
            
            
            break;
            
        case 1:
            //!< 选择英文，当用户当前设置不为英文的时候 再去切换语言
            if (![[XMLanguageManager shareInstance].currentLanguage isEqualToString:@"en"]) {
                
                [XMLanguageManager shareInstance].currentLanguage = @"en";
                
                [self setupText];//!< 更新文字
            }
            
            break;
            
        case 2:
            
            //!< 选择中文,当前环境不为中文的时候再进行切换
            if (![[XMLanguageManager shareInstance].currentLanguage isEqualToString:@"zh-Hans"]) {
                
                [XMLanguageManager shareInstance].currentLanguage = @"zh-Hans";
                
                [self setupText];//!< 更新文字
            }
            
            break;
            
        default:
            break;
    }

}


@end
