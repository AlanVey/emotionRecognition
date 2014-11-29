function [results] = ttestCBC(x, y, folds)  
  DT_stats  = generateAllStatsNFolds(nFoldCrossValidationDT(x, y, folds));
  NN_stats  = generateAllStatsNFolds(nFoldCrossValidationNN(x, y, folds));
  CBR_stats = generateAllStatsNFolds(nFoldCrossValidationCBR(x, y, folds));
  
  for i = 1:folds
    tmp_DT  = 1 - [DT_stats(i).classes.classRate];
    tmp_NN  = 1 - [NN_stats(i).classes.classRate];
    tmp_CBR = 1 - [CBR_stats(i).classes.classRate];
    for j = 1:6
      DT(j, i)  = tmp_DT(j);
      NN(j, i)  = tmp_NN(j);
      CBR(j, i) = tmp_CBR(j);
    end
  end
  
  alpha = 0.05;
  alpha = alpha / 3; % multiple comparisons test
  
  for i = 1:6
    [results(i, 1, 1), results(i, 1, 2)] = ttest(DT(i, :), NN(i, :), 'Alpha', alpha);
    [results(i, 2, 1), results(i, 2, 2)] = ttest(DT(i, :), CBR(i, :), 'Alpha', alpha);
    [results(i, 3, 1), results(i, 3, 2)] = ttest(CBR(i, :), NN(i, :), 'Alpha', alpha);
  end
end

