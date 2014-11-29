function [CBR] = CBRInit(x, y)
  CBR = repmat(struct('AU', [], 'solution', 0, 'typicality', 0), length(x), 1);
  for (i = 1 : length(x))
    Case = struct('AU', find(x(i,:)), 'solution', y(i), 'typicality', 1);
    oldCase = caseExists(CBR, Case);
    if (oldCase > 0)
      CBR(oldCase).typicality = CBR(oldCase).typicality + 1;
    else
      CBR(i) = Case;
    end
  end
end