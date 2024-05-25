% PLOT FILTERED MEAN WITH STANDARD DEVIATION

figure('units', 'normalized', 'outerposition', [0 0 1 1]) % full width

% clockwise responses
subplot(1, 2, 1)
hold on

% Starry sky
if exist('f_MWcw', 'var')
    ss4 = plot([0 360], [mean(BGMW) mean(BGMW)], '--b','LineWidth',3);
    ss1 = plot(1:360, f_MWcw, 'b','LineWidth',3);
    %patch([1:360 fliplr(1:360)], ...
    %    [(f_MWcw + std(fi_MWcw, 0, 1)) ...
    %    fliplr((f_MWcw - std(fi_MWcw, 0, 1)))], ...
    %    'k', 'linestyle', 'none', 'FaceAlpha', 0.25);
    plot(1:360, fi_MWcw, 'b', 'LineWidth', 0.5)
else
    ss1 = plot([0 360], [1 1], 'k', 'LineWidth', 1, 'Visible', 'off');
end

% Control
if exist('f_CONcw', 'var')
    ss3 = plot([0 360], [mean(BGCon) mean(BGCon)], '--', 'Color', [0.6 0.6 0.6],'LineWidth',3);
    ss2 = plot(1:360, f_CONcw, '-', 'Color',[0.6 0.6 0.6],'LineWidth',3);
%     patch([1:360 fliplr(1:360)], ...
%         [(f_CONcw + std(fi_CONcw, 0, 1)) ...
%         fliplr((f_CONcw - std(fi_CONcw, 0, 1)))], ...
%         'k', 'linestyle', 'none', 'FaceAlpha', 0.1);
    plot(1:360, fi_CONcw, 'Color', [0.6 0.6 0.6], 'LineWidth', 0.5)
else
    ss2 = plot([0 360], [1 1], 'Color',[0.6 0.6 0.6], 'LineWidth', 1, 'Visible', 'off');
    ss3 = plot([0 360], [1 1], '--', 'Color',[0.6 0.6 0.6], 'LineWidth', 1, 'Visible', 'off');
end

leg = legend([ss1, ss4, ss2, ss3], 'Starry sky', 'Starry sky pre-stim activity', ...
   'Control', 'Control pre-stim activity');
set(leg, 'FontSize', 18, 'Location', 'best')
xlim([0, 360])
xticks([0, 180, 360])
xticklabels({'0', '180', '360'})
xlabel('Stimulus angle (deg)')
ylabel('Frequency (imp/s)')
set(gca, 'FontSize', 36)
title('CW rotation', 'FontSize', 44, 'FontWeight', 'normal')

%
subplot(1, 2, 2)
hold on

% Starry sky
if exist('f_MWccw', 'var')
    plot([0 360], [mean(BGMW) mean(BGMW)], '--b','LineWidth',3)
    plot(1:360, f_MWccw, 'b','LineWidth',3)
%     patch([1:360 fliplr(1:360)], ...
%         [(f_MWccw + std(fi_MWccw, 0, 1)) ...
%         fliplr((f_MWccw - std(fi_MWccw, 0, 1)))], ...
%         'k', 'linestyle', 'none', 'FaceAlpha', 0.25);
    plot(1:360, fi_MWccw, 'b','LineWidth',0.5)
else
end

% Control
if exist('f_CONccw', 'var')
    plot([0 360], [mean(BGCon) mean(BGCon)], '--', 'Color', [0.6 0.6 0.6],'LineWidth',3)
    plot(1:360, f_CONccw, '-', 'Color', [0.6 0.6 0.6], 'LineWidth',3)
%     patch([1:360 fliplr(1:360)], ...
%         [(f_CONccw + std(fi_CONccw, 0, 1)) ...
%         fliplr((f_CONccw - std(fi_CONccw, 0, 1)))], ...
%         'k', 'linestyle', 'none', 'FaceAlpha', 0.1);
    plot(1:360, fi_CONccw, 'Color', [0.6 0.6 0.6], 'LineWidth', 0.5)
else
end

