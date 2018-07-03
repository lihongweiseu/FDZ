uus0=us0*100;uusl=usl*100;uusf=usf*100;
uubl=ubl*100;uubf=ubf*100; % m to cm
uubl(3,:)=1e4*ubl(3,:);uubf(3,:)=1e4*ubf(3,:);
for i=1:1:8
    uus0(3*i,:)=1e4*us0(3*i,:);uusl(3*i,:)=1e4*usl(3*i,:);uusf(3*i,:)=1e4*usf(3*i,:);
end

dir=char('x-dir','y-dir','r-dir');

%%%%%%%%%%%%%%%%%%%% 1. Displacement %%%%%%%%%%%%%%%%%%%% 
figure('Name','dis');set(gcf,'Position',[0 0 1050 600]);
for i=1:1:3
   subplot(4,3,i); %8th floor
   plot(t,uus0(21+i,:),'Color',[0.5 0.5  0.5],'LineStyle',':','linewidth',1.5);hold on;
   plot(t,uusl(21+i,:),'b','linewidth',1);hold on;
   plot(t,uusf(21+i,:),'r--','linewidth',1);axis tight;xlim([0 ceil(t(end))]);
   title(['\textbf{(' num2str(i) '). 8$^{\bf{th}}$ floor (' dir(i,:) ')}'],'fontsize',12,'interpreter','latex');
   subplot(4,3,3+i); %4th floor
   plot(t,uus0(9+i,:),'Color',[0.5 0.5  0.5],'LineStyle',':','linewidth',1.5);hold on;
   plot(t,uusl(9+i,:),'b','linewidth',1);hold on;
   plot(t,uusf(9+i,:),'r--','linewidth',1);axis tight;xlim([0 ceil(t(end))]);
   title(['\textbf{(' num2str(3+i) '). 4$^{\bf{th}}$ floor (' dir(i,:) ')}'],'fontsize',12,'interpreter','latex');
   subplot(4,3,6+i); %1st floor
   plot(t,uus0(i,:),'Color',[0.5 0.5  0.5],'LineStyle',':','linewidth',1.5);hold on;
   plot(t,uusl(i,:),'b','linewidth',1);hold on;
   plot(t,uusf(i,:),'r--','linewidth',1);axis tight;xlim([0 ceil(t(end))]);
   title(['\textbf{(' num2str(6+i) '). 1$^{\bf{st}}$ floor (' dir(i,:) ')}'],'fontsize',12,'interpreter','latex');
   subplot(4,3,9+i); %Base
   plot(t,uubl(i,:),'b','linewidth',1);hold on;
   plot(t,uubf(i,:),'r--','linewidth',1);
   title(['\textbf{(' num2str(9+i) '). Base (' dir(i,:) ')}'],'fontsize',12,'interpreter','latex');
   xlabel('\textbf{Time (s)}','fontsize',12,'interpreter','latex');axis tight;xlim([0 ceil(t(end))]);
   for j=1:1:4
       subplot(4,3,3*(j-1)+i);
       ylabel('\textbf{Dis (cm)}','fontsize',12,'interpreter','latex');
       axesH = gca ; 
       set(axesH,'TickLabelInterpreter','latex');
       axesH.XAxis.TickLabelFormat ='\\textbf{%g}';axesH.YAxis.TickLabelFormat ='\\textbf{%g}';
       grid on;set(gca,'fontsize',12);
   end
end
for j=1:1:4
    subplot(4,3,3*j);
    ylabel('\textbf{Dis (10$^{\bf{-4}}$rad)}' ,'fontsize',12,'interpreter','latex');
end
subplot(4,3,1);
legend({'\textbf{Uncontrolled}','\textbf{ELA system}','\textbf{FDZ system}'},'fontsize',9,'interpreter','latex','location','NorthEast');
%set(gcf,'renderer','Painters');print -depsc dis;


%%%%%%%%%%%%%%%%%%%% 2. Maxmum drift %%%%%%%%%%%%%%%%%%%%
max_d0=zeros(3,8);max_dl=zeros(3,8);max_df=zeros(3,8);
for j=1:1:8
    for i=1:1:2
        max_d0(i,j)=1000*max(abs(dus0(j,:,i)));
        max_dl(i,j)=1000*max(abs(dusl(j,:,i)));
        max_df(i,j)=1000*max(abs(dusf(j,:,i)));
    end
    max_d0(3,j)=1e5*max(abs(dus0(j,:,3)));
    max_dl(3,j)=1e5*max(abs(dusl(j,:,3)));
    max_df(3,j)=1e5*max(abs(dusf(j,:,3)));
