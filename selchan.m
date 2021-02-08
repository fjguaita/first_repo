function [c1,c2]=selchan(C1,C2,channel,sel_channel)


    [found,idx,idxn] = intersect(lower([channel]),lower([sel_channel]));
    
    c1(idxn,:,:)=C1(idx,:,:);
    c2(idxn,:,:)=C2(idx,:,:);


end
