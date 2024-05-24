%% Figure 1: plot filtered mean with standard deviation
figure('units', 'normalized', 'outerposition', [0 0 1 1]) % full width
% clockwise responses
subplot(1, 2, 1)
hold on
xlim([0, 360])
% Milky Way, not corrected
if exist('f_MWcw', 'var')
    plot([0 360], [mean(BGMW) mean(BGMW)], '--k','LineWidth',1)
    ss1 = plot(1:360, f_MWcw, 'k','LineWidth',2);
    patch([1:360 fliplr(1:360)], ...
        [(f_MWcw + std(fi_MWcw, 0, 1)) ...
        fliplr((f_MWcw - std(fi_MWcw, 0, 1)))], ...
        'k', 'linestyle', 'none', 'FaceAlpha', 0.2);
else
    ss1 = plot([0 360], [1 1], 'k', 'LineWidth', 1, 'Visible', 'off');
end

% Control
if exist('f_CONcw', 'var')
    plot([0 360], [mean(BGCon) mean(BGCon)], '--r','LineWidth',1)
    ss8 = plot(1:360, f_CONcw, 'Color','r','LineWidth',2);
    patch([1:360 fliplr(1:360)], ...
        [(f_CONcw + std(fi_CONcw, 0, 1)) ...
        fliplr((f_CONcw - std(fi_CONcw, 0, 1)))], ...
        'r', 'linestyle', 'none', 'FaceAlpha', 0.2);
else
    ss8 = plot([0 360], [1 1], 'Color','r', 'LineWidth', 1, 'Visible', 'off');
end

% Corrected for long-axis offset
if exist('f_MWcw2', 'var')
    ss2 = plot(1:360, f_MWcw2, 'Color', [0.4 0.4 0.4], 'LineWidth',2);
    patch([1:360 fliplr(1:360)], ...
        [(f_MWcw2 + std(fi_MWcw2, 0, 1)) ...
        fliplr((f_MWcw2 - std(fi_MWcw2, 0, 1)))], ...
        'k', 'linestyle', 'none', 'FaceAlpha', 0.2);
else
    ss2 = plot([0 360], [1 1], 'Color',[0.4 0.4 0.4] , 'LineWidth', 1, 'Visible', 'off');
end

% % Thresholded Milky Way
% if exist('f_THRcw', 'var')
%     plot([0 360], [mean(BGThr) mean(BGThr)], '--b','LineWidth',1)
%     ss3 = plot(1:360, f_THRcw, 'b','LineWidth',2);
%     patch([1:360 fliplr(1:360)], ...
%         [(f_THRcw + std(fi_THRcw, 0, 1)) ...
%         fliplr((f_THRcw - std(fi_THRcw, 0, 1)))], ...
%         'b', 'linestyle', 'none', 'FaceAlpha', 0.2);
% else
%     ss3 = plot([0 360], [1 1], 'b', 'LineWidth', 1, 'Visible', 'off');
% end

% % Bar
% if exist('f_BARcw', 'var')
%     plot([0 360], [mean(BGBar) mean(BGBar)], '--g','LineWidth',1)
%     ss4 = plot(1:360, f_BARcw, 'g','LineWidth',2);
%     patch([1:360 fliplr(1:360)], ...
%         [(f_BARcw + std(fi_BARcw, 0, 1)) ...
%         fliplr((f_BARcw - std(fi_BARcw, 0, 1)))], ...
%         'g', 'linestyle', 'none', 'FaceAlpha', 0.2);
% else
%     ss4 = plot([0 360], [1 1], 'g', 'LineWidth', 1, 'Visible', 'off');
% end
% 
% Gradient bar
if exist('f_GRDcw', 'var')
    plot([0 360], [mean(BGGrd) mean(BGGrd)], '--c','LineWidth',1)
    ss5 = plot(1:360, f_GRDcw, 'c','LineWidth',2);
    patch([1:360 fliplr(1:360)], ...
        [(f_GRDcw + std(fi_GRDcw, 0, 1)) ...
        fliplr((f_GRDcw - std(fi_GRDcw, 0, 1)))], ...
        'c', 'linestyle', 'none', 'FaceAlpha', 0.2);
