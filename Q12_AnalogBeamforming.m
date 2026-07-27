clc;
clear;
close all;

% Analog Beamforming Simulation

N = 8;                      % Number of antenna elements
fc = 28e9;                  % Frequency (28 GHz)
c = 3e8;
lambda = c/fc;
d = lambda/2;               % Antenna spacing

theta = -90:0.1:90;
beamAngles = [-30 0 30];

figure;

for k = 1:length(beamAngles)

    theta0 = beamAngles(k);

    AF = zeros(size(theta));

    for i = 1:length(theta)

        psi = (2*pi*d/lambda)*(sind(theta(i))-sind(theta0));

        if abs(psi)<1e-12
            AF(i)=1;
        else
            AF(i)=abs(sin(N*psi/2)/(N*sin(psi/2)));
        end

    end

    AF = AF/max(AF);

    subplot(3,1,k)
    plot(theta,20*log10(AF),'LineWidth',2)
    grid on
    ylim([-40 2])
    xlabel('Angle (Degree)')
    ylabel('Gain (dB)')
    title(['Beam Pattern at ',num2str(theta0),' Degree'])

end

%% Gain vs Number of Antennas

antenna=[4 8 16 32];
gain=10*log10(antenna);

figure
plot(antenna,gain,'-o','LineWidth',2)
grid on
xlabel('Number of Antennas')
ylabel('Gain (dB)')
title('Array Gain')