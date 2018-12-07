directory='/shared/sp2rc2/Shared/simulations/smaug_realpmode/fastdata/cs1mkg/smaug/spic_5b2_2_bv50G_aka75G/';

wspacename=[directory,'matlabdat/','5b2_2_bv50G_matlab_eflux.mat'];
load(wspacename);

edrv=sum(efluxarray(1:330,11))/330;
for i=1:124
  efluxratav50G(i)=(sum(efluxarray(1:330,i))/330)/edrv;
end


directory='/shared/sp2rc2/Shared/simulations/smaug_realpmode/fastdata/cs1mkg/smaug/spic_5b2_2_bv75G_aka50G/';

wspacename=[directory,'matlabdat/','5b2_2_bv25G_matlab_eflux.mat'];
load(wspacename);

edrv=sum(efluxarray(1:330,11))/330;
for i=1:124
  efluxratav75G(i)=(sum(efluxarray(1:330,i))/330)/edrv;
end

directory='/shared/sp2rc2/Shared/simulations/smaug_realpmode/fastdata/cs1mkg/smaug/spic_5b2_2_bv100G/';

wspacename=[directory,'matlabdat/','5b2_2_bv100G_matlab_eflux.mat'];
load(wspacename);

edrv=sum(efluxarray(1:330,11))/330;
for i=1:124
  efluxratav100G(i)=(sum(efluxarray(1:330,i))/330)/edrv;
end

plot(efluxratav50G)
hold on
plot(efluxratav75G)
plot(efluxratav100G)
xlim([0 120])


set(gca,'XTickLabel',{'0.09';'0.99';'1.94';'2.88';'3.83';'4.77';'5.72';'6.67'})
% colorbar;
xlabel(gca,'Height (Mm)');
ylabel(gca,'Energy Flux Ratio');