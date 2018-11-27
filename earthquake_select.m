<<<<<<< HEAD
=======
<<<<<<< HEAD
function [Nt,t,ag] = earthquake_select(E_direc,E_swit,E_intens)
% this is a function used in 'isolation_run.m' to select earthquake and direction
dt=0.005;
if E_direc==1
    x_direc=1;y_direc=2;
else 
    x_direc=2;y_direc=1;
end

switch E_swit
    case 1
        load newhall.txt;
        Nt=length(newhall(:,1)');   ag=zeros(3,Nt); ag(x_direc,:)=newhall(:,1)';  ag(y_direc,:)=newhall(:,2)';
    case 2
        load sylmar.txt;
        Nt=length(sylmar(:,1)');    ag=zeros(3,Nt); ag(x_direc,:)=sylmar(:,1)';   ag(y_direc,:)=sylmar(:,2)';
    case 3
        load elcentro.txt;
        Nt=length(elcentro(:,1)');  ag=zeros(3,Nt); ag(x_direc,:)=elcentro(:,1)'; ag(y_direc,:)=elcentro(:,2)';
    case 4
        load rinaldi.txt;
        Nt=length(rinaldi(:,1)');   ag=zeros(3,Nt); ag(x_direc,:)=rinaldi(:,1)';  ag(y_direc,:)=rinaldi(:,2)';
    case 5
        load kobe.txt;
        Nt=length(kobe(:,1)');      ag=zeros(3,Nt); ag(x_direc,:)=kobe(:,1)';     ag(y_direc,:)=kobe(:,2)';
    case 6
        load jiji.txt;
        Nt=length(jiji(:,1)');      ag=zeros(3,Nt); ag(x_direc,:)=jiji(:,1)';     ag(y_direc,:)=jiji(:,2)';
    case 7
        load erzikan.txt;
        Nt=length(erzikan(:,1)');   ag=zeros(3,Nt); ag(x_direc,:)=erzikan(:,1)';  ag(y_direc,:)=erzikan(:,2)';
end
ag=ag/100*E_intens;   % (m/s-2)
ag(3,:)=zeros(1,Nt); t=(0:1:Nt-1)*dt;
end

=======
>>>>>>> 4f64618cd0d206c235228f52e1457de4607dec01
function [Nt,t,ag] = earthquake_select(E_direc,E_swit,E_intens)
% this is a function used in 'isolation_run.m' to select earthquake and direction
dt=0.005;
if E_direc==1
    x_direc=1;y_direc=2;
else 
    x_direc=2;y_direc=1;
end

switch E_swit
    case 1
        load newhall.txt;
        Nt=length(newhall(:,1)');   ag=zeros(3,Nt); ag(x_direc,:)=newhall(:,1)';  ag(y_direc,:)=newhall(:,2)';
    case 2
        load sylmar.txt;
        Nt=length(sylmar(:,1)');    ag=zeros(3,Nt); ag(x_direc,:)=sylmar(:,1)';   ag(y_direc,:)=sylmar(:,2)';
    case 3
        load elcentro.txt;
        Nt=length(elcentro(:,1)');  ag=zeros(3,Nt); ag(x_direc,:)=elcentro(:,1)'; ag(y_direc,:)=elcentro(:,2)';
    case 4
        load rinaldi.txt;
        Nt=length(rinaldi(:,1)');   ag=zeros(3,Nt); ag(x_direc,:)=rinaldi(:,1)';  ag(y_direc,:)=rinaldi(:,2)';
    case 5
        load kobe.txt;
        Nt=length(kobe(:,1)');      ag=zeros(3,Nt); ag(x_direc,:)=kobe(:,1)';     ag(y_direc,:)=kobe(:,2)';
    case 6
        load jiji.txt;
        Nt=length(jiji(:,1)');      ag=zeros(3,Nt); ag(x_direc,:)=jiji(:,1)';     ag(y_direc,:)=jiji(:,2)';
    case 7
        load erzikan.txt;
        Nt=length(erzikan(:,1)');   ag=zeros(3,Nt); ag(x_direc,:)=erzikan(:,1)';  ag(y_direc,:)=erzikan(:,2)';
end
ag=ag/100*E_intens;   % (m/s-2)
ag(3,:)=zeros(1,Nt); t=(0:1:Nt-1)*dt;
end

<<<<<<< HEAD
=======
>>>>>>> ac1df34758bb84eee970c017e6146c38cd3c45aa
>>>>>>> 4f64618cd0d206c235228f52e1457de4607dec01
