//
//  CeldaTablaCategoriasWidgetUITableViewCell.m
//  Aquitectura
//
//  Created by Carlos Peralta on 1/9/15.
//  Copyright (c) 2015 Eduardo Pujol. All rights reserved.
//

#import "CeldaTablaCategoriasWidgetUITableViewCell.h"

@implementation CeldaTablaCategoriasWidgetUITableViewCell

- (void)awakeFromNib {
    NSLog(@"%s", __FUNCTION__);

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    NSLog(@"%s", __FUNCTION__);
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc{
    NSLog(@"%s", __FUNCTION__);
}

@end
