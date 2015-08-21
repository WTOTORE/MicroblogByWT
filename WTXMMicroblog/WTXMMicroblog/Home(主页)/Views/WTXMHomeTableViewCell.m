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
@interface WTXMHomeTableViewCell ()
@property (nonatomic,strong) UIView *originateView;

@property (nonatomic,strong) UIImageView *iconView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *addrLabel;
@property (nonatomic,strong) UILabel *originateTextLabel;
@property (nonatomic,strong) UIImageView *imagesView;

@property (nonatomic,strong) UIView *operateView;

@end

@implementation WTXMHomeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.iconView=[[UIImageView alloc] init];
    [self.contentView addSubview:self.iconView];
    self.nameLabel=[[UILabel alloc] init];
    self.nameLabel.font=[UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.nameLabel];
    self.timeLabel=[[UILabel alloc] init];
    self.nameLabel.font=[UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.timeLabel];
    self.addrLabel=[[UILabel alloc] init];
    self.nameLabel.font=[UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.addrLabel];
    self.originateTextLabel=[[UILabel alloc] init];
    self.nameLabel.font=[UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.originateTextLabel];
    return self;
}

- (void)setStatusFrame:(WTXMStatusFrameModel *)statusFrame {
    _statusFrame=statusFrame;
    [self setValues:statusFrame];
    [self setCellFrames:statusFrame];
}
- (void)setValues:(WTXMStatusFrameModel *)statusFrame {
    WTXMBlogModel *blog=statusFrame.blog;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:blog.user.profile_image_url] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    self.nameLabel.text=blog.user.screen_name;
    self.addrLabel.text=blog.created_at;
    self.originateTextLabel.text=blog.text;
}
- (void)setCellFrames:(WTXMStatusFrameModel *)statusFrame {
    self.iconView.frame=statusFrame.iconF;
    self.nameLabel.frame=statusFrame.nameF;
    self.timeLabel.frame=statusFrame.timeF;
    self.addrLabel.frame=statusFrame.addressF;
    self.originateTextLabel.frame=statusFrame.textF;
}
@end
