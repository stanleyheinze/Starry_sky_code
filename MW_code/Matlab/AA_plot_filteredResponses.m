%% Figure 1: plot filtered mean with standard deviation
figure('units', 'normalized', 'outerposition', [0 0 1 1]) % full width
% clockwise responses
subplot(1, 2, 1)
hold on
xlim([0, 360])
% Milky Way
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
    plot([0 360], [mean(BGCon) mean(BGCon)], '--', 'Color', [0.6 0.6 0.6], 'LineWidth',1)
    ss2 = plot(1:360, f_CONcw, 'Color', [0.6 0.6 0.6], 'LineWidth',2);
    patch([1:360 fliplr(1:360)], ...
        [(f_CONcw + std(fi_CONcw, 0, 1)) ...
        fliplr((f_CONcw - std(fi_CONcw, 0, 1)))], ...
        'k', 'linestyle', 'none', 'FaceAlpha', 0.2);
else
    ss2 = plot([0 360], [1 1], 'Color',[0.6 0.6 0.6] , 'LineWidth', 1, 'Visible', 'off');
end

% Thresholded Milky Way
if exist('f_THRcw', 'var')
    plot([0 360], [mean(BGThr) mean(BGThr)], '--b','LineWidth',1)
    ss3 = plot(1:360, f_THRcw, 'b','LineWidth',2);
    patch([1:360 fliplr(1:360)], ...
        [(f_THRcw + std(fi_THRcw, 0, 1)) ...
        fliplr((f_THRcw - std(fi_THRcw, 0, 1)))], ...
        'b', 'linestyle', 'none', 'FaceAlpha', 0.2);
else
    ss3 = plot([0 360], [1 1], 'b', 'LineWidth', 1, 'Visible', 'off');
end

% Bar
if exist('f_BARcw', 'var')
    plot([0 360], [mean(BGBar) mean(BGBar)], '--g','LineWidth',1)
    ss4 = plot(1:360, f_BARcw, 'g','LineWidth',2);
    patch([1:360 fliplr(1:360)], ...
        [(f_BARcw + std(fi_BARcw, 0, 1)) ...
        fliplr((f_BARcw - std(fi_BARcw, 0, 1)))], ...
        'g', 'linestyle', 'none', 'FaceAlpha', 0.2);
else
    ss4 = plot([0 360], [1 1], 'g', 'LineWidth', 1, 'Visible', 'off');
end

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
leg = legend([ss1, ss2, ss3, ss4, ss5, ss6], 'Sky', 'Control', 'Thresholded sky', 'Bar', 'Gradient bar', 'Dot');
set(leg, 'FontSize', 10, 'Location', 'best')
xlabel('Rotation angle (deg)', 'FontSize', 12)
ylabel('Frequency (imp/s)', 'FontSize', 12)
title('Clockwise rotation', 'FontSize', 14)

subplot(1, 2, 2)
hold on
xlim([0, 360])
% Milky Way
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
    plot([0 360], [mean(BGCon) mean(BGCon)], '--', 'Color', [0.75 0.75 0.75], 'LineWidth',1)
    plot(1:360, f_CONccw, 'Color', [0.6 0.6 0.6], 'LineWidth',2)
    patch([1:360 fliplr(1:360)], ...
        [(f_CONccw + std(fi_CONccw, 0, 1)) ...
        fliplr((f_CONccw - std(fi_CONccw, 0, 1)))], ...
        'k', 'linestyle', 'none', 'FaceAlpha', 0.2);
else
end

% Thresholded Milky Way
if exist('f_THRccw', 'var')
    plot([0 360], [mean(BGThr) mean(BGThr)], '--b','LineWidth',1)
    plot(1:360, f_THRccw, 'b','LineWidth',2)
    patch([1:360 fliplr(1:360)], ...
        [(f_THRccw + std(fi_THRccw, 0, 1)) ...
        fliplr((f_THRccw - std(fi_THRccw, 0, 1)))], ...
        'b', 'linestyle', 'none', 'FaceAlpha', 0.2);
else
end

% Bar
if exist('f_BARccw', 'var')
    plot([0 360], [mean(BGBar) mean(BGBar)], '--g','LineWidth',1)
    plot(1:360, f_BARccw, 'g','LineWidth',2)
    patch([1:360 fliplr(1:360)], ...
        [(f_BARccw + std(fi_BARccw, 0, 1)) ...
        fliplr((f_BARccw - std(fi_BARccw, 0, 1)))], ...
        'g', 'linestyle', 'none', 'FaceAlpha', 0.2);
