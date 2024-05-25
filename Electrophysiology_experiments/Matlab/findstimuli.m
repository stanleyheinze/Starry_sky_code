function [pat_on, pat_off, spd_on, spd_off, rot_on, rot_off] = findstimuli(data_pat, data_spd, data_rot)
% This function finds the start and end of stimuli (both pattern data and
% speed data). 
%
% GETS:         data_pat = raw voltage recording from pattern channel
%               data_spd = raw voltage recording from speed channel
%
% RETURNS:        pat_on = vector of pattern onset indices
%                pat_off = vector of pattern stop indices
%                 spd_on = vector of movement onset indices
%                spd_off = vector of movement stop indices
%
% SYNTAX: [pat_on, pat_off, spd_on, spd_off] = findstimuli(data_pat, data_spd)
%
% written by A. Adden, Dec 2016
% 
% see also

% ----- pattern -----
for i = 1:length(data_pat)
    tmppat(i) = round(data_pat(i));
end
pat = find(diff(tmppat));
tempstim = diff(pat);
for i = 1:length(tempstim)
    if tempstim(i) < 10
        pat(i+1) = NaN;
    end
end
pat(find(isnan(pat))) = [];
if isempty(pat)
    pat_on = 1;
    pat_off = length(data_pat);
else
    pat_on = pat(1:2:end-1); % pattern ON
    pat_off = pat(2:2:end); % pattern OFF
end

% ----- speed -----
for i = 1:length(data_spd)
    tmpspd(i) = round(data_spd(i),1);
end
spd = find(diff(tmpspd));
tempstim = diff(spd);
for i = 1:length(tempstim)
    if tempstim(i) < 10
        spd(i+1) = NaN;
    end
end
spd(find(isnan(spd))) = [];
spd_on = spd(1:2:end-1); % movement START
spd_off = spd(2:2:end); % movement STOP

% ----- rotation -----
if std(data_rot) < 1
    rot_on = [];
    rot_off = [];
elseif std(data_rot) > 1
    tmprot = round(data_rot(:),-1);
    rot = find(diff(tmprot));
    tempstim = diff(rot);
    for i = 1:length(tempstim)
        if tempstim(i) < 100
            rot(i+1) = NaN;
        end
    end
    rot(find(isnan(rot))) = [];
    rot_on = rot(1:2:end-1); % movement START
    rot_off = rot(2:2:end); % movement STOP
end