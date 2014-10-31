function [count] = getNumExm(exm, atr, index, examples, binary_targets)
  semiCount = 0;
  for (i = 1 : size(examples))
    if (examples(i, index) == atr && binary_targets(i) == exm)
      semiCount = semiCount + 1;
    end
  end
  count = semiCount;
