function [clase1, clase2] = partitione(eeg,duracion,marcadores)

    
        FS=eeg.Frec_muestreo;   blanking=FS/2;
    
        reg=numel(cell2mat(strfind(fieldnames(eeg),'signal')));
        
        mark1=marcadores.codigo{1};    mark2=marcadores.codigo{2}; 
                         
        sample_bounds = round(duracion*FS);
                
        clase1=[];  clase2=[];  

        
        for N=1:reg
                                   
            signal=eeg.(['signal_' num2str(N)]);
            cod_act=eeg.(['codigo_' num2str(N)]);
            
              
            latency=[1 find(diff(max(cod_act)-cod_act)) find(diff(cod_act))];  latency=sort(latency);
            
            if find(mark1==0),          lat1=[1 find(diff(max(cod_act)-cod_act))];    lat2=[];
                
                for i=1:numel(mark2),    lat2=[lat2 find(mark2(i)==diff(cod_act))];    end;   lat2=sort(lat2);
                
            elseif find(mark2==0),      lat2=[1 find(diff(max(cod_act)-cod_act))];    lat1=[];
                
                for i=1:numel(mark1),    lat1=[lat1 find(mark1(i)==diff(cod_act))];    end;   lat1=sort(lat1);
                
            else,    lat1=find(mark1==diff(cod_act));    lat2=find(mark2==diff(cod_act));
            
            end
      
            select_mask1=false(1,size(signal,2));
            select_mask2=false(1,size(signal,2));
            
            for i=1:numel(latency)-1

                                
                if find([lat1]==latency(i))  
                        begin=randi([latency(i+1)-2.5*FS latency(i+1)-sample_bounds-blanking],1);
                        %poner 2 en vez de 2.5 y borrar blanking para
                        %volver a lo de antes
                        sample_range = begin-80:begin+sample_bounds-1;
                        select_mask1(sample_range)=true;
                                    
                elseif find([lat2]==latency(i))  
                        
                        begin=randi([latency(i)+blanking latency(i+1)-sample_bounds],1);
                        sample_range = begin-80:begin+sample_bounds-1;
                        select_mask2(sample_range)=true;
                end
                
            end
            
            inter1=reshape(find(diff([false select_mask1 false])),2,[])';     inter1(:,2) = inter1(:,2) - 1;
            
            inter2=reshape(find(diff([false select_mask2 false])),2,[])';     inter2(:,2) = inter2(:,2) - 1;
            
            clase1=cat(3,clase1,particion(signal,inter1));
            clase2=cat(3,clase2,particion(signal,inter2));
            
            
        end
                
   
end



function [new_signal]=particion(signal,intervalo)

    for k=1:size(intervalo,1)
         samplerange{k} = intervalo(k,1):intervalo(k,2); 
    end

    for k=1:size(samplerange,2)
        new_signal(:,:,k)=signal(:,samplerange{k}(1):samplerange{k}(end));
    end

end