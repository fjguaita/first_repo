function [PAT]=concat_comb(patrones,channel,sel_channel)


    [~,idx,idxn] = intersect(lower([channel]),lower([sel_channel]));

    for R=1:size(patrones,1)
        
        for p=1:size(patrones,2)
            
                p1=patrones(R,p).C1;
                p2=patrones(R,p).C2;
  
                carac=size(p1,2)/numel(channel);
                C1=zeros(size(p1,1),(carac*numel(idx)));    C2=C1;

                for i=1:numel(idx)
                    C1(:,carac*(idxn(i)-1)+1:carac*idxn(i))=p1(:,carac*(idx(i)-1)+1:carac*idx(i));
                    C2(:,carac*(idxn(i)-1)+1:carac*idxn(i))=p2(:,carac*(idx(i)-1)+1:carac*idx(i));
                end
                
                PAT(R,p).C1=C1;  PAT(R,p).C2=C2;
                clear C1 C2 p1 p2 carac;
        
        end
                    
                  
    end
end