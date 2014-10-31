function [bestAttribute] = chooseBestDecisionAttribute(examples, attributes, binary_targets)
  gain = intmin;
  curBest = 1;
  while (attributes(curBest) == -1)
    curBest = curBest + 1;
  end
  for (a = 1 : length(attributes))
    while (attributes(a) == -1)
      a = a + 1;
      if (a > length(attributes))
        bestAttribute = curBest;
        return;
      end
    end

    p = countMember(1, a, examples);
    n = countMember(0, a, examples);

    p0 = getNumExamples(1, 0, a, examples, binary_targets);
    p1 = getNumExamples(1, 1, a, examples, binary_targets);
    n0 = getNumExamples(0, 0, a, examples, binary_targets);
    n1 = getNumExamples(0, 1, a, examples, binary_targets);

    temp1 = ((p0 + n0) / (p + n)) * calcI(p0, n0);
    temp2 = ((p1 + n1) / (p + n)) * calcI(p1, n1);

    remainder = temp1 + temp2;

    thisGain = calcI(p, n) - remainder;

    if (thisGain > gain)
      gain = thisGain;
      curBest = attributes(a);
    end    
  end
  bestAttribute = curBest;
end
  
function [I] = calcI(p, n)
  temp1 = p / (p + n);
  temp2 = n / (p + n);
  if (temp1 ~= 0)
    temp1 = (temp1 * log2(temp1));
  end
  if (temp2 ~= 0)
    temp2 = (temp2 * log2(temp2));
  end
  I = -temp1 - temp2;
end

function [count] = countMember(elem, pos, examples)
  semiCount = 0;
  for (i = 1 : size(examples, 1))
    if (examples(i,pos) == elem)
      semiCount = semiCount + 1;
    end
  end
  count = semiCount;
end

function [count] = getNumExmamples(exm, atr, index, examples, binary_targets)
  semiCount = 0;
  for (i = 1 : size(examples))
    if (examples(i, index) == atr && binary_targets(i) == exm)
      semiCount = semiCount + 1;
    end
  end
  count = semiCount;
end


