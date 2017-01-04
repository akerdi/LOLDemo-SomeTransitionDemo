//
//  SHChampionsDetailModel.h
//  FaceBookPJ
//
//  Created by MyCompany on 16/12/18.
//  Copyright © 2016年 littleshuai. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 data =     (
 
 {
 
 id = Warwick;
 
 image =             {
 
 full = "Warwick.png";
 
 group = champion;
 
 h = 48;
 
 sprite = "champion3.png";
 
 w = 48;
 
 x = 288;
 
 y = 48;
 
 };
 
 info =             {
 
 attack = 7;
 
 defense = 4;
 
 difficulty = 2;
 
 magic = 4;
 
 };
 
 key = 19;
 
 name = "\U55dc\U8840\U730e\U624b";
 
 passive =             {
 
 description = "\U6c83\U91cc\U514b\U6bcf\U6b21\U653b\U51fb\U9020\U62103\Uff08\U6bcf\U5347\U4e00\U7ea7\U589e\U52a00.5\Uff09\U70b9\U9b54\U6cd5\U4f24\U5bb3\U5e76\U56de\U590d\U7b49\U91cf\U7684\U751f\U547d\U503c\Uff0c\U5bf9\U540c\U4e00\U4e2a\U5355\U4f4d\U6301\U7eed\U653b\U51fb\U65f6\U6548\U679c\U53e0\U52a0\Uff0c\U6700\U591a\U53e0\U52a03\U6b21\U3002";
 
 image =                 {
 
 full = "Warwick_InnerHunger.png";
 
 };
 
 name = "\U8840\U4e4b\U9965\U6e34\Uff08\U88ab\U52a8\Uff09";
 
 };
 
 skins =             (
 
 {
 
 displayUrl = "http://v.qq.com/boke/page/7/O/r/7x5ZEJKwwOr.html";
 
 id = 000;
 
 name = "\U9ed8\U8ba4\U76ae\U80a4";
 
 num = 0;
 
 source = "http://static.video.qq.com/TPout.swf?vid=7x5ZEJKwwOr&auto=1";
 
 },
 
 {
 
 displayUrl = "http://v.qq.com/boke/page/f/0/8/f0112ijthw8.html";
 
 id = 001;
 
 name = "\U6697\U5f71 \U6c83\U91cc\U514b";
 
 num = 1;
 
 source = "http://static.video.qq.com/TPout.swf?vid=f0112ijthw8&auto=1";
 
 },
 
 {
 
 displayUrl = "http://v.qq.com/boke/gplay/431fafbe820562c6d198c58fb86eb4dc_7dde620de5162007c27de70203d389f5_k0102f9yqla.html";
 
 id = 002;
 
 name = "\U62ab\U7740\U6d77\U725b\U7684\U72fc \U6c83\U91cc\U514b";
 
 num = 2;
 
 source = "http://static.video.qq.com/TPout.swf?vid=k0102f9yqla&auto=1";
 
 },
 
 {
 
 displayUrl = "http://v.qq.com/boke/gplay/431fafbe820562c6d198c58fb86eb4dc_7dde620de5162007c27de70203d389f5_z0101jcka6n.html";
 
 id = 003;
 
 name = "\U72fc\U5916\U5a46 \U6c83\U91cc\U514b";
 
 num = 3;
 
 source = "http://static.video.qq.com/TPout.swf?vid=z0101jcka6n&auto=1";
 
 },
 
 {
 
 displayUrl = "http://v.qq.com/boke/page/d/0/2/d0102npzlc2.html";
 
 id = 004;
 
 name = "\U51bb\U539f\U730e\U624b \U6c83\U91cc\U514b";
 
 num = 4;
 
 source = "http://static.video.qq.com/TPout.swf?vid=d0102npzlc2&auto=1";
 
 },
 
 {
 
 displayUrl = "http://v.qq.com/boke/page/p/0/a/p0104xs2mja.html";
 
 id = 005;
 
 name = "\U55dc\U8840\U72c2\U66b4 \U6c83\U91cc\U514b";
 
 num = 5;
 
 source = "http://static.video.qq.com/TPout.swf?vid=p0104xs2mja&auto=1";
 
 },
 
 {
 
 displayUrl = "http://v.qq.com/boke/gplay/431fafbe820562c6d198c58fb86eb4dc_7dde620de5162007c27de70203d389f5_o01001m2skx.html";
 
 id = 006;
 
 name = "\U706b\U7259\U72fc\U4eba \U6c83\U91cc\U514b";
 
 num = 6;
 
 source = "http://static.video.qq.com/TPout.swf?vid=o01001m2skx&auto=1";
 
 },
 
 {
 
 displayUrl = "http://v.qq.com/boke/gplay/431fafbe820562c6d198c58fb86eb4dc_7dde620de5162007c27de70203d389f5_p01022h1a7i.html";
 
 id = 007;
 
 name = "\U8352\U91ce\U8c7a\U72fc \U6c83\U91cc\U514b";
 
 num = 7;
 
 source = "http://static.video.qq.com/TPout.swf?vid=p01022h1a7i&auto=1";
 
 },
 
 {
 
 displayUrl = "http://v.qq.com/boke/page/7/O/r/7x5ZEJKwwOr.html";
 
 id = 008;
 
 name = "\U9ed1\U6697\U9a91\U58eb \U6c83\U91cc\U514b";
 
 num = 8;
 
 source = "http://static.video.qq.com/TPout.swf?vid=7x5ZEJKwwOr&auto=1";
 
 }
 
 );
 
 spells =             (
 
 {
 
 description = "";
 
 id = HungeringStrike;
 
 image =                     {
 
 full = "HungeringStrike.png";
 
 };
 
 leveltip =                     {
 
 effect =                         (
 
 );
 
 label =                         (
 
 );
 
 };
 
 name = "\U55dc\U8840\U653b\U51fb\Uff08Q\Uff09";
 
 resource = "";
 
 tooltip = "\U731b\U51fb\U654c\U4eba\Uff0c\U9020\U621075/125/175/225/275(+1*AP)\U548c\U76ee\U68078/10/12/14/16%(+1*AP)\U6700\U5927\U751f\U547d\U503c\U4e4b\U95f4\U66f4\U5927\U7684\U9b54\U6cd5\U4f24\U5bb3\Uff08\U5bf9\U602a\U7269\U53ea\U80fd\U9020\U6210\U56fa\U5b9a\U4f24\U5bb3\Uff09\Uff0c\U5e76\U6cbb\U7597\U81ea\U5df1\Uff0c\U6cbb\U7597\U6548\U679c\U4e3a\U4ed6\U9020\U6210\U7684\U4f24\U5bb3\U768480%\U3002<br>\U8ddd\U79bb\Uff1a400<br><br>\U51b7\U5374\U65f6\U95f4\Uff1a10/9/8/7/6\U79d2<br>\U6d88\U8017\Uff1a70/80/90/100/110 \U6cd5\U529b";
 
 },
 
 {
 
 description = "";
 
 id = HuntersCall;
 
 image =                     {
 
 full = "HuntersCall.png";
 
 };
 
 leveltip =                     {
 
 effect =                         (
 
 );
 
 label =                         (
 
 );
 
 };
 
 name = "\U730e\U624b\U6012\U543c\Uff08W\Uff09";
 
 resource = "";
 
 tooltip = "\U6c83\U91cc\U514b\U53d1\U51fa\U523a\U8033\U6012\U543c\Uff0c\U589e\U52a0\U81ea\U5df140/50/60/70/80%\U7684\U653b\U51fb\U901f\U5ea6\Uff0c\U540c\U65f6\U5bf9\U9644\U8fd1\U53cb\U65b9\U82f1\U96c4\U5e26\U6765\U4e00\U534a\U7684\U52a0\U901f\U6548\U679c\Uff0c\U6301\U7eed6/6/6/6/6\U79d2\U3002<br>\U8ddd\U79bb\Uff1a1250<br><br>\U51b7\U5374\U65f6\U95f4\Uff1a24/22/20/18/16\U79d2<br>\U6d88\U8017\Uff1a35/35/35/35/35 \U6cd5\U529b";
 
 },
 
 {
 
 description = "";
 
 id = BloodScent;
 
 image =                     {
 
 full = "BloodScent.png";
 
 };
 
 leveltip =                     {
 
 effect =                         (
 
 );
 
 label =                         (
 
 );
 
 };
 
 name = "\U8840\U8ff9\U8ffd\U8e2a\Uff08E\Uff09";
 
 resource = "";
 
 tooltip = "\U6fc0\U6d3b\Uff1a\U6c83\U91cc\U514b\U80fd\U591f\U611f\U77e5\U5230\U9644\U8fd11500/2300/3100/3900/4700\U8303\U56f4\U5185\U751f\U547d\U503c\U4f4e\U4e8e50%\U7684\U654c\U65b9\U82f1\U96c4\U7684\U884c\U8e2a\U3002\U53d1\U73b0\U865a\U5f31\U82f1\U96c4\U540e\Uff0c\U6c83\U91cc\U514b\U589e\U52a020/25/30/35/40%\U7684\U79fb\U52a8\U901f\U5ea6\Uff0c\U5e76\U4f7f\U4e0d\U5728\U6f5c\U884c\U72b6\U6001\U4e0b\U7684\U654c\U4eba\U66b4\U9732\U5728\U5df1\U65b9\U89c6\U91ce\U4e2d\U3002<br><br>\U51b7\U5374\U65f6\U95f4\Uff1a0.5/0.5/0.5/0.5/0.5\U79d2<br>";
 
 },
 
 {
 
 description = "";
 
 id = InfiniteDuress;
 
 image =                     {
 
 full = "InfiniteDuress.png";
 
 };
 
 leveltip =                     {
 
 effect =                         (
 
 );
 
 label =                         (
 
 );
 
 };
 
 name = "\U65e0\U5c3d\U675f\U7f1a\Uff08R\Uff09";
 
 resource = "";
 
 tooltip = "\U6c83\U91cc\U514b\U6251\U5411\U654c\U65b9\U82f1\U96c4\Uff0c\U5e76\U5c06\U76ee\U6807\U538b\U52361.8\U79d2\U3002\U5728\U6b64\U671f\U95f4\Uff0c\U6c83\U91cc\U514b\U4f1a\U5411\U76ee\U6807\U53d1\U8d775\U6b21\U653b\U51fb\Uff0c\U5e76\U9020\U6210\U603b\U5171150/250/350(+2*\U989d\U5916AD)\U70b9\U9b54\U6cd5\U4f24\U5bb3\Uff08\U89e6\U53d15\U6b21\U653b\U51fb\U7279\U6548\Uff09\U3002<br><br>\U6c83\U91cc\U514b\U5728\U6301\U7eed\U65f6\U95f4\U5185\U83b7\U5f9730%\U989d\U5916\U7684\U751f\U547d\U5077\U53d6\U3002<br>\U8ddd\U79bb\Uff1a700<br><br>\U51b7\U5374\U65f6\U95f4\Uff1a110/90/70\U79d2<br>\U6d88\U8017\Uff1a100/125/150 \U6cd5\U529b";
 
 }
 
 );
 
 tags =             (
 
 Fighter,
 
 Tank
 
 );
 
 title = "\U6c83\U91cc\U514b";
 
 trait =             {
 
 dy =                 {
 
 "add-point" = WQQEQRQEQEREEWWRWW;
 
 "eq-recommond" =                     (
 
 "1039;2003:5;3340",
 
 "3117;3154;3091;3068",
 
 "3117;3091;3153;3026;3068;3065",
 
 "3117;3091;3068;3110;3143;3065"
 
 );
 
 };
 
 sd =                 {
 
 "add-point" = QEWQERQEQERQEWWRWW;
 
 "eq-recommond" =                     (
 
 "1056;2003:2;3340",
 
 "3153;3091;3022;3020",
 
 "3153;3091;3020;3143;3065;3026",
 
 "3068;3091;3020;3143;3065;3026"
 
 );
 
 };
 
 };
 
 }
 
 );
 */
