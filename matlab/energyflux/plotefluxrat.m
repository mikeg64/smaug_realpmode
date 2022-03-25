dir = '';


bdir='/Users/mikegriffiths/proj';
rdirectory='/smaug-realpmode-data';

%directory=[bdir,rdirectory,'/matlabdat/'];
directory=[bdir,rdirectory,'/'];



%directory='/shared/sp2rc2/Shared/simulations/smaug_realpmode/fastdata/cs1mkg/smaug/spic_5b2_2_bv50G_aka75G/';

%wspacename=[directory,'matlabdat/','5b2_2_bv50G_matlab_eflux.mat'];
wspacename=[directory,'0g/','5b2_2_matlab_eflux.mat'];
load(wspacename);

edrv=sum(efluxarray(1:330,11))/330;
for i=1:124
  efluxratav0G(i)=(sum(efluxarray(1:330,i))/330)/edrv;
end


%directory='/shared/sp2rc2/Shared/simulations/smaug_realpmode/fastdata/cs1mkg/smaug/spic_5b2_2_bv75G_aka50G/';
directory=[bdir,rdirectory,'/'];
%wspacename=[directory,'matlabdat/','5b2_2_bv25G_matlab_eflux.mat'];
wspacename=[directory,'50g/','5b2_2_bv50G_matlab_eflux.mat'];
load(wspacename);

edrv=sum(efluxarray(1:330,11))/330;
for i=1:124
  efluxratav50G(i)=(sum(efluxarray(1:330,i))/330)/edrv;
end

%directory='/shared/sp2rc2/Shared/simulations/smaug_realpmode/fastdata/cs1mkg/smaug/spic_5b2_2_bv100G/';
%wspacename=[directory,'matlabdat/','5b2_2_bv100G_matlab_eflux.mat'];
directory=[bdir,rdirectory,'/'];
wspacename=[directory,'75g/','5b2_2_bv75G_matlab_eflux.mat'];
load(wspacename);

edrv=sum(efluxarray(1:330,11))/330;
for i=1:124
  efluxratav75G(i)=(sum(efluxarray(1:330,i))/330)/edrv;
end

%directory='/shared/sp2rc2/Shared/simulations/smaug_realpmode/fastdata/cs1mkg/smaug/spic_5b2_2_bv100G/';
%wspacename=[directory,'matlabdat/','5b2_2_bv100G_matlab_eflux.mat'];
directory=[bdir,rdirectory,'/'];
wspacename=[directory,'100g/','5b2_2_bv100G_matlab_eflux.mat'];
load(wspacename);

edrv=sum(efluxarray(1:330,11))/330;
for i=1:124
  efluxratav100G(i)=(sum(efluxarray(1:330,i))/330)/edrv;
end




plot(efluxratav0G)
hold on
plot(efluxratav50G)
plot(efluxratav75G)
plot(efluxratav100G)
xlim([0 120])


set(gca,'XTickLabel',{'0.09';'0.99';'1.94';'2.88';'3.83';'4.77';'5.72';'6.67'})
% colorbar;
xlabel(gca,'Height (Mm)');
ylabel(gca,'Energy Flux Ratio');



%display energy flux ratios at 1,2,4,5.5Mm
sects=[ 21 43 85 117];
efluxratav0G(sects)
efluxratav50G(sects)
efluxratav75G(sects)
efluxratav100G(sects)