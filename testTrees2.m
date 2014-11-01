function [predictions] = testTrees2(trees, x2)
  blength = zeroes(1, size(x2, 1));
  %chooses the tree with the shortest branch
  predictions = ones(length(x2), 1);
  for (i = 1 : length(x2))
    for (j = 2 : length(trees))
      branch = inTree(x2(i,:), trees(j));
      if(branch >= 0 && (branch < blenght(i) || blength(i) == 0))
        blength(i) = branch;
        predictions(i) = j;
      end
    end
  end
end

function [level] = inTree(val, tree)
  tree = tree{1,1};
  level = 0;
  while (size(tree.kids, 1) > 0)
    tree = tree.kids{1, val(tree.op) + 1};
    level = level + 1;
  end
  if(tree.class == 0)
      level = -1;
  end
end