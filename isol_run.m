%clc, clear all %#ok<CLALL>
format long
err=0.005; dt=0.005;

% Parameters of the superstrucrure and the base
load STRUC.mat;
m = STRUC.m; %(10^3kg) mass of base
M = STRUC.M; K = STRUC.K; C = STRUC.C;  %(10^3kg 10^3kgm^2) (kN/m) (kNs/m)
R = STRUC.R; H = STRUC.H;
% R is the matrix of earthquake influence coefficients. H is the location matrix
MK=-M\K;MC=-M\C;m_RC=m\R'*C;m_RK=m\R'*K;
STRUC.MK=MK; STRUC.MC=MC;

% Parameters of bearings
% Linear bearings
kl=H*919.422;cl=H*27.717;
mkl=m\kl;mcl=m\cl;
Al=[zeros(24,24) eye(24) zeros(24,6);MK-R*m_RK MC-R*m_RC R*mkl R*mcl;zeros(3,51) eye(3);m_RK m_RC -mkl -mcl];
Bl=[zeros(51,3);-eye(3)]; Cl=eye(54); Dl=zeros(54,3);

% Fractional bearings
A_h=pi()*0.27^2/0.18; % 0.41^2/0.25 0.27^2/0.18 % geometric parameters of the VE damper: shear area over shear heihgt
%parameters of FDZe model identified by the experiments. G1,G2,yita (kpa).
G1=4.794E3;G2=4.793E2; eta=2.483E2; alpha=0.520;  a_0=(G1+G2)/eta;b_1=A_h*G1; b_0=b_1*G2/eta;
lim=18000; % this is the biggest data number of the earthquake, which is jiji earthquake.
wa=zeros(1,lim-1);wa(1)=alpha;UL=lim-1;T=dt^alpha;
for i=2:1:lim-1
    temp=(1+alpha)/i;wa(i)=wa(i-1)*(1-temp);
    if abs(err>temp)
        UL=i-1;
        break;
    end
end
%superstucture subsystem
As=[zeros(24,24) eye(24) zeros(24,6);MK-R*m_RK MC-R*m_RC zeros(24,6);zeros(3,51) eye(3);m_RK m_RC zeros(3,6)];
Bs=[zeros(24,6);zeros(24,3) R/m;zeros(3,6);-eye(3) -inv(m)]; Cs=eye(54); Ds=zeros(54,6);
sys=ss(As,Bs,Cs,Ds) ;sysd=c2d(sys,dt);Asd=sysd.A;Bsd=sysd.B;Csd=sysd.C;Dsd=sysd.D; % convert continous SS to discrete SS

%bearing subsystem
Ab=-a_0*T*eye(3); Bb=T*eye(3); Cb=(b_0-a_0*b_1)*H; Db=b_1*H;
xb_initial=zeros(3,1);xs_initial=zeros(54,1);
Reduce=zeros(3,54);Reduce(:,49:51)=eye(3);aN=alpha*[1;1;1];

% Evaluation criteria
Jl=zeros(7,7,2);Jf=zeros(7,7,2);J=zeros(7,7,2);
E_intens=1;
for i=1:1:2  % E_direc
    for j=1:1:7 % E_swit
        [Nt,t,ag]=earthquake_select(i,j,E_intens);
        if UL>Nt-1 
            UL=Nt-1; 
        end
        input=[t' ag'];sim('fsim_ss_2016a');
        resp_l=lsim(ss(Al,Bl,Cl,Dl),ag,t,zeros(54,1));
        [Jl(j,:,i),Jf(j,:,i),J(j,:,i)] = evaluation_criteria(Al,resp_l,As,Bs,usb,Fb,Nt,STRUC);
    end
end

%Combination of J
Jc=zeros(14,7); % Jc is the final evaluation criteria
for i=1:1:7
    for j=1:1:7
        Jc(2*i-1,j)=J(i,j,1);
        Jc(2*i,j)=J(i,j,2);
    end
end