function [bestLayerSize, bestNumLayers, bestValPc, bestLr] = optParams(x2, y2)
  bestF1 = 0;
  for (tempLayerSize = 45 : 100)
    for (numLayers = 1 : 5)
      for (valPc = 5 : 20)
        for (lr = 1 : 200)
          result = nFoldCrossValidation(x2, y2, 10, layerSize, numLayers, valPc / 100, lr / 1000);
          stats = generateAllStats(result);
          if (stats.f1 > bestF1)
            bestF1 = stats.f1;
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

