% bin all responses in 1 deg bins and filter

MWcw = [];
MWccw = [];
c_MW = 1;
c_CON = 1;
c_THR = 1;
c_DOT = 1;
c_BAR = 1;
c_GRD = 1;

% user input: does 0 deg stimulus position correspond to a Northern
% moth heading?
prompt = {'Offset: If 0° stimulus angle corresponds to moth heading N, then offset is 0. If 0° equals E, then offset = -90. If 0° equals S, then offset = -180. If 0° equals W, then offset = -270. ---------- NOTE: spring 2018: Oct until Nov 3rd, moth heading is S, after Nov 3rd, moth heading is E. Fall 2019: moth heading is N relative to MW. Fall 2020: moth heading is E.'};
dlgtitle = 'Offset of moth heading vs. Milky Way stimulus';
dims = [1 100];
definput = {'0'};
answer = inputdlg(prompt,dlgtitle,dims,definput); 
zero_adjust = str2num(answer{1});

% ok let's do this
fileList = getAllFiles(pathname, 'FileFilter', '\.mat$');
for i = 1:length(fileList)
    
    load(fileList{i});
    if contains(fileList{i},'MW')
        type = 'Milky Way' % only choose Milky Way rotations
    elseif contains(fileList{i},'Con')
        type = 'Control'
    elseif contains(fileList{i},'Thresh')
        type = 'Thresholded MW'
    elseif contains(fileList{i},'Dot')
        type = 'Dot'
    elseif contains(fileList{i},'Strp')
        type = 'Bar'
    elseif contains(fileList{i},'Grad')
        type = 'Gradient bar'
    else
        continue
    end
    
    % cut data
    cw = response.events(stimulus.cw_on_off(1):stimulus.cw_on_off(2));
    ccw = fliplr(response.events(stimulus.ccw_on_off(1):stimulus.ccw_on_off(2)));
    % how much is 1 degree in this case?
    binSizeCW = floor(length(cw) / 360);
    binSizeCCW = floor(length(ccw) / 360);
    % bin data
    countCW = 1;
    countCCW = 1;
    j = 1;
    deg_cw = zeros(1, 360);
    deg_ccw = zeros(1, 360);
    % (1) bin cw and ccw in 1 deg bins, calculate for each rotation
    for j = 1:360
        deg_cw(1,j) = sum(cw(countCW:countCW+binSizeCW-1));
        deg_ccw(1,j) = sum(ccw(countCCW:countCCW+binSizeCCW-1));
        countCW = countCW+binSizeCW;
        countCCW = countCCW+binSizeCCW;
    end
    
    % prepare for (2)
    if strcmp(type,'Milky Way')
        iMWcw(c_MW,:) = circshift(deg_cw, zero_adjust);
        iMWccw(c_MW,:) = circshift(deg_ccw, zero_adjust);
        BGMW(c_MW) = response.bg_mean_cw;
        BGsemMW(c_MW) = response.bg_SEM_cw;
        c_MW = c_MW + 1;
    elseif strcmp(type,'Control')
        iConcw(c_CON,:) = circshift(deg_cw, zero_adjust);
        iConccw(c_CON,:) = circshift(deg_ccw, zero_adjust);
        BGCon(c_CON) = response.bg_mean_cw;
        BGsemCon(c_CON) = response.bg_SEM_cw;
        c_CON = c_CON + 1;
    elseif strcmp(type,'Thresholded MW')
        iThrcw(c_THR,:) = circshift(deg_cw, zero_adjust);
        iThrccw(c_THR,:) = circshift(deg_ccw, zero_adjust);
        BGThr(c_THR) = response.bg_mean_cw;
        BGsemThr(c_THR) = response.bg_SEM_cw;
        c_THR = c_THR + 1;
    elseif strcmp(type,'Dot')
        iDotcw(c_DOT,:) = circshift(deg_cw, zero_adjust);
        iDotccw(c_DOT,:) = circshift(deg_ccw, zero_adjust);
        BGDot(c_DOT) = response.bg_mean_cw;
        BGsemDot(c_DOT) = response.bg_SEM_cw;
        c_DOT = c_DOT + 1;
    elseif strcmp(type,'Bar')
        iBarcw(c_BAR,:) = circshift(deg_cw, zero_adjust); 
        iBarccw(c_BAR,:) = circshift(deg_ccw, zero_adjust); 
        BGBar(c_BAR) = response.bg_mean_cw;
        BGsemBar(c_BAR) = response.bg_SEM_cw;
        c_BAR = c_BAR + 1;
    elseif strcmp(type,'Gradient bar')
        iGrdcw(c_GRD,:) = circshift(deg_cw, zero_adjust); 
        iGrdccw(c_GRD,:) = circshift(deg_ccw, zero_adjust); 
        BGGrd(c_GRD) = response.bg_mean_cw;
        BGsemGrd(c_GRD) = response.bg_SEM_cw;
        c_GRD = c_GRD + 1;
    end
