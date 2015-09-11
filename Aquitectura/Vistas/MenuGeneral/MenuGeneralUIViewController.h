//
//  MenuGeneralUIViewController.h
//  Aquitectura
//
//  Created by Carlos Peralta on 31/8/15.
//  Copyright (c) 2015 Eduardo Pujol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ControladorPrincipalNSObject.h"
#import "CategoriasControlador.h"

@class ControladorPrincipalNSObject, CategoriasControlador;


@protocol MenuGeneralUIViewControllerProtocol <NSObject>

@required
- (void) cerrarSesionUIButton_presionado;

@end



@interface MenuGeneralUIViewController : UIViewController

@property (retain, nonatomic) NSArray *categoriasNSArray;

@property (retain, nonatomic) CategoriasControlador *categoriasControlador;

@property (weak, nonatomic) IBOutlet UITableView *tablaCategoriasUITableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *cargadorUIActivityIndicatorView;

@property (weak,nonatomic) id<MenuGeneralUIViewControllerProtocol> delegado;

- (void) mostrarCargadorTablaTareas;
- (void) ocultarCargadorTablaTareas;
- (void) seleccionarLaCategoriaTODAS;


- (id)iniciarConSuNibYControlador_ControladorPrincipalNSObject:(ControladorPrincipalNSObject*)controladorPrincipalNSObject;

- (void) cargarCategoriasEnTabla_categoriasNSArray:(NSArray*)categoriasNSArray;

@end
