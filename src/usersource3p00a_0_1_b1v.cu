

__device__ __host__
int addsourceterms2_MODID(real *dw, real *wd, real *w, struct params *p, struct state *s,int *ii,int field,int dir) {

  int direction;
  int status=0;

   real xc1,xc2,xc3,r1,r2;
   real xxmax,yymax;
   real dx,dy,dz;
   real aa;
   real s_period;
   real tdep;
   real s_rad1,s_rad2;
   real delta_x, delta_z, delta_t;
   real exp_x,exp_z,exp_xyz;
   real vvv,vvz,AA;

   real n1,n2;  //mode numbers
	real qt;

   real xp,yp,zp;
   int i,j,k;

   int nx,ny,nz;
   
   ny=(p->n[1]);
   nz=(p->n[2]);
  
	  i=ii[0];
	  j=ii[1];
	  k=ii[2];

//printf("source %d %d %d\n",i,j,k);



real xc1Mm=0.5;  // !Mm        z axis
//real xc3Mm=0.5;  // !Mm        z axis
//xc1Mm=1.1;  // !Mm        z axis
//xc1Mm=1.7;  // !Mm        z axis
//real xc2Mm=1.998046;  // !0.99d0  !Mm        x axis
real xc2Mm=1.998046;  // !0.99d0  !Mm        x axis
real xc3Mm=1.998046;  // !Mm        z axis

xc1=xc1Mm*1.0e6;//  !m        z axis
xc2=xc2Mm*1.0e6;//  !m        x axis
xc3=xc3Mm*1.0e6;//  !m        x axis

yymax=4.0e6;
xxmax=4.0e6;


xp=(p->xmin[0])+(((real)i)*(p->dx[0]));
 
  
r2=(yp-xc2)*(yp-xc2);

xxmax=4.0e6;

exp_x=exp(-r2/(delta_x*delta_x));
delta_x=0.004e6;


qt=p->qt;
r1=(xp-xc1)*(xp-xc1);
delta_z=0.004e6;
n1=0;
n2=1;
AA=200.0;//*(n1+1)*(n2+1);
//AA=10000.0;//*(n1+1)*(n2+1);

//AA=0.0356825*(n1+1)*(n2+1);
//AA=2000;// ! 2 km/sec
s_period=300.0e0;
yp=(p->xmin[1])+(((real)j)*(p->dx[1]));
zp=(p->xmin[2])+(((real)k)*(p->dx[2]));

exp_z=exp(-r1/(delta_z*delta_z));
exp_xyz=sin(PI*yp*(n1+1)/xxmax)*sin(PI*zp*(n2+1)/yymax)*exp_z;
//exp_xyz=(j>1 && j<ny-2 && k>1 && k<nz-2?sin(PI*(j-2)*(n1+1)/((p->n[1])-3))*sin(PI*(k-2)*(n2+1)/((p->n[2])-3))*exp_z:0.0);



tdep=sin(qt*2.0*PI/s_period);
vvz=AA*exp_xyz*tdep;


w[fencode3_MODID(p,ii,mom1)]=w[fencode3_MODID(p,ii,mom1)]+(p->dt)*vvz*(w[fencode3_MODID(p,ii,rho)]+w[fencode3_MODID(p,ii,rhob)]);
w[fencode3_MODID(p,ii,energy)]=w[fencode3_MODID(p,ii,energy)]+(p->dt)*vvz*vvz*(w[fencode3_MODID(p,ii,rho)]+w[fencode3_MODID(p,ii,rhob)])/2.0;
//w[fencode3_MODID(p,ii,mom1)]=w[fencode3_MODID(p,ii,mom1)]+(p->dt)*vvz*w[fencode3_MODID(p,ii,rhob)];

//if(j==63 && i==32  && k==63 /*((p->it)%100 == 0)*/ )
//   printf("Driver amplitude %d %g %g %g %g %g\n",p->it,qt,vvz,w[fencode3_MODID(p,ii,mom1)]/(w[fencode3_MODID(p,ii,rho)]+w[fencode3_MODID(p,ii,rhob)]),p->dt,w[fencode3_MODID(p,ii,rho)]+w[fencode3_MODID(p,ii,rhob)]);


//if(j==63 && i>=8 && i<=32  && k==63 /*((p->it)%100 == 0)*/ )
   //printf("Driver amplitude %d %g %g %g %g %g\n",p->it,qt,vvz,w[fencode3_MODID(p,ii,mom1)]/(w[fencode3_MODID(p,ii,rho)]+w[fencode3_MODID(p,ii,rhob)]),p->dt,w[fencode3_MODID(p,ii,rho)]+w[fencode3_MODID(p,ii,rhob)]);
//	printf("Driver amplitude %d %g %g %g %g %g\n",p->it,qt,vvz,exp_xyz,p->dt,tdep);




return ( status);
}

__device__ __host__
int addsourceterms1_MODID(real *dw, real *wd, real *w, struct params *p, struct state *s,int *ii,int field,int dir) {

   

}

