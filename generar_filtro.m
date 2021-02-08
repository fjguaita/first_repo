function generar_filtro(filtro)


    switch  filtro
        
            case 0
             
                Filtro=[];
             
            case 1
     
                Filtro=designfilt('bandpassfir', 'StopbandFrequency1', 1,...
                    'PassbandFrequency1', 8, 'PassbandFrequency2', 30, 'StopbandFrequency2', 40,...
                    'StopbandAttenuation1', 40, 'PassbandRipple', 0.75, 'StopbandAttenuation2', 40,...
                    'SampleRate', 256);
                
              
            case 2
              
                Filtro=designfilt('bandpassiir', 'StopbandFrequency1', 1, 'PassbandFrequency1', 6,...
                    'PassbandFrequency2', 32, 'StopbandFrequency2', 40, 'StopbandAttenuation1', 60,...
                    'PassbandRipple', 1, 'StopbandAttenuation2', 60, 'SampleRate', 256, 'DesignMethod',...
                    'cheby2', 'MatchExactly', 'passband');
                  
    end
    
    save('Filtro.mat','Filtro');
        
end