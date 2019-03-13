//
//  YKEditTreePhotoCollectionViewCell.m
//  YKMX
//
//  Created by apple on 2017/6/9.
//  Copyright © 2017年 chenshuo. All rights reserved.
//

#import "YKEditTreePhotoCollectionViewCell.h"

@implementation YKEditTreePhotoCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"YKEditTreePhotoCollectionViewCell" owner:self options: nil];
        if(arrayOfViews.count < 1){return nil;}
        if(![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]]){
            return nil;
        }
        
        self.backgroundColor = [UIColor whiteColor];
        
        self = [arrayOfViews objectAtIndex:0];
    }
    @weakify(self);
    [self.delBtn bk_removeEventHandlersForControlEvents:UIControlEventTouchUpInside];
    [self.delBtn bk_addEventHandler:^(id sender) {
        @strongify(self);
        if (self.delegate && [self.delegate respondsToSelector:@selector(cell:didSelectDelBtn:)]) {
            [self.delegate cell:self didSelectDelBtn:self.delBtn];
        }
    } forControlEvents:UIControlEventTouchUpInside];
    
    return self;
}

@end
