clear; clc; 
%% Hover 5-min 4000 ft, 95°F (ISA + 20 K)

% Constants
P0 = 101325;           % SL std pressure [Pa]
T0 = 288.15;           % SL std temp [K]
L = 0.0065;            % Temperature lapse rate [K/m]
g = 9.81;              % [m/s^2]
R_gas = 287.058;           % Specific gas const [J/(kg·K)]
h_ft = 4000;           % Altitude [ft]
delta_ISA = 20;        % Temperature deviation [K]
    

% XV-15 Rotor Parameters
cd_rotor = 0.01;
k_ideal = 1.15;
N_b = 3;               % blades per rotor
omega = 59.167;         % [rad/sec]
c = 0.3556;            % [m] chord main rotor
R = 3.81;              % [m] rotor blade radius
A = pi * R^2;          % [m^2] Rotor disk area
W = 57826.881;         % aircraft weight [N]
T = W/2;               % per rotor thrust
sigma = (N_b * c) / (pi * R); % Solidity

%% Density Calculation
h = h_ft * 0.3048;     % [m] Convert alt to meters
T_ISA = T0 - L * h;    % [K] ISA temperature at altitude
T_actual = T_ISA + delta_ISA;  % [K] Actual temperature (ISA + deviation)
P = P0 * (1 - (L * h) / T0)^(g / (R_gas * L)); % Pressure at altitude using barometric formula
rho = P / (R_gas * T_actual);  % [kg/m^3]  Air density using ideal gas law

%% Profile Power (per rotor)
P_o1 = (1/8) * rho * omega^3 * R^4 * sigma * cd_rotor; %[Watts]
%% Induced Power (per rotor)
P_ideal1 = (T^(3/2)) / sqrt(2*rho*A);%[Watts]
P_i1 = k_ideal * P_ideal1;%[Watts]

%% Total power for aircraft
P_total_W_alt = 2 * (P_o1 + P_i1);
P_total_HP_alt = P_total_W_alt * 0.00134102;

fprintf("\n===== Hover at 4000 ft, ISA+20C =====\n");
fprintf("Profile Power (total) : %.2f W  (%.2f hp)\n", 2*P_o1, 2*P_o1*0.00134102);
fprintf("Induced Power (total) : %.2f W  (%.2f hp)\n", 2*P_i1, 2*P_i1*0.00134102);
fprintf("TOTAL Power Required  : %.2f W  (%.2f hp)\n", P_total_W_alt, P_total_HP_alt);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Hover 5-min Sea Level ISA

rho_SL = 1.225; % [kg/m^3]

%% Profile Power (per rotor)

%P_o2 = (1/8) * rho_SL * omega^3 * R^4 * sigma * cd_rotor; %[Watts]
P_o2 = (1/8) * rho_SL * 4 * (omega^3) * c * cd_rotor * R^4;

%% Induced Power (per rotor)
T = W/2;
P_ideal2 = (T^(3/2)) / sqrt(2*rho_SL*A);
P_i2 = k_ideal * P_ideal2; % [Watts]


%% Total power aircraft
P_total_W_SL = 2 * (P_o2 + P_i2);
P_total_HP_SL = P_total_W_SL * 0.00134102;

fprintf("\n===== Hover at Sea Level ISA =====\n");
fprintf("Profile Power (total) : %.2f W  (%.2f hp)\n", 2*P_o2, 2*P_o2*0.00134102);
fprintf("Induced Power (total) : %.2f W  (%.2f hp)\n", 2*P_i2, 2*P_i2*0.00134102);
fprintf("TOTAL Power Required  : %.2f W  (%.2f hp)\n", P_total_W_SL, P_total_HP_SL);
