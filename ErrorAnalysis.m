clearvars; clc;
dt = 1e-7;
FileID = fopen('OD1Error.txt');
A = fscanf(FileID, '%f %f %f', [3 inf]);
Meshsize = [300, 200, 150, 100, 50];
for i = 1:length(Meshsize)
    [~, col] = find(A == Meshsize(i));
    PhiErr(i) = max(A(2, col));
    for j = 1:length(col)-1
        temp(j) = dt*(A(3, col(j))^2 + A(3, col(j+1))^2)/2;
    end
    PsiErr(i) = sqrt(sum(temp));    
    Phi0Err(i) = A(2, 11*(i-1)+1);
end

% loglog(Meshsize, PhiErr, 'k.-', 'MarkerSize', 16); hold on;
loglog(Meshsize, PsiErr, 'k.-', 'MarkerSize', 16); hold on;
% loglog(Meshsize, PhiErr + PsiErr, 'k.-', 'MarkerSize', 16); hold on;
% loglog(Meshsize, 3.7e1*(Meshsize).^-2, 'k--', 'HandleVisibility', 'off');
Const = polyfit(log(Meshsize), log(PsiErr), 1);
plot(Meshsize, exp(polyval(Const, log(Meshsize))), 'k--', 'HandleVisibility', 'off');
text(150, 1.1e-3, 'N^{-1.68}', 'FontSize', 12);



box on; grid on;
xlabel('No. Elements'); 
% ylabel("$$||\tilde{\phi}-\phi||_{L^\infty(L^2)}$$", 'Interpreter', 'LaTeX');
ylabel("$$||\tilde{\psi}-\psi||_{L^2(L^2)}$$", 'Interpreter', 'LaTeX');
% ylabel("$$||\tilde{\phi}-\phi||_{L^\infty(L^2)} + ||\tilde{\psi}-\psi||_{L^2(L^2)}$$", 'Interpreter', 'LaTeX');