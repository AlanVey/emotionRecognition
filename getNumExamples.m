function [count] = getNumExamples(isPositive, attributeValue, index, examples, binary_targets)
  count = 0;
  for (i = 1 : size(examples))
    if (examples(i, index) == attributeValue && binary_targets(i) == isPositive)
      count = count + 1;
    end
  end