else
    ss5 = plot([0 360], [1 1], 'c', 'LineWidth', 1, 'Visible', 'off');
end

% Dot
if exist('f_DOTcw', 'var')
    plot([0 360], [mean(BGDot) mean(BGDot)], '--m','LineWidth',1)
    ss6 = plot(1:360, f_DOTcw, 'm','LineWidth',2);
    patch([1:360 fliplr(1:360)], ...
        [(f_DOTcw + std(fi_DOTcw, 0, 1)) ...
        fliplr((f_DOTcw - std(fi_DOTcw, 0, 1)))], ...
        'm', 'linestyle', 'none', 'FaceAlpha', 0.2);
else
    ss6 = plot([0 360], [1 1], 'm', 'LineWidth', 1, 'Visible', 'off');
end
leg = legend([ss1, ss8, ss2, ss6, ss5], 'Milky Way', 'Control', ...
    'Milky Way long axis', 'Dot', 'Gradient bar');
set(leg, 'FontSize', 10, 'Location', 'best')
xlabel('Rotation angle (deg)', 'FontSize', 12)
ylabel('Frequency (imp/s)', 'FontSize', 12)
title('Clockwise rotation', 'FontSize', 14)

subplot(1, 2, 2)
hold on
xlim([0, 360])
% Milky Way, not corrected
if exist('f_MWccw', 'var')
    plot([0 360], [mean(BGMW) mean(BGMW)], '--k','LineWidth',1)
    plot(1:360, f_MWccw, 'k','LineWidth',2)
    patch([1:360 fliplr(1:360)], ...
        [(f_MWccw + std(fi_MWccw, 0, 1)) ...
        fliplr((f_MWccw - std(fi_MWccw, 0, 1)))], ...
        'k', 'linestyle', 'none', 'FaceAlpha', 0.2);
else
end

% Control
if exist('f_CONccw', 'var')
    plot([0 360], [mean(BGCon) mean(BGCon)], '--r','LineWidth',1)
    plot(1:360, f_CONccw, 'Color', 'r', 'LineWidth',2)
    patch([1:360 fliplr(1:360)], ...
        [(f_CONccw + std(fi_CONccw, 0, 1)) ...
        fliplr((f_CONccw - std(fi_CONccw, 0, 1)))], ...
        'r', 'linestyle', 'none', 'FaceAlpha', 0.2);
else
end

% Milky Way corrected for long axis
if exist('f_MWccw2', 'var')
    plot(1:360, f_MWccw2, 'Color', [0.4 0.4 0.4], 'LineWidth',2)
    patch([1:360 fliplr(1:360)], ...
        [(f_MWccw2 + std(fi_MWccw2, 0, 1)) ...
        fliplr((f_MWccw2 - std(fi_MWccw2, 0, 1)))], ...
        'k', 'linestyle', 'none', 'FaceAlpha', 0.2);
else
end
% 
% % Thresholded Milky Way
% if exist('f_THRccw', 'var')
%     plot([0 360], [mean(BGThr) mean(BGThr)], '--b','LineWidth',1)
%     plot(1:360, f_THRccw, 'b','LineWidth',2)
%     patch([1:360 fliplr(1:360)], ...
%         [(f_THRccw + std(fi_THRccw, 0, 1)) ...
%         fliplr((f_THRccw - std(fi_THRccw, 0, 1)))], ...
%         'b', 'linestyle', 'none', 'FaceAlpha', 0.2);
% else
% end
% 
% % Bar
% if exist('f_BARccw', 'var')
%     plot([0 360], [mean(BGBar) mean(BGBar)], '--g','LineWidth',1)
%     plot(1:360, f_BARccw, 'g','LineWidth',2)
%     patch([1:360 fliplr(1:360)], ...
%         [(f_BARccw + std(fi_BARccw, 0, 1)) ...
%         fliplr((f_BARccw - std(fi_BARccw, 0, 1)))], ...
%         'g', 'linestyle', 'none', 'FaceAlpha', 0.2);
% else
% end
% 
% Gradient bar
if exist('f_GRDccw', 'var')
    plot([0 360], [mean(BGGrd) mean(BGGrd)], '--c','LineWidth',1)
    plot(1:360, f_GRDccw, 'c','LineWidth',2)
    patch([1:360 fliplr(1:360)], ...
        [(f_GRDccw + std(fi_GRDccw, 0, 1)) ...
        fliplr((f_GRDccw - std(fi_GRDccw, 0, 1)))], ...
        'c', 'linestyle', 'none', 'FaceAlpha', 0.2);