else
end

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
print([pathname filesep 'AllStim_mean'], '-dpng')

%% Figure 2: plot filtered mean with standard deviation in individual plots
figure('units', 'normalized', 'outerposition', [0 0 1 1]) % full width
subplot(2, 3, 1)
hold on
xlim([0, 360])
if exist('f_MWcw', 'var')
    plot([0 360], [mean(BGMW) mean(BGMW)], '--k','LineWidth',1)
    plot(1:360, f_MWcw, 'k','LineWidth',2)
    patch([1:360 fliplr(1:360)], ...
        [(f_MWcw + std(fi_MWcw, 0, 1)) ...
        fliplr((f_MWcw - std(fi_MWcw, 0, 1)))], ...
        'k', 'linestyle', 'none', 'FaceAlpha', 0.1);
    plot(1:360, f_MWccw, 'Color', [53/255 90/255 164/255],'LineWidth',2)
    patch([1:360 fliplr(1:360)], ...
        [(f_MWccw + std(fi_MWccw, 0, 1)) ...
        fliplr((f_MWccw - std(fi_MWccw, 0, 1)))], ...
        'b', 'linestyle', 'none', 'FaceAlpha', 0.1);
else
end
title('Sky rotation', 'FontSize', 12)
xlabel('Rotation angle (deg)', 'FontSize', 12)
ylabel('Frequency (imp/s)', 'FontSize', 12)

subplot(2, 3, 2)
hold on
xlim([0, 360])
if exist('f_CONcw', 'var')
    sh3 = plot([0 360], [mean(BGCon) mean(BGCon)], '--k', 'LineWidth',1);
    sh1 = plot(1:360, f_CONcw, 'k', 'LineWidth',2);
    patch([1:360 fliplr(1:360)], ...
        [(f_CONcw + std(fi_CONcw, 0, 1)) ...
        fliplr((f_CONcw - std(fi_CONcw, 0, 1)))], ...
        'k', 'linestyle', 'none', 'FaceAlpha', 0.1);
    sh2 = plot(1:360, f_CONccw, 'Color', [53/255 90/255 164/255], 'LineWidth',2);
    patch([1:360 fliplr(1:360)], ...
        [(f_CONccw + std(fi_CONccw, 0, 1)) ...
        fliplr((f_CONccw - std(fi_CONccw, 0, 1)))], ...
        'b', 'linestyle', 'none', 'FaceAlpha', 0.1);
else
    sh1 = plot([0 360], [1 1], 'k', 'LineWidth', 1, 'Visible', 'off');
    sh2 = plot([0 360], [1 1], 'Color', [53/255 90/255 164/255], 'LineWidth', 1, 'Visible', 'off');
    sh3 = plot([0 360], [1 1], '--k', 'LineWidth', 1, 'Visible', 'off');
end
leg = legend([sh1, sh2, sh3], 'Mean clockwise', 'Mean counter-clockwise', 'Background');
set(leg, 'FontSize', 10, 'Location', 'best')
title('Control rotation', 'FontSize', 12)
xlabel('Rotation angle (deg)', 'FontSize', 12)
ylabel('Frequency (imp/s)', 'FontSize', 12)

subplot(2, 3, 3)
hold on
xlim([0, 360])
if exist('f_THRcw', 'var')
    plot([0 360], [mean(BGThr) mean(BGThr)], '--k', 'LineWidth',1)
    plot(1:360, f_THRcw, 'k', 'LineWidth',2)
    patch([1:360 fliplr(1:360)], ...
        [(f_THRcw + std(fi_THRcw, 0, 1)) ...
        fliplr((f_THRcw - std(fi_THRcw, 0, 1)))], ...
        'k', 'linestyle', 'none', 'FaceAlpha', 0.1);
    plot(1:360, f_THRccw, 'Color', [53/255 90/255 164/255], 'LineWidth',2)
    patch([1:360 fliplr(1:360)], ...
        [(f_THRccw + std(fi_THRccw, 0, 1)) ...
        fliplr((f_THRccw - std(fi_THRccw, 0, 1)))], ...
        'b', 'linestyle', 'none', 'FaceAlpha', 0.1);
else
end
title('Thresholded sky rotation', 'FontSize', 12)
xlabel('Rotation angle (deg)', 'FontSize', 12)
ylabel('Frequency (imp/s)', 'FontSize', 12)

