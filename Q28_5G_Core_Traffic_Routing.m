clc;
clear;
close all;

%% 5G Core Traffic Routing Simulation

% User Density
userDensity = 100:100:1000;

% Mobility (km/h)
mobility = [10 20 40 60 80 100 120 140 160 180];

% Performance Parameters
latency = 5 + 0.015*userDensity;             % ms
throughput = 1200 - 0.6*userDensity;         % Mbps
resourceUtilization = 30 + 0.06*userDensity; % %
packetLoss = 0.5 + 0.005*userDensity;        % %

%% Figure 1: User Density vs Latency
figure;
plot(userDensity, latency,'-o','LineWidth',2);
grid on;
xlabel('User Density');
ylabel('Latency (ms)');
title('5G Core Routing: User Density vs Latency');

%% Figure 2: User Density vs Throughput
figure;
plot(userDensity, throughput,'-s','LineWidth',2);
grid on;
xlabel('User Density');
ylabel('Throughput (Mbps)');
title('5G Core Routing: User Density vs Throughput');

%% Figure 3: User Density vs Resource Utilization
figure;
plot(userDensity, resourceUtilization,'-^','LineWidth',2);
grid on;
xlabel('User Density');
ylabel('Resource Utilization (%)');
title('5G Core Routing: User Density vs Resource Utilization');

%% Figure 4: User Density vs Packet Loss
figure;
plot(userDensity, packetLoss,'-d','LineWidth',2);
grid on;
xlabel('User Density');
ylabel('Packet Loss (%)');
title('5G Core Routing: User Density vs Packet Loss');

%% Figure 5: Mobility vs Throughput
throughputMobility = 1100 - 2*mobility;

figure;
plot(mobility, throughputMobility,'-*','LineWidth',2);
grid on;
xlabel('Mobility (km/h)');
ylabel('Throughput (Mbps)');
title('Mobility vs Throughput');

%% Display Results
disp('-------------------------------');
disp('5G Core Traffic Routing Results');
disp('-------------------------------');

Result = table(userDensity', latency', throughput', ...
    resourceUtilization', packetLoss', ...
    'VariableNames', {'UserDensity','Latency_ms','Throughput_Mbps',...
    'ResourceUtilization_percent','PacketLoss_percent'});

disp(Result);