//
//  CommentView.m
//  Demo
//
//  Created by 崔婉莹 on 2022/2/10.
//

#import "CommentView.h"

#define TOOL_VIEW_HEIGHT 47

@interface CommentView()

@property (nonatomic, strong) UIControl *maskView;
@property (nonatomic, strong) CommentListView *commentListView;

@property (nonatomic, strong) UIControl *topMaskView;
@property (nonatomic, strong) NSString *historyText;
@property (nonatomic, assign) CGRect historyFrame;
@property (nonatomic, assign) BOOL isKeyBoardShow;

@end

@implementation CommentView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if ([super initWithFrame:frame]) {
        self.backgroundColor = RGBHexColor(0x000000, 0.5);
        //监听当键盘将要出现时
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        //监听当键将要退出时
         [[NSNotificationCenter defaultCenter] addObserver:self
                                                  selector:@selector(keyboardWillHide:)
                                                      name:UIKeyboardWillHideNotification
                                                    object:nil];
        [self layoutUI];
        
    }
    return self;
}

- (void)layoutUI{
    
    @weakify(self)
    _maskView = [[UIControl alloc] initWithFrame:self.frame];
    _maskView.backgroundColor = [UIColor clearColor];
    [_maskView addTarget:self action:@selector(maskViewClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_maskView];
    [_maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
        
    }];

    _commentListView = [[CommentListView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 0)];
    _commentListView.closeBtnBlock = ^{
        @strongify(self)
        [self hideView];
    };
    _commentListView.sendBtnBlock = ^(NSString *text){
        @strongify(self)
        NSLog(@"%@",text);
        [self endEdit];
    };
    _commentListView.replyBtnBlock = ^{
         @strongify(self)
        NSLog(@"回复某人");

    };
    [self addSubview:_commentListView];


    
    UISwipeGestureRecognizer *swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipe:)];
    [swipeGestureRecognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [self addGestureRecognizer:swipeGestureRecognizer];


}

#pragma mark - action
- (void)endEdit{
    [self endEditing:YES];

    self.commentListView.toolView.textView.placeholder = @"你也来聊两句吧";
    [UIView animateWithDuration:0.3 animations:^{
        self.commentListView.toolView.frameHeight = ComentBottomViewHeight+SAFE_AREA_BOTTOM;
        self.commentListView.toolView.frameY = SCREEN_HEIGHT-ComentBottomViewHeight-SAFE_AREA_BOTTOM-STATUS_AND_NAV_BAR_HEIGHT;
    } completion:^(BOOL finished) {

    }];
}

//关闭整个视图
- (void)maskViewClick{
    [self endEdit];
    [self hideView];
}

//关闭界面
- (void)hideView{

    [UIView animateWithDuration:0.2 animations:^{
        self.commentListView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 0);
    } completion:^(BOOL finished) {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        [self removeFromSuperview];
    }];

}

//展示界面
- (void)showView{
    
    [UIView animateWithDuration:0.2 animations:^{
        self.commentListView.frame = CGRectMake(0, CommentViewTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)handleSwipe:(UISwipeGestureRecognizer *)recognizer{
    if(recognizer.direction == UISwipeGestureRecognizerDirectionDown) {
        NSLog(@"swipe down");
        [self hideView];
    }
    if(recognizer.direction == UISwipeGestureRecognizerDirectionUp) {
        NSLog(@"swipe up");
        
    }

}

//当键盘出现
- (void)keyboardWillShow:(NSNotification *)notification
{
    //获取键盘的高度
    NSDictionary *userInfo = [notification userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [value CGRectValue];
    self.topMaskView.hidden = NO;
    CGFloat y = SCREEN_HEIGHT-keyboardRect.size.height-CommentEditToolViewHeight-STATUS_AND_NAV_BAR_HEIGHT;
    self.commentListView.toolView.keyboardHeight = keyboardRect.size.height;
    self.commentListView.toolView.defaultY = y;
    self.commentListView.toolView.defaultHeight = CommentEditToolViewHeight;
    [UIView animateWithDuration:0.3 animations:^{
        self.commentListView.toolView.frameHeight = CommentEditToolViewHeight;
        self.commentListView.toolView.frameY = y;
    }];
}

//当键退出
- (void)keyboardWillHide:(NSNotification *)notification
{
    self.topMaskView.hidden = YES;
    [UIView animateWithDuration:0.3 animations:^{
        self.commentListView.toolView.frameHeight = ComentBottomViewHeight+SAFE_AREA_BOTTOM;
        self.commentListView.toolView.frameY = SCREEN_HEIGHT-ComentBottomViewHeight-SAFE_AREA_BOTTOM-STATUS_AND_NAV_BAR_HEIGHT;
    }];
    
    
}

@end

@implementation CommentManager

+(instancetype)shareManager{
    static CommentManager *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[CommentManager alloc] init];
    });
    return instance;
}

- (void)showCommentWithSourceId:(NSString *)sourceId{
    
    CommentView *view = [[CommentView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [delegate.window addSubview:view];
    [view showView];
}

@end
