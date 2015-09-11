//
//  CeldaTablaTareasWidget.h
//  Aquitectura
//
//  Created by Carlos Peralta on 4/9/15.
//  Copyright (c) 2015 Eduardo Pujol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CeldaTablaTareasWidget.h"

@class CeldaTablaTareasWidget;

@protocol protocoloCeldaTablaTareasWidget <NSObject>

@required
- (void) btnEliminarPresionado_celdaCeldaTablaTareasWidget:(CeldaTablaTareasWidget *)celdaCeldaTablaTareasWidget;

@end

@interface CeldaTablaTareasWidget : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *tareaUILabel;
@property (weak, nonatomic) IBOutlet UILabel *categoriaUILabel;
@property (weak, nonatomic) IBOutlet UIView *vistaBtnEliminarUIView;
@property (weak, nonatomic) IBOutlet UIView *vistaPrincipalUIView;

@property (weak, nonatomic) id<protocoloCeldaTablaTareasWidget> delegado;

@property (weak, nonatomic) IBOutlet UIButton *btnEliminarUIButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *cargadorSobreEliminarUIActivityIndicatorView;
@end