else
end

% Dot
if exist('f_DOTccw', 'var')
    plot([0 360], [mean(BGDot) mean(BGDot)], '--m','LineWidth',1)
    plot(1:360, f_DOTccw, 'm','LineWidth',2)
    patch([1:360 fliplr(1:360)], ...
        [(f_DOTccw + std(fi_DOTccw, 0, 1)) ...
        fliplr((f_DOTccw - std(fi_DOTccw, 0, 1)))], ...
        'm', 'linestyle', 'none', 'FaceAlpha', 0.2);
else
end
xlabel('Rotation angle (deg)', 'FontSize', 12)
ylabel('Frequency (imp/s)', 'FontSize', 12)
title('Counter-clockwise rotation', 'FontSize', 14)

linkaxes
print([pathname filesep 'timecomp'], '-dpng')

prompt = {'CW max:', 'CW max2', 'CCW max:', 'CCW max2'};
dlgtitle = 'Input';
dims = [1 35];
definput = {'180','NaN','180','NaN'};
answer = inputdlg(prompt,dlgtitle,dims,definput);

%% Signal to noise ratio
close
exp_maxcw = [str2num(answer{1}) str2num(answer{2})]; % approximate expected phi max clockwise-- two values if cell is bimodal
exp_maxccw = [str2num(answer{3}) str2num(answer{4})];

if exist('fi_MWcw', 'var') & ~isnan(fi_MWcw)
    [MWcw_snr1, MWcw_snr2, MWcw_phimax1, MWcw_phimax2] = AA_snr(fi_MWcw, BGsemMW, BGMW, exp_maxcw);
    [MWccw_snr1, MWccw_snr2, MWccw_phimax1, MWccw_phimax2] = AA_snr(fi_MWccw, BGsemMW, BGMW, exp_maxccw);
else
    MWcw_snr1 = [];
    MWccw_snr1 = [];
    MWcw_snr2 = [];
    MWccw_snr2 = [];
    MWcw_phimax1 = [];
    MWccw_phimax1 = [];
    MWcw_phimax2 = [];
    MWccw_phimax2 = [];
end

if exist('fi_CONcw', 'var') & ~isnan(fi_CONcw)
    [CONcw_snr1, CONcw_snr2, CONcw_phimax1, CONcw_phimax2] = AA_snr(fi_CONcw, BGsemCon, BGCon, exp_maxcw);
    [CONccw_snr1, CONccw_snr2, CONccw_phimax1, CONccw_phimax2] = AA_snr(fi_CONccw, BGsemCon, BGCon, exp_maxccw);
else
    CONcw_snr1 = [];
    CONccw_snr1 = [];
    CONcw_snr2 = [];
    CONccw_snr2 = [];
    CONcw_phimax1 = [];
    CONccw_phimax1 = [];
    CONcw_phimax2 = [];
    CONccw_phimax2 = [];
end

if exist('fi_THRcw', 'var') & ~isnan(fi_THRcw)
    [THRcw_snr1, THRcw_snr2, THRcw_phimax1, THRcw_phimax2] = AA_snr(fi_THRcw, BGsemThr, BGThr, exp_maxcw);
    [THRccw_snr1, THRccw_snr2, THRccw_phimax1, THRccw_phimax2] = AA_snr(fi_THRccw, BGsemThr, BGThr, exp_maxccw);
else
    THRcw_snr1 = [];
    THRccw_snr1 = [];
    THRcw_snr2 = [];
    THRccw_snr2 = [];
    THRcw_phimax1 = [];
    THRccw_phimax1 = [];
    THRcw_phimax2 = [];
    THRccw_phimax2 = [];
end

