<<<<<<< HEAD
=======
<<<<<<< HEAD
function [Jl,Jf,J] = evaluation_criteria(Al,resp_l,As,Bs,usb,Fb,Nt,STRUC)
usl=resp_l(:,1:24)'; % sl-superstructure with liear bearings
vsl=resp_l(:,25:48)';
ubl=resp_l(:,49:51)'; % bl-base with liear bearings
vbl=resp_l(:,52:54)';
ab_abl=Al(52:54,:)*[usl;vsl;ubl;vbl]; ab_asl=STRUC.MK*usl+STRUC.MC*vsl;
Fsl=STRUC.R'*(STRUC.C*vsl+STRUC.K*usl); % force of first storey
Fgl=Fsl-STRUC.m*ab_abl;  % force of the ground

usf=usb.data(:,1:24)'; % sf-superstructure with fractional bearings
vsf=usb.data(:,25:48)';
ubf=usb.data(:,49:52)'; % bl-base with fractional bearings
Fgf=Fb.data'; % force of the ground
ab_abf=As(52:54,1:48)*[usf;vsf]+Bs(52:54,4:6)*Fgf; ab_asf=STRUC.MK*usf+STRUC.MC*vsf;
Fsf=Fgf+STRUC.m*ab_abf; % force of first storey. to verified: Fsf_veri=R'*(C*vsf+K*usf);

%drift
dusl=zeros(8,Nt,3);dusf=zeros(8,Nt,3);
for i=1:1:3
    dusl(1,:,i)=usl(i,:)/STRUC.dh(1); %dh is the height for each floor
    dusf(1,:,i)=usf(i,:)/STRUC.dh(1);
    for j=2:1:8
        dusl(j,:,i)=(usl(i+(j-1)*3,:)-usl(i+(j-2)*3,:))/STRUC.dh(j);
        dusf(j,:,i)=(usf(i+(j-1)*3,:)-usf(i+(j-2)*3,:))/STRUC.dh(j);
    end
end

%Evaluation
V0l=zeros(1,Nt);V0f=zeros(1,Nt); % Peak base shear
V1l=zeros(1,Nt);V1f=zeros(1,Nt); % Peak structure shear (at first storey level)
dil=zeros(1,Nt);dif=zeros(1,Nt); % Peak base displacement
dfl=zeros(8,Nt);dff=zeros(8,Nt); % Peak inter-storey drift
afl=zeros(8,Nt);aff=zeros(8,Nt); % Peak absolute floor acceleration
sigma_dl=sqrt(rms(ubl(1,:))^2+rms(ubl(2,:))^2);sigma_df=sqrt(rms(ubf(1,:))^2+rms(ubf(2,:))^2); % RMS base displacement
sigma_al=zeros(1,8);sigma_af=zeros(1,8); % RMS absolute floor acceleration
Jl=zeros(1,7);Jf=zeros(1,7);

for i=1:1:Nt
    V0l(i)=sqrt(Fgl(1,i)^2+Fgl(2,i)^2);
    V1l(i)=sqrt(Fsl(1,i)^2+Fsl(2,i)^2);
    dil(i)=sqrt(ubl(1,i)^2+ubl(2,i)^2);
    
    V0f(i)=sqrt(Fgf(1,i)^2+Fgf(2,i)^2);
    V1f(i)=sqrt(Fsf(1,i)^2+Fsf(2,i)^2);
    dif(i)=sqrt(ubf(1,i)^2+ubf(2,i)^2);
end
Jl(1)=max(V0l(:));Jl(2)=max(V1l(:));Jl(3)=max(dil(:));
Jf(1)=max(V0f(:));Jf(2)=max(V1f(:));Jf(3)=max(dif(:));

for j=1:1:8
    for i=1:1:Nt
        dfl(j,i)=sqrt(dusl(j,i,1)^2+dusl(j,i,2)^2);
        afl(j,i)=sqrt(ab_asl(3*j-2,i)^2+ab_asl(3*j-1,i)^2);
        
        dff(j,i)=sqrt(dusf(j,i,1)^2+dusf(j,i,2)^2);
        aff(j,i)=sqrt(ab_asf(3*j-2,i)^2+ab_asf(3*j-1,i)^2);
    end
    sigma_al(j)=sqrt(rms(ab_asl(3*j-2,:))^2+rms(ab_asl(3*j-1,:))^2);
    sigma_af(j)=sqrt(rms(ab_asf(3*j-2,:))^2+rms(ab_asf(3*j-1,:))^2);
end
Jl(4)=max(max(dfl));Jl(5)=max(max(afl));Jl(6)=max(sigma_dl);Jl(7)=max(sigma_al);
Jf(4)=max(max(dff));Jf(5)=max(max(aff));Jf(6)=max(sigma_df);Jf(7)=max(sigma_af);
J=Jf./Jl;
end

