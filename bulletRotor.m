clc; clear; clf;

% Define parameters
numShotsMin = 1;
numShotsMax = 500;
rotorRPM = 62.83;  % in rad/s
bulletVel = 400;  % m/s
numBlades = 1;
Tmax = 10;
maxIter = 100;
distShot = 1;
chord = 1/6;
colorCode = ['b' 'r'];

probHit = zeros(1,numShotsMax);

for inum=numShotsMin:numShotsMax
  numShots=inum;
  
  % Calculated parameters
  shotStatus = zeros(1,numShots); % [1] Hit, [0] No hit
  
  % Generate a set of unique random points in time
  tShot = rand(1,numShots);
  for i=1:maxIter
    if (length(unique(tShot)) < numShots)
      tShot = rand(1,numShots);
    else
      tShot = unique(tShot);
      break;
    end
  end
  
  if (i == maxIter)
    disp('Failed to find unique tShot array');
    exit;
  end
  
  tShot = tShot*Tmax;
  
  % Generate a set of random points in polar coords
  PShot = rand(2,numShots);
  PShot(2,:) = PShot(2,:)*2*pi;  % Scale from unity to 2pi radians
  
  %polar(PShot(2,:),PShot(1,:),'o')
  
  % Calculate time taken for bullet to travel to PShot(r,psi)
  % Assume shot fired from distance dist
  tTravel = sqrt(PShot(1,:).*PShot(1,:)+distShot*distShot)/bulletVel;
  
  % Check if bullet collides with blade at tTravel time instant
  for i=1:numShots
    shotStatus(i)=checkImpact(PShot(:,i),tTravel(i),numBlades,rotorRPM,chord);
  end
  
%   % Plot hit and non-hit shots
%   for i=1:numShots
%     polarplot(PShot(2,i),PShot(1,i),[colorCode(shotStatus(i)+1) 'o']);
%     hold on;
%   end
%   pause(0.25);
%   clf;
  
  numHits = sum(shotStatus);
  probHit(inum) = numHits/numShots;
end

plot(numShotsMin:numShotsMax,probHit)
mean(probHit)