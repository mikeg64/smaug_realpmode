


int ngi=2;
int ngj=2;
int ngk=2;

//Domain definition
// Define the x domain
//#ifdef USE_SAC
//vac ozt
int ni;
//ni=240;

ni=124;
//ni=252;
//ni=124;    //OZT tests
ni=ni+2*ngi;
//ni=512;
//real xmax = 6.2831853;  
//real xmax=5955555.6e0;
//real xmin=133333.33;
//real xmax=6.00251e6;
real xmax=5955555.6e0;
//real xmax=3.98638e6;

//real xmin=39426.5;
real xmin=133333.33;
real dx = (xmax-xmin)/(ni-2*ngi);
//#endif



// Define the y domain
//#ifdef USE_SAC
//vac ozt
int nj = 124;  //OZT tests
//int nj=2;  //BW test
nj=nj+2*ngj;
//nj=512;
//real ymax = 6.2831853; 
//real ymax = 4.0e6;
//real ymin=1953.10;
real ymax = 4.0e6;
real ymin=1953.1;

real dy = (ymax-ymin)/(nj-2*ngj);    
//nj=41;
//#endif



#ifdef USE_SAC_3D

int nk;
nk=124;    //BW tests

nk=nk+2*ngk;
//real zmax=4.0e6;
//real zmin=1953.1;
real zmax = 4.0e6;
real zmin=1953.1;

//real dx = xmax/(ni-4);
real dz = (zmax-zmin)/(nk-2*ngk);
#endif  



real cmax[NDIM];
real courantmax;                
char configfile[300];
int nt;

struct params *d_p;
struct params *p=(struct params *)malloc(sizeof(struct params));

struct state *d_state;
struct state *state=(struct state *)malloc(sizeof(struct state));


  
real *x=(real *)calloc(ni,sizeof(real));
//for(i=0;i<ni;i++)
//		x[i]=i*dx;

//real *y=(real *)calloc(nj,sizeof(real));
//for(i=0;i<nj;i++)
//		y[i]=i*dy;


//real *z=(real *)calloc(nk,sizeof(real));
//for(i=0;i<nk;i++)
//		z[i]=i*dz;





for(i=0;i<ni;i++)
		x[i]=(xmin-ngi*dx)+i*dx;

real *y=(real *)calloc(nj,sizeof(real));
for(i=0;i<nj;i++)
		y[i]=(ymin-ngj*dy)+i*dy;


real *z=(real *)calloc(nk,sizeof(real));
for(i=0;i<nk;i++)
		z[i]=(zmin-ngk*dz)+i*dz;




int step=0;
//real tmax = 200;
real tmax = 0.2;
int steeringenabled=1;
int finishsteering=0;

//char *cfgfile="zero1.ini";

//char *cfgfile="zero1_np020203.ini";
//char *cfgfile="zero1_np0201.ini";
//char *cfgfile="2D_bhoriz120_2048_1024_asc.ini";
//char *cfgfile="/fastdata/cs1mkg/smaug/em6b4_bhor120/zerospic1_asc_84000.ini";
//char *cfgfile="/shared/sp2rc2/Shared/configs/3D_128_spic_asc.ini";
//char *cfgfile="/shared/sp2rc2/Shared/configs/3D_128_4Mm_asc.ini";
//char *cfgfile="/data/cs1mkg/smaug_realpmode/configs/magvert/3D_128_spic_bvert20G_asc.ini";
char *cfgfile="/fastdata/cs1mkg/smaug/spic_5b2_2_bv20G/zerospic1_asc_711000.ini";





//char *cfgfile="configs/pmode_256_256_128_4Mm_asc.ini";
//char *cfgfile="/fastdata/cs1mkg/smaug/spic256_5b2_2/zerospic1_asc_1953000.ini";

//char *cfgfile="/fastdata/cs1mkg/smaug/spic5b2_2/zerospic1_asc_573000.ini";
//char *cfgfile="/fastdata/cs1mkg/smaug/spic5b0_3d/zerospic1_asc_402000.ini";
//char *cfgfile="/fastdata/cs1mkg/smaug/spic5b0_3d/zerospic1_asc_79000.ini";

//char *cfgfile="/fastdata/cs1mkg/smaug/spicule5b0_3d/zerospic1_asc_489000.ini";
//char *cfgfile="/data/cs1mkg/smaug_spicule1/spicule5b0_3d/zerospic1_asc_489000.ini";
//char *cfgfile="2D_spicule1_2048_1024_test_asc.ini";
//char *cfgfile="2D_spiculemuraw1_nohydros_nobg_tube_2048_1024_asc.o";
//char *cfgfile="2D_spiculemuraw1_nohydros_tube_2048_1024_asc.out";
//char *cfgfile="2D_spiculemuraw1_tube_2048_1024_asc.out";
//char *cfgfile="2D_spiculemuraw1_tube_2048_1024_asc.out";
//char *cfgfile="2D_spiculemuraw2_tube_2048_1024_asc.out";
//char *cfgfile="zero1_BW_bin.ini";
//char *cfgout="zero1_np010203."
//char *cfgout="/fastdata/cs1mkg/smaug/spicule_nob1/zerospic1";
//char *cfgout="/fastdata/cs1mkg/smaug/spicule_nosource_nohydros/zerospic1";
//char *cfgout="/fastdata/cs1mkg/smaug/spicule_nohydros/zerospic1";
//char *cfgout="/fastdata/cs1mkg/smaug/spicule2/zerospic1";
//char *cfgout="/fastdata/cs1mkg/smaug/spicule3/zerospic1";
//char *cfgout="/fastdata/cs1mkg/smaug/spicule4_nob/zerospic1";
//char *cfgout="/fastdata/cs1mkg/smaug/spicule7_nob/zerospic1";
//char *cfgout="/data/cs1mkg/smaug_spicule1/out/spicule5b4/zerospic1_";
//char *cfgout="/data/cs1mkg/smaug_spicule1/spicule5b0_3d/zerospic1_";
//char *cfgout="/fastdata/cs1mkg/smaug/spic5b2_2/zerospic1_";
char *cfgout="/fastdata/cs1mkg/smaug/spic_5b2_2_bv20G/zerospic1_";
//char *cfgout="/data/cs1mkg/smaug_spicule1/spicule5b0_3d/zerospic1_";
//char *cfgout="/fastdata/cs1mkg/smaug/em6b4_bhor120/zerospic1_";

