function [index] = caseExists(CBR, Case)
  index = 0;
  for (i = 1 : length(CBR))
    if (isempty(setxor(Case.AU, CBR(i).AU)) && (Case.solution == CBR(i).solution))
      index = i;
    end
  end
end