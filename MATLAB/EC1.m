%%%%%%%%%%%%%%%%%%%%%
%Kevin Moffatt
%u0987649
%Matt Wilson
%u0499184
%EC1
%Due April 1,2016
%%%%%%%%%%%%%%%%%%%%%
clear, clc, close all, format compact

load d_vector;
load optimal_v0_2; %Optimal v0 of 3.30 m/s from second data set
v0 = optimal_v0_2;
load L_vector;
load H_vector; %This is same as calling ConvertBetweenLandH for L
load optimal_offsets_3; %Optimal offsets from 3rd data set [10.14,6.995] 
offsets = optimal_offsets_3;
currentLAerror = 2; %Diff between exp and the launch angles
xTarget = [0.7,0.95,1.2];
minReqLA = min(SteepLaunchAngle(d,v0,xTarget))
maxReqLA = max(SteepLaunchAngle(d,v0,xTarget))
currentServoRange = ServoRange(H,offsets,minReqLA,maxReqLA)
currentxLandError = MissBy(d,v0,xTarget,currentLAerror)
L1 = 131.3; %Not varied
L2 = [31.5,39.5,47.5]; %Holes in angle bracket are spaced by 8mm
L3 = 72:8:144; %Holes in link rod are spaced by 8mm
L4 = 96:16:128; %Holes in 1x9 beam are spaced by 16mm
maxServoRange = 0;
for i=1:length(L2)
    for j=1:length(L3)
        for h=1:length(L4)
            Lposs = [L1,L2(i),L3(j),L4(h)];
            Hposs = ConvertBetweenLandH(Lposs);
            class = FourbarClass2(Lposs);
            if class == 1
                [class,sLoc] = FourbarClass2(Lposs);
                if sLoc == 2
                    [minLA,maxLA] = MinMaxLaunchAngles(Lposs,offsets);
                    if (minLA < minReqLA) & (maxLA > maxReqLA)
                        newServoRange = ServoRange(Hposs,offsets,minReqLA,maxReqLA);
                        if newServoRange > maxServoRange
                            maxServoRange = newServoRange;
                            bestLvals = Lposs;
                        end
                    end
                end
            end
        end
    end
end
maxServoRange, bestLvals
[minLA,maxLA] = MinMaxLaunchAngles(bestLvals,offsets)
expectedLAerror = currentLAerror*(currentServoRange/maxServoRange)
xLandError = MissBy(d,v0,xTarget,expectedLAerror)
ThetaLaunch(bestLvals,0:180,offsets);
Hbest = ConvertBetweenLandH(bestLvals) / 1000;


            