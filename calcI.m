function [I] = calcI(p, n)
  temp1 = p / (p + n);
  temp2 = n / (p + n);
  if (temp1 ~= 0)
    temp1 = (temp1 * log2(temp1));
  end
  if (temp2 ~= 0)
    temp2 = (temp2 * log2(temp2));
  end
  I = -temp1 - temp2;
