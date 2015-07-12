//
//  ComposeViewController.m
//  YNWeiBo
//
//  Created by james on 15/7/9.
//  Copyright (c) 2015年 kfvnx. All rights reserved.
//

#import "ComposeViewController.h"
#import "AccountTool.h"
#import "UIView+Extension.h"
#import "YNTextView.h"
#import <AFNetworking.h>
#import "MBProgressHUD+MJ.h"
#import "ComposeToolbar.h"
#import "UIView+Extension.h"
#import "ComposePhotosView.h"
#import "EmotionKeyboard.h"
#import "UIView+Extension.h"

@interface ComposeViewController ()<UITextViewDelegate,ComposeToolbarDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (weak, nonatomic) YNTextView *textView;
@property (weak, nonatomic) ComposeToolbar *toolbar;
@property (weak, nonatomic) ComposePhotosView *photosView;
@property (strong, nonatomic) EmotionKeyboard *emotionKeyboard;

@end

@implementation ComposeViewController

-(EmotionKeyboard *)emotionKeyboard{
    if (!_emotionKeyboard) {
        self.emotionKeyboard = [[EmotionKeyboard alloc]init];
        //系统会强制让键盘的宽度为屏幕的宽度，前提是有设置了非0的宽度
        self.emotionKeyboard.width = self.view.width;
//        self.emotionKeyboard.width = 0;
        
        self.emotionKeyboard.height = 216;
    }
    
    return _emotionKeyboard;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNav];
    
    [self setupTextView];
    
    [self setupToolbar];
    
    [self setupPhotoView];

}

-(void)setupPhotoView{
    
    ComposePhotosView *photosView =[[ComposePhotosView alloc]init];
    photosView.width = self.view.width;
    photosView.height = 500;
    photosView.y = 100;
    [self.textView addSubview:photosView ];
    self.photosView = photosView;

    
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
    [self.textView becomeFirstResponder];
}

/**
UITextField:
 文字只有一行
 有placehoder
 继承处UIControl
 监听行为
   1.设置代理
    2.addTarget:action:forControlEvents:
    3.通知 UItextFieldTextDidChangeNotification
 
UITextView
 多行
 不能设置占位文字
 继承自ScrollView
 监听行为
   1.设置代理
   2.通知 UItextViewTextDidChangeNotification
 **/


-(void)setupTextView{
    
    //继承自ScrollView，设置了内边距，可以在导航栏下才开始输出文字
    //其它控件如buttom直接添加，会被导航栏挡住
    YNTextView *textView = [[YNTextView alloc]init];
    //占据整个屏幕
    textView.frame = self.view.bounds;
    textView.font = [UIFont systemFontOfSize:15];
    //垂直方向永远有拖动弹簧效果
    textView.alwaysBounceVertical = YES;
    textView.placeholder = @"分享你的新鲜事...";
    textView.delegate =self;
    [self.view addSubview:textView];
    
    self.textView = textView;
    
    //文字改变通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    
    //键盘通知
//    UIKeyboardWillChangeFrameNotification; frame发生改变（位置和尺寸）
//    UIKeyboardWillShowNotification;
//    UIKeyboardWillHideNotification;
//    UIKeyboardDidChangeFrameNotification;
//    UIKeyboardDidShowNotification;
//    UIKeyboardDidHideNotification;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    //
    //self.automaticallyAdjustsScrollViewInsets = NO;
}

-(void)keyboardWillChangeFrame:(NSNotification *)notification{
    
    //notification.userInfo
    //UIKeyboardFrameEndUserInfoKey = CGrect{{0,352},{320,216}};
    //UIKeyboardAnimationDurationUserInfoKey=0.25;
    //UIKeyboardAnimationCurveUserInfoKey = 7
    
    NSDictionary *userInfo = notification.userInfo;
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGRect keyboardFrame =  [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    [UIView animateWithDuration:duration animations:^{
    
        if (keyboardFrame.origin.y>=self.view.height) {
                self.toolbar.y = self.view.height - self.toolbar.height;
        }else{
                self.toolbar.y = keyboardFrame.origin.y - self.toolbar.height;
        }
    }];
}


-(void)setupNav{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    UILabel *titleView = [[UILabel alloc]init];
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.numberOfLines = 0;
    titleView.height =44;
    NSString *name = [AccountTool account].name;
    
    NSString *str = [NSString stringWithFormat:@"发微博\n%@",name];
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15 ] range:NSMakeRange(0, 3)];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12 ] range:[str rangeOfString:name]];
    
    titleView.attributedText = attrStr;
    
    
    self.navigationItem.titleView  =titleView;
    

}

