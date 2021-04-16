//
//  GamaRateView.m
//  rate
//
//  Created by Mgs on 2021/3/9.
//

#import "GamaRateView.h"
#import <StoreKit/StoreKit.h>
#import "Masonry.h"
#import "GamaTools.h"
@interface GamaRateView()<UITextViewDelegate>
@property(nonatomic,strong)UIButton *zzButton;
@property(nonatomic,strong)UIView *rtView;//评论区域
@property(nonatomic,strong)UIButton *star1btn;
@property(nonatomic,strong)UIButton *star2btn;
@property(nonatomic,strong)UIButton *star3btn;
@property(nonatomic,strong)UIButton *star4btn;
@property(nonatomic,strong)UIButton *star5btn;
@property(nonatomic,strong)UIButton *laterBtn;

@property(nonatomic,strong)UIImageView *liantiao1;
@property(nonatomic,strong)UIImageView *liantiao2;
@property(nonatomic,strong)UIView *commentView;
@property(nonatomic,strong)UITextView *textView;

@property(nonatomic,strong)UIButton *commitBtn;
@property(nonatomic,strong)UIButton *cancleBtn;
@end
@implementation GamaRateView

-(instancetype)init{
    if (self = [super init]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self loadUI];
        });
    }
    return self;
}


-(void)loadUI{
    self.backgroundColor = [UIColor clearColor];
    self.zzButton = [UIButton buttonWithType:0];
    [self addSubview:self.zzButton];
    CGSize size = [UIScreen mainScreen].bounds.size;
    [self.zzButton setFrame:CGRectMake(0, 0, size.width, size.height)];
    [self.zzButton setBackgroundColor:[UIColor blackColor]];
    [self.zzButton setAlpha:0.3];
    [self.zzButton addTarget:self action:@selector(zzBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.rtView = [[UIView alloc]init];
    self.rtView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.rtView];
    self.rtView.layer.cornerRadius = 20;
    self.rtView.alpha = 0.9;
    self.rtView.layer.masksToBounds = true;
    [self.rtView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.offset(0);
        make.width.equalTo(@(270));
        make.height.equalTo(@270);
    }];
    
    
    NSDictionary *infoPlist = [[NSBundle mainBundle] infoDictionary];
    NSString *iconString = [[infoPlist valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject];
    UIImage* iconImage = [UIImage imageNamed:iconString];
    UIImageView *iconImageView = [[UIImageView alloc]initWithImage:iconImage];
    iconImageView.layer.cornerRadius = 10;
    iconImageView.layer.masksToBounds = true;
    [self.rtView addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(20);
        make.width.height.equalTo(@70);
    }];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    [self.rtView addSubview:titleLabel];
    //设置标题
    NSString*name=[infoPlist objectForKey:@"CFBundleDisplayName"];
    if ([GamaTools isSimpleChinese]==false) {
        name = [NSString stringWithFormat:@"Enjoying %@？",name];
    }else{
        name = [NSString stringWithFormat:@"喜欢\"%@\"吗？",name];
    }
    
    [titleLabel setText:name];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.numberOfLines = 0;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@20);
        make.left.offset(15);
        make.right.offset(-15);
        make.top.equalTo(iconImageView.mas_bottom).offset(20);
    }];
    
    
    UILabel *subTitle = [[UILabel alloc]init];
    [self.rtView addSubview:subTitle];
    subTitle.numberOfLines = 0;
    subTitle.textColor = [UIColor blackColor];
    subTitle.font = [UIFont systemFontOfSize:13];
    subTitle.text = @"轻点星形已在 App Store 中评分。";
    if ([GamaTools isSimpleChinese]==false) {
        subTitle.text = @"Tap a star to rate it on the App Store.";
    }
    subTitle.textAlignment = NSTextAlignmentCenter;
    [subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@25);
        make.left.offset(10);
        make.right.offset(-10);
        make.top.equalTo(titleLabel.mas_bottom).offset(5);
    }];
    
    UIView *line1 = [[UIView alloc]init];
    [self.rtView addSubview:line1];
    line1.backgroundColor = [UIColor lightGrayColor];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(subTitle.mas_bottom).offset(20);
        make.height.equalTo(@1);
    }];
    
    self.star3btn = [UIButton buttonWithType:0];
    [self.star3btn setImage:[UIImage imageNamed:@"GMGSupport.bundle/star1.png"] forState:0];
    [self.star3btn addTarget:self action:@selector(starClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.rtView addSubview:self.star3btn];
    [self.star3btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.width.equalTo(@25);
        make.height.equalTo(@24);
        make.top.equalTo(line1.mas_bottom).offset(10);
    }];
    
    self.star2btn = [UIButton buttonWithType:0];
    [self.star2btn setImage:[UIImage imageNamed:@"GMGSupport.bundle/star1.png"] forState:0];
    [self.star2btn addTarget:self action:@selector(starClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.rtView addSubview:self.star2btn];
    [self.star2btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line1.mas_bottom).offset(10);
        make.centerX.offset(-40);
        make.width.equalTo(@25);
        make.height.equalTo(@24);
    }];
    
    self.star1btn = [UIButton buttonWithType:0];
    [self.star1btn setImage:[UIImage imageNamed:@"GMGSupport.bundle/star1.png"] forState:0];
    [self.star1btn addTarget:self action:@selector(starClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.rtView addSubview:self.star1btn];
    [self.star1btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line1.mas_bottom).offset(10);
        make.centerX.offset(-80);
        make.width.equalTo(@25);
        make.height.equalTo(@24);
    }];
    
    self.star4btn = [UIButton buttonWithType:0];
    [self.star4btn setImage:[UIImage imageNamed:@"GMGSupport.bundle/star1.png"] forState:0];
    [self.star4btn addTarget:self action:@selector(starClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.rtView addSubview:self.star4btn];
    [self.star4btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line1.mas_bottom).offset(10);
        make.centerX.offset(40);
        make.width.equalTo(@25);
        make.height.equalTo(@24);
    }];
    
    self.star5btn = [UIButton buttonWithType:0];
    [self.star5btn setImage:[UIImage imageNamed:@"GMGSupport.bundle/star1.png"] forState:0];
    [self.star5btn addTarget:self action:@selector(starClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.rtView addSubview:self.star5btn];
    [self.star5btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line1.mas_bottom).offset(10);
        make.centerX.offset(80);
        make.width.equalTo(@25);
        make.height.equalTo(@24);
    }];
    UIView *line2 = [[UIView alloc]init];
    [self.rtView addSubview:line2];
    line2.backgroundColor = [UIColor lightGrayColor];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.star5btn.mas_bottom).offset(10);
        make.height.equalTo(@1);
    }];
    
    self.laterBtn = [UIButton buttonWithType:0];
    [self.rtView addSubview:self.laterBtn];
    [self.laterBtn setTitle:@"以后再说" forState:0];
    if ([GamaTools isSimpleChinese]==false) {
        [self.laterBtn setTitle:@"Not Now" forState:0];
    }
    self.laterBtn.titleLabel.font =[UIFont systemFontOfSize:16];
    [self.laterBtn setTitleColor:[UIColor blueColor] forState:0];
    [self.laterBtn addTarget:self action:@selector(laterBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.laterBtn setTitleColor:[UIColor colorWithRed:0 green:122/255.0 blue:1 alpha:1] forState:0];
    [self.laterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.top.equalTo(line2.mas_bottom);
    }];
    
    [self addSubview:self.commentView];
    self.commentView.hidden = true;
    [self.commentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rtView.mas_bottom).offset(20);
        make.width.equalTo(@270);
        make.height.equalTo(@200);
        make.centerX.offset(0);
    }];
    
    [self addSubview:self.liantiao1];
    self.liantiao1.hidden = true;
    [self.liantiao1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rtView.mas_bottom).offset(-16);
        make.bottom.equalTo(self.commentView.mas_top).offset(25);
        make.width.equalTo(@14.8);
        make.centerX.offset(70);
    }];
    
    [self addSubview:self.liantiao2];
    self.liantiao2.hidden = true;
    [self.liantiao2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.rtView.mas_bottom).offset(-16);
        make.bottom.equalTo(self.commentView.mas_top).offset(25);
        make.width.equalTo(@14.8);
        make.centerX.offset(-70);
    }];
}

