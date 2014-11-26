function [index] = caseExists(CBR, Case)
  index = 0;
  for (i = 1 : length(CBR))
    if (length(Case.AU) == length(CBR(i).AU))
      if (prod(Case.AU == CBR(i).AU) && (Case.solution == CBR(i).solution))
        index = i;
      end
    end
  end
end