function [Case] = retrieve(CBR, newCase)
  k = 1;
  distType = 3;
  
  entries = repmat(struct('AU', [], 'solution', 0, 'typicality', 0, 'distance', 0), k, 1);
  maxDist = intmin;
  maxDistIndex = 0;
  
  for (i = 1 : k)
    curCase = CBR(i);
    curCase.distance = distance(CBR(i), newCase, distType);
    entries(i) = curCase;
    if (curCase.distance > maxDist)
      maxDist = curCase.distance;
      maxDistIndex = i;
    end
  end
  
  for (i = k + 1 : length(CBR))
    caseDist = distance(CBR(i), newCase, distType);
    if (caseDist < maxDist || ((caseDist == maxDist) && (CBR(i).typicality > entries(maxDistIndex).typicality)))
      newCase = CBR(i);
      newCase.distance = caseDist;
      entries(maxDistIndex) = newCase;
      [maxDist, maxDistIndex] = getMaxDistance(entries);
    end
  end
  
  avgRes = calcAdjMode(entries);
  bestDistance = intmax;
  
  for (i = 1 : k)
    if ((entries(i).solution == avgRes) && (entries(i).distance < bestDistance))
      Case = entries(i);
      bestDistance = entries(i).distance;
    end
  end
end

function [distance, index] = getMaxDistance(entries)
  distance = entries(1).distance;
  index = 1;
  for (i = 2 : length(entries))
    if (entries(i).distance > distance)
      distance = entries(i).distance;
      index = i;
    end
  end
end

function [retVal] = calcAdjMode(entries)
  values = [];
  for (i = 1 : length(entries))
    for (j = 1 : entries(i).typicality)
      values(length(values) + 1) = entries(i).solution;
    end
  end
  retVal = mode(values);
end