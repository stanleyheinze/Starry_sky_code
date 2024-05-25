function [spikes, events] = spikedetection(data_raw, samp_per_sec)
% This function finds spikes using David O'Carroll's spike detection
% algorithm, and stores the detected spikes in two variables: (1) spikes,
% in which only the indices of the spikes are stored, and (2) events, which
% is a binary vector that covers the time of the whole recording.
% 
% The user gets the opportunity to correct the detected spikes manually, by
% checking and re-checking the plotted spikes. If no more corrections are
% needed, the user should press "cancel" and the function will proceed.
% 
% GETS:     data_raw = raw voltage recording
% 
% RETURNS:    spikes = spike indices
% events = binary vector of spike times
% 
% SYNTAX: [spikes, events] = spikedetection(data_raw)
% 
% written by A. Adden
% 
% see also getSpikes
ok = 1;
while ok < 2
    figure('units','normalized','outerposition',[0 0 1 1]);
    plot(data_raw)
    prompt = {'Enter the threshold:','Which percentage of biggest spike still counts:',...
        'Filter? Y/N:'};
    name = 'Parameters for spike detection';
    numlines = 3;
    defaultanswer = {'0.8','0.5','N'};
    answer = inputdlg(prompt,name,numlines,defaultanswer);
    thr = str2num(answer{1});
    perc = str2num(answer{2});
    if strcmp(answer{3},'N')
        filt = 2;
    else
        filt = 1;
    end
    close
    
    spikes = getSpikes(data_raw, [thr perc], filt); % using D. O'Carroll's spike detection algorithm
    %--- OR ---
%     [b,a] = butter(3,[.001 .5]);
%     data = filtfilt(b,a,data_raw); % zero phase shift band-pass filter data from D. O'Cs spike detection algorithm
%     [spikes, ~, ~] = autothreshold(data,samp_per_sec,'refract',1);
    
    prompt = {'OK?'};
    name = 'Spikes accepted?';
    numlines = 1;
    defaultanswer = {'Y'};
    answer = inputdlg(prompt,name,numlines,defaultanswer);
    if strcmp(answer{1},'N')
        ok = 1;
    else
        ok = 2;
    end
    close
end
close all

% % for autothreshold
% events = reshape(spikes, 1, length(spikes)); % binary vector of spikes
% % make spike time vector
% for i = 1:length(events)
%     if isequal(events(i),1)
%         spikes = [spikes i];
%     end
% end

%store spikes times in binary vector
events = zeros(1, length(data_raw));
for i = spikes
    events(i) = 1;
end