subplot(2, 3, 4)
hold on
xlim([0, 360])
if exist('f_DOTcw', 'var')
    plot([0 360], [mean(BGDot) mean(BGDot)], '--k', 'LineWidth',1)
    plot(1:360, f_DOTcw, 'k', 'LineWidth',2)
    patch([1:360 fliplr(1:360)], ...
        [(f_DOTcw + std(fi_DOTcw, 0, 1)) ...
        fliplr((f_DOTcw - std(fi_DOTcw, 0, 1)))], ...
        'k', 'linestyle', 'none', 'FaceAlpha', 0.1);
    plot(1:360, f_DOTccw, 'Color', [53/255 90/255 164/255], 'LineWidth',2)
    patch([1:360 fliplr(1:360)], ...
        [(f_DOTccw + std(fi_DOTccw, 0, 1)) ...
        fliplr((f_DOTccw - std(fi_DOTccw, 0, 1)))], ...
        'b', 'linestyle', 'none', 'FaceAlpha', 0.1);
else
end
title('Dot rotation', 'FontSize', 12)
xlabel('Rotation angle (deg)', 'FontSize', 12)
ylabel('Frequency (imp/s)', 'FontSize', 12)

subplot(2, 3, 5)
hold on
xlim([0, 360])
if exist('f_BARcw', 'var')
    plot([0 360], [mean(BGBar) mean(BGBar)], '--k', 'LineWidth',1)
    plot(1:360, f_BARcw, 'k', 'LineWidth',2)
    patch([1:360 fliplr(1:360)], ...
        [(f_BARcw + std(fi_BARcw, 0, 1)) ...
        fliplr((f_BARcw - std(fi_BARcw, 0, 1)))], ...
        'k', 'linestyle', 'none', 'FaceAlpha', 0.1);
    plot(1:360, f_BARccw, 'Color', [53/255 90/255 164/255], 'LineWidth',2)
    patch([1:360 fliplr(1:360)], ...
        [(f_BARccw + std(fi_BARccw, 0, 1)) ...
        fliplr((f_BARccw - std(fi_BARccw, 0, 1)))], ...
        'b', 'linestyle', 'none', 'FaceAlpha', 0.1);
else
end
title('Bar rotation', 'FontSize', 12)
xlabel('Rotation angle (deg)', 'FontSize', 12)
ylabel('Frequency (imp/s)', 'FontSize', 12)

subplot(2, 3, 6)
hold on
xlim([0, 360])
if exist('f_GRDcw', 'var')
    plot([0 360], [mean(BGGrd) mean(BGGrd)], '--k', 'LineWidth',1)
    plot(1:360, f_GRDcw, 'k', 'LineWidth',2)
    patch([1:360 fliplr(1:360)], ...
        [(f_GRDcw + std(fi_GRDcw, 0, 1)) ...
        fliplr((f_GRDcw - std(fi_GRDcw, 0, 1)))], ...
        'k', 'linestyle', 'none', 'FaceAlpha', 0.1);
    plot(1:360, f_GRDccw, 'Color', [53/255 90/255 164/255], 'LineWidth',2)
    patch([1:360 fliplr(1:360)], ...
        [(f_GRDccw + std(fi_GRDccw, 0, 1)) ...
        fliplr((f_GRDccw - std(fi_GRDccw, 0, 1)))], ...
        'b', 'linestyle', 'none', 'FaceAlpha', 0.1);
else
end
title('Gradient bar rotation', 'FontSize', 12)
xlabel('Rotation angle (deg)', 'FontSize', 12)
ylabel('Frequency (imp/s)', 'FontSize', 12)

linkaxes
print([pathname filesep 'Mean_responses_all'], '-dpng')
%% Figure 3: plot filtered mean with standard deviation
% but only for control and Milky Way rotations
figure('units', 'normalized', 'outerposition', [0 0 1 1]) % full width
% clockwise responses
subplot(1, 2, 1)
hold on
xlim([0 360])

% Milky Way
if exist('f_MWcw', 'var')
    s1 = plot([0 360], [mean(BGMW) mean(BGMW)], '--k','LineWidth',1);
    s2 = plot(1:360, f_MWcw, 'k','LineWidth',2);
    patch([1:360 fliplr(1:360)], ...
        [(f_MWcw + std(fi_MWcw, 0, 1)) ...
        fliplr((f_MWcw - std(fi_MWcw, 0, 1)))], ...
        'k', 'linestyle', 'none', 'FaceAlpha', 0.2);
else
    s1 = plot([0 360], [1 1], '--k', 'Visible', 'off');
    s2 = plot([0 360], [1 1], 'k', 'Visible', 'off');
