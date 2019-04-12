//
//  TSTeamDetailsModel.h
//  EducationMix
//
//  Created by Taosky on 2019/4/9.
//  Copyright © 2019 iTaosky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSTeamDetailsModel : NSObject

@property(nonatomic,strong)NSString *team_name;
@property(nonatomic,strong)NSString *formation_date;
@property(nonatomic,strong)NSString *professional_field;
@property(nonatomic,assign)NSInteger unit_type;
@property(nonatomic,strong)NSString *unit_name;

@property(nonatomic,strong)NSString *team_profile;
@property(nonatomic,strong)NSString *scientific_research_achievements;
@property(nonatomic,strong)NSString *team_leader_number;
@property(nonatomic,strong)NSString *team_leaders_name;
@property(nonatomic,strong)NSString *research_direction;

@property(nonatomic,strong)NSString *responsible_jobtitle;
@property(nonatomic,strong)NSString *need_talent;
@property(nonatomic,strong)NSString *personnel_demand_quantity;
@property(nonatomic,strong)NSString *personnel_requirements;
@property(nonatomic,strong)NSString *team_contact;

@property(nonatomic,strong)NSString *contact_number;
@property(nonatomic,strong)NSString *email;
@property(nonatomic,strong)NSString *team_photo;
@property(nonatomic,strong)NSString *research_subject;


//"apply_phone":"",
//"apply_email":"",
//"team_id":37,
//"member_id":3135,
//"team_name":"梦之队",
//"formation_date":"2018-10-30",
//"professional_field":"2",
//"unit_type":1,
//"unit_name":"电子科技大学",
//"team_profile":"国家青年特聘专家、第一位基础院与材料学院双聘教授、材料学院副院长牛晓滨，就是王志明团队招募的一员大将。牛晓滨认为，尽",
//"scientific_research_achievements":"随着人才的聚集，王志明团队的各项学术成果也逐步发表。目前，团队已在多光子量子态、纳米材料、热电材料、低维材料光电器件",
//"team_leader_number":null,
//"team_leaders_name":"王志明",
//"research_direction":"高端科研",
//"responsible_jobtitle":"教授",
//"need_talent":2,
//"personnel_demand_quantity":5,
//"personnel_requirements":"",
//"team_contact":"王志明",
//"contact_number":"13415256462",
//"email":"197545453@qq.com",
//"team_photo":"/uploads/ExpertTeam/20181122/1542872272886923686.jpg|/uploads/ExpertTeam/20181122/1542872272259212878.jpg|/uploads/ExpertTeam/20181122/1542872272881493563.jpg",
//"research_subject":"[{"subject_name":"IT科技","technology_project":"IT科技"},{"subject_name":"信息工程","technology_project":"信息科技"}]",
//"main_result":"[]"

@end

NS_ASSUME_NONNULL_END
