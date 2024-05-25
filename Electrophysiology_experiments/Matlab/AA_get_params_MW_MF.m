% Script that gets relevant parameters for analysis from data files
% recorded during the spring migration Oct-Nov 2018 in Adaminaby.
%
% Saves a .mat file with the following fields:
%
%   stimulus = struct containing the fields pattern, speed, direction,
%              pat_on, pat_off, spd_on, spd_off, samp_per_sec
%   response = struct containing the fields spikes, events, bg_ISI,
%              bg_meanfreq
%
% written by A. Adden, 27-10-2018
%
% see also ana_master_AA, findstimuli, spikedetection

% --- INPUT PATH & GET ALL FILES ON PATH ---
fileList = getAllFiles(pathname, 'FileFilter', '\.txt$');

% --- CYCLE THROUGH FILES AND EXTRACT RELEVANT PARAMETERS ---
for j = 1:length(fileList)
    filename = fileList{j};
    % check if data file exists already, in which case skip the following:
    if exist(strcat(filename(1:end-4), '_data.mat'),'file')
        return
    end
    
    %load data
    data = load(filename);
    data_raw = data(:,2); % neuronal response trace
    data_MW = data(:,3); % visual stimulus rotation
%     data_MF = data(:,4); % magnetic field on/off
    
    samp_per_sec = 1 / (data(2,1) - data(1,1)); % samples per second
    clear data
    
    % ----- DETECT STIMULI -----
    % pattern onset and end for other stimuli that have one cw and one ccw
    % rotation
    [cw_on, cw_off, ccw_on, ccw_off] = findstim_single(data_MW);
    
    
    % ----- DETECT SPIKES -----
    % spikes: includes only spike timing indices, events: binary vector
    % covering whole recording time
    [spikes, events] = spikedetection(data_raw, samp_per_sec);
    
    
    % ----- CALCULATE BACKGROUND FREQUENCY -----
    % from the start of the recording to the start of the stimulus
    bg_ISI = diff(find(events(1:cw_on))); % inter-spike-intervals
    sum_events = sum(events(1:cw_on));
    
    % in 100 ms bins because of reasons
    c_cw = 1; icw = 1;
    while c_cw < length(1:cw_on)
        spPbinCW(icw) = sum(events(c_cw:c_cw+999)); % 100 ms when sampling at 10000
        c_cw = c_cw + 1000; % jump to next 100 ms window
        icw = icw + 1;
    end
    c_ccw = 1; iccw = 1;
    while c_ccw < length(cw_off:ccw_on)
        spPbinCCW(iccw) = sum(events((cw_off+c_ccw):(cw_off+c_ccw+999))); % 100 ms when sampling at 10000
        c_ccw = c_ccw + 1000; % jump to next 100 ms window
        iccw = iccw + 1;
    end
    % now translate from imp/100ms to imp/s
    spPsecCW = spPbinCW * 10;
    spPsecCCW = spPbinCCW * 10;
    % now calculate means and SDs
    bg_mean_cw = mean(spPsecCW);
    bg_mean_ccw = mean(spPsecCCW);
%     bg_std_cw = std(spPsecCW);
%     bg_std_ccw = std(spPsecCCW);
    bg_SEM_cw = std(spPsecCW) / sqrt(length(spPsecCW));
    bg_SEM_ccw = std(spPsecCCW) / sqrt(length(spPsecCCW));
    
    D = [bg_mean_cw bg_mean_ccw; bg_SEM_cw bg_SEM_ccw]
%     if isequal(sum_events, 0)
%         bg_meanfreq_cw = 0;
%     else
%         bg_meanfreq_cw = mean(events(1:cw_on))*samp_per_sec; % mean frequency per second
%         bg_std_cw = std(events(1:cw_on)); % standard deviation
%     end
%     % now background for ccw
%     bg_ISI = diff(find(events(cw_off:ccw_on))); % inter-spike-intervals
%     sum_events = sum(events(cw_off:ccw_on));
%     if isequal(sum_events, 0)
%         bg_meanfreq_ccw = 0;
%     else
%         bg_meanfreq_ccw = mean(events(cw_off:ccw_on))*samp_per_sec; % mean frequency per second
%         bg_std_ccw = std(events(cw_off:ccw_on));
%     end
    
    % ----- SAVE -----
    stimulus = struct('cw_on_off', [cw_on, cw_off],...
        'ccw_on_off', [ccw_on, ccw_off],...
        'samp_per_sec', samp_per_sec, ...
        'data_raw', data_raw);
    %reshape(spikes, 1, length(spikes))
    % REMEMBER: only 1 second between stimuli, therefore bg is same = taken
    % from before clockwise rotation for both cw and ccw!
    response = struct('spikes', spikes, 'events', events, 'bg_ISI', bg_ISI,...
        'bg_mean_cw', bg_mean_cw,'bg_mean_ccw', bg_mean_cw,...
        'bg_SEM_cw', bg_SEM_cw, 'bg_SEM_ccw', bg_SEM_cw);
    
    filename = strcat(filename(1:end-4), '_data');
    save(filename, 'stimulus', 'response');
end