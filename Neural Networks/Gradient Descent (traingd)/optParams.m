function [bestLayerSize, bestNumLayers, bestValPc, bestLr] = optParams(x, y)
  bestF1 = 0;
  for (layerSize = 45 : 100)
    for (numLayers = 1 : 5)
      for (valPc = 5 : 20)
        for (lr = 1 : 200)
          result = nFoldCrossValidation(x, y, 10, layerSize, numLayers, valPc / 100, lr / 1000);
          stats = generateAllStats(result);
          if (calcMeanF1(stats) > bestF1)
            bestF1 = calcMeanF1(stats);
            bestLayerSize = layerSize;
            bestNumLayers = numLayers;
            bestValPc = valPc;
            bestLr = lr;
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