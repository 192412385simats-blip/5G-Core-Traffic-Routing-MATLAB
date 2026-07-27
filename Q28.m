clc;
clear;
close all;

%% 1. Simulation Parameters
% User Density (Number of active users in the cell)
userDensity = 100:100:1000;

% Mobility Levels (User speed in km/h)
mobility = [10, 20, 40, 60, 80, 100, 120, 140, 160, 180];

%% 2. Mathematical Performance Models
% As user density increases: latency rises, throughput drops, and resource utilization increases
latency = 5 + 0.015 * userDensity;              % Latency in ms
throughput = 1200 - 0.6 * userDensity;          % Throughput in Mbps
resourceUtilization = 30 + 0.06 * userDensity;  % Resource utilization in %
packetLoss = 0.5 + 0.005 * userDensity;         % Packet loss rate in %

% Impact of mobility on throughput (higher speed leads to frequent handovers)
throughputMobility = 1100 - 2 * mobility;       % Mbps

%% 3. Visualizations

% Figure 1: User Density vs Latency
figure('Name', 'User Density vs Latency');
plot(userDensity, latency, '-o', 'LineWidth', 2, 'MarkerFaceColor', 'b');
grid on;
xlabel('User Density (Active Users)');
ylabel('Latency (ms)');
title('5G Core Routing: User Density vs. Latency');

% Figure 2: User Density vs Throughput
figure('Name', 'User Density vs Throughput');
plot(userDensity, throughput, '-s', 'LineWidth', 2, 'MarkerFaceColor', 'r');
grid on;
xlabel('User Density (Active Users)');
ylabel('Throughput (Mbps)');
title('5G Core Routing: User Density vs. Throughput');

% Figure 3: User Density vs Resource Utilization
figure('Name', 'User Density vs Resource Utilization');
plot(userDensity, resourceUtilization, '-^', 'LineWidth', 2, 'MarkerFaceColor', 'g');
grid on;
xlabel('User Density (Active Users)');
ylabel('Resource Utilization (%)');
title('5G Core Routing: User Density vs. Resource Utilization');

% Figure 4: User Density vs Packet Loss
figure('Name', 'User Density vs Packet Loss');
plot(userDensity, packetLoss, '-d', 'LineWidth', 2, 'MarkerFaceColor', 'm');
grid on;
xlabel('User Density (Active Users)');
ylabel('Packet Loss (%)');
title('5G Core Routing: User Density vs. Packet Loss');

% Figure 5: Mobility vs Throughput
figure('Name', 'Mobility vs Throughput');
plot(mobility, throughputMobility, '-*', 'LineWidth', 2, 'MarkerFaceColor', 'k');
grid on;
xlabel('Mobility / Speed (km/h)');
ylabel('Throughput (Mbps)');
title('5G Core Routing: Mobility vs. Throughput');

%% 4. Tabular Summary Output
disp('====================================================');
disp('      5G CORE TRAFFIC ROUTING SIMULATION RESULTS    ');
disp('====================================================');

ResultTable = table(userDensity', latency', throughput', ...
    resourceUtilization', packetLoss', ...
    'VariableNames', {'User_Density', 'Latency_ms', 'Throughput_Mbps', ...
    'Resource_Utilization_pct', 'Packet_Loss_pct'});

disp(ResultTable);