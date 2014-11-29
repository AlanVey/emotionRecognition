function [value] = similarity(case1, case2, type)
  AU1 = case1.AU;
  AU2 = case2.AU;
 
  switch type
    case 1
      value = 1 - (length(setxor(AU1, AU2)) / length(union(AU1, AU2)));
    case 2
      value = length(setxor(AU1, AU2));
    case 3
      value = abs(length(AU1) - length(AU2));
  end
  
  if (isempty(AU1) || isempty(AU2))
    value = intmax;
  end

end

