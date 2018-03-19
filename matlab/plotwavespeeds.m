%
%save('speeds_25G.mat','cs','calf','cslow','cfast','xx','nrange')
cw=cslow;


newxx=(xx(nrange,nrange,nrange));
heights=reshape(newxx(:,63,63),[1,124]);
figure
plot(heights/1e6,reshape(cw(63,63,:)/1000,[1,124]),'r')
hold on

plot(heights/1e6,reshape(cw(31,63,:)/1000,[1,124]),'g')

plot(heights/1e6,reshape(cw(15,63,:)/1000,[1,124]),'b')

xlabel('Height (Mm)')
ylabel('Speed (km/s)')