clc; clear; close all;

%% Parameters

Temp = 1:1e5;
hbar = 1e-16;
Bm = 1e-6;
kB = 1.38e-23;
N = 1e5;
l = 1e3;

%% Calculate

w = 2.*sqrt(Bm).*abs(sin(pi.*l/N));
lambda = hbar.*w./(kB*Temp);
C = 1e5*3*kB.*lambda.^2.*exp(lambda)./(exp(lambda)-1).^2;

for i = 1:length(Temp)
TdOD = 1e3/Temp(i);
fun = @(x) x.^4.*exp(x)./(exp(x)-1).^2;
q = integral(fun,0,TdOD);
CD(i) = 9*N*kB*(TdOD)^-3*q;
end

%% Plot
semilogx(Temp/1e3,C/(kB*N))
hold on
semilogx(Temp/1e3,CD/(kB*N))
ylabel('$C/k_BN$')
xlabel('$T/O_D$')
xlim([1e-2 1e2])
legend('Exact solution','Debye interpolation')
grid on
