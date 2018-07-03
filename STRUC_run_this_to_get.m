%This is to calculate 'STRUC.mat' for 'isolation_run.m'
%All the values here is provided by Sriram Narasimhan

nfloors=8;               %Number of floors
retained_modes=24;       %Number of retained eigenvectors. 
%This is the square of the first 24 frequencies
eigenval=[49.62	65.66	91.05	496.42	557.82	860.45	1674.41	1793.83	2858.65	3292.80	3511.06	5583.47	5743.95	5958.46	7453.32	7928.58	9248.47	9702.50	10431.08	11673.94	12011.94	12912.83	15828.77	17720.57]; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Eigen Vectors which are Mass Normalized. These correspond to first twentyfour frequencies. Please note that at each floor level there is a x, y and rotation value.
eigenvec=[-0.01220185	0.00018398	0.00011371	0.00036462	0.00975687	-0.00224544	0.00049235	-0.00892955	0.00250350	-0.00005742	-0.00689831	0.00349933	0.00054310	-0.00563796	-0.00016464	0.00514449	0.00436299	-0.00101911	0.00026217	0.00043421	-0.00127372	0.00417143	0.00036802	-0.00093019;
-0.00019829	-0.01225941	-0.00048522	0.01018180	-0.00032104	0.00022136	0.00958531	0.00050686	0.00011786	-0.00702796	0.00009342	-0.00027156	0.00715005	0.00052477	-0.00502329	-0.00024812	0.00012959	0.00003954	-0.00296512	0.00355114	0.00027817	-0.00026402	0.00005514	-0.00019508;
0.00001734	-0.00002537	0.00045328	0.00000928	-0.00005859	-0.00036098	-0.00000890	0.00009454	0.00032461	0.00000744	0.00007942	0.00022629	-0.00000688	0.00008698	0.00000826	-0.00010529	0.00015491	0.00017131	0.00002388	0.00001555	-0.00017165	-0.00003300	0.00007701	-0.00013789;
-0.01104877	0.00015612	0.00018011	0.00018196	0.00518434	-0.00126391	0.00002488	-0.00109963	0.00026235	0.00005072	0.00289156	-0.00245458	-0.00061471	0.00634726	0.00028877	-0.00850503	-0.00735301	0.00293447	-0.00041814	-0.00100393	0.00241446	-0.01169330	-0.00125736	0.00263041;
-0.00018994	-0.01113919	-0.00052557	0.00547783	-0.00016248	0.00027932	0.00025218	-0.00000199	-0.00013889	0.00352555	-0.00002679	0.00022260	-0.00913519	-0.00068968	0.00910025	0.00045768	-0.00033687	-0.00018495	0.00764351	-0.01001736	-0.00069600	0.00072313	-0.00025313	0.00055375;
0.00001588	-0.00001902	0.00040203	0.00000125	-0.00002530	-0.00018011	-0.00000717	0.00000822	0.00000595	-0.00000017	-0.00003534	-0.00011993	0.00000829	-0.00009230	-0.00001025	0.00014489	-0.00018861	-0.00024194	-0.00003615	-0.00001605	0.00031648	0.00009479	-0.00019777	0.00039482;
-0.00969521	0.00013423	0.00036648	-0.00002740	-0.00020900	-0.00002200	-0.00040481	0.00678374	-0.00200876	0.00007965	0.00870698	-0.00430188	-0.00054264	0.00597038	-0.00001812	-0.00125373	-0.00009153	-0.00261691	-0.00007448	0.00075777	-0.00011101	0.01411840	0.00097211	-0.00321618;
-0.00015922	-0.00967539	-0.00050373	-0.00026922	0.00000053	0.00013097	-0.00858272	-0.00049043	-0.00021383	0.00877007	-0.00011312	0.00023329	-0.00576306	-0.00044715	-0.00045771	0.00006031	0.00014212	-0.00006582	-0.00727573	0.01264514	0.00122236	-0.00088949	0.00021461	-0.00076490;
0.00000922	-0.00001730	0.00035194	-0.00000662	0.00001580	0.00003614	0.00000125	-0.00007833	-0.00029358	-0.00000807	-0.00010322	-0.00029097	0.00000659	-0.00010189	-0.00000103	0.00007037	-0.00016469	-0.00008787	0.00000161	-0.00003316	-0.00002690	-0.00011901	0.00017148	-0.00048109;
-0.00820215	0.00011483	0.00043161	-0.00021629	-0.00522027	0.00123656	-0.00053015	0.00974914	-0.00300937	-0.00004708	0.00400826	0.00035115	0.00052353	-0.00587754	-0.00029190	0.00946513	0.00692313	-0.00140132	0.00052847	-0.00009406	-0.00240334	-0.00957076	0.00008794	0.00231962;
-0.00013452	-0.00799838	-0.00045832	-0.00566300	0.00015182	-0.00001371	-0.01072934	-0.00056274	0.00008246	0.00210396	-0.00007928	-0.00024504	0.00998538	0.00072607	-0.00896391	-0.00046468	0.00015454	0.00021215	0.00168729	-0.00958671	-0.00130770	0.00063726	-0.00003551	0.00058690;
0.00000674	-0.00001536	0.00028469	-0.00000969	0.00004956	0.00022473	0.00000830	-0.00010438	-0.00035890	-0.00000883	-0.00004354	-0.00006969	-0.00001022	0.00006679	0.00001491	-0.00014605	0.00021442	0.00025748	0.00002511	0.00006809	-0.00030037	0.00008468	-0.00001826	0.00034387;
-0.00609858	0.00009951	0.00018810	-0.00034193	-0.00977976	0.00173812	-0.00018290	0.00468571	-0.00134263	-0.00015501	-0.00910173	0.00496038	0.00062995	-0.00765403	0.00029547	-0.00624113	-0.00657673	0.00713167	-0.00057166	-0.00019048	0.00235829	0.00418398	-0.00175895	-0.00127519;
-0.00008440	-0.00565061	-0.00043821	-0.01031936	0.00028600	-0.00022433	-0.00278411	-0.00012230	0.00045377	-0.01112462	0.00009954	-0.00019848	0.00412138	0.00034477	0.01034292	0.00032284	-0.00031603	-0.00004481	0.00638770	0.00702600	0.00149272	-0.00038142	-0.00025537	-0.00038160;
-0.00000106	-0.00000876	0.00019916	-0.00001554	0.00006930	0.00037782	0.00000981	-0.00003340	-0.00007478	0.00000018	0.00011264	0.00038385	-0.00000057	0.00012711	-0.00000940	-0.00001708	0.00018240	-0.00002547	-0.00001637	-0.00006083	0.00038456	-0.00003458	-0.00020814	-0.00019856;
-0.00408040	0.00007276	0.00033099	-0.00038939	-0.01106636	0.00140991	0.00032000	-0.00476845	0.00163610	-0.00002264	-0.00813328	-0.00033155	-0.00075763	0.00958695	-0.00005120	-0.00249973	0.00507019	-0.01042116	0.00047432	0.00013122	-0.00076688	-0.00172538	0.00382830	0.00122197;
-0.00005046	-0.00418615	-0.00028260	-0.01052520	0.00029303	-0.00054492	0.00517138	0.00026228	0.00007948	-0.00648987	0.00007238	0.00016970	-0.00894603	-0.00062865	-0.00235517	-0.00000879	0.00069873	0.00001157	-0.01247574	-0.00660105	-0.00154030	0.00031627	0.00039894	0.00030596;
-0.00000804	-0.00000746	0.00013677	-0.00001498	0.00007509	0.00038485	0.00000742	0.00004282	0.00022845	0.00000650	0.00009403	0.00020655	0.00001582	-0.00006203	0.00000165	0.00007702	-0.00033403	-0.00014498	-0.00000045	0.00002607	-0.00017063	0.00001866	0.00040712	0.00015387;
-0.00225078	0.00004736	0.00012752	-0.00028988	-0.00880479	0.00094116	0.00058383	-0.01069396	0.00180789	0.00013005	0.00610078	-0.00057948	-0.00013514	0.00341788	-0.00022802	0.00970073	-0.00498096	0.00793852	-0.00033249	0.00005413	-0.00108381	0.00067148	-0.00314617	-0.00077024;
-0.00002797	-0.00276822	-0.00021302	-0.00845560	0.00023769	-0.00052252	0.00967663	0.00050724	-0.00027145	0.00609831	-0.00003646	0.00010499	-0.00366478	-0.00036772	-0.00908522	-0.00020316	-0.00075914	0.00004248	0.01090008	0.00421250	0.00095374	-0.00016698	-0.00030841	-0.00012790;
-0.00001019	-0.00000194	0.00007733	-0.00000886	0.00003348	0.00028714	0.00000212	0.00008635	0.00036857	0.00000928	-0.00009659	-0.00026915	-0.00000950	-0.00004042	-0.00000108	-0.00003584	0.00000433	-0.00006776	-0.00000039	0.00002389	-0.00023826	-0.00001505	-0.00044216	-0.00010451;
-0.00087020	0.00002725	0.00011924	-0.00015295	-0.00421164	0.00055593	0.00038488	-0.00729870	0.00165699	0.00013572	0.00915653	-0.00212053	0.00061772	-0.01057943	0.00026194	-0.00890970	0.00381329	-0.00395997	0.00017955	-0.00007589	0.00097157	-0.00021641	0.00108346	0.00022340;
-0.00002112	-0.00132825	-0.00011519	-0.00462372	0.00013913	-0.00034363	0.00755868	0.00043896	-0.00016012	0.01052008	-0.00013664	-0.00031252	0.00928106	0.00071615	0.00881328	0.00015749	0.00047014	-0.00000836	-0.00533685	-0.00172789	-0.00033469	0.00005453	0.00008048	0.00004858;
-0.00000771	-0.00000010	0.00003206	-0.00000223	0.00000928	0.00014106	0.00000133	0.00004410	0.00024161	0.00000823	-0.00008453	-0.00031898	-0.00001584	0.00000159	-0.00000779	0.00003452	0.00020669	0.00028439	0.00000153	-0.00003469	0.00033427	0.00001528	0.00028183	0.00005275;];

