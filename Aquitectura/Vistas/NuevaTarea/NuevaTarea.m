//
//  NuevaTarea.m
//  Aquitectura
//
//  Created by Carlos Peralta on 8/9/15.
//  Copyright (c) 2015 Eduardo Pujol. All rights reserved.
//

#import "NuevaTarea.h"
#import "CategoriaDTO.h"
#import "TareaDTO.h"
#import "NuevaTareaControlador.h"

@interface NuevaTarea () <UIPickerViewDelegate>
@property (nonatomic, retain) ControladorPrincipalNSObject *controladorPrincipalRefNSObject;
@property (nonatomic, retain) NSArray *categoriasNSArray;
@property (nonatomic, retain) NuevaTareaControlador *nuevaTareaControlador;


@end

@implementation NuevaTarea

- (id)iniciaConSuNibYControlador_ControladorPrincipalNSObject:(ControladorPrincipalNSObject*)controladorPrincipalNSObject categoriasNSArray:(NSArray*)categoriasNSArray{
    NSLog(@"%s", __FUNCTION__);
    
    _controladorPrincipalRefNSObject = controladorPrincipalNSObject;
    _categoriasNSArray = categoriasNSArray;
    _nuevaTareaControlador = [[NuevaTareaControlador alloc] init_nuevaTareaUIViewController:self];
    
    _categoriaNuevaCategoriaDTO = nil;
    _tareaNuevaTareaDTO = nil;
    
    
    
    
    [self agregarNuevaCategoriaItem];
   
   
    
    return [self initWithNibName:@"NuevaTarea" bundle:nil];
}

- (void) cerrarYRecargarTareasMasCategorias{
    NSLog(@"%s", __FUNCTION__);
    
    [_controladorPrincipalRefNSObject cerrarYRecargarTareasMasCategorias];
}

- (IBAction)cerrarVentanaNuevaTareaUIButton_presionado:(id)sender {
     NSLog(@"%s", __FUNCTION__);

    [_controladorPrincipalRefNSObject cerrarVistaNuevaTarea];
}

- (IBAction)agregarTareaUIButton_presionado:(id)sender {
    NSLog(@"%s", __FUNCTION__);
    
    if (_nuevaCategoriaUITextField.text.length > 0) {
        _categoriaNuevaCategoriaDTO = [[CategoriaDTO alloc] init];
        _categoriaNuevaCategoriaDTO.categoriaNombreNSString = _nuevaCategoriaUITextField.text;
        _categoriaNuevaCategoriaDTO.idCategoriaInt = -1;
    }else{
        _categoriaNuevaCategoriaDTO = _categoriasNSArray[[_categoriaUIPickerView selectedRowInComponent:0]];
    }
    
    _tareaNuevaTareaDTO = [[TareaDTO alloc ] init];
    _tareaNuevaTareaDTO.tareaNSString = _nuevaTareaUITextField.text;
    _tareaNuevaTareaDTO.idCategoriaParaEstaTareaInt = _categoriaNuevaCategoriaDTO.idCategoriaInt;
    
    [_nuevaTareaControlador agregarTareaAccionRequerida];
}

- (void)viewDidLoad {
    NSLog(@"%s", __FUNCTION__);
    
    [super viewDidLoad];
    
    _nuevaCategoriaUITextField.hidden = true;
    _categoriaUIPickerView.delegate = self;
    _cargardorSobreAgregarUIActivityIndicatorView.hidden = true;
}

- (void) viewDidAppear:(BOOL)animated{
    NSLog(@"%s", __FUNCTION__);
    
    [_nuevaTareaUITextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    NSLog(@"%s", __FUNCTION__);
    
    [super didReceiveMemoryWarning];
}

- (void) agregarNuevaCategoriaItem{
    NSLog(@"%s", __FUNCTION__);
    
    NSMutableArray *categoriasConTodasNSMutableArray = [[NSMutableArray alloc] init];
   
    // Saca  todas...
    for (int i=1; i<[_categoriasNSArray count]; i++) {
        [categoriasConTodasNSMutableArray addObject:[_categoriasNSArray objectAtIndex:i]];
    }
    
    CategoriaDTO *categoriaDTO = [[CategoriaDTO alloc] init];
    categoriaDTO.idCategoriaInt = -1;
    categoriaDTO.categoriaNombreNSString = @"-Nueva-";
    [categoriasConTodasNSMutableArray addObject:categoriaDTO];
    
    _categoriasNSArray = categoriasConTodasNSMutableArray;
}

- (void)dealloc{
    NSLog(@"%s", __FUNCTION__);
}


- (void) bloquearComponentesYMostrarCargadorSobreBtnAgregar{
    _nuevaCategoriaUITextField.enabled = false;
    _nuevaTareaUITextField.enabled = false;
    _categoriaUIPickerView.userInteractionEnabled = false;
    _agregarNuevaTareaUIButton.hidden = true;
    
    _cargardorSobreAgregarUIActivityIndicatorView.hidden = false;

}


#pragma mark -
#pragma mark UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    NSLog(@"%s", __FUNCTION__);
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSLog(@"%s", __FUNCTION__);
    
    return [_categoriasNSArray count];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSLog(@"%s", __FUNCTION__);
    
    if (row == ([_categoriasNSArray count]-1)) {
        _nuevaCategoriaUITextField.hidden = false;
    }else{
        _nuevaCategoriaUITextField.hidden = true;
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    NSLog(@"%s", __FUNCTION__);
    
    UILabel *vista = (UILabel*)view;
    if (!vista) {
        vista = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView rowSizeForComponent:component].width, [pickerView rowSizeForComponent:component].height)];
    }
    
    vista.font = [UIFont systemFontOfSize:14];
    
    CategoriaDTO *categoriaDTO = (CategoriaDTO*)[_categoriasNSArray objectAtIndex:row];
    vista.text = categoriaDTO.categoriaNombreNSString;
    vista.textAlignment = NSTextAlignmentCenter;
    
    return vista;
}

@end
