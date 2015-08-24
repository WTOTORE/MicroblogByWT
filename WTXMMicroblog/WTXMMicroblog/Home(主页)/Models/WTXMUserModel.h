//
//  WTXMUserModel.h
//  WTXMMicroblog
//
//  Created by 王涛 on 15/8/20.
//  Copyright (c) 2015年 王涛. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  user = {
	allow_all_comment = 1;
	avatar_large = http://tp4.sinaimg.cn/1660612723/180/5718983670/0;
	profile_image_url = http://tp4.sinaimg.cn/1660612723/50/5718983670/0;
	class = 1;
	id = 1660612723;
	cover_image = http://ww2.sinaimg.cn/crop.0.0.980.300/62faf073jw1e167wpnnwzj.jpg;
	created_at = Fri Nov 13 16:17:24 +0800 2009;
	allow_all_act_msg = 1;
	remark = ;
	verified_trade = ;
	mbtype = 12;
	verified_reason = ;
	location = 广东 广州;
	geo_enabled = 0;
	idstr = 1660612723;
	description = 这里是所有爱宠，爱心人士的集聚地，诚邀您来一起关注、爱护这些可爱的小动物！·····图片摘自网络,侵权删;
	url = ;
	followers_count = 3893981;
	follow_me = 0;
	bi_followers_count = 10;
	lang = zh-cn;
	verified_source_url = ;
	credit_score = 80;
	block_word = 0;
	statuses_count = 72500;
	following = 1;
	verified_type = -1;
	avatar_hd = http://ww1.sinaimg.cn/crop.0.0.750.750.1024/62faf073jw8epahqjrpqaj20ku0kugmf.jpg;
	cover_image_phone = http://ww4.sinaimg.cn/crop.0.0.640.640.640/6ce2240djw1e9ob4y5qvcj20hs0hsq5v.jpg;
	star = 0;
	name = 可爱宠物中心;
	domain = mengchongwu;
	city = 1;
	block_app = 1;
	online_status = 0;
	urank = 34;
	verified_reason_url = ;
	screen_name = 可爱宠物中心;
	province = 44;
	verified_source = ;
	weihao = ;
	gender = f;
	pagefriends_count = 0;
	favourites_count = 70;
	mbrank = 6;
	profile_url = mengchongwu;
	user_ability = 0;
	ptype = 0;
	friends_count = 141;
	verified = 0;
 }
 ;

 */
@interface WTXMUserModel : NSObject
@property (nonatomic,copy) NSString *screen_name;
@property (nonatomic,copy) NSString *profile_image_url;
//"mbtype": 12,
//"mbrank": 5,
//会员类型,如果当前这个值大于第于2的话,就代表是会员
@property (nonatomic, assign) NSInteger mbtype;

//会员等级:如果会员类型大于等于2的话,才有用
@property (nonatomic, assign) NSInteger mbrank;

@property (nonatomic, assign,getter=isVip) BOOL vip;

@end
