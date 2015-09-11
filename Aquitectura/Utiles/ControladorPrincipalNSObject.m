#import "ControladorPrincipalNSObject.h"
#import "ContenedorHomeUIViewController.h"
#import "InicialUIViewController.h"
#import "App.h"
#import "IndicadorActividadWidget.h"
#import "MenuGeneralUIViewController.h"
#import "NuevaTarea.h"


@interface ControladorPrincipalNSObject() <UIAlertViewDelegate>

@property (retain,nonatomic) UIViewController *inicialUINavigationController;
@property (retain, nonatomic) UINavigationController *uiNavController;
@property (retain, nonatomic) IndicadorActividadWidget *indicadorActividadWidgetUIView;
@property (retain, nonatomic) ContenedorHomeUIViewController *contenedorHomeUIViewController;
@property (retain, nonatomic) NuevaTarea *nuevaTareaUIViewController;

@end

@implementation ControladorPrincipalNSObject


- (void) iniciar{
    NSLog(@"%s", __FUNCTION__);
    // Creamos la vista inicial...
    _inicialUINavigationController = [[InicialUIViewController alloc] inciaConSuNibYControlador_ControladorPrincipalNSObject:self];
    [_inicialUINavigationController.view setFrame:[[UIScreen mainScreen] bounds]];
    // Creamos un UIViewController simulado como root para poder bajar y vaciar...
    UIViewController *simuladoUIViewController = [[UIViewController alloc] init];
    
    // Inicializamos el UINavigationController con la vista incial
    _uiNavController = [[UINavigationController alloc] initWithRootViewController:simuladoUIViewController];
    
    [_uiNavController pushViewController:_inicialUINavigationController animated:false];
    
    // Ocultamos el NavBar general
    _uiNavController.navigationBarHidden = YES;
    
    // Preparamos la ventana inicial con el navegador del controlador principal y presentamos en el Window del AppDelegate..
    App *app = (App*)[[UIApplication sharedApplication] delegate];
    app.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    app.window.rootViewController = _uiNavController;
    
    
    [app.window makeKeyAndVisible];
}

- (void) mostrarActivityIndicator_msg:(NSString*)msgNSString{
    NSLog(@"%s", __FUNCTION__);
    
    [self ocultarTeclado];
    
    App *app = (App*)[[UIApplication sharedApplication] delegate];
    
    _indicadorActividadWidgetUIView = [[IndicadorActividadWidget alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _indicadorActividadWidgetUIView.msgUILabel.text = msgNSString;
    [app.window addSubview:_indicadorActividadWidgetUIView];
    [app.window bringSubviewToFront:_indicadorActividadWidgetUIView];
    
}

- (void) ocultarActivityIndicator{
    NSLog(@"%s", __FUNCTION__);
    [_indicadorActividadWidgetUIView removeFromSuperview];
}

- (void) cargarTareasParaCategoriaSeleccionada_IDCatInt:(int)IDCatInt{
     NSLog(@"%s", __FUNCTION__);
    [_contenedorHomeUIViewController.homeUIViewController.homeTareasControlador cargarTareasParaIdCat_idCatInt:IDCatInt];
}

- (void) cargarTodasLasTareas{
     NSLog(@"%s", __FUNCTION__);
    [_contenedorHomeUIViewController.homeUIViewController ocultarTablaYMostrarCargador];
    [_contenedorHomeUIViewController.homeUIViewController.homeTareasControlador tomarTareas];
}

- (void) cargarHome{
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"cargarSegundaVista");
    NSLog(@"%lu", (unsigned long)_uiNavController.viewControllers.count);
    
    // Eliminamos login
    [_uiNavController popViewControllerAnimated:false];
  
    
    _contenedorHomeUIViewController = [[ContenedorHomeUIViewController alloc] inciaConSuNibYControlador_ControladorPrincipalNSObject:self];
    
    [_uiNavController pushViewController:_contenedorHomeUIViewController animated:false];
    
    [UIView transitionFromView:_inicialUINavigationController.view
                        toView:_contenedorHomeUIViewController.view
                        duration:0.7
                        options:UIViewAnimationOptionTransitionFlipFromRight
                        completion:^(BOOL finished){
                            NSLog(@"DDDD %lu", (unsigned long)_uiNavController.viewControllers.count);
                             _inicialUINavigationController = nil; // Necesario para que ARC dealloque...
                            
                            // Iniciamos carga tareas y categorías
                            [_contenedorHomeUIViewController.homeUIViewController.homeTareasControlador tomarTareas];
                            [_contenedorHomeUIViewController.menuGeneralUIViewController.categoriasControlador tomarCategorias];
                        }
    ];
}

- (void) volverPrimerVista_desdeUIViewController:(UIViewController*)desdeUIViewController{
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"volverPrimerVista");
    NSLog(@"%lu", (unsigned long)_uiNavController.viewControllers.count);
    
    // Eliminamos home
    [_uiNavController popViewControllerAnimated:false];
    
    _inicialUINavigationController = [[InicialUIViewController alloc] inciaConSuNibYControlador_ControladorPrincipalNSObject:self];
    [_uiNavController pushViewController:_inicialUINavigationController animated:false];
    
    [UIView transitionFromView:desdeUIViewController.view
                        toView: _inicialUINavigationController.view
                        duration:0.7
                        options:UIViewAnimationOptionTransitionFlipFromRight
                        completion:^(BOOL finished){
                            _contenedorHomeUIViewController = nil;
                            NSLog(@"DDDD al volver login %lu", (unsigned long)_uiNavController.viewControllers.count);
                        }
    ];
}

