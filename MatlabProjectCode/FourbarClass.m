function [ class, Sloc ] = FourbarClass( L )
%FourbarClass inputs link lengths and outputs the class and shortest
%linkage length
[sortedLinks,sLinkInd] = sort(L);
s = sortedLinks(1);
p = sortedLinks(2);
q = sortedLinks(3);
l = sortedLinks(4);
if s+l<p+q
    class = 1;
elseif s+l>p+q
    class = 2;
else
    class = 3;
end
sLinkIndLogic = (sortedLinks == s);
Sloc = sLinkInd(sLinkIndLogic);



end

%Kevin Moffatt      u0987649     ME EN 1010 Lab 003         HW6