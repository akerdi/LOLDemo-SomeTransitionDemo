//
//  SHBlurbNode.m
//  FaceBookPJ
//
//  Created by MyCompany on 16/12/1.
//  Copyright © 2016年 littleshuai. All rights reserved.
//

#import "SHBlurbNode.h"

static CGFloat kFixedHeight = 75.0f;
static CGFloat kTextPadding = 10.0f;

@implementation SHBlurbNode{
    ASTextNode *_textNode;
}

+(CGFloat)desiredHeightForWidth:(CGFloat)width{
    return kFixedHeight;
}

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor lightGrayColor];
        _textNode = [[ASTextNode alloc]init];
        _textNode.maximumNumberOfLines = 2;
        _textNode.delegate = self;
        _textNode.userInteractionEnabled = YES;
        
        // generate an attributed string using the custom link attribute specified above
        NSString *blurb = @"Kittens courtesy lorempixel.com \U0001F638 草草草 😢👀\nTitles courtesy of catipsum.com";
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:blurb];
        [string addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f] range:NSMakeRange(0, blurb.length)];
        [string addAttributes:@{
                                NSLinkAttributeName: [NSURL URLWithString:@"http://lorempixel.com/"],
                                NSForegroundColorAttributeName: [UIColor cyanColor],
                                NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle | NSUnderlinePatternDot),
                                }
                        range:[blurb rangeOfString:@"lorempixel.com"]];
        [string addAttributes:@{
                                NSLinkAttributeName: [NSURL URLWithString:@"http://www.catipsum.com/"],
                                NSForegroundColorAttributeName: [UIColor blueColor],
                                NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle | NSUnderlinePatternDot),
                                } range:[blurb rangeOfString:@"catipsum.com"]];
        _textNode.attributedText = string;
        
        [self addSubnode:_textNode];
    }
    return self;
}

-(void)didLoad{
    self.layer.as_allowsHighlightDrawing = YES;
    [super didLoad];
}

-(ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize{
    ASCenterLayoutSpec *centerSpec = [[ASCenterLayoutSpec alloc]init];
    centerSpec.centeringOptions = ASCenterLayoutSpecCenteringX;
    centerSpec.sizingOptions = ASCenterLayoutSpecSizingOptionMinimumY;
    centerSpec.child = _textNode;
    
    UIEdgeInsets padding = UIEdgeInsetsMake(kTextPadding, kTextPadding, kTextPadding, kTextPadding);
    return [ASInsetLayoutSpec insetLayoutSpecWithInsets:padding child:centerSpec];
}

#pragma mark ASTextNodeDelegate methods.

- (BOOL)textNode:(ASTextNode *)richTextNode shouldHighlightLinkAttribute:(NSString *)attribute value:(id)value atPoint:(CGPoint)point
{
    // opt into link highlighting -- tap and hold the link to try it!  must enable highlighting on a layer, see -didLoad
    return YES;
}

- (void)textNode:(ASTextNode *)richTextNode tappedLinkAttribute:(NSString *)attribute value:(NSURL *)URL atPoint:(CGPoint)point textRange:(NSRange)textRange
{
    // the node tapped a link, open it
    [[UIApplication sharedApplication] openURL:URL];
}


@end
