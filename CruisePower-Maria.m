clc; clear;

W = 13000;
rho = 0.001818;
S = 169.0;
b = 32.17;
fp_area = 10.79;
eta_p = 0.85;
g = 32.174;
tc = 0.18;
AR = b*b/S;

V_knots = linspace(140,300.077,400);
V = V_knots * 1.68781;

CL = (W) ./ (0.5.*rho .* (V.^2) .* S);% Incorrect Formula for CL
cl = CL(400);

term1 = 0.55 .* tc .* (CL.^5) ./ (pi .* AR);
term2 = 0.55 .* tc ./ ( (CL.^2.4) .* pi .* AR );
e0 = -1+(1 ./ ( 0.618 + term1 + term2 ));

k   = 1 ./ (pi .* AR .* e0);
K = k(400);

CD0 = 0.055;
q = 0.5 .* rho .* V.^2;

CDi = (k .* CL.^2);
cdi = CDi(400);
D  = (q .* fp_area * CD0) + (q .* S .* CDi);

%Cruise Power

P_req = ((q .* V .* S .*CD0) + ((2*W*W)./(rho*pi*AR.*e0*S.*V)));
P_req = P_req/eta_p

P = P_req(400)/550

P_shaft = 2 * 1250 * 550;
P_avail = eta_p * P_shaft * ones(size(V));

%ROC from Availaible power
ROC = (P_avail - P_req)/W;

%Assuming P = 1000SHP find ROD
ROD = (((1000*550) - P_req) / W) * 60;

%P_cruise vs. Velocity
figure; hold on; grid on;
plot(V_knots, P_req/550, 'LineWidth', 2);
plot(V_knots, P_avail/550, 'LineWidth', 2);
xlabel('Velocity [knots]');
ylabel('Power [HP]');
title('Power vs Velocity');

%ROC vs. Velocite
%Power of climb is max power to get an ROC for mission
figure; hold on; grid on;
plot(V_knots, ROC, 'LineWidth', 2);
xlabel('V [KTS]');
ylabel('ROC (FT/S)');
title('ROC vs Velocity');


%Calculating require descent speed at different flight speeds
H_descent = 10000;
X_descent_nm = 306;
ft_per_nm = 6076;

descent_gradient = H_descent / (X_descent_nm * ft_per_nm);

V_fpm = V * 60;
ROD_req_fpm = V_fpm * descent_gradient;


%Intersection poijnt is target ROD and flight speed
figure; hold on; grid on;
plot(V_knots, ROD, 'LineWidth', 2);
plot(V_knots, -ROD_req_fpm, 'LineWidth', 2);
xlabel('V [KTS]');
ylabel('ROD (FT/Min)');
title('ROD vs Velocity');
legend('1000 Shp ROD vs Vel','Required ROD vs. V','Location','best');

