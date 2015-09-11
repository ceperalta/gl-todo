//
//  BarraNavegacionWidget.h
//  Aquitectura
//
//  Created by Carlos Peralta on 28/8/15.
//  Copyright (c) 2015 Eduardo Pujol. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol BarraNavegacionWidgetProtocol <NSObject>

@required
- (void) btnMenuPresionado;
- (void) btnNuevaTareaPresionado;

@end

IB_DESIGNABLE
@interface BarraNavegacionWidget : UIView

@property (weak,nonatomic) id<BarraNavegacionWidgetProtocol> delegado;

@end
