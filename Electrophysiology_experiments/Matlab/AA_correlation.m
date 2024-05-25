%% cross-correlation between Milky Way and Dot response

close all
if exist('f_DOTcw','var')
    
    [c_cw, lagscw] = xcov(f_MWcw, f_DOTcw);
    [c_ccw, lagsccw] = xcov(f_MWccw, f_DOTccw);
    
    figure('units', 'normalized', 'outerposition', [0 0 1 1])
    ax(1)=subplot(2, 6, 1);
    hold on
    stem(lagscw, c_cw)
    [ycw, ixcw] = max(c_cw); % index of maximum correlation
    shift_cw = lagscw(ixcw); % shift of how many degrees produces best fit?
    s = plot([shift_cw shift_cw], [0 ycw], 'r', 'LineWidth', 2);
    title('Corr MW--dot cw', 'FontSize', 14)
    ylabel('Correlation strength', 'FontSize', 12)
    xlabel('Lag (degrees)', 'FontSize', 12)
    leg = legend(s, ['Shift = ', num2str(shift_cw), ' deg']);
    set(leg, 'FontSize', 12, 'Location', 'best')
    
    ax(2)=subplot(2, 6, 7);
    hold on
    stem(lagsccw, c_ccw)
    [yccw, ixccw] = max(c_ccw); % index of maximum correlation
    shift_ccw = lagsccw(ixccw); % shift of how many degrees produces best fit?
    st = plot([shift_ccw shift_ccw], [0 yccw], 'r', 'LineWidth', 2);
    title('Corr MW--dot ccw', 'FontSize', 14)
    ylabel('Correlation strength', 'FontSize', 12)
    xlabel('Lag (degrees)', 'FontSize', 12)
    leg = legend(st, ['Shift = ', num2str(shift_ccw), ' deg']);
    set(leg, 'FontSize', 12, 'Location', 'best')
        
    axs(1)=subplot(2, 6, 2);
    hold on
    plot(f_MWcw, 'k', 'LineWidth', 2)
    plot(circshift(f_DOTcw, shift_cw), 'b', 'LineWidth', 2)
    legend('Milky Way', 'Dot')
    ylabel('Firing frequency (imp/sec)', 'FontSize', 12)
    xlabel('Stimulus angle (deg)', 'FontSize', 12)
    title('Aligned responses (cw)', 'FontSize', 14)
    
    axs(2)=subplot(2, 6, 8);
    hold on
    plot(f_MWccw, 'k', 'LineWidth', 2)
    plot(circshift(f_DOTccw, shift_ccw), 'b', 'LineWidth', 2)
    legend('Milky Way', 'Dot')
    ylabel('Firing frequency (imp/sec)', 'FontSize', 12)
    xlabel('Stimulus angle (deg)', 'FontSize', 12)
    title('Aligned responses (ccw)', 'FontSize', 14)
    
end

