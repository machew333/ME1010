function [ xLand ] = LandingDistance( d,v0,theta )
%Average normal and drag landing distances

xLandNormal = LandingDistance2(d,v0,theta);
xLandDrag = [];
for i = theta
    xLandDrag = [xLandDrag LandingDistance1(d,v0,i)];
end

xLand  = (xLandNormal + xLandDrag) / 2;


end
