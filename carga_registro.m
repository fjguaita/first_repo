function [eeg,reg]=carga_registro(sujeto)


    archivo={};        

    for R=1:5
        if exist(['Registros\Sujeto' int2str(sujeto) 'R' int2str(R) '.dat'],'file')
            archivo = [archivo ['Registros\Sujeto' int2str(sujeto) 'R' int2str(R) '.dat']];
        end
    end

      
    eeg=[]; reg=numel(archivo);
    
    for i=1:reg
        
        if exist(archivo{i},'file')
        
              [signal, states, parameters] = load_bcidat(archivo{i});
              eeg.(['signal_' num2str(i)]) = double (signal');
              eeg.(['codigo_' num2str(i)])= states.StimulusCode';
 
              frec_muestreo(i)=parameters.SamplingRate.NumericValue;
              channel{i}= strjoin(parameters.ChannelNames.Value);
              canales=parameters.ChannelNames.Value';

        
                    
        end
    
    end   
    
    

    frec_muestreo=unique(frec_muestreo);
    channel=unique(channel);
    
    
    eeg.Frec_muestreo=frec_muestreo;
    eeg.Canales=canales;
    
             
            

end
