clear all
close all
clc

% Load data from the Excel file
data = readtable('HittingStats.xlsx');

% Filter for only 5on5 play
data_5on5 = data(strcmp(data.situation, '5on5'), :);

% Remove rows with zero or missing iceTime to avoid divide-by-zero errors
data_5on5 = data_5on5(data_5on5.iceTime > 0, :);

% Normalize hitsFor and xGoalsFor (per second)
data_5on5.normalHitsFor = data_5on5.hitsFor ./ data_5on5.iceTime*3600;
data_5on5.normalxGoalsFor = data_5on5.xGoalsFor ./ data_5on5.iceTime*3600;

% List of unique seasons (e.g., 2008, 2009, ..., 2024)
uniqueSeasons = unique(data_5on5.season);

% Convert seasons to display format: 'YYYY-YY'
seasonLabels = arrayfun(@(x) sprintf('%d-%02d', x, mod(x+1,100)), uniqueSeasons, 'UniformOutput', false);

figure;
hold on;
legendEntries = cell(length(uniqueSeasons), 1);

% Loop through each season to create a scatter plot
for i = 1:length(uniqueSeasons)
    season = uniqueSeasons(i);
    seasonData = data_5on5(data_5on5.season == season, :);
    
    % Scatter plot
    scatter(seasonData.normalHitsFor, seasonData.normalxGoalsFor, 'filled');
    
    % Annotate each point with team name
    for j = 1:height(seasonData)
        text(seasonData.normalHitsFor(j), seasonData.normalxGoalsFor(j), ...
             seasonData.team{j}, 'FontSize', 8);
    end
    
    % Add entry to legend
    legendEntries{i} = seasonLabels{i};
  
end

xlabel('Normalized Hits For (hits per 60)');
ylabel('Normalized Expected Goals For (xG per 60)');
title('Normalized xGoalsFor vs HitsFor per Team at 5on5');
  % Get current axis limits
    xLimits = xlim;
    yLimits = ylim;

    % Coordinates for corner text
    topRight = [xLimits(2), yLimits(2)];
    topLeft = [xLimits(1), yLimits(2)];
    bottomLeft = [xLimits(1), yLimits(1)];
    bottomRight = [xLimits(2), yLimits(1)];

    % Add words to corners (clockwise: Exciting, Chasing, Boring, Chased)
    text(topRight(1), topRight(2), 'Exciting', ...
        'HorizontalAlignment', 'right', 'VerticalAlignment', 'top', 'FontWeight', 'bold');

    text(bottomRight(1), bottomRight(2), 'Defence Heavy', ...
        'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom', 'FontWeight', 'bold');

    text(bottomLeft(1), bottomLeft(2), 'Boring', ...
        'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'FontWeight', 'bold');

    text(topLeft(1), topLeft(2), 'Offence Heavy', ...
        'HorizontalAlignment', 'left', 'VerticalAlignment', 'top', 'FontWeight', 'bold');
grid on;
legend(legendEntries, 'Location', 'eastoutside');
hold off;

%% Plot 1: One scatter plot per season
for i = 1:length(uniqueSeasons)
    figure;
    hold on;

    % Select data for the current season
    season = uniqueSeasons(i);
    seasonData = data_5on5(data_5on5.season == season, :);

    % Scatter plot
    scatter(seasonData.normalHitsFor, seasonData.normalxGoalsFor, 'filled');

    % Annotate each point with the team name
    for j = 1:height(seasonData)
        text(seasonData.normalHitsFor(j), seasonData.normalxGoalsFor(j), ...
             seasonData.team{j}, 'FontSize', 8);
    end

    % Axis labels and title
    xlabel('Normalized Hits For (hits per 60)');
    ylabel('Normalized Expected Goals For (xG per 60)');
    title(['Normalized xGoalsFor vs HitsFor per Team at 5on5 during ', seasonLabels{i}]);
    grid on;
    % Get current axis limits
    xLimits = xlim;
    yLimits = ylim;

    % Coordinates for corner text
    topRight = [xLimits(2), yLimits(2)];
    topLeft = [xLimits(1), yLimits(2)];
    bottomLeft = [xLimits(1), yLimits(1)];
    bottomRight = [xLimits(2), yLimits(1)];

    % Add words to corners (clockwise: Exciting, Chasing, Boring, Chased)
    text(topRight(1), topRight(2), 'Exciting', ...
        'HorizontalAlignment', 'right', 'VerticalAlignment', 'top', 'FontWeight', 'bold');

    text(bottomRight(1), bottomRight(2), 'Defence Heavy', ...
        'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom', 'FontWeight', 'bold');

    text(bottomLeft(1), bottomLeft(2), 'Boring', ...
        'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'FontWeight', 'bold');

    text(topLeft(1), topLeft(2), 'Offence Heavy', ...
        'HorizontalAlignment', 'left', 'VerticalAlignment', 'top', 'FontWeight', 'bold');
    hold off;

    % Optional: Uncomment below to save the figure automatically
    % saveas(gcf, ['xG_vs_Hits_', seasonLabels{i}, '.png']);
end

%% Plot 2: Mean and SD for each season
meanHits = zeros(length(uniqueSeasons), 1);
meanxGoals = zeros(length(uniqueSeasons), 1);
sdHits = zeros(length(uniqueSeasons), 1);
sdxGoals = zeros(length(uniqueSeasons), 1);

for i = 1:length(uniqueSeasons)
    season = uniqueSeasons(i);
    seasonData = data_5on5(data_5on5.season == season, :);

    meanHits(i) = mean(seasonData.normalHitsFor);
    meanxGoals(i) = mean(seasonData.normalxGoalsFor);

    sdHits(i) = std(seasonData.normalHitsFor);
    sdxGoals(i) = std(seasonData.normalxGoalsFor);
end

% Plot means with error bars
figure;
plot(meanHits, meanxGoals,'o');
xlabel('Mean Normalized Hits For');
ylabel('Mean Normalized xGoals For');
title('Season Averages of Play Style at 5on5');
grid on;

% Get current axis limits
    xLimits = xlim;
    yLimits = ylim;

    % Coordinates for corner text
    topRight = [xLimits(2), yLimits(2)];
    topLeft = [xLimits(1), yLimits(2)];
    bottomLeft = [xLimits(1), yLimits(1)];
    bottomRight = [xLimits(2), yLimits(1)];

    % Add words to corners (clockwise: Exciting, Chasing, Boring, Chased)
    text(topRight(1), topRight(2), 'Exciting', ...
        'HorizontalAlignment', 'right', 'VerticalAlignment', 'top', 'FontWeight', 'bold');

    text(bottomRight(1), bottomRight(2), 'Defence Heavy', ...
        'HorizontalAlignment', 'right', 'VerticalAlignment', 'bottom', 'FontWeight', 'bold');

    text(bottomLeft(1), bottomLeft(2), 'Boring', ...
        'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom', 'FontWeight', 'bold');

    text(topLeft(1), topLeft(2), 'Offence Heavy', ...
        'HorizontalAlignment', 'left', 'VerticalAlignment', 'top', 'FontWeight', 'bold');


xlabel('Mean Normalized Hits For (hits per 60)');
ylabel('Mean Normalized xGoals For (xG per 60)');
title('Season Averages of Normalized Stats at 5on5');
grid on;

% Add season labels to each point
for i = 1:length(uniqueSeasons)
    text(meanHits(i), meanxGoals(i), seasonLabels{i}, ...
        'VerticalAlignment','bottom','HorizontalAlignment','right', 'FontSize', 10);
end