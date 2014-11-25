function [bestLayerSize, bestNumLayers, bestValPc, bestLr, bestMc, bestF1] = optParamsGDM(x, y)
  bestF1 = 0;
  for (layerSize = 40 : 15 : 85)
    for (numLayers = 1 : 3)
      for (valPc = 0.1 : 0.05 : 0.2)
        for (lr = 0.04 : 0.02 : 0.08)
          for (mc = .85 : 0.05 : .95)
            result = nFoldCrossValidationGDM(x, y, 10, layerSize, numLayers, valPc, lr, mc);
            stats = generateAllStats(result);
            if (calcMeanF1(stats) > bestF1)
              bestF1 = calcMeanF1(stats);
              bestLayerSize = layerSize;
              bestNumLayers = numLayers;
              bestValPc = valPc;
              bestLr = lr;
              bestMc = mc;
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