-(UIView *)commentView{
    if (_commentView==nil) {
        _commentView = [[UIView alloc]init];
        _commentView.layer.cornerRadius = 15;
        _commentView.alpha = 0.9;
        _commentView.layer.masksToBounds = true;
        _commentView.backgroundColor = [UIColor whiteColor];
        
        UILabel *lab = [[UILabel alloc]init];
        [_commentView addSubview:lab];
        lab.text = @"评论";
        if ([GamaTools isSimpleChinese]==false) {
            lab.text = @"Rate";
        }
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = [UIFont boldSystemFontOfSize:18];
        lab.textColor = [UIColor blackColor];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset(0);
            make.height.equalTo(@50);
            make.top.offset(0);
        }];
        
        [_commentView addSubview:self.textView];
        [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.right.offset(-15);
            make.top.equalTo(lab.mas_bottom);
            make.height.equalTo(@100);
        }];
        
        [_commentView addSubview:self.cancleBtn];
        [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.textView.mas_bottom);
            make.left.bottom.offset(0);
            make.width.equalTo(@135);
        }];
        [_commentView addSubview:self.commitBtn];
        [self.commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.textView.mas_bottom);
            make.right.bottom.offset(0);
            make.width.equalTo(@135);
        }];
        
    }
    return _commentView;
}
-(UIImageView *)liantiao1{
    if (!_liantiao1) {
        _liantiao1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"GMGSupport.bundle/lian.png"]];
    }
    return _liantiao1;
}
-(UIImageView *)liantiao2{
    if (!_liantiao2) {
        _liantiao2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"GMGSupport.bundle/lian.png"]];
    }
    return _liantiao2;
}
-(UITextView *)textView{
    if (!_textView) {
        _textView = [[UITextView alloc]init];
        _textView.font = [UIFont systemFontOfSize:16];
        _textView.textColor = [UIColor blackColor];
        _textView.delegate = self;
        _textView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
        _textView.layer.cornerRadius = 10;
        _textView.layer.masksToBounds = true;
        _textView.keyboardType = UIKeyboardTypeDefault;
        _textView.returnKeyType = UIReturnKeyDone;
    }
    return _textView;
}
-(UIButton *)cancleBtn{
    if (!_cancleBtn) {
        _cancleBtn = [UIButton buttonWithType:0];
        [_cancleBtn setTitle:@"关闭" forState:0];
        if ([GamaTools isSimpleChinese]==false) {
            [_cancleBtn setTitle:@"Close" forState:0];
        }
        _cancleBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [_cancleBtn setTitleColor:[UIColor redColor] forState:0];
        [_cancleBtn addTarget:self action:@selector(laterBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleBtn;
}
-(UIButton *)commitBtn{
    if (!_commitBtn) {
        _commitBtn = [UIButton buttonWithType:0];
        [_commitBtn setTitle:@"提交" forState:0];
        if ([GamaTools isSimpleChinese]==false) {
            [_commitBtn setTitle:@"Submit" forState:0];
        }
        _commitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [_commitBtn setTitleColor:[UIColor colorWithRed:0 green:122/255.0 blue:1 alpha:1] forState:0];
        [_commitBtn addTarget:self action:@selector(laterBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commitBtn;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSLog(@"%@",text);
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
    }
    return true;
}
- (void)textViewDidChange:(UITextView *)textView{
    NSLog(@"%@",textView.text);
}

-(void)zzBtnClicked{
    NSLog(@"点击在遮罩层上");
}

-(void)starClicked:(UIButton *)sender{
    UIImage *normal = [UIImage imageNamed:@"GMGSupport.bundle/star1.png"];
    UIImage *select = [UIImage imageNamed:@"GMGSupport.bundle/star2.png"];
    if (sender==self.star1btn) {
        [self.star1btn setImage:select forState:0];
        [self.star2btn setImage:normal forState:0];
        [self.star3btn setImage:normal forState:0];
        [self.star4btn setImage:normal forState:0];
        [self.star5btn setImage:normal forState:0];
        [self openComment];
    }else if (sender==self.star2btn){
        [self.star1btn setImage:select forState:0];
        [self.star2btn setImage:select forState:0];
        [self.star3btn setImage:normal forState:0];
        [self.star4btn setImage:normal forState:0];
        [self.star5btn setImage:normal forState:0];
        [self openComment];
    }else if (sender==self.star3btn){
        [self.star1btn setImage:select forState:0];
        [self.star2btn setImage:select forState:0];
        [self.star3btn setImage:select forState:0];
        [self.star4btn setImage:normal forState:0];
        [self.star5btn setImage:normal forState:0];
        [self openComment];
    }else if (sender==self.star4btn){
        [self.star1btn setImage:select forState:0];
        [self.star2btn setImage:select forState:0];
        [self.star3btn setImage:select forState:0];
        [self.star4btn setImage:select forState:0];
        [self.star5btn setImage:normal forState:0];
        [self gotoAppleRata];
    }else{
        [self.star1btn setImage:select forState:0];
        [self.star2btn setImage:select forState:0];
        [self.star3btn setImage:select forState:0];
        [self.star4btn setImage:select forState:0];
        [self.star5btn setImage:select forState:0];
        [self gotoAppleRata];
    }
}


-(void)gotoAppleRata{
    dispatch_after(0.5, dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });
    NSLog(@"打开苹果评论");
    if (@available(iOS 10.3, *)) {
        [SKStoreReviewController requestReview];
    } else {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *appId = [infoDictionary objectForKey:@"AppleId"];
        NSURL *appReviewUrl = [NSURL URLWithString:[NSString stringWithFormat: @"itms-apps://itunes.apple.com/app/id%@?action=write-review",appId]];
        if (@available(iOS 10, *)) {
            [[UIApplication sharedApplication] openURL:appReviewUrl options:@{} completionHandler:nil];
        }else{
           [[UIApplication sharedApplication] openURL:appReviewUrl];
        }
    }
}

-(void)openComment{
    [UIView animateWithDuration:1 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
//    dispatch_after(0.5, dispatch_get_main_queue(), ^{
//        [self removeFromSuperview];
//    });
    
//    self.laterBtn.hidden = true;
//    self.liantiao1.hidden = false;
//    self.liantiao2.hidden = false;
//    self.commentView.hidden = false;
//    dispatch_after(1, dispatch_get_main_queue(), ^{
//        [self.textView becomeFirstResponder];
//    });
//    [self.rtView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.width.equalTo(@270);
//        make.height.equalTo(@240);
//        make.centerX.offset(0);
//        make.top.offset(180);
//    }];
}



-(void)laterBtnClicked{
    [self removeFromSuperview];
}

+(void)openRate:(UIView *)superView{
    GamaRateView *rateView = [[GamaRateView alloc]init];
    [superView addSubview:rateView];
    CGSize size = [UIScreen mainScreen].bounds.size;
    rateView.frame = CGRectMake(0, 0, size.width, size.height);
}

@end
