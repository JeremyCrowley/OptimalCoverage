close all;
clear;
clc;

% simulation parameters
N = 20;
L = 10;
ts = 0.05;


% viz parameters
delay = 0.25;

% define nodes and IC
numNodes = 2;
nodes = linspace(1,numNodes,numNodes);

% initial conditions
%IC = [-1.2,1.3,0,0,0.5,0.8;
%      0,0,-1.5,1,0.5,-0.2];
%IC = [0,   0.1,  0.1  -0.1, -0.1, 0;
%      0,   0,   -0.1, -0.1, 0.1,  0.1];
IC = [0 0.5;0 0.5];
%IC = [0,   0.1,  0.1;
%      0,   0,   -0.1];

% IC size      
[m,n] = size(IC);
 
% boundary
b = 4.5;
config = [-b b -b b];

% proximity communication
senseR = 2;
commR = 6;

% obstacle position
xObst = [-1;-1.5];
uObst = [-0.5;0.5];
threshold = 0.5;

% initial conditions
uGuess = zeros(m,1);

% predict obst
xObstPoly = integratorReach(xObst,uObst,ts,N);

% optimize
tic
[uopt,g] = optimalInputCoverage(IC, N, ts, L, uGuess, nodes, config, commR, senseR, xObstPoly, threshold);
toc
uopt;

% show one round of opt
showOptimization(g,nodes,numNodes,config,commR,senseR,xObstPoly,threshold,delay);
plotObstDist(g,numNodes,xObstPoly,threshold)