end

% Control
if exist('f_CONcw','var')
    s3 = plot([0 360], [mean(BGCon) mean(BGCon)], '--', 'Color', [0.6 0.6 0.6], 'LineWidth',1);
    s4 = plot(1:360, f_CONcw, 'Color', [0.6 0.6 0.6], 'LineWidth',2);
    patch([1:360 fliplr(1:360)], ...
        [(f_CONcw + std(fi_CONcw, 0, 1)) ...
        fliplr((f_CONcw - std(fi_CONcw, 0, 1)))], ...
        'k', 'linestyle', 'none', 'FaceAlpha', 0.1);
else
    s3 = plot([0 360], [1 1], '--', 'Color', [0.6 0.6 0.6], 'Visible', 'off');
    s4 = plot([0 360], [1 1], 'Color', [0.6 0.6 0.6], 'Visible', 'off');
end
xlabel('Rotation angle (deg)', 'FontSize', 12)
ylabel('Frequency (imp/s)', 'FontSize', 12)
title('Clockwise rotation', 'FontSize', 14)
leg = legend([s2, s4, s1, s3], 'Sky rotation', 'Control rotation', 'Sky background', 'Control background');
set(leg, 'FontSize', 12, 'Location', 'best')

subplot(1, 2, 2)
hold on
% Milky Way
if exist('f_MWccw','var')
plot([0 360], [mean(BGMW) mean(BGMW)], '--k','LineWidth',1)
plot(1:360, f_MWccw, 'k','LineWidth',2)
patch([1:360 fliplr(1:360)], ...
    [(f_MWccw + std(fi_MWccw, 0, 1)) ...
    fliplr((f_MWccw - std(fi_MWccw, 0, 1)))], ...
    'k', 'linestyle', 'none', 'FaceAlpha', 0.2);
else
end
xlim([0 360])

% Control
if exist('f_CONccw','var')
plot([0 360], [mean(BGCon) mean(BGCon)], '--', 'Color', [0.6 0.6 0.6], 'LineWidth',1)
plot(1:360, f_CONccw, 'Color', [0.6 0.6 0.6], 'LineWidth',2)
patch([1:360 fliplr(1:360)], ...
    [(f_CONccw + std(fi_CONccw, 0, 1)) ...
    fliplr((f_CONccw - std(fi_CONccw, 0, 1)))], ...
    'k', 'linestyle', 'none', 'FaceAlpha', 0.1);
else
end
xlabel('Rotation angle (deg)', 'FontSize', 12)
ylabel('Frequency (imp/s)', 'FontSize', 12)
title('Counter-clockwise rotation', 'FontSize', 14)


linkaxes
print([pathname filesep 'Sky_vs_control_mean'], '-dpng')
%% Figure 4: plot individual trials for all stimuli, cw-ccw in same subplot

figure('units','normalized','outerposition',[0 0 1 1])
subplot(2,3,1)
hold on
if exist('fi_MWcw', 'var')
    plot(1:360,fi_MWcw, 'Color', [0.6 0.6 0.6], 'LineWidth',0.25) 
    plot(1:360,fi_MWccw, 'Color', [53/255 90/255 164/255], 'LineWidth',0.25) 
    plot([0,360], [mean(BGMW) mean(BGMW)],'--k')
else
end
xlim([0 360])
xlabel('Rotation angle (deg)', 'FontSize', 12)
ylabel('Frequency (imp/s)', 'FontSize', 12)
title('Normal sky rotation', 'FontSize', 12)

subplot(2,3,2)
hold on
if exist('fi_CONcw', 'var')
    s1 = plot(1:360,fi_CONcw, 'Color', [0.6 0.6 0.6], 'LineWidth',0.25); 
    s2 = plot(1:360,fi_CONccw, 'Color', [53/255 90/255 164/255], 'LineWidth',0.25); 
    s3 = plot([0,360], [mean(BGCon) mean(BGCon)],'--k');
else
    s1 = plot([0 360], [1 1], 'Color', [0.6 0.6 0.6], 'LineWidth', 1, 'Visible', 'off');
    s2 = plot([0 360], [1 1], 'Color', [53/255 90/255 164/255], 'LineWidth', 1, 'Visible', 'off');
    s3 = plot([0,360], [1 1], '--k', 'LineWidth', 1, 'Visible', 'off');
