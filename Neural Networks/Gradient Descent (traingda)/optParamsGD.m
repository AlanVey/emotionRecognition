function [bestLayerSize, bestNumLayers, bestValPc, bestLr, bestLr_inc, bestLr_dec, bestF1] = optParamsGD(x, y)
  bestF1 = 0;
  for (layerSize = 40 : 15 : 85)
    for (numLayers = 1 : 3)
      for (valPc = 0.1 : 0.05 : 0.2)
        for (lr = 0.04 : 0.02 : 0.08)
          for (lr_inc = 1.0 : 0.05 :1.1)
            for (lr_dec = 0.65 : 0.05 :0.75)  
              result = nFoldCrossValidationGD(x, y, 10, layerSize, numLayers, valPc, lr, lr_inc, lr_dec);
              stats = generateAllStats(result);
              if (calcMeanF1(stats) > bestF1)
                bestF1 = calcMeanF1(stats);
                bestLayerSize = layerSize;
                bestNumLayers = numLayers;
                bestValPc = valPc;
                bestLr = lr;
                bestLr_inc = lr_inc; 
                bestLr_dec = lr_dec;
              end
            end
          end
        end
      end
    end
  end
end

function [meanF1] = calcMeanF1(stats)
  meanF1 = 0;
  for (i = 1 : length(stats))
    meanF1 = meanF1 + (stats(i).f1 / length(stats));
  end
end