function [results] = ttest(x, y, folds)
  load('network.mat');
  load('Trees.mat');

  trees = [ATree, BTree, CTree, DTree, ETree, FTree];
  
  DT_stats  = generateAllStatsNFolds(nFoldCrossValidationDT(x, y, folds, trees));
  NN_stats  = generateAllStatsNFolds(nFoldCrossValidationNN(x, y, folds, net));
  CBR_stats = generateAllStatsNFolds(nFoldCrossValidationCBR(x, y, folds));
  
  for i = 1:folds
    DT_stats(i)  = (1 - [DT_stats(i).classes.classRate])';
    NN_stats(i)  = (1 - [NN_stats(i).classes.classRate])';
    CBR_stats(i) = (1 - [CBR_stats(i).classes.classRate])';
  end
  
  alpha = 0.05;
  alpha = alpha / 3; % multiple comparisons test
  
  for i = 1:folds
    results(i, 1) = ttest(DT_stats, NN_Stats, 'Alpha', alpha);
    results(i, 2) = ttest(DT_stats, CBR_Stats, 'Alpha', alpha);
    results(i, 3) = ttest(CBR_stats, NN_Stats, 'Alpha', alpha);
  end
end

