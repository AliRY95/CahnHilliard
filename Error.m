clearvars; clc;
FileID = fopen('Error1.txt');
A = fscanf(FileID,'%f %f',[2 inf]);
loglog(1./A(1,:), A(2,:), 'k.-', 'MarkerSize', 16);
box on; grid on;
xlabel('Elements Size'); ylabel('L^2-Error');
hold on; title('P_1 Space')
% loglog(1./A(1,:), 0.010*(1./A(1,:)).^1.65, 'k--');
% text(0.03, 5e-5, 'h^{1.65}', 'FontSize', 14);