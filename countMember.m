function [count] = countMember(elem, pos, examples)
  semiCount = 0;
  for (i = 1 : size(examples, 1))
    if (examples(i,pos) == elem)
      semiCount = semiCount + 1;
    end
  end
  count = semiCount;
