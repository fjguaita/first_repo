function [Resultado] = principal(Parametros)

 
   marcadores.clases={'Descanso','Pie'};
   marcadores.codigo={0,[1 2]};

   [eeg,reg]=carga_registro(Parametros.Sujeto); 

   Features.FS=eeg.Frec_muestreo;
   Features.Canales=eeg.Canales;
   Features.Laplaciano=false;
   
           
   
   switch Parametros.Experimento
       
        
       case 1
           
           for M=1:numel(Parametros.Metodo)
               
               Features.Metodo=Parametros.Metodo(M).Metodo;
           
               for V=1:numel(Parametros.Metodo(M).Ventana)
                   
                   duracion=Parametros.Metodo(M).Ventana(V);
                   Features.Variable=Parametros.Metodo(M).Variable;
                                      
                   parfor R=1:Parametros.Repet
                                         
                        [C1, C2] = partitione(eeg,duracion,marcadores);
                        patrones(:,R) = conformar_patron(C1,C2,Features);
                        
                   end
                   
                   for P=1:numel(Features.Variable)
                       
                       F(V,P) = fisher_criterion(patrones(P,:),1);
                       
                   end
                   clear patrones;
               end
               
               Resultado.(Features.Metodo)=F;
               
           end
           
           
           
           
        case 2
           
           Features.Laplaciano=true;
            
           for M=1:numel(Parametros.Metodo)
               
               Features.Metodo=Parametros.Metodo(M).Metodo;
               duracion=Parametros.Metodo(M).Ventana;
               Features.Variable=Parametros.Metodo(M).Variable;
               
               
               parfor R=1:Parametros.Repet
                                         
                        [C1, C2] = partitione(eeg,duracion,marcadores);
                        patrones = conformar_patron(C1,C2,Features);
                        TA(R,:) = classificare(patrones,reg);
               end
               
               TA=mean(TA);               
               Resultado(M)=struct('Metodo',(Features.Metodo),'TA_cz',TA(1),'TA_lap',TA(2));
                           
           end    
           
           
           
           
       case 4
           
           for M=1:numel(Parametros.Metodo)
           
               Features.Metodo=Parametros.Metodo{M};
                
               Features.Variable=Parametros.(Features.Metodo).Variable;
               duracion=Parametros.(Features.Metodo).Ventana;
               
                             
               parfor R=1:Parametros.Repet
                        
                   [C1, C2] = partitione(eeg,duracion,marcadores);
                   patrones = conformation(C1,C2,Features);
                   [TA(:,R),SE(:,R),ES(:,R)] = classify_comb(patrones,reg,Features.canales);
                   
               end
                       
                                      
               Resultado.(Features.Metodo) = [mean(TA,2)'; mean(SE,2)'; mean(ES,2)'];
                        
               clear TA SE ES;

              
           end
   end
          
end