% Script for circular plots of cell responses.

% Get files
fileList = getAllFiles(pathname, 'FileFilter', '\.mat$');

bins_deg = 10; % bins for circular plots. 10 degrees, can be adjusted
bg = zeros(1,length(fileList)); % background frequency

% initialise indices for later use
x = 1; y = 1; u = 1; q = 1; qi = 1;
% initalise variables for later use
theta_MW_cw = [];
theta_MW_ccw = [];
theta_con_cw = [];
theta_con_ccw = [];
theta_wdot_cw = [];
theta_wdot_ccw = [];
theta_sprl_cw = [];
theta_sprl_ccw = [];
theta_strp_cw = [];
theta_strp_ccw = [];
theta_thresh_cw = [];
theta_thresh_ccw = [];

for i = 1:length(fileList)
    load(fileList{i});
    
    if contains(fileList{i},'MW')
        colour = 'b';
        name = 'MW';
    elseif contains(fileList{i},'Dot')
        colour = 'c';
        name = 'wdot';
    elseif contains(fileList{i},'Strp')
        colour = 'k';
        name = 'strp';
    elseif contains(fileList{i},'Grad')
        colour = 'k';
        name = 'grad';    
    elseif contains(fileList{i}, 'Con')
        colour = 'g';
        name = 'con';
    elseif contains(fileList{i}, 'Thresh')
        colour = 'm';
        name = 'thresh';
    end
    
    % cut data
    cw = response.events(stimulus.cw_on_off(1):stimulus.cw_on_off(2));
    ccw = response.events(stimulus.ccw_on_off(1):stimulus.ccw_on_off(2));
    
    % get angles
    angles_rad_cw = deg2rad(round(linspace(0,360,length(stimulus.cw_on_off(1):stimulus.cw_on_off(2))+1)));
    spikes_cw = find(response.events(stimulus.cw_on_off(1):stimulus.cw_on_off(2)));
    theta_cw = angles_rad_cw(spikes_cw);
    
    angles_rad_ccw = fliplr(deg2rad(round(linspace(0,360,length(stimulus.ccw_on_off(1):stimulus.ccw_on_off(2))+1))));
    spikes_cw = find(response.events(stimulus.ccw_on_off(1):stimulus.ccw_on_off(2)));
    theta_ccw = angles_rad_ccw(spikes_cw);
    
    [angles_cw, count_cw] = rose(theta_cw, 360/bins_deg);
    [angles_ccw, count_ccw] = rose(theta_ccw, 360/bins_deg);
    
    binned_freq_cw(1,:) = count_cw / (8/(360/bins_deg)); % the duration of  each bin
    binned_freq_ccw(1,:) = count_ccw / (8/(360/bins_deg)); % the duration of each bin
    
    if isequal(name,'MW')
        MW_cw(x,:) = binned_freq_cw;
        MW_ccw(x,:) = binned_freq_ccw;
        theta_MW_cw = [theta_MW_cw theta_cw];
        theta_MW_ccw = [theta_MW_ccw theta_ccw];
        mean_cw(x) = circ_mean(theta_cw, [], 2); % in radians
        mean_ccw(x) = circ_mean(theta_ccw, [], 2);
        x = x+1;
    elseif isequal(name,'con')
        con_cw(y,:) = binned_freq_cw;
        con_ccw(y,:) = binned_freq_ccw;
        theta_con_cw = [theta_con_cw theta_cw];
        theta_con_ccw = [theta_con_ccw theta_ccw];
        y = y+1;
    elseif isequal(name,'wdot')
        wdot_cw(u,:) = binned_freq_cw;
        wdot_ccw(u,:) = binned_freq_ccw;
        theta_wdot_cw = [theta_wdot_cw theta_cw];
        theta_wdot_ccw = [theta_wdot_ccw theta_ccw];
        u = u+1;
    elseif isequal(name,'grad')
        sprl_cw(q,:) = binned_freq_cw;
        sprl_ccw(q,:) = binned_freq_ccw;
        theta_sprl_cw = [theta_sprl_cw theta_cw];
        theta_sprl_ccw = [theta_sprl_ccw theta_ccw];
        q = q+1;
    elseif isequal(name,'strp')
        strp_cw(qi,:) = binned_freq_cw;
        strp_ccw(qi,:) = binned_freq_ccw;
        theta_strp_cw = [theta_strp_cw theta_cw];
        theta_strp_ccw = [theta_strp_ccw theta_ccw];
        qi = qi+1;
    elseif isequal(name,'thresh')
        thresh_cw(qi,:) = binned_freq_cw;
        thresh_ccw(qi,:) = binned_freq_ccw;
        theta_thresh_cw = [theta_thresh_cw theta_cw];
        theta_thresh_ccw = [theta_thresh_ccw theta_ccw];
        qi = qi+1;
    end
