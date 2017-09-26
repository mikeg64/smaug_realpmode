
# coding: utf-8

# In[85]:

import numpy as np
from numpy import *
import scipy.io
from scipy import special
import matplotlib
import matplotlib.pyplot as plt
import struct


from mpl_toolkits.mplot3d import Axes3D
from matplotlib import cm
from matplotlib.ticker import LinearLocator, FormatStrFormatter


get_ipython().magic('matplotlib inline')


# In[86]:

#file = open('/fastdata/cs1mkg/smaug/spic5b2_2_tube1/zerospic1__761000.out','rb')
file = open('/fastdata/cs1mkg/smaug/spic_5b2_2_bv50G/zerospic1__177000.out','rb')
#file = open('/fastdata/cs1mkg/smaug/spic_5b2_2_bv20G/zerospic1__469000.out','rb')




# In[97]:


R=8.3e+003
mu=1.257E-6
mu_gas=0.6
gamma=1.66667





# In[ ]:

#;****************** Pressure background begin ********************
#TP=saeb
#TP=TP-(sabx_t^2.0+saby_t^2.0+sabz_t^2.0)/2.0
#TP=(gamma-1.d0)*TP
#;****************** Pressure background end ********************
#T=mu_gas*TP/R/sarho_t


# In[87]:

file.seek(0,2)
eof = file.tell()
file.seek(0,0)

name = file.read(79)

nit = fromfile(file,dtype=int32,count=1)

t = fromfile(file,dtype=float64,count=1)
ndim=fromfile(file,dtype=int32,count=1)
neqpar=fromfile(file,dtype=int32,count=1)
nw=fromfile(file,dtype=int32,count=1)

ndata = fromfile(file,dtype=int32,count=ndim)[:ndim]

varbuf = fromfile(file,dtype=float,count=7)[:7]

#if ndim=2
varnames = file.read(79)

#if ndim=3
 
 
 
 
 
 #typedef enum vars {rho, mom1, mom2, mom3, energy, b1, b2, b3,energyb,rhob,b1b,b2b,b3b} CEV;

if ndim==3:
    alldat=fromfile(file,dtype=float,count=(nw+ndim)*ndata[0]*ndata[1]*ndata[2])[:(nw+ndim)*ndata[0]*ndata[1]*ndata[2]]
    #if size(alldat)<(nw+ndim)*ndata[0]*ndata[1]*ndata[2]:
    #    alldat=resize(alldat,(nw+ndim)*ndata[0]*ndata[1]*ndata[2])
    alldat=np.reshape(alldat,(nw+ndim,ndata[0],ndata[1],ndata[2],),'C')  # should be 'C' 'F' or 'A' order

file.close()


# In[88]:

print 'varnames:',varnames
print 'nit:',nit
print 'name:',name
print 't:',t
print 'ndim:',ndim
print 'neqpar:',neqpar
print 'nw:',nw
print 'varbuf:',varbuf


# In[89]:

print size(alldat)
print shape(alldat)


# In[98]:

x=alldat[0,:,:,:]
y=alldat[1,:,:,:]
z=alldat[2,:,:,:]

#Bx=alldat[13,:,:,:]+alldat[5,:,:,:]
#By=alldat[14,:,:,:]+alldat[6,:,:,:]
#Bz=alldat[15,:,:,:]+alldat[7,:,:,:]

Bx=alldat[8,:,:,:]*sqrt(mu)*1.0e4
By=alldat[9,:,:,:]*sqrt(mu)*1.0e4
Bz=alldat[10,:,:,:]*sqrt(mu)*1.0e4




dens=alldat[0,:,:,:]


# In[103]:


X=alldat[0,64,:,:]/1.0e6
Y=alldat[1,64,:,:]/1.0e6
vx=alldat[4,64,:,:]/(alldat[3,64,:,:]+alldat[12,64,:,:])
#vx=alldat[4,64,:,:]
#dens=(alldat[3,64,:,:]+alldat[12,64,:,:])
bx=alldat[8,64,:,:]*sqrt(mu)*1.0e4






# In[104]:

print size(bx)
print shape(bx)
print bx[:,:]


# In[105]:

fig = plt.figure()
ax = fig.gca(projection='3d')




#bsq=alldat[6,:,:]*alldat[6,:,:]+alldat[7,:,:]*alldat[7,:,:]
#bmag=sqrt(bsq)

surf = ax.plot_surface(X, Y, vx, rstride=1, cstride=1, cmap=cm.coolwarm,
                       linewidth=0, antialiased=False)
#ax.set_zlim(-1.01, 1.01)

#ax.zaxis.set_major_locator(LinearLocator(10))
#ax.zaxis.set_major_formatter(FormatStrFormatter('%.02f'))
ax.view_init(elev=90,azim=0) 
fig.colorbar(surf, shrink=0.5, aspect=5)

plt.show()


# In[106]:

figb = plt.figure()
axb = figb.gca(projection='3d')




#bsq=alldat[6,:,:]*alldat[6,:,:]+alldat[7,:,:]*alldat[7,:,:]
#bmag=sqrt(bsq)

surfb = axb.plot_surface(X, Y, bx, rstride=1, cstride=1, cmap=cm.coolwarm,
                       linewidth=0, antialiased=False)
#ax.set_zlim(-1.01, 1.01)

#ax.zaxis.set_major_locator(LinearLocator(10))
#ax.zaxis.set_major_formatter(FormatStrFormatter('%.02f'))
axb.view_init(elev=90,azim=0) 
figb.colorbar(surfb, shrink=0.5, aspect=5)

plt.show()

