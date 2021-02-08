function [TA,SE,ES] = classify_comb(patrones,reg,Canales)

        comb=gen_comb({'CZ'},Canales);
        
        
        for C=1:numel(comb)
            
            pat=concat_comb(patrones,Canales,comb(C).comb);

            [TA(C), SE(C), ES(C)] = classificare(pat,reg);
            
        end
  

end