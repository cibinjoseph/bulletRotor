function stat = checkImpact(PShot,tTravel,numBlades,rotorRPM,chord)
stat = 0;

rShot = PShot(1);
psiShot = PShot(2);
psiBlade = zeros(1,numBlades);

% Get angular positions of blades at time tTravel
for i=1:numBlades
  psiBlade(i) = rotorRPM*tTravel+2*pi*(i-1)/numBlades;
end
psiBlade = wrapTo2Pi(psiBlade);

% Find index of nearest blade
[~,minIndx]=min(abs(psiBlade-psiShot));

% Find approx perpendicular distance to blade
dist = abs(rShot*sin(psiShot-psiBlade(minIndx)));

% Check if collides within tolerance
if (dist <= 0.5*chord*1.10)
  stat = 1;
end

return;
