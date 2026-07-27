clc;
clear;
close all;

%% 1. Parameters Setup
c = 3e8;                    % Speed of light (m/s)
fc = 28e9;                  % Carrier frequency (28 GHz - 5G mmWave)
lambda = c / fc;            % Wavelength
d = lambda / 2;             % Half-wavelength antenna spacing

N = 8;                      % Default number of antenna elements
theta = -90:0.1:90;         % Angular range in degrees
theta_rad = deg2rad(theta); 

%% 2. Analog Beamforming Pattern for Different Steering Angles
beamAngles = [-30, 0, 30];  % Target beam directions in degrees

figure('Name', 'Analog Beamforming Steering Angles');
for k = 1:length(beamAngles)
    theta0 = beamAngles(k);
    theta0_rad = deg2rad(theta0);

    % Progressive phase shift required for beam steering at theta0
    beta = -2 * pi * (d / lambda) * sin(theta0_rad);

    % Array Factor calculation
    psi = 2 * pi * (d / lambda) * sin(theta_rad) + beta;
    AF = abs(sin(N * psi / 2) ./ (N * sin(psi / 2)));
    AF(isnan(AF)) = 1;      % Handle 0/0 limit (main lobe peak)

    % Plot normalized radiation pattern in dB
    subplot(length(beamAngles), 1, k);
    plot(theta, 20*log10(AF), 'LineWidth', 1.8);
    grid on;
    ylim([-40, 2]);
    xlim([-90, 90]);
    xlabel('Angle (Degrees)');
    ylabel('Normalized Gain (dB)');
    title(['Beam Steering Angle (\theta_0) = ', num2str(theta0), '°']);
end

%% 3. Sidelobe Level (SLL) Analysis & Phase Shift Variation Effect
% Simulating phase error/variation (e.g., non-ideal phase shifters)
phase_error_std = 10; % Standard deviation of phase error in degrees

% Ideal steering at 0 degrees
beta_ideal = zeros(1, N); 

% Non-ideal steering with random phase shift variation
rng(1); % For reproducibility
phase_noise = deg2rad(normrnd(0, phase_error_std, [1, N]));
beta_noisy = beta_ideal + phase_noise;

% Calculating Array Factor with phase shift variations
AF_ideal = zeros(size(theta));
AF_noisy = zeros(size(theta));

for i = 1:length(theta)
    % Steering vector for element positions [0, 1, ..., N-1]
    n = 0:N-1;
    spatial_phase = 2 * pi * (d / lambda) * n * sin(theta_rad(i));

    AF_ideal(i) = abs(sum(exp(1i * (spatial_phase + beta_ideal))));
    AF_noisy(i) = abs(sum(exp(1i * (spatial_phase + beta_noisy))));
end

AF_ideal = AF_ideal / max(AF_ideal);
AF_noisy = AF_noisy / max(AF_noisy);

figure('Name', 'Phase Shift Variation & Sidelobe Level');
plot(theta, 20*log10(AF_ideal), 'b', 'LineWidth', 1.8, 'DisplayName', 'Ideal Phase');
hold on;
plot(theta, 20*log10(AF_noisy), 'r--', 'LineWidth', 1.5, 'DisplayName', 'Phase Error (\sigma = 10°)');
grid on;
ylim([-40, 2]);
xlim([-90, 90]);
xlabel('Angle (Degrees)');
ylabel('Normalized Gain (dB)');
title('Impact of Phase Shift Variation on Sidelobe Level (SLL)');
legend('Location', 'northeast');

%% 4. Array Gain vs. Antenna Count (N)
antenna_counts = [4, 8, 16, 32, 64];
array_gain_dB = 10 * log10(antenna_counts); % Gain G = 10*log10(N)

figure('Name', 'Array Gain vs Antenna Count');
plot(antenna_counts, array_gain_dB, '-o', 'LineWidth', 2, 'MarkerSize', 8, 'MarkerFaceColor', 'r');
grid on;
xlabel('Number of Antenna Elements (N)');
ylabel('Array Gain (dB)');
title('Array Gain vs. Antenna Count');
xticks(antenna_counts);