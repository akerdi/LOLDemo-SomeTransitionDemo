//
//  SHSkinsNode.m
//  FaceBookPJ
//
//  Created by MyCompany on 16/12/19.
//  Copyright © 2016年 littleshuai. All rights reserved.
//

#import "SHSkinsNode.h"
#import "SHChampionsDetailModel.h"

#import "UIView+SHFindViewController.h"

@interface SHSkinsNode ()<ASTextNodeDelegate>
@property (nonatomic, strong) ASTextNode *titleNode;
@property (nonatomic, strong) ASTextNode *displayUrlSourceTextNode;


@property (nonatomic, strong) SHChampionsDetailSkins *model;

@property UIImage *videoImage;
@end

@implementation SHSkinsNode

-(instancetype)initWithModel:(id)model{
    if (self = [super init]) {
        
        self.model = model;
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.titleNode = [[ASTextNode alloc]init];
        self.titleNode.attributedText = [SHAttributeTool championDetailTitleWith:self.model.name];
        [self addSubnode:self.titleNode];
        self.titleNode.cornerRadius = 4;
        self.titleNode.layerBacked = YES;
        
        self.displayUrlSourceTextNode = [[ASTextNode alloc]init];
        [self addSubnode:self.displayUrlSourceTextNode];
        self.displayUrlSourceTextNode.delegate = self;
        self.displayUrlSourceTextNode.userInteractionEnabled = YES;
        
        NSString *url = @"地址一 和 地址二";
        NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc]initWithString:url];//[NSString stringWithFormat:,self.model.displayUrl,self.model.source]];
        [attributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:[url rangeOfString:@"地址一"]];
        [attributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:[url rangeOfString:@"地址二"]];
        if (self.model.displayUrl.length){
            [attributeStr addAttributes:@{
                                          NSForegroundColorAttributeName:APPColor,
                                          NSLinkAttributeName:[NSURL URLWithString:self.model.displayUrl],
                                          NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle | NSUnderlinePatternDot)
                                          } range:[url rangeOfString:@"地址一"]];
        }
        if (self.model.source.length) {
            [attributeStr addAttributes:@{
                                          NSForegroundColorAttributeName:APPColor,
                                          NSLinkAttributeName:[NSURL URLWithString:self.model.source],
                                          NSUnderlineStyleAttributeName:@(NSUnderlineStyleSingle | NSUnderlinePatternDot)
                                          } range:[url rangeOfString:@"地址二"]];
        }
        self.displayUrlSourceTextNode.attributedText = attributeStr;
    }
    return self;
}

-(ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize{
    
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObject:self.titleNode];
    [arr addObject:self.displayUrlSourceTextNode];
    
    ASStackLayoutSpec *verticalSpec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:CellPadding justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStart children:arr];
    return [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(CellPadding, CellPadding, CellPadding, CellPadding) child:verticalSpec];
}

-(BOOL)textNode:(ASTextNode *)textNode shouldHighlightLinkAttribute:(NSString *)attribute value:(id)value atPoint:(CGPoint)point{
    return YES;
}

-(void)textNode:(ASTextNode *)textNode tappedLinkAttribute:(NSString *)attribute value:(id)value atPoint:(CGPoint)point textRange:(NSRange)textRange{
    
    ASDisplayNode *node = [[ASDisplayNode alloc]initWithViewBlock:^UIView * _Nonnull{
        UIWebView *webView = [[UIWebView alloc]init];
        webView.scalesPageToFit = YES;
        [webView loadRequest:[NSURLRequest requestWithURL:value]];
        return webView;
    }];
    ASViewController *viewC = [[ASViewController alloc]initWithNode:node];
    viewC.title = self.model.name;
    node.style.flexGrow = YES;
    
    UIViewController *parentVC = [self.owningNode.view viewController];
    [parentVC.navigationController pushViewController:viewC animated:YES];
}



@end
