function [Parametros] = seleccion_parametros(Parametros, Resultado)

    param_aux=Parametros;
    
    clear Parametros;
    
    Parametros.Sujeto=param_aux.Sujeto;
    
   
    for M=1:numel(param_aux.Metodo)
        
        Metodo=param_aux.Metodo(M).Metodo;
        
        
        for i=1:numel(param_aux.Metodo(M).Ventana)
            for j=1:numel(param_aux.Metodo(M).Variable)
                aux(i,j).Ventana=param_aux.Metodo(M).Ventana(i);
                aux(i,j).Variable=param_aux.Metodo(M).Variable(j);
            end
        end
        
        better=aux(Resultado.(Metodo)==max(max(Resultado.(Metodo)))); 
        
        Parametros.Ajuste(M)=struct('Metodo',Metodo,'Variable',better.Variable,'Ventana',better.Ventana);
        
        Parametros.Indice_Fisher=Resultado;
     
  
    end
    
    
    
end