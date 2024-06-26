function [m,boundaries] = CircularConfidenceIntervals2(angles,alpha,nBootstrap)

%CircularConfidenceIntervals - Compute circular mean and confidence intervals of circular data.
 %
% Compute circular mean and confidence intervals of circular data (see NI Fisher, Analysis
% of circular data, p. 88). If fewer than 25 angle measurements are provided, bootstrap is used.
%
%  USAGE
%
%    [mean,boundaries] = CircularConfidenceIntervals(angles,alpha,nBootstrap)
%
%    angles         angles in radians
%    alpha          optional confidence level (default = 0.05)
%    nBootstrap     optional number of bootstraps (for < 25 angle values)
%                   (default = 200)
%
%  SEE
%
%    See also CircularMean, CircularVariance, Concentration, ConcentrationTest.

% Copyright (C) 2004-2011 by Micha�l Zugaro
%
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 3 of the License, or
% (at your option) any later version.

if nargin < 1,
    error('Incorrect number of parameters (type ''help <a href="matlab:help CircularConfidenceIntervals">CircularConfidenceIntervals</a>'' for details).');
end
%isradians(angles);
%if isdscalar(angles),
%    m = angles;
%    boundaries = [m m];
%    return
%end

m = [];
boundaries = [];
n = length(angles);
if n == 0, return; end

if nargin < 2
    alpha = 0.05;
end
if nargin < 3
    if n < 25
        nBootstrap = 200;
    else
        nBootstrap = 0;
    end
end

if nBootstrap == 0
    [m,r1] = CircularMean(angles);
    %mr=circstat(angles);
    [unused,r2] = CircularMean(wrapToPi(2*angles));
    %mr2=circstat(wrap(2*angles));
    delta = (1-r2)/(2*r1^2);
    %delta=(1-mr2(2)/(2*mr(2)^2));
    sigma = sqrt(delta/n);
    sinarg = norminv(1-alpha/2)*sigma;
    if sinarg < 1
        err = asin(sinarg);
    else
        err = pi;
    end
    boundaries = m + [-err err];
    %boundaries=mr(1)+[-err err];
else
    m = CircularMean(angles);
    %m=circstat(alpha);
    b = bootstrp(nBootstrap,'CircularMean',angles);
    %b=bootstrp(nBootstrap,'circstat',angles);
    
    % unwrap data around mean value
    unwrapped = mod(b-m+pi,2*pi)+m-pi;
    %unwrapped=mod(b-m(1)+pi,2*pi)+m(1)-pi;
    
    boundaries(1) = prctile(unwrapped(:,1),100*(alpha/2));
    boundaries(2) = prctile(unwrapped(:,1),100-100*(alpha/2));
end
 
 