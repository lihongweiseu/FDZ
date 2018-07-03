% 1. Set err=0.02 in fsim_isol and run fsim_isol,then run 'first part' of compare_with_FFT
% 2. Set err=0.005 in fsim_isol and run fsim_isol,then run 'second part' of compare_with_FFT

%%%%%%%%%%%%%%%%%%%%%% first part %%%%%%%%%%%%%%%%%%%%%%
Nf= 2^nextpow2(Nt);
af_fre(1:2,:)=fft(ag(1:2,:),Nf,2);af_fre(3,:)=zeros(1,Nf);
wf=zeros(1,Nf);kb=zeros(3,3,Nf);
us_fre=zeros(24,Nf);vs_fre=us_fre;as_fre=us_fre;
ub_fre=zeros(3,Nf);vb_fre=ub_fre;ab_fre=ub_fre;Fb_fre=ub_fre;
for i=1:1:Nf
    if i<Nf/2+2
        wf(i)=(i-1)*2*pi/Nf/dt;
    else
        wf(i)=(i-Nf-1)*2*pi/Nf/dt;
    end
    wf_a=(1i*wf(i))^alpha;wf_2=wf(i)^2;iwCK=1i*wf(i)*C+K;
    kb(:,:,i)=(b_0+b_1*wf_a)/(a_0+wf_a)*H;
    a1=-(-wf_2*M+iwCK)\M*R;a2=-wf_2*a1;
    a3=R'*iwCK*a1-m;a4=-wf_2*a3;
    ub_fre(:,i)=(kb(:,:,i)-a4)\a3*af_fre(:,i);Fb_fre(:,i)=kb(:,:,i)*ub_fre(:,i);
    us_fre(:,i)=a1*af_fre(:,i)+a2*ub_fre(:,i);vs_fre(:,i)=1i*wf(i)*us_fre(:,i);as_fre(:,i)=-wf(i)^2*us_fre(:,i);
    vb_fre(:,i)=1i*wf(i)*ub_fre(:,i);ab_fre(:,i)=-wf(i)^2*ub_fre(:,i);
end
usF_Nf=ifft(us_fre,Nf,2); vsF_Nf=ifft(vs_fre,Nf,2);asF_Nf=ifft(as_fre,Nf,2);
ubF_Nf=ifft(ub_fre,Nf,2); vbF_Nf=ifft(vb_fre,Nf,2);abF_Nf=ifft(ab_fre,Nf,2);FbF_Nf=ifft(Fb_fre,Nf,2);

% short to Nt
usF=real(usF_Nf(:,1:Nt));vsF=real(vsF_Nf(:,1:Nt));asF=real(asF_Nf(:,1:Nt));
ubF=real(ubF_Nf(:,1:Nt));vbF=real(vbF_Nf(:,1:Nt));abF=real(abF_Nf(:,1:Nt));FbF=real(FbF_Nf(:,1:Nt));
ab_abF=abF+ag;ab_asF=asF+R*ab_abF;

FsF(1:3,:)=R'*(C*vsF+K*usF);
for i=1:1:7
    FsF(3*i+1:3*i+3,:)=FsF(3*i-2:3*i,:)+M(3*i-2:3*i,3*i-2:3*i)*ab_asF(3*i-2:3*i,:);
end

figure('Name','FFT_veri');set(gcf,'Position',[0 0 1050 500]);
subplot(2,2,1); % displacement
plot(t,ubF(1,:)*1E2,'b','linewidth',1.5);hold on;
plot(t,ubf(1,:)*1E2,'r:','linewidth',2);grid on;
title(['\textbf{(1). Base x-dir (}$\bf{\xi}$\textbf{=' num2str(err*100) '\%,{\it UL}=' num2str(UL) ')}'],'fontsize',12,'interpreter','latex');
legend({'\textbf{FFT method}','\textbf{SS method}'},'fontsize',12,'interpreter','latex','location','NorthEast');
xlabel('\textbf{Time (s)}','fontsize',12,'interpreter','latex');
ylabel('\textbf{Dis (cm)}','fontsize',12,'interpreter','latex');
axis tight;xlim([0 ceil(t(end))]);
axesH = gca ; 
set(axesH,'TickLabelInterpreter','latex');
axesH.XAxis.TickLabelFormat ='\\textbf{%g}';axesH.YAxis.TickLabelFormat ='\\textbf{%g}';
grid on;set(gca,'fontsize',12);

subplot(2,2,3); % Absolute acceleration
plot(t,ab_asF(23,:),'b','linewidth',1.5);hold on;
plot(t,ab_asf(23,:),'r:','linewidth',2);grid on;
title(['\textbf{(3). 8}$^{\bf{th}}$\textbf{ floor y-dir (}$\bf{\xi}$\textbf{=' num2str(err*100) '\%,{\it UL}=' num2str(UL) ')}'],'fontsize',12,'interpreter','latex');
xlabel('\textbf{Time (s)}','fontsize',12,'interpreter','latex');
ylabel('\textbf{Ab Acc (m/s}$^{\bf{2}}$\textbf{)}','fontsize',12,'interpreter','latex');
axis tight;xlim([0 ceil(t(end))]);
axesH = gca ; 
set(axesH,'TickLabelInterpreter','latex');
axesH.XAxis.TickLabelFormat ='\\textbf{%g}';axesH.YAxis.TickLabelFormat ='\\textbf{%g}';
grid on;set(gca,'fontsize',12);

%%%%%%%%%%%%%%%%%%%%%% second part %%%%%%%%%%%%%%%%%%%%%%
subplot(2,2,2); % displacement
plot(t,ubF(1,:)*1E2,'b','linewidth',1.5);hold on;
plot(t,ubf(1,:)*1E2,'r:','linewidth',2);grid on;
title(['\textbf{(2). Base x-dir (}$\bf{\xi}$\textbf{=' num2str(err*100) '\%,{\it UL}=' num2str(UL) ')}'],'fontsize',12,'interpreter','latex');
xlabel('\textbf{Time (s)}','fontsize',12,'interpreter','latex');
ylabel('\textbf{Dis (cm)}','fontsize',12,'interpreter','latex');
axis tight;xlim([0 ceil(t(end))]);
axesH = gca ; 
set(axesH,'TickLabelInterpreter','latex');
axesH.XAxis.TickLabelFormat ='\\textbf{%g}';axesH.YAxis.TickLabelFormat ='\\textbf{%g}';
grid on;set(gca,'fontsize',12);

subplot(2,2,4); % Absolute acceleration
plot(t,ab_asF(23,:),'b','linewidth',1.5);hold on;
plot(t,ab_asf(23,:),'r:','linewidth',2);grid on;
title(['\textbf{(4). 8}$^{\bf{th}}$\textbf{ floor y-dir (}$\bf{\xi}$\textbf{=' num2str(err*100) '\%,{\it UL}=' num2str(UL) ')}'],'fontsize',12,'interpreter','latex');
xlabel('\textbf{Time (s)}','fontsize',12,'interpreter','latex');
ylabel('\textbf{Ab Acc (m/s}$^{\bf{2}}$\textbf{)}','fontsize',12,'interpreter','latex');
axis tight;xlim([0 ceil(t(end))]);
axesH = gca ; 
set(axesH,'TickLabelInterpreter','latex');
axesH.XAxis.TickLabelFormat ='\\textbf{%g}';axesH.YAxis.TickLabelFormat ='\\textbf{%g}';
grid on;set(gca,'fontsize',12);
%print -depsc FFT_veri