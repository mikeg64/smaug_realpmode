

directory='/shared/sp2rc2/Shared/simulations/smaug_realpmode/fastdata/cs1mkg/smaug/spic_5b2_2_bv100G/';
extension='.out';
%bdir='/shared/sp2rc2/Shared/simulations/smaug_realpmode/fastdata/cs1mkg/smaug/';
%rdirectory='spic_5b2_2_bv100G';

bdir='/Users/mikegriffiths/proj';
rdirectory='/smaug-realpmode-data';

%directory=[bdir,rdirectory,'/matlabdat/'];
directory=[bdir,rdirectory,'/'];



%matfile=[directory,'vvzverustime.mat'];
matfile=[directory,'pvvt.mat'];

%load(matfile);

evelv=evel2Mm;
sz=size(evelv);
nt=sz(3);

ss1=reshape(evelv(62,:,:),[124,nt]);
s1=surf(ss1(1:45,1:700));  %low and mid chromosphere
s1.EdgeColor = 'none';

zlimv=3*[-1 1];


xlimv=[0 700]; %time limit
ylimv=[0 45];

hc=colorbar();
caxis(zlimv);

%yticks={'0';'0.6667';'1.333';'2.0';'2.667';'3.333';'4.0'};
yticks=cell(11,1);
for i=1:11
   yticks{i,1} = sprintf('%.2f',0.0625+5*(i-1)*0.03125);
end
%yticks={sprintf('%.6f',a), sprintf('%.6f',a), sprintf('%.6f',a), sprintf('%.6f',a)}

%set(hc,'Zlim',zlimv);
set(gca,'Xlim',xlimv,'Ylim',ylimv);

set(gca,'YTickLabel',yticks)


%colorbar;
xlabel(gca,'Time (seconds)');
ylabel(gca,'Height (Mm)');
%xlabel(gca,'Distance (Mm)');



view(2);