function [ numOfEven, numOfOdd ] = EvensOdds( posInts )
%EVENSODDS takes a vector of positive integer values and returns the number
%of even values and number of odd values in the vector
numOfEven=0;
numOfOdd=0;
for i=posInts
    if rem(i,2)==0
        numOfEven=numOfEven+1;
    else
        numOfOdd=numOfOdd+1;
    end
end

end

%Kevin Moffatt      u0987649     ME EN 1010 Lab 003         HW5