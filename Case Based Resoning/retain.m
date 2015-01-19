function [CBR] = retain(CBR, solvedCase)
  index = caseExists(CBR, solvedCase);
  if (index > 0)
    CBR(index).typicality = CBR(index).typicality + 1;
  else
    CBR(length(CBR) + 1) = solvedCase;
  end
end

