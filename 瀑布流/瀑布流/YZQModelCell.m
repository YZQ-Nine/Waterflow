//
//  YZQModelCell.m
//  瀑布流
//
//  Created by YZQ_Nine on 16/3/1.
//  Copyright © 2016年 YZQ_Nine. All rights reserved.
//

#import "YZQModelCell.h"
#import "YZQModel.h"
#import "UIImageView+WebCache.h"


@interface YZQModelCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end

@implementation YZQModelCell

- (void)setModel:(YZQModel *)model{

    _model = model;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.thumbURL] placeholderImage:[UIImage imageNamed:@"arrow"]];

    
}
@end