if exist('fi_DOTcw', 'var') & ~isnan(fi_DOTcw)
    [DOTcw_snr1, DOTcw_snr2, DOTcw_phimax1, DOTcw_phimax2] = AA_snr(fi_DOTcw, BGsemDot, BGDot, exp_maxcw);
    [DOTccw_snr1, DOTccw_snr2, DOTccw_phimax1, DOTccw_phimax2] = AA_snr(fi_DOTccw, BGsemDot, BGDot, exp_maxccw);
else
    DOTcw_snr1 = [];
    DOTccw_snr1 = [];
    DOTcw_snr2 = [];
    DOTccw_snr2 = [];
    DOTcw_phimax1 = [];
    DOTccw_phimax1 = [];
    DOTcw_phimax2 = [];
    DOTccw_phimax2 = [];
end

if exist('fi_BARcw', 'var') & ~isnan(fi_BARcw)
    [BARcw_snr1, BARcw_snr2, BARcw_phimax1, BARcw_phimax2] = AA_snr(fi_BARcw, BGsemBar, BGBar, exp_maxcw);
    [BARccw_snr1, BARccw_snr2, BARccw_phimax1, BARccw_phimax2] = AA_snr(fi_BARccw, BGsemBar, BGBar, exp_maxccw);
else
    BARcw_snr1 = [];
    BARccw_snr1 = [];
    BARcw_snr2 = [];
    BARccw_snr2 = [];
    BARcw_phimax1 = [];
    BARccw_phimax1 = [];
    BARcw_phimax2 = [];
    BARccw_phimax2 = [];
end

if exist('fi_GRDcw', 'var') & ~isnan(fi_GRDcw)
    [GRDcw_snr1, GRDcw_snr2, GRDcw_phimax1, GRDcw_phimax2] = AA_snr(fi_GRDcw, BGsemGrd, BGGrd, exp_maxcw);
    [GRDccw_snr1, GRDccw_snr2, GRDccw_phimax1, GRDccw_phimax2] = AA_snr(fi_GRDccw, BGsemGrd, BGGrd, exp_maxccw);
else
    GRDcw_snr1 = [];
    GRDccw_snr1 = [];
    GRDcw_snr2 = [];
    GRDccw_snr2 = [];
    GRDcw_phimax1 = [];
    GRDccw_phimax1 = [];
    GRDcw_phimax2 = [];
    GRDccw_phimax2 = [];
end

close
%%
figure('units', 'normalized', 'outerposition', [0 0 1 1])
Y = [mean(MWcw_snr1) mean(MWccw_snr1); ...
    mean(CONcw_snr1) mean(CONccw_snr1); ...
    mean(THRcw_snr1) mean(THRccw_snr1); ...
    mean(DOTcw_snr1) mean(DOTccw_snr1); ...
    mean(BARcw_snr1) mean(BARccw_snr1); ...
    mean(GRDcw_snr1) mean(GRDccw_snr1)];
err = [std(MWcw_snr1) std(MWccw_snr1); ...
    std(CONcw_snr1) std(CONccw_snr1); ...
    std(THRcw_snr1) std(THRccw_snr1); ...
    std(DOTcw_snr1) std(DOTccw_snr1); ...
    std(BARcw_snr1) std(BARccw_snr1); ...
    std(GRDcw_snr1) std(GRDccw_snr1)];
errloc = [1 1; 2 2; 3 3; 4 4; 5 5; 6 6;] ...
    + [-0.15 0.15; -0.15 0.15; -0.15 0.15; -0.15 0.15; -0.15 0.15; -0.15 0.15];
bar(Y)
hold on
errorbar(errloc, Y, err, 'ok')
ylabel('Signal-to-noise ratio');
xlabel('Stimulus');
set(gca, 'xticklabels', {'Sky', 'Control', 'Thresholded sky', 'Dot', 'Bar', 'Gradient bar'}, ...
    'FontSize', 14)
title(pathname)
axes = gca;
ypos1 = axes.YLim(2)-(axes.YTick(end)-axes.YTick(end-1))/2;
ypos2 = axes.YLim(2)-2*((axes.YTick(end)-axes.YTick(end-1))/2);