-(void)setupToolbar{
    
    ComposeToolbar *toolbar = [ComposeToolbar new];
    toolbar.height =44;
    toolbar.width = self.view.width;
    toolbar.delegate = self;
    //inputView用来设置键盘
    //self.textView.inputView;
    //inputAccessoryView 设置键盘上面的位置
    //self.textView.inputAccessoryView = toobar;
    //不跟随键盘
    toolbar.y = self.view.height-toolbar.height;
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
}

#pragma mark - UITextViewDelegate

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    //键盘消失
    [self.view endEditing:YES];
}

-(void)composeToolbar:(ComposeToolbar *)toolbar didClickButton:(ComposeToolbarButtonType)buttonType{
    
    switch (buttonType) {
        case ComposeToolbarButtonTypeCamera:
            [self openCamera];
            break;
        case ComposeToolbarButtonTypePicture:
            [self openAlbum];
            break;
        case ComposeToolbarButtonTypeMention: //@
            
            break;
        case ComposeToolbarButtonTypeTrend: //#
            
            break;
        case ComposeToolbarButtonTypeEmotion: //表情
            
            [self switchKeyboard];
            
            break;
        default:
            break;
    }
}

-(void)switchKeyboard{
    
    if (self.textView.inputView ==nil) {
 
        self.textView.inputView = self.emotionKeyboard;
        
        self.toolbar.showKeyboardButton = YES;
        
    }else{
        //切换为系统自带键盘
        self.textView.inputView = nil;
        self.toolbar.showKeyboardButton = NO;
    }
    
    //退出键盘
    [self.textView endEditing:YES];
//    [self.view.window endEditing:YES];
//    [self.textView resignFirstResponder];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
            [self.textView becomeFirstResponder];
    });
    
}

#pragma mark - event response

-(void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)send{
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [AccountTool account].access_token;
    params[@"status"]= self.textView.text;
    
  
    if (self.photosView.photos.count) {
        //只支持一张图片
        [mgr POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            UIImage *image = [self.photosView.photos firstObject];
            NSData *data = UIImageJPEGRepresentation(image, 1.0);
            
            [formData appendPartWithFileData:data name:@"pic" fileName:@"test.jpg" mimeType:@""];
            
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"请求成功-%@",responseObject);
            
            [MBProgressHUD showSuccess:@"发送成功"];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"发送失败-%@",error);
        }];
        
    }else{
        
        [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
            NSLog(@"请求成功-%@",responseObject);
            
            [MBProgressHUD showSuccess:@"发送成功"];
            
            //自定义状态栏，显示api返回的信息
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"发送失败-%@",error);
        }];
    }
    
    
    
    

    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)textDidChange{
    
    self.navigationItem.rightBarButtonItem.enabled  = self.textView.hasText;
}

-(void)openCamera{
  
    
    [self openImagePickerController:UIImagePickerControllerSourceTypeCamera];
}

-(void)openAlbum{
    //如果想自己写一个图片选择控制器，得利用AssetsLibray.framework
    //UIImagePickerControllerSourceTypePhotoLibrary  包含 UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    [self openImagePickerController:UIImagePickerControllerSourceTypePhotoLibrary];
}

-(void)openImagePickerController:(UIImagePickerControllerSourceType)type{
    
    if (![UIImagePickerController isSourceTypeAvailable:type]) return;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc]init];
    ipc.sourceType = type;
    ipc.delegate =self;
    [self presentViewController:ipc animated:YES completion:nil];
}

//从控制器选择完图片（拍照完毕或选 择相册完毕）
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    [self.photosView addPhoto:image];
}


@end
