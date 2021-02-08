function [F] = fisher_criterion(patrones,modo)


    %modo - >  1:   separación entre clases
    %          2:   discriminabilidad de cada característica 
    
    C1=[];  C2=[];

    for i=1:size(patrones,2)
            
        C1=cat(1,C1,patrones(i).C1);
        C2=cat(1,C2,patrones(i).C2);
    end

    switch modo
        
        case 1
            
            F=(norm(mean(C1)-mean(C2),2)^2)/(trace(cov(C1))+trace(cov(C2)));
            
        case 2
            
            template=true(1,size(C1,2));
    
     
            for ind=1:numel(template)
                
                FC(ind)=(norm((mean(C1(:,template))-mean(C2(:,template))),2)^2)/(trace(cov(C1(:,template)))...
                    +trace(cov(C2(:,template))));
                
                F(ind).template=template;
    
                for f=1:size(C1,2)
            
                    if template(f),  Fcar(f)=((mean(C1(:,f))-mean(C2(:,f)))^2)/(var(C1(:,f))^2+var(C2(:,f))^2);
                
                    else,      Fcar(f)=1000000000;
                    end
                end
                    
                template(Fcar==min(min(Fcar)))=false;
           
    
            end
            
            F=F(FC==(max(max(FC)))).template;
            
           
    end
    
end