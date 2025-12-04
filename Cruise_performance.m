%% Variables
W = 13000; %lbs Weight
v_kt_cal = 260; % Calibrated
v_kt = 300.077; % Velocity in Knots

v_ft = v_kt/0.592484; % Velocity in ft/s
v_ft_cal = v_kt_cal/0.592484; % Velocity calibrated in Ft/s

e = 0.055; %oswald eff.
eta_p = 0.85;
rho = 0.001818; %slug/ft^3 @ 10,000ft
f = 10.78; % ft^2 flat plate area

tc = 0.18;
%%

D_p = 0.5*rho*(v_ft)^2*f; % Parasite Drag
S = 169; %ft^2 Wing Area
b = 32.17; %span     % Incorrect Span
AR = (b^2)/S;
S_wet = 1941.68; % ft^2 S wetted
P_i = (W^2)/(2*rho*S*v_ft);

CD0 = 0.055;
CL = W/(0.5*rho*(v_ft^2)*S)

term1 = 0.55 .* tc .* (CL.^5) ./ (pi .* AR);
term2 = 0.55 .* tc ./ ( (CL.^2.4) .* pi .* AR );
e = -1+(1 ./ ( 0.618 + term1 + term2 ));

k=(1/(pi*e*AR))
CDi = k*(CL^2)
CDe = f/S;

CD = CDi+CD0;
 
T = W*(CD/CL);
P = T*v_ft;
P_hp = P/(eta_p*550) % Convert to hp
