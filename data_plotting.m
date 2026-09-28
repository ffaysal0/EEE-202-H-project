clc; clear; close all;

x1 = [0.233, 0.316, 0.44, 0.49, 0.53, 0.56, 0.61, 0.63, 0.66, 0.67, 0.673, 0.675]; % Vbe (V)
y1 = [0.213, 0.4, 0.83, 1.38, 2.13, 3.4, 5.74, 8.08, 21.06, 30.21, 49.37, 111.49]; % Ib (uA)

y1_fit = log(y1); 
N1 = 6; 
X1 = zeros(N1, N1);
Y1 = zeros(N1, 1);

for i = 1:N1
    for j = 1:N1
        X1(i,j) = sum(x1.^(i+j-2));
    end
end

for i = 1:N1
    Y1(i,1) = sum((x1.^(i-1)) .* y1_fit);
end

P1 = flip(X1 \ Y1);
xi1 = linspace(min(x1), max(x1), 300);
yi1 = exp(polyval(P1, xi1));

x2 = [0.11, 0.13, 0.152, 0.19, 0.261, 0.472, 0.66, 0.91, 1.3, 1.74, 2.12, 2.66, 3.06]; % Vce (V)
y2 = [4.36, 6.5, 8.44, 10.77, 12.5, 14.05, 15.27, 16.04, 17, 17.31, 17.5, 17.81, 18];  % Ic (mA)

x2_fit = log(x2);
N2 = 4; 
X2 = zeros(N2, N2);
Y2 = zeros(N2, 1);

for i = 1:N2
    for j = 1:N2
        X2(i,j) = sum(x2_fit.^(i+j-2));
    end
end

for i = 1:N2
    Y2(i,1) = sum((x2_fit.^(i-1)) .* y2);
end

P2 = flip(X2 \ Y2);
xi2 = linspace(min(x2), max(x2), 300);
yi2 = polyval(P2, log(xi2));

figure('Name', 'Input Characteristics', 'Color', 'w', ...
       'Units', 'normalized', 'Position', [0.05, 0.15, 0.43, 0.7]);

plot(x1, y1, 'bo', 'MarkerSize', 8, 'MarkerFaceColor', 'b');
hold on;
plot(xi1, yi1, 'b-', 'LineWidth', 2.2);
grid on;
xlim([0.2, 0.7]);
ylim([0, 120]);
set(gca, 'FontSize', 12, 'LineWidth', 1.2);
xlabel('Base-Emitter Voltage, V_{BE} (V)', 'FontSize', 13, 'FontWeight', 'bold');
ylabel('Base Current, I_B (\muA)', 'FontSize', 13, 'FontWeight', 'bold');
title('BJT Input Characteristics (I_B vs V_{BE})', 'FontSize', 14, 'FontWeight', 'bold');
legend('Measured Data (I_B)', 'Fitted Curve', 'Location', 'northwest', 'FontSize', 11);

figure('Name', 'Output Characteristics', 'Color', 'w', ...
       'Units', 'normalized', 'Position', [0.52, 0.15, 0.43, 0.7]);

plot(x2, y2, 'rs', 'MarkerSize', 8, 'MarkerFaceColor', 'r');
hold on;
plot(xi2, yi2, 'r-', 'LineWidth', 2.2);
grid on;
xlim([0, 3.2]);
ylim([0, 20]);
set(gca, 'FontSize', 12, 'LineWidth', 1.2);
xlabel('Collector-Emitter Voltage, V_{CE} (V)', 'FontSize', 13, 'FontWeight', 'bold');
ylabel('Collector Current, I_C (mA)', 'FontSize', 13, 'FontWeight', 'bold');
title('BJT Output Characteristics (I_C vs V_{CE})', 'FontSize', 14, 'FontWeight', 'bold');
legend('Measured Data (I_C)', 'Fitted Curve', 'Location', 'southeast', 'FontSize', 11);