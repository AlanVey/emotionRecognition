function [stats] = generateAllStats(predictions, actual)
  totalConfusion = zeros(6,6);
  for (i = 1 : length(predictions))
    foldConfusion = generateConfusion(predictions{i,1}, actual{i,1});
    totalConfusion = totalConfusion + foldConfusion;
  end
  rawStats = calculateStats(totalConfusion);
  stats = averageCVCR(rawStats);
end

function [CVCR] = averageCVCR(stats)
  CVCR = repmat(struct('recall', 0, 'precision', 0, 'f1', 0, 'classRate', 0), length(stats(1).classes), 1);
  for (i = 1 : length(stats(1).classes))
    S = struct('recall', 0, 'precision', 0, 'f1', 0, 'classRate', 0);
    for (j = 1 : length(stats))
      S.recall = S.recall + (stats(j).classes(i).recall / length(stats));
      S.precision = S.precision + (stats(j).classes(i).precision / length(stats));
      S.f1 = S.f1 + (stats(j).classes(i).f1 / length(stats));
      S.classRate = S.classRate + (stats(j).classes(i).classRate / length(stats));
    end
    CVCR(i) = S;
  end
end

function [stats] = calculateStats(confusion)
  numClasses = size(confusion, 1);
  stats.classes = [];
  stats.averages = struct('recall', 0, 'precision', 0, 'f1', 0, 'classRate', 0);
  tP = truePositives(confusion);
  fP = falsePositives(confusion);
  tN = trueNegatives(confusion);
  fN = falseNegatives(confusion);
  for (i = 1 : numClasses)
    TP = tP(i);
    FP = fP(i);
    TN = tN(i);
    FN = fN(i);
    recall = (TP * 100 / (TP + FN));
    precision = (TP * 100 / (TP + FP));
    f1 = 2 * precision * recall / (precision + recall);
    classRate = (TP + TN) / (TP + FP + TN + FN);
    stats.classes(i).recall = recall;
    stats.classes(i).precision = precision;
    stats.classes(i).f1 = f1;
    stats.classes(i).classRate = classRate;
    stats.classes(i).truePositive = TP;
    stats.classes(i).falsePositive = FP;
    stats.classes(i).trueNegative = TN;
    stats.classes(i).falseNegative = FN;
    stats.averages.recall = stats.averages.recall + (recall / numClasses);
    stats.averages.precision = stats.averages.precision + (precision / numClasses);
    stats.averages.f1 = stats.averages.f1 + (f1 / numClasses);
    stats.averages.classRate = stats.averages.classRate + (classRate / numClasses);
  end
end

function[tp] = truePositives(confusion)
  for (i = 1 : size(confusion, 1))
    tp(i) = confusion(i, i);
  end
end

function[fp] = falsePositives(confusion)
  totals = sum(confusion);
  for (i = 1 : size(confusion, 1))
    fp(i) = totals(i) - confusion(i, i);
  end
end

function[tn] = trueNegatives(confusion)
  for (i = 1 : size(confusion, 1))
    temp = confusion([1:(i - 1),(i + 1):end],:);
    temp = temp(:,[1:(i - 1),(i + 1):end]);
    tn(i) = sum(sum(temp));
  end
end

function[fn] = falseNegatives(confusion)
  transpC = transpose(confusion);
  totals = sum(transpC);
  for (i = 1 : size(confusion, 1))
    fn(i) = totals(i) - transpC(i, i);
  end
end