%the eigenvec above is from floor 8 to 1 and mode 1 to 24
%for example eigenvec(9,6) is the rotation shape of floor 3 of mode 6
%the following is to transform the eigenvec to the form from floor 1 to 8
temp=eigenvec;
for i=1:1:nfloors
    eigenvec(3*(nfloors-i)+1,:)=temp(3*i-2,:);
    eigenvec(3*(nfloors-i)+2,:)=temp(3*i-1,:);
    eigenvec(3*(nfloors-i)+3,:)=temp(3*i,:);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
% Translational Masses in X, Y and rotational Directions, from floor 1 to 8
trans_massx=[2580  2247  2057  2051  2051  2051   2051   2051];                                            %kN-sec^2/m
trans_massy=trans_massx;                                                                                   %kN-sec^2/m
mass_rot=[1957503     1705017     1560994     1560994     1560994    1560994    1560994       1560994 ];   %kN-sec^2-m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
%Damping ratios in all 24 modes is 5% critical
damp_rat=0.05*ones(24,1)';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
%Height of the floors from the base
height =[0   4.42   8.84   13.26   17.68   21.34   25.00  28.66  32.32]; % m
%Mass of the base
mass_basex=3565.73;   %kN-sec^2/m
mass_baser=2706868;   %kN-sec^2-m
mass_basey=mass_basex;  %kN-sec^2/m

