
//
//  SHLoginViewController.m
//  FaceBookPJ
//
//  Created by MyCompany on 16/12/3.
//  Copyright © 2016年 littleshuai. All rights reserved.
//

#import "SHLoginViewController.h"

#import "RegExCategories.h"

@interface SHLoginViewController ()<UITextFieldDelegate>

@end

@implementation SHLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
     RACSignal *signal = [self.usernameTF.rac_textSignal filter:^BOOL(NSString* value) {
        if (value.length>6) {
            return 1;
        }else{
            return 0;
        }
    }];
    
    
    RAC(self.passwordTF,enabled) = [self.usernameTF.rac_textSignal map:^id(NSString *value) {
        BOOL valid = [self isUsernameTFValid:value];
        return @(valid);
    }];
    
    
    
    RAC(self.loginButton,backgroundColor) = [RACObserve(self.passwordTF, enabled) map:^id(NSNumber * value) {
        return value.boolValue?[UIColor redColor]:[UIColor yellowColor];
    }];
    [RACObserve(self, loginButton) subscribeNext:^(id x) {
        self.registButton.backgroundColor = [UIColor cyanColor];
        
        if ([x isKindOfClass:[NSString class]]) {
            if ( [x isEqualToString:@"haha"]) {
                self.registButton.backgroundColor = [UIColor purpleColor];
            }
        }
    } error:^(NSError *error) {
        LxDBAnyVar(error);
    } completed:^{
        LxDBAnyVar(@"111aaa");
    }];
    
    
    [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.loginButton removeFromSuperview];
            self.loginButton = nil;
            
            [subscriber sendNext:@"haha"];
            [subscriber sendCompleted];
        });
        return nil;
    }] subscribeNext:^(id x) {
        LxDBAnyVar(x);
    }];
    
    
    
    [[RACSignal combineLatest:@[self.usernameTF.rac_textSignal,self.passwordTF.rac_textSignal,[self getFilterGoodsSignal]] reduce:^id(NSString *usernameStr,NSString *passStr,NSNumber *filterNumber){
        if (usernameStr.length>11&&passStr.length>6) {
            return @1;
        }else{
            return @(0);
        }
    }] subscribeNext:^(id x) {
        LxDBAnyVar(x);
        LxDBAnyVar([x class]);
    } error:^(NSError *error) {
        LxDBAnyVar(error);
    } completed:^{
        LxDBAnyVar(@"1111");
    }];
    
}

-(RACSignal *)getFilterGoodsSignal{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendNext:@1];
            [subscriber sendCompleted];
        });
        
        return nil;
    }];
}


//-(RACSignal *)isUsernameValid{
//    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        if ([self isUsernameTFValid]) {
//            [subscriber sendNext:@1];
//            [subscriber sendCompleted];
//        }else{
//            [subscriber sendNext:@0];
//            [subscriber sendCompleted];
//        }
//        return nil;
//    }];
//}

-(BOOL)isUsernameTFValid:(NSString *)str{
    BOOL phoneMatch = [str isMatch:RX(@"^1[3|45|6|7|8|9][0-9]\\d{8}$")];
    return phoneMatch;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
