%% Variables
W = 13000; %lbs Weight
v_kt_cal = 260; % Calibrated
v_kt = 300.077; % Velocity in Knots

v_ft = v_kt/0.592484; % Velocity in ft/s
v_ft_cal = v_kt_cal/0.592484; % Velocity calibrated in Ft/s

e = 0.055; %oswald eff.
rho = 0.001183; %slug/ft^3 @ 10,000ft
f = 10.78; % ft^2 flat plate area
%%

D_p = 0.5*rho*(v_ft)^2*f; % Parasite Drag
S = 169; %ft^2 Wing Area
b = 35; %span
AR = (b^2)/S;
S_wet = 1941.68; % ft^2 S wetted
P_i = (W^2)/(2*rho*S*v_ft);


CL = W/(0.5*rho*(v_ft^2)*S)
CDi = (1/(pi*e*AR))*(CL^2)
CDe = f/S

CD = CDi+CDe

T = W*(CD/CL);
P = T*v_ft;
P_hp = (P * 1.818182*10^-3)*1.15 % Convert to hp
