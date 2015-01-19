function [bestParam] = optParamsRP(x, y)
bestF1 = 0;
for (layerSize = 6 : 45)
    for (numLayers = 1 : 3)
        for (valPc = 0.05 : 0.03 : 0.20)
            for (delt_inc = 1.1 : 0.05 :1.4)    %typical 1.2
                for (delt_dec = 0.4 : 0.05 :0.6)  %typical 0.5
                    result = nFoldCrossValidationRP(x, y, 10, layerSize, numLayers, valPc , delt_inc, delt_dec);
                    stats = generateAllStats(result);
                    
                    if (calcMeanF1(stats) > bestF1)
                        bestF1 = calcMeanF1(stats);
                        bestLayerSize = layerSize;
                        bestNumLayers = numLayers;
                        bestValPc = valPc;
                        bestDelt_inc = delt_inc;
                        bestDelt_dec = delt_dec;
                    end
                end
            end
        end
    end
end
bestParam = [bestLayerSize, bestNumLayers, bestValPc, bestDelt_inc, bestDelt_dec, bestF1];
end


function [meanF1] = calcMeanF1(stats)
  meanF1 = 0;
  for (i = 1 : length(stats))
    meanF1 = meanF1 + (stats(i).f1 / length(stats));
  end
end