xlim([0, 360])
xticks([0, 180, 360])
xticklabels({'0', '180', '360'})
xlabel('Stimulus angle (deg)')
ylabel('Frequency (imp/s)')
set(gca, 'FontSize', 36)
title('CCW rotation', 'FontSize', 44, 'FontWeight', 'normal')


linkaxes
print([pathname filesep 'MW-CON_forSuppl'], '-dpng')
saveas(gca,[pathname filesep 'MW-CON_forSuppl'], 'svg')

%%
% % PLOT FILTERED MEAN WITH STANDARD DEVIATION
% 
% figure('units', 'normalized', 'outerposition', [0 0 1 1]) % full width
% 
% % clockwise responses
% subplot(1, 2, 1)
% hold on
% 
% % Milky Way, not corrected
% if exist('f_MWcw', 'var')
%     plot([0 360], [mean(BGMW) mean(BGMW)], '--k','LineWidth',1)
%     ss1 = plot(1:360, f_MWcw, 'k','LineWidth',2);
%     patch([1:360 fliplr(1:360)], ...
%         [(f_MWcw + std(fi_MWcw, 0, 1)) ...
%         fliplr((f_MWcw - std(fi_MWcw, 0, 1)))], ...
%         'k', 'linestyle', 'none', 'FaceAlpha', 0.2);
% else
%     ss1 = plot([0 360], [1 1], 'k', 'LineWidth', 1, 'Visible', 'off');
% end
% 
% % Control
% if exist('f_CONcw', 'var')
%     plot([0 360], [mean(BGCon) mean(BGCon)], '--r','LineWidth',1)
%     ss2 = plot(1:360, f_CONcw, 'Color','r','LineWidth',2);
%     patch([1:360 fliplr(1:360)], ...
%         [(f_CONcw + std(fi_CONcw, 0, 1)) ...
%         fliplr((f_CONcw - std(fi_CONcw, 0, 1)))], ...
%         'r', 'linestyle', 'none', 'FaceAlpha', 0.2);
% else
%     ss2 = plot([0 360], [1 1], 'Color','r', 'LineWidth', 1, 'Visible', 'off');
% end
% 
% leg = legend([ss1, ss2, ss2, ss6, ss5], 'Milky Way', 'Control', ...
%     'Milky Way long axis', 'Dot', 'Gradient bar');
% set(leg, 'FontSize', 10, 'Location', 'best')
% xlim([0, 360])
% xlabel('Rotation angle (deg)', 'FontSize', 12)
% ylabel('Frequency (imp/s)', 'FontSize', 12)
% title('Clockwise rotation', 'FontSize', 14)
% 
% %
% subplot(1, 2, 2)
% hold on
% 
% % Milky Way, not corrected
% if exist('f_MWccw', 'var')
%     plot([0 360], [mean(BGMW) mean(BGMW)], '--k','LineWidth',1)
%     plot(1:360, f_MWccw, 'k','LineWidth',2)
%     patch([1:360 fliplr(1:360)], ...
%         [(f_MWccw + std(fi_MWccw, 0, 1)) ...
%         fliplr((f_MWccw - std(fi_MWccw, 0, 1)))], ...
%         'k', 'linestyle', 'none', 'FaceAlpha', 0.2);
% else
% end
% 
% % Control
% if exist('f_CONccw', 'var')
%     plot([0 360], [mean(BGCon) mean(BGCon)], '--r','LineWidth',1)
%     plot(1:360, f_CONccw, 'Color', 'r', 'LineWidth',2)
%     patch([1:360 fliplr(1:360)], ...
%         [(f_CONccw + std(fi_CONccw, 0, 1)) ...
%         fliplr((f_CONccw - std(fi_CONccw, 0, 1)))], ...
%         'r', 'linestyle', 'none', 'FaceAlpha', 0.2);
% else
% end
% 
% xlim([0, 360])
% xlabel('Rotation angle (deg)', 'FontSize', 12)
% ylabel('Frequency (imp/s)', 'FontSize', 12)
% title('Counter-clockwise rotation', 'FontSize', 14)
% 
% linkaxes
% print([pathname filesep 'MW-CON'], '-dpng')