//char *cfgout="zero1_np0201.out";


//dt=0.0018;  //OZT test
dt=0.001;



//nt=3000;
//nt=5000;
//nt=200000;
//nt=150000;
//nt=540001;
//nt=4800001;
nt=4000002;
//nt=100;


real *t=(real *)calloc(nt,sizeof(real));
printf("runsim 1%d \n",nt);
//t = [0:dt:tdomain];
for(i=0;i<nt;i++)
		t[i]=i*dt;

//real courant = wavespeed*dt/dx;

p->n[0]=ni;
p->n[1]=nj;
p->n[2]=nk;
p->ng[0]=ngi;
p->ng[1]=ngj;
p->ng[2]=ngk;




p->dt=dt;
p->dx[0]=dx;
p->dx[1]=dy;
p->dx[2]=dz;

//p->qt=0.0;
//p->it=0;

p->qt=711.0;
p->it=711001;





//ozt test
p->gamma=1.66666667;  //OZ test
//p->gamma=2.0;  //BW test
//p->gamma=5.0/3.0;  //BACH3D
//alfven test
//p->gamma=1.4;



p->mu=1.0;
p->eta=0.0;
p->g[0]=-274.0;
//p->g[0]=0.0;
p->g[1]=0.0;
p->g[2]=0.0;



#ifdef USE_SAC_3D

#endif
//p->cmax=1.0;
p->cmax=0.02;

p->rkon=0.0;
p->sodifon=1.0;
p->courant=0.1;
p->moddton=0.0;
p->divbon=0.0;
p->divbfix=0.0;
p->hyperdifmom=1.0;
p->readini=1.0;
p->cfgsavefrequency=1000;
//p->cfgsavefrequency=100;

p->xmax[0]=xmax+ngi*dx;
p->xmax[1]=ymax+ngj*dy;
p->xmax[2]=zmax+ngk*dz;
p->xmin[0]=xmin-ngi*dx;
p->xmin[1]=ymin-ngj*dy;
p->xmin[2]=zmin-ngk*dz;
p->nt=nt;
p->tmax=tmax;
p->steeringenabled=steeringenabled;
p->finishsteering=finishsteering;

p->maxviscoef=0;
//p->chyp=0.0;       
//p->chyp=0.00000;
p->chyp3=0.00000;


for(i=0;i<NVAR;i++)
  p->chyp[i]=0.0;

p->chyp[rho]=0.02;
p->chyp[energy]=0.02;
p->chyp[b1]=0.02;
p->chyp[b2]=0.02;
p->chyp[b3]=0.02;
p->chyp[mom1]=0.4;
p->chyp[mom2]=0.4;
p->chyp[mom3]=0.4;
p->chyp[rho]=0.02;

p->chyp[rho]=0.7;
p->chyp[energy]=0.7;
p->chyp[b1]=0.7;
p->chyp[b2]=0.7;
p->chyp[b3]=0.7;
p->chyp[mom1]=0.7;
p->chyp[mom2]=0.7;
p->chyp[mom3]=0.7;
p->chyp[rho]=0.7;



#ifdef USE_MPI
//number of procs in each dim mpi only
p->pnpe[0]=2;
p->pnpe[1]=2;
p->pnpe[2]=1;
#endif


iome elist;
meta meta;

//set boundary types
for(int ii=0;ii<NVAR; ii++)
for(int idir=0; idir<NDIM; idir++)
for(int ibound=0; ibound<2; ibound++)
{
   (p->boundtype[ii][idir][ibound])=4;  //period=0 mpi=1 mpiperiod=2  cont=3 contcd4=4 fixed=5 symm=6 asymm=7
}

//set boundary types
for(int ii=0;ii<NVAR; ii++)
for(int ibound=0; ibound<2; ibound++)
{
   (p->boundtype[ii][0][ibound])=4;  //period=0 mpi=1 mpiperiod=2  cont=3 contcd4=4 fixed=5 symm=6 asymm=7
}




elist.server=(char *)calloc(500,sizeof(char));


meta.directory=(char *)calloc(500,sizeof(char));
meta.author=(char *)calloc(500,sizeof(char));
meta.sdate=(char *)calloc(500,sizeof(char));
meta.platform=(char *)calloc(500,sizeof(char));
meta.desc=(char *)calloc(500,sizeof(char));
meta.name=(char *)calloc(500,sizeof(char));
meta.ini_file=(char *)calloc(500,sizeof(char));
meta.log_file=(char *)calloc(500,sizeof(char));
meta.out_file=(char *)calloc(500,sizeof(char));

strcpy(meta.directory,"out");
strcpy(meta.author,"MikeG");
strcpy(meta.sdate,"Nov 2009");
strcpy(meta.platform,"swat");
strcpy(meta.desc,"A simple test of SAAS");
strcpy(meta.name,"test1");
strcpy(meta.ini_file,"test1.ini");
strcpy(meta.log_file,"test1.log");
strcpy(meta.out_file,"test1.out");
strcpy(elist.server,"localhost1");

elist.port=80801;
elist.id=0;


