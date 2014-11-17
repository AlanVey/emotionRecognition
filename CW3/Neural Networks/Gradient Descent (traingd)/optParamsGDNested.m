function [bestLayerSize, bestNumLayers, bestValPc, bestLr, bestF1] = optParamsGDNested(x, y)
  bestF1 = 0;
  remainingIterations = 216;
  completedIterations = 0;
  averageTime = 0;
  
  for (layerSize = 40 : 15 : 85)
    for (numLayers = 1 : 3)
      for (valPc = 0.1 : 0.02 : 0.2)
        for (lr = 0.04 : 0.02 : 0.08)
          tic;
          result = nFoldCrossValidationGD(x, y, 10, layerSize, numLayers, valPc, lr);
          stats = generateAllStats(result);
          if (calcMeanF1(stats) > bestF1)
            bestF1 = calcMeanF1(stats);
            bestLayerSize = layerSize;
            bestNumLayers = numLayers;
            bestValPc = valPc;
            bestLr = lr;
          end
          time = toc;
          averageTime = (averageTime * completedIterations) + time;
          remainingIterations = remainingIterations - 1;
          completedIterations = completedIterations + 1;
          averageTime = averageTime / completedIterations;
          remainingDays = averageTime * remainingIterations / (60 * 60 * 24);
          text = ['Remaining: ', num2str(remainingIterations), ', remaining time: ', datestr(remainingDays, 'HH:MM:SS')];
          disp(text);
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