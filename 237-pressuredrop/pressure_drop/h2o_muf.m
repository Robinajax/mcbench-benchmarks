function MUF = h2o_muf(P)
% H2O_MUF  Dynamic viscosity of saturated fluid at a given pressure
% H2O_MUF(P) Returns the dynamic viscosity of saturated fluid at a given pressure.
% Dynamic viscosity in (Pa s) i.e., (kg/ms)
% Based on the correlation given in Appendix 6 of the 
% ASME STEAM TABLES - SIXTH EDITION
% Range of validity of equation:
%    P<=500MPa for   0�C <= T <= 150�C
%    P<=350MPa for 150�C <= T <= 600�C
%    P<=300MPa for 600�C <= T <= 900�C
% Called function: h2o_mu(T,RHO), h2o_tsat(P), h2o_rhof(P)
%  Required Inputs are: P - pressure in kPa
% ---------------------------------------------------------------
% The MATLAB function was created by Tibor Balint, December 1998
% TBoreal Research Corporation, Toronto, Ont. Canada 
% (tibor@netcom.ca) and also, University of Warwick, UK
% ---------------------------------------------------------------

format long g;  % set the format of the calculations

% Get the saturation temperature at a given pressure
TS=h2o_tsat(P);

% Get the saturated fluid density
RHOF=h2o_rhof(P);

% Get the dynamic viscosity of the saturated fluid
MUF=h2o_mu(TS,RHOF);

return

