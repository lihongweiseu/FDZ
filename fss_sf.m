function [sys,x0,str,ts] = fss_sf(t,x,u,flag,UL,GL,A,B,C,D,x_initial)
switch flag
  case 0
    [sys,x0,str,ts] = mdlInitializeSizes(A,D,x_initial);
  case 2                                                
    sys = mdlUpdate(t,x,u,UL,GL,A,B); 
  case 3                                               
    sys = mdlOutputs(t,x,u,C,D);
  case 9                                                
    sys = [];
  otherwise
    DAStudio.error('Simulink:blocks:unhandledFlag', num2str(flag));
end

function [sys,x0,str,ts] = mdlInitializeSizes(A,D,x_initial)
sizes = simsizes;
sizes.NumContStates  = 0;
sizes.NumDiscStates  = size(A,1);
sizes.NumOutputs     = size(D,1);
sizes.NumInputs      = size(D,2);
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);
x0  = x_initial;
str = [];
ts  = [-1 0]; 

function sys = mdlUpdate(~,x,u,UL,GL,A,B)
persistent x_pre;
if isempty(x_pre)
    x_pre=zeros(size(u,1),UL);
end
persistent x_assemble;
if isempty(x_assemble)
    if UL==1
        x_assemble=0;
    else
    x_assemble=zeros(UL,UL);
    x_assemble(1:UL-1,2:UL)=eye(UL-1);
    end
end
x_pre=x_pre*x_assemble;
x_pre(:,1)=x;
sys = A*x+B*u-x_pre*GL(1:UL)';

function sys = mdlOutputs(~,x,u,C,D)
sys = C*x+D*u;