end
xlim([0 360])
xlabel('Rotation angle (deg)', 'FontSize', 12)
ylabel('Frequency (imp/s)', 'FontSize', 12)
leg2 = legend([s1(1), s2(1), s3(1)], 'Clockwise', 'Counter-clockwise', 'Background');
set(leg2, 'FontSize', 10, 'Location', 'best')
title('Control sky rotation', 'FontSize', 12)


subplot(2,3,3)
hold on
if exist('fi_THRcw', 'var')
    plot(1:360,fi_THRcw, 'Color', [0.6 0.6 0.6], 'LineWidth',0.25) 
    plot(1:360,fi_THRccw, 'Color', [53/255 90/255 164/255], 'LineWidth',0.25) 
    plot([0,360], [mean(BGThr) mean(BGThr)],'--k')
else
end
xlim([0 360])
xlabel('Rotation angle (deg)', 'FontSize', 12)
ylabel('Frequency (imp/s)', 'FontSize', 12)
title('Thresholded sky rotation', 'FontSize', 12)

subplot(2,3,4)
hold on
if exist('fi_DOTcw', 'var')
    plot(1:360,fi_DOTcw, 'Color', [0.6 0.6 0.6], 'LineWidth',0.25) 
    plot(1:360,fi_DOTccw, 'Color', [53/255 90/255 164/255], 'LineWidth',0.25) 
    plot([0,360], [mean(BGDot) mean(BGDot)],'--k')
else
end
xlim([0 360])
xlabel('Rotation angle (deg)', 'FontSize', 12)
ylabel('Frequency (imp/s)', 'FontSize', 12)
title('Dot rotation', 'FontSize', 12)

subplot(2,3,5)
hold on
if exist('fi_BARcw', 'var')
    plot(1:360,fi_BARcw, 'Color', [0.6 0.6 0.6], 'LineWidth',0.25) 
    plot(1:360,fi_BARccw, 'Color', [53/255 90/255 164/255], 'LineWidth',0.25) 
    plot([0,360], [mean(BGBar) mean(BGBar)],'--k')
else
end
xlim([0 360])
xlabel('Rotation angle (deg)', 'FontSize', 12)
ylabel('Frequency (imp/s)', 'FontSize', 12)
title('Bar rotation', 'FontSize', 12)

subplot(2,3,6)
hold on
if exist('fi_GRDcw', 'var')
    plot(1:360,fi_GRDcw, 'Color', [0.6 0.6 0.6], 'LineWidth',0.25) 
    plot(1:360,fi_GRDccw, 'Color', [53/255 90/255 164/255], 'LineWidth',0.25) 
    plot([0,360], [mean(BGGrd) mean(BGGrd)],'--k')
else
end
xlim([0 360])
xlabel('Rotation angle (deg)', 'FontSize', 12)
ylabel('Frequency (imp/s)', 'FontSize', 12)
title('Gradient bar rotation', 'FontSize', 12)

linkaxes
print([pathname filesep 'individual_responses_all'], '-dpng')

%% save filtered responses

if exist('fi_MWcw','var')
else
    fi_MWcw = NaN;
    fi_MWccw = NaN;
    BGMW = NaN;
end
if exist('fi_CONcw','var')
else
    fi_CONcw = NaN;
    fi_CONccw = NaN;
    BGCon = NaN;
end
if exist('fi_THRcw','var')
else
    fi_THRcw = NaN;
    fi_THRccw = NaN;
    BGThr = NaN;
end
if exist('fi_DOTcw','var')
else
    fi_DOTcw = NaN;
    fi_DOTccw = NaN;
    BGDot = NaN;
end
if exist('fi_BARcw','var')
else
    fi_BARcw = NaN;
    fi_BARccw = NaN;
    BGBar = NaN;
end
if exist('fi_GRDcw','var')
else
    fi_GRDcw = NaN;
    fi_GRDccw = NaN;
    BGGrd = NaN;
end

filtered = struct('MWcw', fi_MWcw, 'MWccw', fi_MWccw, ...
    'CONcw', fi_CONcw, 'CONccw', fi_CONccw, 'THRcw', fi_THRcw, ...
    'THRccw', fi_THRccw, 'DOTcw', fi_DOTcw, 'DOTccw', fi_DOTccw, ...
    'BARcw', fi_BARcw, 'BARccw', fi_BARccw, 'GRDcw', fi_GRDcw, ...
    'GRDccw', fi_GRDccw);
bg = struct('MW', BGMW, 'CON', BGCon, 'THR', BGThr, 'DOT', BGDot, ...
    'BAR', BGBar, 'GRD', BGGrd);

save([pathname filesep 'filtered_responses.mat'], 'filtered', 'bg')