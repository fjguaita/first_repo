function [TA,SE,ES] = classificare(patrones,C)

      
    TA=zeros(size(patrones,2),1);
   % SE=zeros(size(patrones,2),1);
   % ES=zeros(size(patrones,2),1);

    
               
            cant=size(patrones(1).C1,1)/C;
        
            comb=combntns([1:C],C-1);
            compl=sort([1:C],'descend');
            
            Ltrain_1=zeros(size(patrones(1).C1,1)-cant,1);
            Ltrain_2=ones(size(patrones(1).C2,1)-cant,1);
            
            Ltest_1=zeros(cant,1);
            Ltest_2=ones(cant,1);
            
            
            for P=1:size(patrones,2)
                
                Clase_1=patrones(P).C1;     Clase_2=patrones(P).C2;
         
                Acierto = zeros(size(comb,1),1);
              %  Sens = zeros(size(comb,1),1);
               % Espec = zeros(size(comb,1),1);
            
                for CV=1:size(comb,1)
                
                    C1=[];  C2=[];
                
                    for ind=1:size(comb,2)
                    
                        C1=cat(1,C1,Clase_1(cant*(comb(CV,ind)-1)+1:comb(CV,ind)*cant,:));
                        C2=cat(1,C2,Clase_2(cant*(comb(CV,ind)-1)+1:comb(CV,ind)*cant,:));
                    end
                
                    T1=Clase_1(cant*(compl(CV)-1)+1:compl(CV)*cant,:);
                    T2=Clase_2(cant*(compl(CV)-1)+1:compl(CV)*cant,:);
                
                    Train = prdataset([C1;C2],[Ltrain_1;Ltrain_2]);
                    Train = setprior(Train,getprior(Train,0)); 
                
                    Test = prdataset([T1;T2],[Ltest_1;Ltest_2]);
                    Test = setprior(Test,getprior(Test,0)); 
                                    
                    [e,error] = testc(Test,Train*{fisherc});
                    error=cell2mat(error);

                  %  FN=error(1);    VP=size(T1,1) - FN;
                  %  FP=error(2);    VN=size(T1,1) - FP;
                    
                 
                    Acierto(CV)=1-cell2mat(e);      
                  %  Sens(CV)=VP/(VP+FN);
                  %  Espec(CV)=VN/(VN+FP);   
                               
                                
                end
     
                TA(P) = mean(Acierto);    % SE(P) = mean(Sens);      ES(P) = mean(Espec);
                
            
            end
            
   

end