=======
>>>>>>> 4f64618cd0d206c235228f52e1457de4607dec01
function [Jl,Jf,J] = evaluation_criteria(Al,resp_l,As,Bs,usb,Fb,Nt,STRUC)
usl=resp_l(:,1:24)'; % sl-superstructure with liear bearings
vsl=resp_l(:,25:48)';
ubl=resp_l(:,49:51)'; % bl-base with liear bearings
vbl=resp_l(:,52:54)';
ab_abl=Al(52:54,:)*[usl;vsl;ubl;vbl]; ab_asl=STRUC.MK*usl+STRUC.MC*vsl;
Fsl=STRUC.R'*(STRUC.C*vsl+STRUC.K*usl); % force of first storey
Fgl=Fsl-STRUC.m*ab_abl;  % force of the ground

usf=usb.data(:,1:24)'; % sf-superstructure with fractional bearings
vsf=usb.data(:,25:48)';
ubf=usb.data(:,49:52)'; % bl-base with fractional bearings
Fgf=Fb.data'; % force of the ground
ab_abf=As(52:54,1:48)*[usf;vsf]+Bs(52:54,4:6)*Fgf; ab_asf=STRUC.MK*usf+STRUC.MC*vsf;
Fsf=Fgf+STRUC.m*ab_abf; % force of first storey. to verified: Fsf_veri=R'*(C*vsf+K*usf);

%drift
dusl=zeros(8,Nt,3);dusf=zeros(8,Nt,3);
for i=1:1:3
    dusl(1,:,i)=usl(i,:)/STRUC.dh(1); %dh is the height for each floor
    dusf(1,:,i)=usf(i,:)/STRUC.dh(1);
    for j=2:1:8
        dusl(j,:,i)=(usl(i+(j-1)*3,:)-usl(i+(j-2)*3,:))/STRUC.dh(j);
        dusf(j,:,i)=(usf(i+(j-1)*3,:)-usf(i+(j-2)*3,:))/STRUC.dh(j);
    end
end

%Evaluation
V0l=zeros(1,Nt);V0f=zeros(1,Nt); % Peak base shear
V1l=zeros(1,Nt);V1f=zeros(1,Nt); % Peak structure shear (at first storey level)
dil=zeros(1,Nt);dif=zeros(1,Nt); % Peak base displacement
dfl=zeros(8,Nt);dff=zeros(8,Nt); % Peak inter-storey drift
afl=zeros(8,Nt);aff=zeros(8,Nt); % Peak absolute floor acceleration
sigma_dl=sqrt(rms(ubl(1,:))^2+rms(ubl(2,:))^2);sigma_df=sqrt(rms(ubf(1,:))^2+rms(ubf(2,:))^2); % RMS base displacement
sigma_al=zeros(1,8);sigma_af=zeros(1,8); % RMS absolute floor acceleration
Jl=zeros(1,7);Jf=zeros(1,7);

for i=1:1:Nt
    V0l(i)=sqrt(Fgl(1,i)^2+Fgl(2,i)^2);
    V1l(i)=sqrt(Fsl(1,i)^2+Fsl(2,i)^2);
    dil(i)=sqrt(ubl(1,i)^2+ubl(2,i)^2);
    
    V0f(i)=sqrt(Fgf(1,i)^2+Fgf(2,i)^2);
    V1f(i)=sqrt(Fsf(1,i)^2+Fsf(2,i)^2);
    dif(i)=sqrt(ubf(1,i)^2+ubf(2,i)^2);
end
Jl(1)=max(V0l(:));Jl(2)=max(V1l(:));Jl(3)=max(dil(:));
Jf(1)=max(V0f(:));Jf(2)=max(V1f(:));Jf(3)=max(dif(:));

for j=1:1:8
    for i=1:1:Nt
        dfl(j,i)=sqrt(dusl(j,i,1)^2+dusl(j,i,2)^2);
        afl(j,i)=sqrt(ab_asl(3*j-2,i)^2+ab_asl(3*j-1,i)^2);
        
        dff(j,i)=sqrt(dusf(j,i,1)^2+dusf(j,i,2)^2);
        aff(j,i)=sqrt(ab_asf(3*j-2,i)^2+ab_asf(3*j-1,i)^2);
    end
    sigma_al(j)=sqrt(rms(ab_asl(3*j-2,:))^2+rms(ab_asl(3*j-1,:))^2);
    sigma_af(j)=sqrt(rms(ab_asf(3*j-2,:))^2+rms(ab_asf(3*j-1,:))^2);
end
Jl(4)=max(max(dfl));Jl(5)=max(max(afl));Jl(6)=max(sigma_dl);Jl(7)=max(sigma_al);
Jf(4)=max(max(dff));Jf(5)=max(max(aff));Jf(6)=max(sigma_df);Jf(7)=max(sigma_af);
J=Jf./Jl;
end

<<<<<<< HEAD
=======
>>>>>>> ac1df34758bb84eee970c017e6146c38cd3c45aa
>>>>>>> 4f64618cd0d206c235228f52e1457de4607dec01
