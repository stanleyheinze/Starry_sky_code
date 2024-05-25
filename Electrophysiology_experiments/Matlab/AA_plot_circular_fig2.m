figure()
polarscatter(deg2rad(Phimaxall1.MWcw), ones(1, length(Phimaxall1.MWcw)), 100, 'b', 'filled')
hold on
polarscatter(deg2rad(Phimaxall2.MWcw), ones(1, length(Phimaxall2.MWcw)), 100, 'b', 'filled')
polarscatter(deg2rad(Phimaxall1.DOTcw), ones(1, length(Phimaxall1.DOTcw)), 100, 'k', 'filled')
polarscatter(deg2rad(Phimaxall2.DOTcw), ones(1, length(Phimaxall2.DOTcw)), 100, 'k', 'filled')
set(gca, 'RLim', [0 1], 'ThetaZeroLocation', 'top')
title('cw')
hold off
saveas(gca,[pathname '/cwCirc_forSuppl'], 'svg')

figure()
polarscatter(deg2rad(Phimaxall1.MWccw), ones(1, length(Phimaxall1.MWccw)), 100, 'b', 'filled')
hold on
polarscatter(deg2rad(Phimaxall2.MWccw), ones(1, length(Phimaxall2.MWccw)), 100, 'b', 'filled')
polarscatter(deg2rad(Phimaxall1.DOTccw), ones(1, length(Phimaxall1.DOTccw)), 100, 'k', 'filled')
polarscatter(deg2rad(Phimaxall2.DOTccw), ones(1, length(Phimaxall2.DOTccw)), 100, 'k', 'filled')
set(gca, 'RLim', [0 1], 'ThetaZeroLocation', 'top')
title('ccw')
hold off
saveas(gca,[pathname '/ccwCirc_forSuppl'], 'svg')

