function [combinacion]=gen_comb(principal,canales)

        
        %[found,idx,idxn] = intersect(lower({'T8','T7'}),lower([canales]));

       % if ~isempty(idxn),   canales(idxn)=[];   end

        combinacion=[];
        
        [found,idx,idxn] = intersect(lower([principal]),lower([canales]));
        
        if ~isempty(idxn),   canales(idxn)=[];   end
                
        combinacion(end+1).comb = principal;
        
        for i=1:numel(canales)
        
            Z=combntns(canales,i);  
            
            for i=1:size(Z,1),   combinacion(end+1).comb=[principal {Z{i,:}}]; end
            
        end
        


end