end
clear x y z q qi

if exist('MW_cw','var')
    n_MW = size(MW_cw, 1);
else
    n_MW = 0;
    MW_cw = NaN;
    MW_ccw = NaN;
end
if exist('con_cw','var')
    n_con = size(con_cw, 1); 
else
    n_con = 0;
    con_cw = NaN;
    con_ccw = NaN;
end
if exist('wdot_cw','var')
    n_wdot = size(wdot_cw, 1);
else
    n_wdot = 0;
    wdot_cw = NaN;
    wdot_ccw = NaN;
end
if exist('sprl_cw','var')
    n_sprl = size(sprl_cw, 1);
else
    n_sprl = 0;
    sprl_cw = NaN;
    sprl_ccw = NaN;
end
if exist('strp_cw','var')
    n_strp = size(strp_cw, 1);
else
    n_strp = 0;
    strp_cw = NaN;
    strp_ccw = NaN;
end
if exist('thresh_cw','var')
    n_thresh = size(thresh_cw, 1);
else
    n_thresh = 0;
    thresh_cw = NaN;
    thresh_ccw = NaN;
end

if size(MW_cw,1)>1
    MW_cw = mean(MW_cw); MW_ccw = mean(MW_ccw);
end
if size(con_cw,1)>1
    con_cw = mean(con_cw); con_ccw = mean(con_ccw);
end
if size(wdot_cw,1)>1
    wdot_cw = mean(wdot_cw); wdot_ccw = mean(wdot_ccw);
end
if size(sprl_cw,1)>1
    sprl_cw = mean(sprl_cw); sprl_ccw = mean(sprl_ccw);
end
if size(strp_cw,1)>1
    strp_cw = mean(strp_cw); strp_ccw = mean(strp_ccw);
end
if size(thresh_cw,1)>1
    thresh_cw = mean(thresh_cw); thresh_ccw = mean(thresh_ccw);
end

maxval = max([MW_cw MW_ccw con_cw con_ccw wdot_cw wdot_ccw sprl_cw sprl_ccw strp_cw strp_ccw thresh_cw thresh_ccw]);

