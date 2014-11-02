function [predictions] = testTrees(trees, x2)
  predictions = ones(length(x2), 1);
  for (i = 1 : length(x2))
    for (j = 2 : length(trees))
      if (inTree(x2(i,:), trees(j)))
        predictions(i) = j;
      end
    end
  end
end

function [isInTree] = inTree(val, tree)
  tree = tree{1,1};
  while (size(tree.kids, 1) > 0)
    tree = tree.kids{1, val(tree.op) + 1};
  end
  isInTree = tree.class;
end