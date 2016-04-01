load d_vector
vo = 3.3;
thetaRange = [1:1:90];

figure
trial1 = LandingDistance2(d,vo,thetaRange);
plot(thetaRange,trial1);
xlabel('theta');
ylabel('Distance [m]');

hold on

exes = [];
for i = thetaRange
    exes = [exes, LandingDistance1(d,vo,i)];
end
plot(thetaRange,exes);



average = (trial1 + exes) /2;
plot(thetaRange,average);

% for i = 

trial3 = LandingDistance3(d,vo,thetaRange);
plot(thetaRange,trial3);

legend('Normal','Air resistance','Average','Empirical');

% LandingDistance1(d,vo,48);