% % get mean vectors and statistics
% if ~isempty(theta_MW_cw)
%     mean_MW_cw = circ_mean(theta_MW_cw');
%     [pval_MW_cw, ~] = circ_rtest(theta_MW_cw');
%     mean_MW_ccw = circ_mean(theta_MW_ccw');
%     [pval_MW_ccw, ~] = circ_rtest(theta_MW_ccw');
%     [r_cw, axmean_MW_cw] = circ_axialmean(theta_MW_cw');
%     [r_ccw, axmean_MW_ccw] = circ_axialmean(theta_MW_ccw');
%     str_MW_cw = [{['circular mean = ', num2str(round(rad2deg(mean_MW_cw))), ' deg; p = ', num2str(pval_MW_cw)]},...
%         {['axial mean = ', num2str(round(rad2deg(axmean_MW_cw))),' deg, r = ', num2str(r_cw)]}];
%     str_MW_ccw = [{['circular mean = ', num2str(round(rad2deg(mean_MW_ccw))), ' deg; p = ', num2str(pval_MW_ccw)]},...
%         {['axial mean = ', num2str(round(rad2deg(axmean_MW_ccw))), ' deg, r = ', num2str(r_ccw)]}];
% else
%     mean_MW_cw = NaN;
%     pval_MW_cw = NaN;
%     mean_MW_ccw = NaN;
%     pval_MW_ccw = NaN;
%     axmean_MW_cw = NaN;
%     axmean_MW_ccw = NaN;
%     str_MW_cw = [{['mean = NaN deg']}, {['axial mean = NaN']}];
%     str_MW_ccw = [{['mean = NaN deg']}, {['axial mean = NaN']}];
% end
% 
% if ~isempty(theta_con_cw)
%     mean_con_cw = circ_mean(theta_con_cw');
%     [pval_con_cw, ~] = circ_rtest(theta_con_cw');
%     mean_con_ccw = circ_mean(theta_con_ccw');
%     [pval_con_ccw, ~] = circ_rtest(theta_con_ccw');
%     [r_cw, axmean_con_cw] = circ_axialmean(theta_con_cw');
%     [r_ccw, axmean_con_ccw] = circ_axialmean(theta_con_ccw');
%     str_con_cw = [{['circular mean = ', num2str(round(rad2deg(mean_con_cw))), ' deg; p = ', num2str(pval_con_cw)]},...
%         {['axial mean = ', num2str(round(rad2deg(axmean_con_cw))),' deg, r = ', num2str(r_cw)]}];
%     str_con_ccw = [{['circular mean = ', num2str(round(rad2deg(mean_con_ccw))), ' deg; p = ', num2str(pval_con_ccw)]},...
%         {['axial mean = ', num2str(round(rad2deg(axmean_con_ccw))),' deg, r = ', num2str(r_ccw)]}];
% else
%     mean_con_cw = NaN;
%     pval_con_cw = NaN;
%     mean_con_ccw = NaN;
%     pval_con_ccw = NaN;
%     str_con_cw = [{['mean = NaN deg']}, {['axial mean = NaN']}];
%     str_con_ccw = [{['mean = NaN deg']}, {['axial mean = NaN']}];
% end
% 
% if ~isempty(theta_wdot_cw)
%     mean_wdot_cw = circ_mean(theta_wdot_cw');
%     [pval_wdot_cw, ~] = circ_rtest(theta_wdot_cw');
%     mean_wdot_ccw = circ_mean(theta_wdot_ccw');
%     [pval_wdot_ccw, ~] = circ_rtest(theta_wdot_ccw');
%     [r_cw, axmean_wdot_cw] = circ_axialmean(theta_wdot_cw');
%     [r_ccw, axmean_wdot_ccw] = circ_axialmean(theta_wdot_ccw');
%     str_wdot_cw = [{['circular mean = ', num2str(round(rad2deg(mean_wdot_cw))), ' deg; p = ', num2str(pval_wdot_cw)]},...
%         {['axial mean = ', num2str(round(rad2deg(axmean_wdot_cw))),' deg, r = ', num2str(r_cw)]}];
%     str_wdot_ccw = [{['circular mean = ', num2str(round(rad2deg(mean_wdot_ccw))), ' deg; p = ', num2str(pval_wdot_ccw)]},...
%         {['axial mean = ', num2str(round(rad2deg(axmean_wdot_ccw))),' deg, r = ', num2str(r_ccw)]}];
% else
%     mean_wdot_cw = NaN;
%     pval_wdot_cw = NaN;
%     mean_wdot_ccw = NaN;
%     pval_wdot_ccw = NaN;
%     str_wdot_cw = [{['mean = NaN deg']}, {['axial mean = NaN']}];
%     str_wdot_ccw = [{['mean = NaN deg']}, {['axial mean = NaN']}];
% end
% 
% if ~isempty(theta_sprl_cw)
%     mean_sprl_cw = circ_mean(theta_sprl_cw');
%     [pval_sprl_cw, ~] = circ_rtest(theta_sprl_cw');
%     mean_sprl_ccw = circ_mean(theta_sprl_ccw');
%     [pval_sprl_ccw, ~] = circ_rtest(theta_sprl_ccw');
%     [r_cw, axmean_sprl_cw] = circ_axialmean(theta_sprl_cw');
%     [r_ccw, axmean_sprl_ccw] = circ_axialmean(theta_sprl_ccw');
%     str_sprl_cw = [{['circular mean = ', num2str(round(rad2deg(mean_sprl_cw))), ' deg; p = ', num2str(pval_sprl_cw)]},...
%         {['axial mean = ', num2str(round(rad2deg(axmean_sprl_cw))),' deg, r = ', num2str(r_cw)]}];
%     str_sprl_ccw = [{['circular mean = ', num2str(round(rad2deg(mean_sprl_ccw))), ' deg; p = ', num2str(pval_sprl_ccw)]},...
%         {['axial mean = ', num2str(round(rad2deg(axmean_sprl_ccw))),' deg, r = ', num2str(r_ccw)]}];
% else
%     mean_sprl_cw = NaN;
%     pval_sprl_cw = NaN;
%     mean_sprl_ccw = NaN;
%     pval_sprl_ccw = NaN;
%     str_sprl_cw = [{['mean = NaN deg']}, {['axial mean = NaN']}];
%     str_sprl_ccw = [{['mean = NaN deg']}, {['axial mean = NaN']}];
% end
% 
% if ~isempty(theta_strp_cw)
%     mean_strp_cw = circ_mean(theta_strp_cw');
%     [pval_strp_cw, ~] = circ_rtest(theta_strp_cw');
%     mean_strp_ccw = circ_mean(theta_strp_ccw');
%     [pval_strp_ccw, ~] = circ_rtest(theta_strp_ccw');
%     [r_cw, axmean_strp_cw] = circ_axialmean(theta_strp_cw');
%     [r_ccw, axmean_strp_ccw] = circ_axialmean(theta_strp_ccw');
%     str_strp_cw = [{['circular mean = ', num2str(round(rad2deg(mean_strp_cw))), ' deg; p = ', num2str(pval_strp_cw)]},...
%         {['axial mean = ', num2str(round(rad2deg(axmean_strp_cw))),' deg, r = ', num2str(r_cw)]}];
%     str_strp_ccw = [{['circular mean = ', num2str(round(rad2deg(mean_strp_ccw))), ' deg; p = ', num2str(pval_strp_ccw)]},...
%         {['axial mean = ', num2str(round(rad2deg(axmean_strp_ccw))),' deg, r = ', num2str(r_ccw)]}];
% else
%     mean_strp_cw = NaN;
%     pval_strp_cw = NaN;
%     mean_strp_ccw = NaN;
%     pval_strp_ccw = NaN;
%     str_strp_cw = [{['mean = NaN deg']}, {['axial mean = NaN']}];
%     str_strp_ccw = [{['mean = NaN deg']}, {['axial mean = NaN']}];
% end
% 
% if ~isempty(theta_thresh_cw)
%     mean_thresh_cw = circ_mean(theta_thresh_cw');
%     [pval_thresh_cw, ~] = circ_rtest(theta_thresh_cw');
%     mean_thresh_ccw = circ_mean(theta_thresh_ccw');
%     [pval_thresh_ccw, ~] = circ_rtest(theta_thresh_ccw');
%     [r_cw, axmean_thresh_cw] = circ_axialmean(theta_thresh_cw');
%     [r_ccw, axmean_thresh_ccw] = circ_axialmean(theta_thresh_ccw');
%     str_thresh_cw = [{['circular mean = ', num2str(round(rad2deg(mean_thresh_cw))), ' deg; p = ', num2str(pval_thresh_cw)]},...
%         {['axial mean = ', num2str(round(rad2deg(axmean_thresh_cw))),' deg, r = ', num2str(r_cw)]}];
%     str_thresh_ccw = [{['circular mean = ', num2str(round(rad2deg(mean_thresh_ccw))), ' deg; p = ', num2str(pval_thresh_ccw)]},...
%         {['axial mean = ', num2str(round(rad2deg(axmean_thresh_ccw))),' deg, r = ', num2str(r_ccw)]}];
% else
%     mean_thresh_cw = NaN;
%     pval_thresh_cw = NaN;
%     mean_thresh_ccw = NaN;
%     pval_thresh_ccw = NaN;
%     str_thresh_cw = [{['mean = NaN deg']}, {['axial mean = NaN']}];
%     str_thresh_ccw = [{['mean = NaN deg']}, {['axial mean = NaN']}];
% end
% % plot
% figure('units','normalized','outerposition',[0 0 1 1]);
% subplot(2,5,1)
% polarplot(angles_cw, MW_cw, 'Color',[0 0 1]); 
% title({'Milky Way', ['Mean of ' num2str(n_MW) ' rotations'], 'clockwise'})
% set(gca, 'RLim', [0 maxval], 'ThetaDir', 'clockwise', 'ThetaZeroLocation','top')
% hold on
% %c = polarplot([0 mean_MW_cw], [0 maxval], 'Color', [0.6 0 0]);
% %set(c, 'LineWidth', 1);
% annotation('textbox',[.135 .1 .9 .47],'String',str_MW_cw,'EdgeColor','none')
% 
% subplot(2,5,6)
% polarplot(angles_ccw, MW_ccw, 'Color',[0 0 1]); 
% set(gca, 'RLim', [0 maxval], 'ThetaDir', 'clockwise', 'ThetaZeroLocation','top')
% title('counter-clockwise')
% hold on
% %c = polarplot([0 mean_MW_ccw], [0 maxval], 'Color', [0.6 0 0]);
% %set(c, 'LineWidth', 1);
% annotation('textbox',[.135 .1 .9 0],'String',str_MW_ccw,'EdgeColor','none')
% 
% 
% subplot(2,5,2)
% polarplot(angles_cw, wdot_cw, 'Color',[0 0 0.5]); 
% set(gca, 'RLim', [0 maxval], 'ThetaDir', 'clockwise', 'ThetaZeroLocation','top')
% title({'White dot', ['Mean of ' num2str(n_wdot) ' rotations'], 'clockwise'})
% hold on
% %c = polarplot([0 mean_wdot_cw], [0 maxval], 'Color', [0.6 0 0]);
% %set(c, 'LineWidth', 1);
% annotation('textbox',[.295 .1 .9 .47],'String',str_wdot_cw,'EdgeColor','none')
% 
% subplot(2,5,7)
% polarplot(angles_ccw, wdot_ccw, 'Color',[0 0 0.5]); 
% set(gca, 'RLim', [0 maxval], 'ThetaDir', 'clockwise', 'ThetaZeroLocation','top')
% title('counter-clockwise')
% hold on
% %c = polarplot([0 mean_wdot_ccw], [0 maxval], 'Color', [0.6 0 0]);
% %set(c, 'LineWidth', 1);
% annotation('textbox',[.295 .1 .9 0],'String',str_wdot_ccw,'EdgeColor','none')
% 
% 
% subplot(2,5,3)
% polarplot(angles_cw, sprl_cw, 'Color',[0 0 0]); 
% set(gca, 'RLim', [0 maxval], 'ThetaDir', 'clockwise', 'ThetaZeroLocation','top')
% title({'Spiral', ['Mean of ' num2str(n_sprl) ' rotations'], 'clockwise'})
% hold on
% %c = polarplot([0 mean_bdot_cw], [0 maxval], 'Color', [0.6 0 0]);
% %set(c, 'LineWidth', 1);
% annotation('textbox',[.45 .1 .9 .47],'String',str_sprl_cw,'EdgeColor','none')
% 
% subplot(2,5,8)
% polarplot(angles_ccw, sprl_ccw, 'Color',[0 0 0]);
% set(gca, 'RLim', [0 maxval], 'ThetaDir', 'clockwise', 'ThetaZeroLocation','top')
% title('counter-clockwise')
% hold on
% %c = polarplot([0 mean_bdot_ccw], [0 maxval], 'Color', [0.6 0 0]);
% %set(c, 'LineWidth', 1);
% annotation('textbox',[.45 .1 .9 0],'String',str_sprl_ccw,'EdgeColor','none')
% 
% 
% subplot(2,5,4)
% polarplot(angles_cw, strp_cw, 'Color',[0 0.5 0]); 
% set(gca, 'RLim', [0 maxval], 'ThetaDir', 'clockwise', 'ThetaZeroLocation','top')
% title({'Stripe', ['Mean of ' num2str(n_strp) ' rotations'], 'clockwise'})
% hold on
% %c = polarplot([0 mean_con_cw], [0 maxval], 'Color', [0.6 0 0]);
% %set(c, 'LineWidth', 1);
% annotation('textbox',[.62 .1 .9 .47],'String',str_strp_cw,'EdgeColor','none')
% 
% subplot(2,5,9)
% polarplot(angles_ccw, strp_ccw, 'Color',[0 0.5 0]); 
% set(gca, 'RLim', [0 maxval], 'ThetaDir', 'clockwise', 'ThetaZeroLocation','top')
% title('counter-clockwise')
% hold on
% %c = polarplot([0 mean_con_ccw], [0 maxval], 'Color', [0.6 0 0]);
% %set(c, 'LineWidth', 1);
% annotation('textbox',[.62 .1 .9 0],'String',str_strp_ccw,'EdgeColor','none')
% 
% subplot(2,5,5)
% polarplot(angles_cw, con_cw, 'Color',[0 0.5 0]); 
% set(gca, 'RLim', [0 maxval], 'ThetaDir', 'clockwise', 'ThetaZeroLocation','top')
% title({'Control image', ['Mean of ' num2str(n_con) ' rotations'], 'clockwise'})
% hold on
% %c = polarplot([0 mean_con_cw], [0 maxval], 'Color', [0.6 0 0]);
% %set(c, 'LineWidth', 1);
% annotation('textbox',[.78 .1 .9 .47],'String',str_con_cw,'EdgeColor','none')
% 
% subplot(2,5,10)
% polarplot(angles_ccw, con_ccw, 'Color',[0 0.5 0]); 
% set(gca, 'RLim', [0 maxval], 'ThetaDir', 'clockwise', 'ThetaZeroLocation','top')
% title('counter-clockwise')
% hold on
% %c = polarplot([0 mean_con_ccw], [0 maxval], 'Color', [0.6 0 0]);
% %set(c, 'LineWidth', 1);
% annotation('textbox',[.78 .1 .9 0],'String',str_con_ccw,'EdgeColor','none')
% print([pathname filesep 'mean_MW_response_polar_all'], '-dpng')
% 
% %clearvars -except pathname fileList

%% export theta vectors for statistical analysis in R
theta_MW_cw = theta_MW_cw';
save([pathname filesep 'theta_MW_cw'],'theta_MW_cw','-ascii','-tabs')
theta_MW_ccw = theta_MW_ccw';
save([pathname filesep 'theta_MW_ccw'],'theta_MW_ccw','-ascii','-tabs')
theta_con_cw = theta_con_cw';
save([pathname filesep 'theta_con_cw'],'theta_con_cw','-ascii','-tabs')
theta_con_ccw = theta_con_ccw';
save([pathname filesep 'theta_con_ccw'],'theta_con_ccw','-ascii','-tabs')
theta_wdot_cw = theta_wdot_cw';
save([pathname filesep 'theta_wdot_cw'],'theta_wdot_cw','-ascii','-tabs')
theta_wdot_ccw = theta_wdot_ccw';
save([pathname filesep 'theta_wdot_ccw'],'theta_wdot_ccw','-ascii','-tabs')
theta_sprl_cw = theta_sprl_cw';
save([pathname filesep 'theta_grad_cw'],'theta_sprl_cw','-ascii','-tabs')
theta_sprl_ccw = theta_sprl_ccw';
save([pathname filesep 'theta_grad_ccw'],'theta_sprl_ccw','-ascii','-tabs')
theta_strp_cw = theta_strp_cw';
save([pathname filesep 'theta_strp_cw'],'theta_strp_cw','-ascii','-tabs')
theta_strp_ccw = theta_strp_ccw';
save([pathname filesep 'theta_strp_ccw'],'theta_strp_ccw','-ascii','-tabs')
theta_thresh_cw = theta_thresh_cw';
save([pathname filesep 'theta_thresh_cw'],'theta_thresh_cw','-ascii','-tabs')
theta_thresh_ccw = theta_thresh_ccw';
save([pathname filesep 'theta_thresh_ccw'],'theta_thresh_ccw','-ascii','-tabs')
% for i = 1:length(theta_MW_cw)
%     MWcw{i,1} = 'MWcw'; MWcw{i,2} = theta_MW_cw(i);
% end
% for i = 1:length(theta_MW_ccw)
%     MWccw{i,1} = 'MWccw'; MWccw{i,2} = theta_MW_ccw(i);
% end
% for i = 1:length(theta_con_cw)
%     Concw{i,1} = 'concw'; Concw{i,2} = theta_con_cw(i);
% end
% for i = 1:length(theta_con_ccw)
%     Conccw{i,1} = 'conccw'; Conccw{i,2} = theta_con_ccw(i);
% end
% for i = 1:length(theta_sprl_cw)
%     Sprlcw{i,1} = 'sprlcw'; Sprlcw{i,2} = theta_sprl_cw(i);
% end
% for i = 1:length(theta_sprl_ccw)
%     Sprlccw{i,1} = 'sprlccw'; Sprlccw{i,2} = theta_sprl_ccw(i);
% end
% for i = 1:length(theta_strp_cw)
%     Strpcw{i,1} = 'strpcw'; Strpcw{i,2} = theta_strp_cw(i);
% end
% for i = 1:length(theta_strp_ccw)
%     Strpccw{i,1} = 'strpccw'; Strpccw{i,2} = theta_strp_ccw(i);
% end
% for i = 1:length(theta_wdot_cw)
%     Wdotcw{i,1} = 'wdotcw'; Wdotcw{i,2} = theta_wdot_cw(i);
% end
% for i = 1:length(theta_wdot_ccw)
%     Wdotccw{i,1} = 'wdotccw'; Wdotccw{i,2} = theta_wdot_ccw(i);
% end
% MWcw = [ones(1,length(theta_MW_cw))*11;theta_MW_cw];
% MWccw = [ones(1,length(theta_MW_cw))*12;theta_MW_cw];
% Concw = [ones(1,length(theta_con_cw))*21;theta_con_cw];
% Conccw = [ones(1,length(theta_con_cw))*22;theta_con_cw];
% Sprlcw = [ones(1,length(theta_sprl_cw))*31;theta_sprl_cw];
% Sprlccw = [ones(1,length(theta_sprl_cw))*32;theta_sprl_cw];
% Strpcw = [ones(1,length(theta_strp_cw))*41;theta_strp_cw];
% Strpccw = [ones(1,length(theta_strp_cw))*42;theta_strp_cw];
% Wdotcw = [ones(1,length(theta_wdot_cw))*51;theta_wdot_cw];
% Wdotccw = [ones(1,length(theta_wdot_cw))*52;theta_wdot_cw];
% Datarad = [MWcw'; MWccw'; Concw'; Conccw'; Sprlcw'; Sprlccw'; Strpcw'; Strpccw';...
%     Wdotcw'; Wdotccw'];
% 
% save([pathname filesep 'Datarad.mat'],'Datarad')
%% circular means for each rotation
mean_cw = mean_cw*180/pi;
mean_ccw = mean_ccw*180/pi;
save([pathname filesep 'Milky_circ_means'], 'mean_cw', 'mean_ccw')



% %% circular plots for inhibited cells
% fileList = getAllFiles(pathname, 'FileFilter', '\.mat$');
% X_MW_cw = []; Y_MW_cw = []; X_MW_ccw = []; Y_MW_ccw = [];
% A_MW_cw = []; B_MW_cw = []; A_MW_ccw = []; B_MW_ccw = [];
% 
% for i = 1:length(fileList)
%     load(fileList{i});
%     
%     if contains(fileList{i},'MW')
%         colour = 'b';
%         name = 'MW';
%     else
%         continue
%     end
%     
%     % cut data
%     cw = response.events(stimulus.cw_on_off(1):stimulus.cw_on_off(2));
%     ccw = response.events(stimulus.ccw_on_off(1):stimulus.ccw_on_off(2));
%     cw_ISI = diff(find(cw))/10;
%     ccw_ISI = diff(find(ccw))/10;
%     
%     % get angles for each spike
%     angles_rad_cw = deg2rad(round(linspace(0,360,length(stimulus.cw_on_off(1):stimulus.cw_on_off(2))+1)));
%     spikes_cw = find(response.events(stimulus.cw_on_off(1):stimulus.cw_on_off(2)));
%     theta_cw = angles_rad_cw(spikes_cw);
%     theta_cw_inb = rad2deg((theta_cw(2:end) + theta_cw(1:end-1))/2);
%     angles_rad_ccw = fliplr(deg2rad(round(linspace(0,360,length(stimulus.ccw_on_off(1):stimulus.ccw_on_off(2))+1))));
%     spikes_ccw = find(response.events(stimulus.ccw_on_off(1):stimulus.ccw_on_off(2)));
%     theta_ccw = angles_rad_ccw(spikes_ccw);
%     theta_ccw_inb = rad2deg((theta_ccw(2:end) + theta_ccw(1:end-1))/2); % in between
%     
%     [Xcw, Ycw] = pol2cart(theta_cw_inb, cw_ISI);
%     [Xccw, Yccw] = pol2cart(theta_ccw_inb, ccw_ISI);
%     
%     X_MW_cw = [X_MW_cw Xcw];
%     Y_MW_cw = [Y_MW_cw Ycw];
%     X_MW_ccw = [X_MW_ccw Xccw];
%     Y_MW_ccw = [Y_MW_ccw Yccw];
%     
%     A_MW_cw = [A_MW_cw theta_cw_inb];
%     B_MW_cw = [B_MW_cw cw_ISI];
%     A_MW_ccw = [A_MW_ccw theta_ccw_inb];
%     B_MW_ccw = [B_MW_ccw ccw_ISI];
% end
% MW_CW = zeros(length(A_MW_cw), 2);
% MW_CW(:,1) = B_MW_cw';
% MW_CW(:,2) = A_MW_cw';
% 
% MW_CCW = zeros(length(A_MW_ccw), 2);
% MW_CCW(:,1) = B_MW_ccw';
% MW_CCW(:,2) = A_MW_ccw';
% 
% figure(1)
% compass(X_MW_cw, Y_MW_cw, '-k')
% title('CW')
% figure(2)
% compass(X_MW_ccw, Y_MW_ccw, '-b')
% title('CCW')
% 
% save([pathname filesep 'inhib_angles'], 'MW_CW', 'MW_CCW')
