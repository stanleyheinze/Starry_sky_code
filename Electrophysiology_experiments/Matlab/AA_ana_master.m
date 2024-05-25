% Master script for electrophysiological data analysis.
%
% -1- get parameters from data files
% -2- frequency analysis of response & plot results
%
% see also AA_get_params, AA_freq_analysis

clear
close all
path(genpath('Users/andreaadden/myDocuments/Data/Rec_Mar-Apr2020/'), path);
pathname = uigetdir('/Users/andreaadden/myDocuments/Data/Rec_Mar-Apr2020/');

% global visible
% [s,ok] = listdlg('PromptString','Figure visibility setting:',...
%     'SelectionMode', 'single','ListSize',[160 80],'ListString',{'on','off'});
% if isequal(s, 1)
%     visible = 'on';
% else
%     visible = 'off';
% end

% ************* DO NOT EDIT ************

% ----- 1 -----
% get stimulus and response parameters for analysis from data files
AA_get_params_MW_MF;

% ----- 2 ----- filter responses
AA_filter_responses_preMarch8; % bar / gradient bar start in South (moth perspective)
%AA_filter_responses_postMarch8; % bar / gradient bar start in West (moth's perspective)

% ----- 3 ----- plot and do further analysis (phimax, correlations)
% AA_plot_filteredResponses; % plot individually and means for all stimuli
% AA_find_phimax; % gets user input to detect and save phimax values
% AA_correlation; % correlation between MW and Dot / Bar stimulus
AA_plot_filteredMeanSD % --- filtered MW and Control plot for paper suppl. figures
%AA_raster;
AA_plot_circular_fig2 % --- circular scatterplot for paper suppl. figure

% !!! the following exports all spike angles for later use in R:
% AA_circular_plots_MW; %close % circular plots of responses to visual stimuli

% AA_signal_to_noise; % careful with this, still experimental
% close all