text(0.7, ypos1, ['mean cw phi_m_a_x = ', num2str(mean(MWcw_phimax1)), ' deg'])
text(1.7, ypos1, ['mean cw phi_m_a_x = ', num2str(mean(CONcw_phimax1)), ' deg'])
text(2.7, ypos1, ['mean cw phi_m_a_x = ', num2str(mean(THRcw_phimax1)), ' deg'])
text(3.7, ypos1, ['mean cw phi_m_a_x = ', num2str(mean(DOTcw_phimax1)), ' deg'])
text(4.7, ypos1, ['mean cw phi_m_a_x = ', num2str(mean(BARcw_phimax1)), ' deg'])
text(5.7, ypos1, ['mean cw phi_m_a_x = ', num2str(mean(GRDcw_phimax1)), ' deg'])

text(0.7, ypos2, ['mean ccw phi_m_a_x = ', num2str(mean(MWccw_phimax1)), ' deg'])
text(1.7, ypos2, ['mean ccw phi_m_a_x = ', num2str(mean(CONccw_phimax1)), ' deg'])
text(2.7, ypos2, ['mean ccw phi_m_a_x = ', num2str(mean(THRccw_phimax1)), ' deg'])
text(3.7, ypos2, ['mean ccw phi_m_a_x = ', num2str(mean(DOTccw_phimax1)), ' deg'])
text(4.7, ypos2, ['mean ccw phi_m_a_x = ', num2str(mean(BARccw_phimax1)), ' deg'])
text(5.7, ypos2, ['mean ccw phi_m_a_x = ', num2str(mean(GRDccw_phimax1)), ' deg'])

print([pathname filesep 'SNR'], '-dpng')

SNRall1 = struct('MWcw', MWcw_snr1, 'MWccw', MWccw_snr1, ...
    'CONcw', CONcw_snr1, 'CONccw', CONccw_snr1,...
    'THRcw', THRcw_snr1, 'THRccw', THRccw_snr1, ...
    'DOTcw', DOTcw_snr1, 'DOTccw', DOTccw_snr1, ...
    'BARcw', BARcw_snr1, 'BARccw', BARccw_snr1, ...
    'GRDcw', GRDcw_snr1, 'GRDccw', GRDccw_snr1);
Phimaxall1 = struct('MWcw', MWcw_phimax1, 'MWccw', MWccw_phimax1, ...
    'CONcw', CONcw_phimax1, 'CONccw', CONccw_phimax1,...
    'THRcw', THRcw_phimax1, 'THRccw', THRccw_phimax1, ...
    'DOTcw', DOTcw_phimax1, 'DOTccw', DOTccw_phimax1, ...
    'BARcw', BARcw_phimax1, 'BARccw', BARccw_phimax1, ...
    'GRDcw', GRDcw_phimax1, 'GRDccw', GRDccw_phimax1);

SNRall2 = struct('MWcw', MWcw_snr2, 'MWccw', MWccw_snr2, ...
    'CONcw', CONcw_snr2, 'CONccw', CONccw_snr2,...
    'THRcw', THRcw_snr2, 'THRccw', THRccw_snr2, ...
    'DOTcw', DOTcw_snr2, 'DOTccw', DOTccw_snr2, ...
    'BARcw', BARcw_snr2, 'BARccw', BARccw_snr2, ...
    'GRDcw', GRDcw_snr2, 'GRDccw', GRDccw_snr2);
Phimaxall2 = struct('MWcw', MWcw_phimax2, 'MWccw', MWccw_phimax2, ...
    'CONcw', CONcw_phimax2, 'CONccw', CONccw_phimax2,...
    'THRcw', THRcw_phimax2, 'THRccw', THRccw_phimax2, ...
    'DOTcw', DOTcw_phimax2, 'DOTccw', DOTccw_phimax2, ...
    'BARcw', BARcw_phimax2, 'BARccw', BARccw_phimax2, ...
    'GRDcw', GRDcw_phimax2, 'GRDccw', GRDccw_phimax2);

save([pathname filesep 'SNR_PHI_all'], 'SNRall1', 'Phimaxall1', 'SNRall2', 'Phimaxall2')