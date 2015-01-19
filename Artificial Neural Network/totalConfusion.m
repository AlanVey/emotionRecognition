function [confusion] = totalConfusion(folds)
  confusion = zeros(6,6);
  for (i = 1 : length(folds))
    confusion = confusion + generateConfusion(folds{i,1}, folds{i,2});
  end
end