function [leftBound, rightBound, upperBound, lowerBound] = getBounds(DoGLevel, j, k)
    if (j-1 < 1)
        leftBound = j;
    else
        leftBound = j-1;
    end
    if (j+1 > size(DoGLevel, 1))
        rightBound = j;
    else
        rightBound = j+1;
    end
    if (k-1 < 1)
        upperBound = k;
    else
        upperBound = k-1;
    end
    if (k+1 > size(DoGLevel, 2))
        lowerBound = k;
    else
        lowerBound = k+1;
    end
end