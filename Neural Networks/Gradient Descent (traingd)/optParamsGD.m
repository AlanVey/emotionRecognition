function [bestLayerSize, bestNumLayers, bestValPc, bestLr, bestF1] = optParamsGD(x, y)
  bestF1 = 0;
  numLayers = 3;
  valPc = 0.1;
  lr = 0.05;
  
  for (layerSize = 45 : 100)
    result = nFoldCrossValidationGD(x, y, 10, layerSize, numLayers, valPc, lr);
    stats = generateAllStats(result);
    if (calcMeanF1(stats) > bestF1)
      bestF1 = calcMeanF1(stats);
      bestLayerSize = layerSize;
    end
  end
  bestF1 = 0;
  
  for (numLayers = 1 : 5)
    result = nFoldCrossValidationGD(x, y, 10, bestLayerSize, numLayers, valPc, lr);
    stats = generateAllStats(result);
    if (calcMeanF1(stats) > bestF1)
      bestF1 = calcMeanF1(stats);
      bestNumLayers = numLayers;
    end
  end
  bestF1 = 0;
  
  for (valPc = 0.05 : 0.01 : 0.20)
    result = nFoldCrossValidationGD(x, y, 10, bestLayerSize, bestNumLayers, valPc, lr);
    stats = generateAllStats(result);
    if (calcMeanF1(stats) > bestF1)
      bestF1 = calcMeanF1(stats);
      bestValPc = valPc;
    end
  end
  bestF1 = 0;
  
  for (lr = 0.01 : 0.01 : 0.1)
    result = nFoldCrossValidationGD(x, y, 10, bestLayerSize, bestNumLayers, bestValPc, lr);
    stats = generateAllStats(result);
    if (calcMeanF1(stats) > bestF1)
      bestF1 = calcMeanF1(stats);
      bestLr = lr;
    end
  end
end

function [meanF1] = calcMeanF1(stats)
  meanF1 = 0;
  for (i = 1 : length(stats))
    meanF1 = meanF1 + (stats(i).f1 / length(stats));
  end
end