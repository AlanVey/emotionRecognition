function [confusion] = generateConfusion(pred, y)
  confusionMatrix = zeros(6, 6, 'double');
  for (i = 1 : length(pred))
    confusionMatrix(y(i), pred(i)) = confusionMatrix(y(i), pred(i)) + 1;
  end
  confusion = confusionMatrix;
end
