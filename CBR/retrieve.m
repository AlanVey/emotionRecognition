function [Case] = retrieve(CBR, newCase)
  k = 4;
  simType = 1;
  
  sims = [];
  
  for (i = 1 : length(CBR))
    caseSim = similarity(CBR(i), newCase, simType);
    sims(caseSim, length(sims, caseSim) + 1) = CBR(i);
  end
  
  topSims = [];
  
  for (i = 1 : k)
    topSims = cat(2, topSims, sims(i));
  end
  
  topSims = topSims(1:k);
  
  avgRes = mode([topSims.solution].');
  
  topSims = fliplr(topSims);
  for (i = 1 : k)
    if (topSims(i).solution == avgRes)
      Case = topSims(i);
    end
  end
end

function [simil, index] = getMinSimilarity(topSimils)
  simil = topSimils(1).Simil;
  index = 1;
  for (i = 2 : length(topSimils))
    if (topSimils(i).Simil < simil)
      simil = topSimils(i).Simil;
      index = i;
    end
  end
end