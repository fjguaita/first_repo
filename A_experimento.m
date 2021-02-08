clearvars;
close all;

Parametros.Experimento=2;               % 1-> ajuste de parametros     2-> Cz y laplaciano     3-> seleccion de canales

%generar_filtro(1);                     % 0=sin filtro      1=FIR        2=IIR

Parametros.Repet=24;                    % cantidad de repeticiones de segmentación aleatoria

Parametros.Sujeto=1;                    % elegir sujeto



switch Parametros.Experimento
 
    case 1
        
            Parametros.Metodo(1)=struct('Metodo','Welch','Variable',50,'Ventana',[0.5 0.75 1 1.25 1.5]);    
            %50 es solapamiento método Welch

            Parametros.Metodo(2)=struct('Metodo','Burg','Variable',1:10,'Ventana',[0.5 0.75 1 1.25 1.5]); 
            %orden del modelo AR

            %ventana es la duración del trial de EEG en segundos
        
            
            Resultado=principal(Parametros);
            Valores=seleccion_parametros(Parametros, Resultado);
            nombre=['Sujeto' num2str(Parametros.Sujeto) '_AjPar.mat'];
            save(nombre,'Valores');
       
      
    case 2
       
            load(['Sujeto' num2str(Parametros.Sujeto) '_AjPar.mat']);
            Parametros.Metodo=Valores.Ajuste;
            Resultado=principal(Parametros);
            nombre=['Sujeto' num2str(Parametros.Sujeto) '_SingleChannel.mat'];
            save(nombre,'Resultado');


    case 3
     
    
            load(['Sujeto' num2str(Parametros.Sujeto) '_AjPar.mat']);
            Parametros.Metodo=Valores.Ajuste;
            Resultado=principal(Parametros);
        
                %posicion 24 -> C3 C4 Cz
        
    
        
end



clear nombre;