% cross-correlation between Milky Way and Bar response
if exist('f_BARcw','var')
    [c_cw, lagscw] = xcov(f_MWcw, f_BARcw);    
    [c_ccw, lagsccw] = xcov(f_MWccw, f_BARccw);
    
    ax(3)=subplot(2, 6, 3);
    hold on
    stem(lagscw, c_cw)
    [ycw, ixcw] = max(c_cw); % index of maximum correlation
    shift_cw = lagscw(ixcw); % shift of how many degrees produces best fit?
    s = plot([shift_cw shift_cw], [0 ycw], 'r', 'LineWidth', 2);
    title('Corr MW--bar cw', 'FontSize', 14)
    ylabel('Correlation strength', 'FontSize', 12)
    xlabel('Lag (degrees)', 'FontSize', 12)
    leg = legend(s, ['Shift = ', num2str(shift_cw), ' deg']);
    set(leg, 'FontSize', 12, 'Location', 'best')
    
    ax(4)=subplot(2, 6, 9);
    hold on
    stem(lagsccw, c_ccw)
    [yccw, ixccw] = max(c_ccw); % index of maximum correlation
    shift_ccw = lagsccw(ixccw); % shift of how many degrees produces best fit?
    st = plot([shift_ccw shift_ccw], [0 yccw], 'r', 'LineWidth', 2);
    title('Corr MW--bar ccw', 'FontSize', 14)
    ylabel('Correlation strength', 'FontSize', 12)
    xlabel('Lag (degrees)', 'FontSize', 12)
    leg = legend(st, ['Shift = ', num2str(shift_ccw), ' deg']);
    set(leg, 'FontSize', 12, 'Location', 'best')
        
    axs(3)=subplot(2, 6, 4);
    hold on
    plot(f_MWcw, 'k', 'LineWidth', 2)
    plot(circshift(f_BARcw, shift_cw), 'r', 'LineWidth', 2)
    legend('Milky Way', 'Bar')
    ylabel('Firing frequency (imp/sec)', 'FontSize', 12)
    xlabel('Stimulus angle (deg)', 'FontSize', 12)
    title('Aligned responses (cw)', 'FontSize', 14)
    
    axs(4)=subplot(2, 6, 10);
    hold on
    plot(f_MWccw, 'k', 'LineWidth', 2)
    plot(circshift(f_BARccw, shift_ccw), 'r', 'LineWidth', 2)
    legend('Milky Way', 'Bar')
    ylabel('Firing frequency (imp/sec)', 'FontSize', 12)
    xlabel('Stimulus angle (deg)', 'FontSize', 12)
    title('Aligned responses (ccw)', 'FontSize', 14)
end

% cross-correlation between Milky Way and Gradient bar response
if exist('f_GRDcw','var')
    [c_cw, lagscw] = xcov(f_MWcw, f_GRDcw);    
    [c_ccw, lagsccw] = xcov(f_MWccw, f_GRDccw);
    
    ax(5)=subplot(2, 6, 5);
    hold on
    stem(lagscw, c_cw)
    [ycw, ixcw] = max(c_cw); % index of maximum correlation
    shift_cw = lagscw(ixcw); % shift of how many degrees produces best fit?
    s = plot([shift_cw shift_cw], [0 ycw], 'r', 'LineWidth', 2);
    title('Corr MW--gradient bar cw', 'FontSize', 14)
    ylabel('Correlation strength', 'FontSize', 12)
    xlabel('Lag (degrees)', 'FontSize', 12)
    leg = legend(s, ['Shift = ', num2str(shift_cw), ' deg']);
    set(leg, 'FontSize', 12, 'Location', 'best')
    
    ax(6)=subplot(2, 6, 11);
    hold on
    stem(lagsccw, c_ccw)
    [yccw, ixccw] = max(c_ccw); % index of maximum correlation
    shift_ccw = lagsccw(ixccw); % shift of how many degrees produces best fit?
    st = plot([shift_ccw shift_ccw], [0 yccw], 'r', 'LineWidth', 2);
    title('Corr MW--gradient bar ccw', 'FontSize', 14)
    ylabel('Correlation strength', 'FontSize', 12)
    xlabel('Lag (degrees)', 'FontSize', 12)
    leg = legend(st, ['Shift = ', num2str(shift_ccw), ' deg']);
    set(leg, 'FontSize', 12, 'Location', 'best')
        
    axs(5)=subplot(2, 6, 6);
    hold on
    plot(f_MWcw, 'k', 'LineWidth', 2)
    plot(circshift(f_GRDcw, shift_cw), 'm', 'LineWidth', 2)
    legend('Milky Way', 'Gradient bar')
    ylabel('Firing frequency (imp/sec)', 'FontSize', 12)
    xlabel('Stimulus angle (deg)', 'FontSize', 12)
    title('Aligned responses (cw)', 'FontSize', 14)
    
    axs(6)=subplot(2, 6, 12);
    hold on
    plot(f_MWccw, 'k', 'LineWidth', 2)
    plot(circshift(f_GRDccw, shift_ccw), 'm', 'LineWidth', 2)
    legend('Milky Way', 'Gradient bar')
    ylabel('Firing frequency (imp/sec)', 'FontSize', 12)
    xlabel('Stimulus angle (deg)', 'FontSize', 12)
    title('Aligned responses (ccw)', 'FontSize', 14)
    
    print([pathname filesep 'covariance'], '-dpng')
end

suptitle(pathname)
linkaxes(ax)
linkaxes(axs)