end

% (3) filter binned mean (f_) and individual trials (fi_)
if exist('iMWcw','var')
    f_MWcw = resp_filter(iMWcw, 1)/binSizeCW*stimulus.samp_per_sec;
    f_MWccw = resp_filter(iMWccw, 1)/binSizeCW*stimulus.samp_per_sec;
    fi_MWcw = resp_filter(iMWcw, 2)/binSizeCW*stimulus.samp_per_sec;
    fi_MWccw = resp_filter(iMWccw, 2)/binSizeCW*stimulus.samp_per_sec;
else
end

if exist('iConcw', 'var')
    f_CONcw = resp_filter(iConcw, 1)/binSizeCW*stimulus.samp_per_sec; 
    f_CONccw = resp_filter(iConccw, 1)/binSizeCW*stimulus.samp_per_sec;
    fi_CONcw = resp_filter(iConcw, 2)/binSizeCW*stimulus.samp_per_sec; 
    fi_CONccw = resp_filter(iConccw, 2)/binSizeCW*stimulus.samp_per_sec;
else
end

if exist('iThrcw','var')
    f_THRcw = resp_filter(iThrcw, 1)/binSizeCW*stimulus.samp_per_sec; 
    f_THRccw = resp_filter(iThrccw, 1)/binSizeCW*stimulus.samp_per_sec;
    fi_THRcw = resp_filter(iThrcw, 2)/binSizeCW*stimulus.samp_per_sec; 
    fi_THRccw = resp_filter(iThrccw, 2)/binSizeCW*stimulus.samp_per_sec;
else
end

if exist('iDotcw','var')
    f_DOTcw = resp_filter(iDotcw, 1)/binSizeCW*stimulus.samp_per_sec; 
    f_DOTccw = resp_filter(iDotccw, 1)/binSizeCW*stimulus.samp_per_sec;
    fi_DOTcw = resp_filter(iDotcw, 2)/binSizeCW*stimulus.samp_per_sec; 
    fi_DOTccw = resp_filter(iDotccw, 2)/binSizeCW*stimulus.samp_per_sec;
else
end

if exist('iBarcw','var')
    f_BARcw = resp_filter(iBarcw, 1)/binSizeCW*stimulus.samp_per_sec; 
    f_BARccw = resp_filter(iBarccw, 1)/binSizeCW*stimulus.samp_per_sec;
    fi_BARcw = resp_filter(iBarcw, 2)/binSizeCW*stimulus.samp_per_sec; 
    fi_BARccw = resp_filter(iBarccw, 2)/binSizeCW*stimulus.samp_per_sec;
else
end

if exist('iGrdcw','var')
    f_GRDcw = resp_filter(iGrdcw, 1)/binSizeCW*stimulus.samp_per_sec; 
    f_GRDccw = resp_filter(iGrdccw, 1)/binSizeCW*stimulus.samp_per_sec;
    fi_GRDcw = resp_filter(iGrdcw, 2)/binSizeCW*stimulus.samp_per_sec; 
    fi_GRDccw = resp_filter(iGrdccw, 2)/binSizeCW*stimulus.samp_per_sec;
else
end

