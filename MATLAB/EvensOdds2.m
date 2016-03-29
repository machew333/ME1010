function [ evens, odds ] = EvensOdds2( posInts )
%EvensOdds2 takes a vector of positive integers and outputs a vector
%containing all even numbers and a vector containing all odds
evens = [];
odds = [];
for i=1:length(posInts);
    if rem(posInts(i),2)==0
        evens = [evens posInts(i)];
    else
        odds = [odds posInts(i)];
    end
end

end

%Kevin Moffatt      u0987649     ME EN 1010 Lab 003         HW6