@class SHChampionsDetailInfo,SHChampionsDetailPassive,SHChampionsDetailSkins,SHChampionsDetailSpells;

@interface SHChampionsDetailModel : NSObject
@property (nonatomic, strong) SHChampionsDetailInfo *info;

@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) SHChampionsDetailPassive *passive;
@property (nonatomic, strong) NSArray <SHChampionsDetailSkins *>*skins;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSArray <SHChampionsDetailSpells *>*spells;

@end

@interface SHChampionsDetailInfo : NSObject
@property (nonatomic, strong) NSNumber *attack;
@property (nonatomic, strong) NSNumber *defense;
@property (nonatomic, strong) NSNumber *difficulty;
@property (nonatomic, strong) NSNumber *magic;
@end

@interface SHChampionsDetailPassive : NSObject
@property (nonatomic, copy) NSString *descriptionn;
@property (nonatomic, strong) NSDictionary *image;
@property (nonatomic, copy) NSString *name;
@end

@interface SHChampionsDetailSkins : NSObject
@property (nonatomic, copy) NSString *displayUrl;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, strong) NSNumber *num;
@end

@interface SHChampionsDetailSpells : NSObject
@property (nonatomic, copy) NSString *descriptionn;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *resource;
@property (nonatomic, copy) NSString *tooltip;
@property (nonatomic, strong) NSDictionary *image;//full
@property (nonatomic, strong) NSDictionary *leveltip;

@end
