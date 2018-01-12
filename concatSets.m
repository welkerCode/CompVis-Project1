function catSet = concatSets(oldSet, newSet)
    if(size(oldSet) == 0)
        catSet = newSet;
    else
        catSet = cat(1,oldSet,newSet);
    end
end