function [Conc]=concat(pat,channel,sel_channel)

        carac=size(pat,2);
        
        if isempty(channel) && isempty(sel_channel)
            
            idx=1; idxn=1;
            
        else
            
            [found,idx,idxn] = intersect(lower([channel]),lower([sel_channel]));
            
        end


        
        Conc=zeros(size(pat,3),(carac*numel(idx)));
        
        
        
        for i=1:numel(idx)
            
            Conc(:,carac*(idxn(i)-1)+1:carac*idxn(i))=squeeze(pat(idx(i),:,:))';
                        
        end
        
                        
                  

end