- (void) mostrarAlerta_msg:(NSString*)msgNSString{
    NSLog(@"%s", __FUNCTION__);
    UIAlertView *alertaUIAlertView = [[UIAlertView alloc]
                                                           initWithTitle:@""
                                                           message:msgNSString
                                                           delegate:self
                                                           cancelButtonTitle:NSLocalizedString(@"General_aceptar", nil)
                                                           otherButtonTitles:nil];
    [alertaUIAlertView show];
    
    alertaUIAlertView.delegate = self;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%s", __FUNCTION__);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"AlertaGeneralAceptada" object:nil];
    NSLog(@"NOTIFICACION LANZADA: AlertaGeneralAceptada");
}

- (void) ocultarTeclado{
    NSLog(@"%s", __FUNCTION__);
    
    App *app = (App*)[[UIApplication sharedApplication] delegate];
    [app.window endEditing:true];
}

- (void) ocultarMenuSlideAnimando{
    NSLog(@"%s", __FUNCTION__);
    
    [_contenedorHomeUIViewController cerrarMenuAnimado];
}

- (void) mostrarVistaNuevaTarea{
    NSLog(@"%s", __FUNCTION__);
    
    _nuevaTareaUIViewController = [[NuevaTarea alloc] iniciaConSuNibYControlador_ControladorPrincipalNSObject:self categoriasNSArray:_contenedorHomeUIViewController.menuGeneralUIViewController.categoriasNSArray];
    
    [_uiNavController presentViewController:_nuevaTareaUIViewController animated:YES completion:^{}];
}

- (void) cerrarVistaNuevaTarea{
    NSLog(@"%s", __FUNCTION__);
    
    [_uiNavController dismissViewControllerAnimated:true completion:^{}];
}

- (void) cerrarYRecargarTareasMasCategorias{
    NSLog(@"%s", __FUNCTION__);
    
    [_uiNavController dismissViewControllerAnimated:true completion:^{}];
    [_contenedorHomeUIViewController.homeUIViewController.homeTareasControlador tomarTareas];
    [_contenedorHomeUIViewController.menuGeneralUIViewController.categoriasControlador tomarCategorias];    
}

@end
