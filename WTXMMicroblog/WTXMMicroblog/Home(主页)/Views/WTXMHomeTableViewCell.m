//
//  WTXMHomeTableViewCell.m
//  WTXMMicroblog
//
//  Created by 王涛 on 15/8/21.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import "WTXMHomeTableViewCell.h"
#import "WTXMStatusFrameModel.h"
#import "WTXMBlogModel.h"
#import "WTXMUserModel.h"
#import "WTXMGeoModel.h"
#import "WTXMCellImagesView.h"
#define BUTTON_COUNT 3

@interface WTXMHomeTableViewCell ()
@property (nonatomic,strong) UIView *spaceView;
/**
 *  原创
 */
@property (nonatomic,strong) UIView *originateView;
@property (nonatomic,strong) UIImageView *iconView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UIImageView *vipImage;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *sourceLabel;
@property (nonatomic,strong) UILabel *originateTextLabel;
@property (nonatomic,strong) WTXMCellImagesView *originateImagesView;
/**
 *  转发
 */
@property (nonatomic,strong) UIView *retweetedView;
@property (nonatomic,strong) UILabel *retweetTextLabel;
@property (nonatomic,strong) WTXMCellImagesView *retweetImagesView;
/**
 *  操作
 */
@property (nonatomic,strong) UIView *operateView;
//timeline_icon_comment
//timeline_icon_retweet
//timeline_icon_unlike
@property (nonatomic,strong) UIButton *commenButton;
@property (nonatomic,strong) UIButton *retweetButton;
@property (nonatomic,strong) UIButton *unlikeButton;
@end

@implementation WTXMHomeTableViewCell


- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    [self addOriginalView];
    
    [self addRetweetedView];
    
    [self addOperateView];
    
    return self;
}
/**
 *  添加原创微博视图
 */
- (void) addOriginalView {
    self.originateView=[UIView new];
    
    self.iconView=[[UIImageView alloc] init];
    [self.originateView addSubview:self.iconView];
    
    self.nameLabel=[[UILabel alloc] init];
    self.nameLabel.font=[UIFont systemFontOfSize:NAME_FONT];
    [self.originateView addSubview:self.nameLabel];
    
    self.vipImage=[[UIImageView alloc] init];
    [self.originateView addSubview:self.vipImage];
    
    self.timeLabel=[[UILabel alloc] init];
    self.timeLabel.font=[UIFont systemFontOfSize:TIME_FONT];
    [self.originateView addSubview:self.timeLabel];
    
    self.sourceLabel=[[UILabel alloc] init];
    self.sourceLabel.font=[UIFont systemFontOfSize:ADDR_FONT];
    [self.originateView addSubview:self.sourceLabel];
    
    self.originateTextLabel=[[UILabel alloc] init];
    self.originateTextLabel.numberOfLines=0;
    self.originateTextLabel.font=[UIFont systemFontOfSize:TEXT_FONT];
    [self.originateView addSubview:self.originateTextLabel];
    
    self.originateImagesView=[[WTXMCellImagesView alloc] init];
    [self.originateView addSubview:self.originateImagesView];
    
    [self.contentView addSubview:self.originateView];
}
/**
 * 添加转发微博内容
 */
- (void) addRetweetedView {
    self.retweetedView= [UIView new];
    self.retweetedView.backgroundColor=[UIColor lightGrayColor];
    
    self.retweetTextLabel=[[UILabel alloc] init];
    self.retweetTextLabel.numberOfLines=0;
    self.retweetTextLabel.font=[UIFont systemFontOfSize:TEXT_FONT];
    [self.retweetedView addSubview:self.retweetTextLabel];
    
    self.retweetImagesView=[[WTXMCellImagesView alloc] init];
    [self.retweetedView addSubview:self.retweetImagesView];
    
    [self.contentView addSubview:self.retweetedView];
}

