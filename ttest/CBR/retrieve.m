function [Case] = retrieve(CBR, newCase)
  k = 4;
  simType = 1;
  
  sims = repmat(struct('AU', [], 'solution', 0, 'typicality', 0, 'similarity', 0), k, 1);
  maxSim = intmin;
  maxSimIndex = 0;
  
  for (i = 1 : k)
    curCase = CBR(i);
    curCase.similarity = similarity(CBR(i), newCase, simType);
    sims(i) = curCase;
    if (curCase.similarity > maxSim)
      maxSim = curCase.similarity;
      maxSimIndex = i;
    end
  end
  
  for (i = k + 1 : length(CBR))
    caseSim = similarity(CBR(i), newCase, simType);
    if (caseSim < maxSim)
      newCase = CBR(i);
      newCase.similarity = caseSim;
      sims(maxSimIndex) = newCase;
      [maxSim, maxSimIndex] = getMaxSimilarity(sims);
    end
  end
  
  avgRes = mode([sims.solution].');
  
  for (i = 1 : k)
    if (sims(i).solution == avgRes)
      Case = sims(i);
    end
  end
end

function [simil, index] = getMaxSimilarity(sims)
  simil = sims(1).similarity;
  index = 1;
  for (i = 2 : length(sims))
    if (sims(i).similarity > simil)
      simil = sims(i).similarity;
      index = i;
    end
  end
end