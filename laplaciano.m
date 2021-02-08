function [L1,L2] = laplaciano(C1,C2,canales,tipo)


    [~,idcz,~] = intersect(lower([canales]),lower({'Cz'})); 

    switch tipo
        
        case 'espacial'
            
          canales = struct('labels',canales); 
    
          load('ubicacion_electrodos.mat'); 
  
          [~,idx_in_locdb,idx_in_res] = intersect(lower({channel_pos.labels}),lower({canales.labels}));

          for fname = fieldnames(channel_pos)'
                        [chanlocs(idx_in_res).(fname{1})] = channel_pos(idx_in_locdb).(fname{1}); end

                   
          vecinos=numel(canales);
    
          ok = find(~(cellfun('isempty',{chanlocs.X}) | cellfun('isempty',{chanlocs.Y}) | cellfun('isempty',{chanlocs.Z})));
          [px,py] = cart2sph([chanlocs(ok).Z],[chanlocs(ok).X],[chanlocs(ok).Y]);
    
    
           M = zeros(length(ok));
            for c=1:length(ok)
                v = [px(c)-px; py(c)-py];
                [ang,dst] = deal((180/pi)*(pi+atan2(v(1,:),v(2,:))), sqrt(v(1,:).^2+v(2,:).^2));
                for s = 1:vecinos
                        validchns = find(within(ang, 360*(s-1.5)/vecinos, 360*(s-0.5)/vecinos) & c~=(1:length(ok)));
                        [dummy,idx] = min(dst(validchns)); %#ok<ASGLU>
                        if ~isempty(idx)
                            M(c,validchns(idx)) = 1; end
                end
            end
    
    
            M = (eye(length(ok)) - normrow(M));
    
            L1(ok,:,:) = reshape(M*reshape(C1(ok,:,:),length(ok),[]),length(ok),size(C1,2),size(C1,3));
        
            L2(ok,:,:) = reshape(M*reshape(C2(ok,:,:),length(ok),[]),length(ok),size(C2,2),size(C2,3));
    
   
            L1=L1(idcz,:,:);    L2=L2(idcz,:,:);
            
            
        case 'promedio'
                
            [~,idchan,~] = intersect(lower([canales]),lower({'F3','F4','C3','C4','Pz'}));
  
            L1(1,:,:)=C1(idcz,:,:)-(sum(C1(idchan,:,:))/5);
            L2(1,:,:)=C2(idcz,:,:)-(sum(C2(idchan,:,:))/5);
            
    end
        
          
                                      
                    
end


function tf = within(x,a,b)
if b<a b = b+360; end
tf = (x>=a & x<b) | ((x+360)>=a & (x+360)<b) | ((x-360)>=a & (x-360)<b);
end


function X = normrow(X)

C = size(X,2);
if C == 1
    X = X ./ abs(X);
else
    X = sqrt(ones./(sum(X.*X,2)'))'*ones(1,C).*X;
end
end




