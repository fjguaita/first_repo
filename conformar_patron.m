function [patrones] = conformar_patron(C1,C2,Features)


        if Features.Laplaciano
                 
               [L1,L2] = laplaciano(C1,C2,Features.Canales,'promedio'); 
        end
        
        load('Filtro.mat');
        
        
        if isempty(Filtro)

            C1=C1(:,81:end,:);      C2=C2(:,81:end,:);
            
            if Features.Laplaciano
                L1=L1(:,81:end,:);      L2=L2(:,81:end,:);
            end
            
        else
             
            C1=filter(Filtro,C1);       C1=C1(:,81:end,:);
            C2=filter(Filtro,C2);       C2=C2(:,81:end,:);
            
            if Features.Laplaciano
                L1=filter(Filtro,L1);       L1=L1(:,81:end,:);
                L2=filter(Filtro,L2);       L2=L2(:,81:end,:);  
            end
               
        end
          
    
           

        for P=1:numel(Features.Variable)
            
            VAR=Features.Variable(P);  ind=1;

                
            [Cz1,Cz2]=selchan(C1,C2,Features.Canales,{'CZ'});
                
            [c1, c2] = estimar_PSMR(Cz1,Cz2,VAR,Features.FS,Features.Metodo);

                
            patrones(P,ind).C1=squeeze(c1)';
            patrones(P,ind).C2=squeeze(c2)';
                
            ind=ind+1;
            
            
            if Features.Laplaciano
     
                [c1, c2] = estimar_PSMR(L1,L2,VAR,Features.FS,Features.Metodo);
                        
                patrones(P,ind).C1=squeeze(c1)';
                patrones(P,ind).C2=squeeze(c2)';                
      
            end
                
                

         end
               
                
  
   
end