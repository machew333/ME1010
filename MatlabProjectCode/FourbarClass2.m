function [ class, Sloc ] = FourbarClass2( L )
%FourbarClass2 inputs link lengths and outputs the class and shortest
%linkage length, also uses nargout to overload
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
if nargout == 2
    Sloc = sLinkInd(sLinkIndLogic);
else
    Sloc = [];



end

%Kevin Moffatt      u0987649     ME EN 1010 Lab 003         HW6