%plotbfield

%use following script to load data set
%plotsecs_isocontour_2d_array

figure
hold on

     wd(6,:,:,:)=10000*sqrt(rmu).* wd(6,:,:,:);
     wd(7,:,:,:)=10000*sqrt(rmu).* wd(7,:,:,:);
     wd(8,:,:,:)=10000*sqrt(rmu).* wd(8,:,:,:);

     wd(11,:,:,:)=10000*sqrt(rmu).* wd(11,:,:,:);
     wd(12,:,:,:)=10000*sqrt(rmu).* wd(12,:,:,:);
     wd(13,:,:,:)=10000*sqrt(rmu).* wd(13,:,:,:);




 val3=reshape(wd(6,nrange,nrange,nrange)+wd(11,nrange,nrange,nrange),124,124,124); 
 val2=reshape(wd(7,nrange,nrange,nrange)+wd(12,nrange,nrange,nrange),124,124,124); 
 val1=reshape(wd(8,nrange,nrange,nrange)+wd(13,nrange,nrange,nrange),124,124,124);

%    val3=reshape(wd(6,nrange,nrange,nrange),124,124,124); 
%    val2=reshape(wd(7,nrange,nrange,nrange),124,124,124); 
%    val1=reshape(wd(8,nrange,nrange,nrange),124,124,124);


    
    
val4=sqrt(val1.^2 + val3.^2+val2.^2);
mytval=shiftdim(val4,1);


%hcs=contour((reshape(mytval(:,:,64),[124 124]))',[10 20 30 40 48
%50],'ShowText','on');  %for 50G

%hcs=contour((reshape(mytval(:,:,64),[124 124]))',[15 30 45 60 70 75],'ShowText','on');  %for 75G AKA 25G


[C,hcs]=contour((reshape(mytval(:,:,64),[124 124]))',[20 40 60 80 95 100],'ShowText','on');  %for 75G AKA 25G


lab=20:20:120;

dlab=4/128;
lab=dlab*lab;

set(gca,'XTickLabel',{'0.63';'1.25';'1.88';'2.50';'3.13';'3.75'})
set(gca,'YTickLabel',{'0.63';'1.25';'1.88';'2.50';'3.13';'3.75'})
%  set(gca,'YTickLabel',{'0.09';'0.99';'1.94';'2.88';'3.83';'4.77';'5.72'})
xlabel('Distance (Mm)')
ylabel('Distance (Mm)')

clabel(C,hcs,'FontSize',14,'Color','k','FontName','Courier')