- (void) addOperateView {
    self.operateView=[UIView new];
    
    self.retweetButton=[UIButton new];
    [self.retweetButton setBackgroundImage:[UIImage imageNamed:@"timeline_card_bottom_background"] forState:UIControlStateNormal];
    [self.retweetButton setBackgroundImage:[UIImage imageNamed:@"timeline_card_bottom_line_highlighted"] forState:UIControlStateHighlighted];
    [self.operateView insertSubview:self.retweetButton atIndex:0];
    
    self.commenButton=[UIButton new];
    [self.commenButton setBackgroundImage:[UIImage imageNamed:@"timeline_card_bottom_background"] forState:UIControlStateNormal];
    [self.commenButton setBackgroundImage:[UIImage imageNamed:@"timeline_card_bottom_line_highlighted"] forState:UIControlStateHighlighted];
    [self.operateView insertSubview:self.commenButton atIndex:1];
    
    self.unlikeButton=[UIButton new];
    [self.unlikeButton setBackgroundImage:[UIImage imageNamed:@"timeline_card_bottom_background"] forState:UIControlStateNormal];
    [self.unlikeButton setBackgroundImage:[UIImage imageNamed:@"timeline_card_bottom_line_highlighted"] forState:UIControlStateHighlighted];
    [self.operateView insertSubview:self.unlikeButton atIndex:2];
    
    [self.retweetButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.commenButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.unlikeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    self.retweetButton.titleLabel.font=[UIFont systemFontOfSize:14];
     self.commenButton.titleLabel.font=[UIFont systemFontOfSize:14];
     self.unlikeButton.titleLabel.font=[UIFont systemFontOfSize:14];
    
    [self.contentView addSubview:self.operateView];
    self.spaceView = [UIView new];
    self.spaceView.backgroundColor=[UIColor grayColor];
    [self.contentView addSubview:self.spaceView];
}

- (void)setStatusFrame:(WTXMStatusFrameModel *)statusFrame {
    _statusFrame=statusFrame;
    [self setOriginalViewFrames:statusFrame];
    [self setOriginalViewData:statusFrame];
    
    [self setRetweetViewData:statusFrame];
    [self setRetweetViewFrames:statusFrame];
    
    [self setOperateViewData:statusFrame];
    [self setOperateViewFrames:statusFrame];
}

- (void)setOriginalViewData:(WTXMStatusFrameModel *)statusFrame {
    WTXMBlogModel *blog=statusFrame.blog;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:blog.user.profile_image_url] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    self.nameLabel.text=blog.user.screen_name;
    if (blog.user.isVip) {
        self.vipImage.hidden = NO;
        self.vipImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"common_icon_membership_level%zd",blog.user.mbrank]];
        self.nameLabel.textColor = [UIColor orangeColor];
    }else{
        self.vipImage.hidden = YES;
        self.nameLabel.textColor = [UIColor blackColor];
    }
    self.timeLabel.text=blog.created_at;
    NSDictionary *attrs=@{NSFontAttributeName:[UIFont systemFontOfSize:TIME_FONT]};
    CGSize textSize = [blog.created_at sizeWithAttributes:attrs];
    self.timeLabel.wid=textSize.width;
    self.sourceLabel.text=blog.source;
    self.sourceLabel.x=CGRectGetMaxX(self.timeLabel.frame)+MARGIN;
    self.originateTextLabel.text=blog.text;
    self.originateImagesView.imagePaths=blog.pic_urls;

}
- (void)setOriginalViewFrames:(WTXMStatusFrameModel *)statusFrame {
    self.iconView.frame=statusFrame.iconF;
    self.nameLabel.frame=statusFrame.nameF;
    self.vipImage.frame=statusFrame.vipF;
    self.vipImage.centerY=self.nameLabel.centerY;
    self.timeLabel.frame=statusFrame.timeF;
    self.sourceLabel.frame=statusFrame.sourceF;
    self.originateTextLabel.frame=statusFrame.textF;
    self.originateImagesView.frame=statusFrame.imageViewF;
    self.originateView.frame=statusFrame.originateViewF;
}

- (void)setRetweetViewData:(WTXMStatusFrameModel *)statusFrame {
    WTXMBlogModel *retweetBlog=statusFrame.blog.retweeted_status;
        self.retweetTextLabel.text=retweetBlog.text;
        self.retweetImagesView.imagePaths=retweetBlog.pic_urls;
}

- (void)setRetweetViewFrames:(WTXMStatusFrameModel *)statusFrame {
        self.retweetTextLabel.frame=statusFrame.retweetTextF;
    self.retweetImagesView.frame=statusFrame.retweetImageViewF;
    self.retweetedView.frame=statusFrame.retweetedViewF;
}

- (void) setOperateViewData:(WTXMStatusFrameModel *)statusFrame {
     WTXMBlogModel *blog=statusFrame.blog;
    [self.retweetButton setTitle:blog.retweetCount forState: UIControlStateNormal];
    [self.commenButton setTitle:blog.commentCount forState: UIControlStateNormal];
    [self.unlikeButton setTitle:blog.unlikeCount forState: UIControlStateNormal];
    [self.retweetButton setImage:[UIImage imageNamed:@"timeline_icon_retweet"] forState:UIControlStateNormal];
    [self.commenButton setImage:[UIImage imageNamed:@"timeline_icon_comment"] forState:UIControlStateNormal];
    [self.unlikeButton setImage:[UIImage imageNamed:@"timeline_icon_unlike"] forState:UIControlStateNormal];
}

- (void)setOperateViewFrames:(WTXMStatusFrameModel *)statusFrame {
    CGFloat btnW=[UIScreen mainScreen].bounds.size.width/BUTTON_COUNT*1.0;
    for (int i=0; i<BUTTON_COUNT; i++) {
        if (i>0) {
            UIImageView *img=[UIImageView new];
            img.image=[UIImage imageNamed:@"timeline_card_bottom_line"];
            img.frame=CGRectMake(btnW*(i%BUTTON_COUNT), 0, 1, BUTTON_HEIGHT);
            [self.operateView addSubview:img];
        }
        UIButton *btn=self.operateView.subviews[i];
        btn.frame=CGRectMake(btnW*(i%BUTTON_COUNT), 0, btnW, BUTTON_HEIGHT);
    }
    self.operateView.frame=statusFrame.operateViewF;
    
    self.spaceView.frame=CGRectMake(0, CGRectGetMaxY(self.operateView.frame), SCREEN_WIDTH, SPACE_HEIGHT);
    
}


@end
