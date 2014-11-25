function [Case] = retrieve(CBR, newCase)
  k = 4;
  simType = 1;
  
  sims = [];
  
  for (i = 1 : length(CBR))
    caseSim = similarity(CBR(i), newCase, simType);
    sims(caseSim, length(sims, caseSim) + 1) = CBR(i);
  end
  
  sims = fliplr(sims);
  
  sims = sims(1:k);
  
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