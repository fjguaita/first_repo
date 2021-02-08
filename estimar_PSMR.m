function [C1, C2] = estimar_PSMR(Clase1,Clase2,param,FS,metodo)

  
        C1=zeros(size(Clase1,1),2,size(Clase1,3));  C2=C1;

        switch metodo
            
            case 'Welch'
                                                    
                   for R=1:size(Clase1,3)
                        
                       PSD=(pwelch(Clase1(:,:,R)',FS/2,param,[],FS))';
                       C1(:,:,R)=[mean(PSD(:,9:13),2), mean(PSD(:,19:31),2)];
                
                       PSD=(pwelch(Clase2(:,:,R)',FS/2,param,[],FS))';
                       C2(:,:,R)=[mean(PSD(:,9:13),2), mean(PSD(:,19:31),2)];               
                   end
                   
                   
            case 'Yule'
                    
                  for R=1:size(Clase1,3)
                        
                      PSD=(pyulear(Clase1(:,:,R)',param,[],FS))';
                      C1(:,:,R)=[mean(PSD(:,9:13),2), mean(PSD(:,19:31),2)];
                     
                      PSD=(pyulear(Clase2(:,:,R)',param,[],FS))';
                      C2(:,:,R)=[mean(PSD(:,9:13),2), mean(PSD(:,19:31),2)];
                  end
                         
       
                  
             case 'Burg'
                
                 for R=1:size(Clase1,3)
                        
                      PSD=(pburg(Clase1(:,:,R)',param,[],FS))';
                      C1(:,:,R)=[mean(PSD(:,9:13),2), mean(PSD(:,19:31),2)];
                     
                      PSD=(pburg(Clase2(:,:,R)',param,[],FS))';
                      C2(:,:,R)=[mean(PSD(:,9:13),2), mean(PSD(:,19:31),2)];
                 end
     
         
        end
        
         
end