%Mass stiffness and damping matrices
assembled_mass=zeros(3*nfloors+3);
for  J=1:nfloors
   J1=3*J-2;
   J2=J1+1;
   J3=J1+2;
   assembled_mass(J1,J1)=trans_massx(J);
   assembled_mass(J2,J2)=trans_massy(J);
   assembled_mass(J3,J3)=mass_rot(J);
end
JK1=3*nfloors+1;
JK2=JK1+1;
JK3=JK1+2;
assembled_mass(JK1,JK1)=mass_basex;
assembled_mass(JK2,JK2)=mass_basey;
assembled_mass(JK3,JK3)=mass_baser;

assembled_stiff=zeros(retained_modes);
for J=1:retained_modes
   assembled_stiff(J,J)=eigenval(J);
end

assembled_damping=zeros(retained_modes);
for J=1:retained_modes
   assembled_damping(J,J)=2*damp_rat(J)*sqrt(eigenval(J));
end

STRUC.M = assembled_mass(1:24,1:24);
STRUC.K = (eigenvec'\assembled_stiff)/eigenvec;
STRUC.C = (eigenvec'\assembled_damping)/eigenvec;
STRUC.m = assembled_mass(25:27,25:27);

% Check
nat_freqs = sqrt(diag(eigenvec'*STRUC.K*eigenvec)./diag(eigenvec'*STRUC.M*eigenvec));
dampings = diag(eigenvec'*STRUC.C*eigenvec)./diag(eigenvec'*STRUC.M*eigenvec)/2./nat_freqs;
unit_M=eigenvec'*STRUC.M*eigenvec;

R=zeros(24,3); % R is the matrix of earthquake influence coefficients
for i=1:1:8
    R(3*i-2:3*i,:)=eye(3);
end
STRUC.R = R;

dh=zeros(1,8); %the height for each floor
for i=1:1:8
    dh(i)=height(i+1)-height(i);
end
STRUC.dh=dh;

bearing_locs	=	[...
 1.0000    1.8200  -47.7900
 2.0000   -7.3200  -47.7900
 3.0000  -17.2500  -47.7900 
 4.0000  -17.2500  -39.9300
 5.0000  -17.2500  -31.8800
 6.0000  -17.2500  -24.0500
 7.0000  -17.2500  -16.1800
 8.0000  -17.2500   -8.3500 
 9.0000  -17.2500   -0.4900
10.0000  -17.2500    7.3500
11.0000  -17.2500   15.0000
12.0000  -17.2500   22.8300
13.0000  -17.2500   30.6900 
14.0000   -7.3200   30.6900
15.0000    1.8200   30.6900
16.0000   10.2100   30.6900
17.0000   18.1700   30.6900
18.0000   25.9700   30.6900
19.0000   32.8300   30.6900 
20.0000   32.8300   23.0400
21.0000   32.8300   15.2100
22.0000   32.8300    7.3500
23.0000   32.8300   -0.4900
24.0000   32.8300  -11.1600 
25.0000   25.9700  -11.1600
26.0000   18.1700  -11.1600 
27.0000   12.5300  -16.1800
28.0000   12.5300  -24.0500
29.0000   12.5300  -31.8800
30.0000   12.5300  -39.7500
31.0000   12.5300  -47.7900 
32.0000   -7.3200   23.0400
33.0000   -7.3200   15.2100
34.0000   -7.3200    7.3500
35.0000   -7.3200   -0.4900
36.0000   -7.3200   -8.3500
37.0000   -7.3200  -16.1800
38.0000   -7.3200  -24.0500
39.0000   -7.3200  -31.8800
40.0000   -7.3200  -39.7500
41.0000    1.8200   23.0400
42.0000    1.8200   15.2100
43.0000    1.8200    7.3500
44.0000    1.8200   -0.5000
45.0000    1.8200   -8.3500 
46.0000    1.8200  -16.1800
47.0000    1.8200  -24.0500
48.0000    1.8200  -31.8800
49.0000    1.8200  -39.7500
50.0000   10.2100   23.0400
51.0000   10.2100   15.2100
52.0000   10.2100    7.3500
53.0000   10.2100   -0.4900
54.0000   18.1700   23.0400
55.0000   18.1700   15.2100
56.0000   18.1700    7.3500
57.0000   18.1700   -0.4900
58.0000   25.9700   23.0400
59.0000   25.9700   15.2100
60.0000   25.9700    7.3500
61.0000   25.9700   -0.4900
62.0000  -12.2800  -47.7900
63.0000   -2.8000  -47.7900
64.0000    7.1000  -47.7900
65.0000  -17.2500  -43.8600
66.0000  -17.2500  -36.0300
67.0000  -17.2500  -28.1600
68.0000  -17.2500  -20.3300
69.0000  -17.2500  -12.4700
70.0000  -17.2500   -4.6300
71.0000  -17.2500    3.2300
72.0000  -17.2500   11.0600
73.0000  -17.2500   18.9300
74.0000  -17.2500   26.7600
75.0000  -12.2800   30.6900
76.0000   -2.4100   30.6900
77.0000    6.0000   30.6900
78.0000   14.1700   30.6900
79.0000   22.0700   30.6900
80.0000   29.4100   30.6900
81.0000   32.8300   26.8800
82.0000   32.8300   19.1100
83.0000   32.8300   11.2800
84.0000   32.8300    3.4100
85.0000   32.8300   -5.8200
86.0000   29.3500  -11.1600
87.0000   22.0700  -11.1600
88.0000   12.5300  -11.1600
89.0000   12.5300  -20.1200
90.0000   12.5300  -27.9500
91.0000   12.5300  -35.8100
92.0000   12.5300  -43.6500
];

bearing_num=length(bearing_locs(:,1));
H=zeros(3,3);H(1,1)=bearing_num;H(2,2)=bearing_num; % H is the location matrix
for i=1:1:bearing_num
    H(1,3)=H(1,3)-bearing_locs(i,3);
    H(2,3)=H(2,3)+bearing_locs(i,2);
    H(3,3)=H(3,3)+bearing_locs(i,2)^2+bearing_locs(i,3)^2;
end
H(3,1)=H(1,3);H(3,2)=H(2,3);

STRUC.H=H;
save('STRUC','STRUC');