end
figure('Name','drift_ratio');set(gcf,'Position',[0 0 1050 600]);
for i=1:1:3
    subplot(1,3,i);
    ba=barh([flipud(max_d0(i,:))' flipud(max_dl(i,:))' flipud(max_df(i,:))'],1,'FaceColor','flat'); grid on;
    set(ba(1),'FaceColor','c');set(ba(2),'FaceColor','b');set(ba(3),'FaceColor','r');
    title(['\textbf{(' num2str(i) '). ' dir(i,:) '}'],'fontsize',12,'interpreter','latex');
    xlabel('\textbf{Drift (10$^{\bf{-3}}$)}','fontsize',12,'interpreter','latex');
    ylabel('\textbf{Floor}','fontsize',12,'interpreter','latex');ylim([0.5 8.5]);
    axesH = gca ; 
    set(axesH,'TickLabelInterpreter','latex');
    axesH.XAxis.TickLabelFormat ='\\textbf{%g}';axesH.YAxis.TickLabelFormat ='\\textbf{%g}';
    grid on;set(gca,'fontsize',12);
end
subplot(1,3,1);
legend({'\textbf{Uncontrolled}','\textbf{ELA system}','\textbf{FDZ system}'},'fontsize',9,'interpreter','latex','location','NorthEast');
subplot(1,3,3);xlabel('\textbf{Drift (10$^{\bf{-5}}$rad/m)}','fontsize',12,'interpreter','latex');
%print -depsc drift_ratio;

%%%%%%%%%%%%%%%%%%%% 3. Absolute acceleration %%%%%%%%%%%%%%%%%%%% 
figure('Name','ab_acc');set(gcf,'Position',[0 0 1050 600]);
for i=1:1:3
   subplot(4,3,i); %8th floor
   plot(t,ab_as0(21+i,:),'Color',[0.5 0.5  0.5],'LineStyle',':','linewidth',1.5);hold on;
   plot(t,ab_asl(21+i,:),'b','linewidth',1);hold on;
   plot(t,ab_asf(21+i,:),'r--','linewidth',1);axis tight;xlim([0 ceil(t(end))]);
   title(['\textbf{(' num2str(i) '). 8$^{\bf{th}}$ floor (' dir(i,:) ')}'],'fontsize',12,'interpreter','latex');
   subplot(4,3,3+i); %4th floor
   plot(t,ab_as0(9+i,:),'Color',[0.5 0.5  0.5],'LineStyle',':','linewidth',1.5);hold on;
   plot(t,ab_asl(9+i,:),'b','linewidth',1);hold on;
   plot(t,ab_asf(9+i,:),'r--','linewidth',1);axis tight;xlim([0 ceil(t(end))]);
   title(['\textbf{(' num2str(3+i) '). 4$^{\bf{th}}$ floor (' dir(i,:) ')}'],'fontsize',12,'interpreter','latex');
   subplot(4,3,6+i); %1st floor
   plot(t,ab_as0(i,:),'Color',[0.5 0.5  0.5],'LineStyle',':','linewidth',1.5);hold on;
   plot(t,ab_asl(i,:),'b','linewidth',1);hold on;
   plot(t,ab_asf(i,:),'r--','linewidth',1);axis tight;xlim([0 ceil(t(end))]);
   title(['\textbf{(' num2str(6+i) '). 1$^{\bf{st}}$ floor (' dir(i,:) ')}'],'fontsize',12,'interpreter','latex');
   subplot(4,3,9+i); %Base
   plot(t,ab_abl(i,:),'b','linewidth',1);hold on;
   plot(t,ab_abf(i,:),'r--','linewidth',1);
   title(['\textbf{(' num2str(9+i) '). Base (' dir(i,:) ')}'],'fontsize',12,'interpreter','latex');
   xlabel('\textbf{Time (s)}','fontsize',12,'interpreter','latex');axis tight;xlim([0 ceil(t(end))]);
   for j=1:1:4
       subplot(4,3,3*(j-1)+i);
       ylabel('\textbf{Ab Acc (m/s$^{\bf{2}}$)}','fontsize',12,'interpreter','latex');
       axesH = gca ; 
       set(axesH,'TickLabelInterpreter','latex');
       axesH.XAxis.TickLabelFormat ='\\textbf{%g}';axesH.YAxis.TickLabelFormat ='\\textbf{%g}';
       grid on;set(gca,'fontsize',12);
   end
end
for j=1:1:4
    subplot(4,3,3*j);
    ylabel('\textbf{Ab Acc (rad/s$^{\bf{2}}$)}' ,'fontsize',12,'interpreter','latex');
end
subplot(4,3,1);
legend({'\textbf{Uncontrolled}','\textbf{ELA system}','\textbf{FDZ system}'},'fontsize',9,'interpreter','latex','location','NorthEast');
%set(gcf,'renderer','Painters');print -depsc ab_acc;

%%%%%%%%%%%%%%%%%%%% 4. Max absolute acceleration %%%%%%%%%%%%%%%%%%%%
max_a0=zeros(3,8);max_al=zeros(3,8);max_af=zeros(3,8);
figure('Name','max_ab_acc');set(gcf,'Position',[0 0 1050 600]);
for i=1:1:3
    for j=1:1:8
        max_a0(i,j)=max(abs(ab_as0(3*(j-1)+i,:)));
        max_al(i,j)=max(abs(ab_asl(3*(j-1)+i,:)));
        max_af(i,j)=max(abs(ab_asf(3*(j-1)+i,:)));
    end
    subplot(1,3,i);
    ba=barh([flipud(max_a0(i,:))' flipud(max_al(i,:))' flipud(max_af(i,:))'],1,'FaceColor','flat'); grid on;
    set(ba(1),'FaceColor','c');set(ba(2),'FaceColor','b');set(ba(3),'FaceColor','r');
    title(['\textbf{(' num2str(i) '). ' dir(i,:) '}'],'fontsize',12,'interpreter','latex');
    xlabel('\textbf{Max Ab Acc (m/s$^{\bf{2}}$)}','fontsize',12,'interpreter','latex');
    ylabel('\textbf{Floor}','fontsize',12,'interpreter','latex');ylim([0.5 8.5]);
    axesH = gca ; 
    set(axesH,'TickLabelInterpreter','latex');
    axesH.XAxis.TickLabelFormat ='\\textbf{%g}';axesH.YAxis.TickLabelFormat ='\\textbf{%g}';
    grid on;set(gca,'fontsize',12);
end
subplot(1,3,1);
legend({'\textbf{Uncontrolled}','\textbf{ELA system}','\textbf{FDZ system}'},'fontsize',9,'interpreter','latex','location','NorthEast');
subplot(1,3,3);xlabel('\textbf{Max Ab Acc (rad/s$^{\bf{2}}$)}','fontsize',12,'interpreter','latex');
%print -depsc max_ab_acc;

%%%%%%%%%%%%%%%%%%%% 5. Maximun shear force/moment %%%%%%%%%%%%%%%%%%%%
max_F0=zeros(3,9);max_Fl=zeros(3,9);max_Ff=zeros(3,9);
figure('Name','max_force');set(gcf,'Position',[0 0 1050 600]);
for i=1:1:3
    max_F0(i,1)=max(abs(Fg0(i,:)));
    max_Fl(i,1)=max(abs(Fgl(i,:)));
    max_Ff(i,1)=max(abs(Fgf(i,:)));
    for j=1:1:8
        max_F0(i,j+1)=max(abs(Fs0(3*(j-1)+i,:)));
        max_Fl(i,j+1)=max(abs(Fsl(3*(j-1)+i,:)));
        max_Ff(i,j+1)=max(abs(Fsf(3*(j-1)+i,:)));
    end
    subplot(1,3,i);
    ba=barh([flipud(max_F0(i,:)/1e4)' flipud(max_Fl(i,:)/1e4)' flipud(max_Ff(i,:)/1e4)'],1,'FaceColor','flat'); grid on;
    set(ba(1),'FaceColor','c');set(ba(2),'FaceColor','b');set(ba(3),'FaceColor','r');
    title(['\textbf{(' num2str(i) '). ' dir(i,:) '}'],'fontsize',12,'interpreter','latex');
    xlabel('\textbf{Max Force (10$^{\bf{4}}$kN)}','fontsize',12,'interpreter','latex');
    ylabel('\textbf{Floor}','fontsize',12,'interpreter','latex');ylim([0.5 9.5]);
    axesH = gca ; 
    set(axesH,'TickLabelInterpreter','latex');
    axesH.XAxis.TickLabelFormat ='\\textbf{%g}';axesH.YAxis.TickLabelFormat ='\\textbf{%g}';
    grid on;set(gca,'fontsize',12);
end
subplot(1,3,1);
legend({'\textbf{Uncontrolled}','\textbf{ELA system}','\textbf{FDZ system}'},'fontsize',9,'interpreter','latex','location','NorthEast');
subplot(1,3,3);xlabel('\textbf{Max Moment (10$^{\bf{4}}$kNm)}','fontsize',12,'interpreter','latex');
%print -depsc max_force;
