import matplotlib.pyplot as plt
from matplotlib import patches
import astropy.units as u
from astropy.coordinates import SkyCoord

import sunpy.map

#Coordinates of the bozes

P1a = [200, -550]
P1q = [-200, -150]
P1c = [-150, 300]


length_x = 800 * 0.6 * u.arcsec
length_y = 500 * 0.6 * u.arcsec
x0 = 0 * u.arcsec
y0 = -500 * u.arcsec

smap_list = sunpy.map.Map('/Users/norbertgyenge/Research/AOSC/data/figure1/')
smap_list = [smap_list[i] for i in [0, 2, 7, 6, 4, 3, 5, 8, 1]]

smap_list = smap_list[2:3]

label = ['A) T = 5000K ',
		 'B) T = 0.05 MK ',
		 'C) T = 0.1 MK ',
		 'D) T = 0.6 MK ',
		 'E) T = 1.6 MK ',
		 'F) T = 2.0 MK ',
		 'G) T = 2.5 MK ',
		 'H) T = 6.4 MK ',
		 'I) T = 10 MK ']

fig = plt.figure(figsize=(6, 4))

for i, smap in enumerate(smap_list, start=1):

	ax1 = fig.add_subplot(1,1,1)


	lab = label[i-1] + '\nAIA ' + str(smap.wavelength).split()[0] + '\n' + str(smap.date).split('.')[0]
	ax1.annotate(lab, xy=(0.025, 0.025), xycoords='axes fraction', color='white')

	#if i == 1:
		#ax1.annotate('P1a', xy=(P1a[0], P1a[1]+125/2), color='white', horizontalalignment='right', verticalalignment='center')
		#ax1.annotate('P1q', xy=(P1q[0], P1q[1]+125/2), color='white', horizontalalignment='right', verticalalignment='center')
		#ax1.annotate('P1c', xy=(P1c[0], P1c[1]+125/2), color='white', horizontalalignment='right', verticalalignment='center')

	ax1.xaxis.set_ticks([-400, -200, 0, 200, 400])
	ax1.yaxis.set_ticks([800, -600, -400, -200, 0, 200, 400, 600, 800])

	bottom_left = SkyCoord(x0 - length_x, y0 - length_y, frame=smap.coordinate_frame)
	top_right = SkyCoord(x0 + length_x, y0 + length_y,  frame=smap.coordinate_frame)

	sub = smap.submap(bottom_left, top_right)

	x1 = SkyCoord(P1a[0] * u.arcsec, P1a[1] * u.arcsec, frame=smap.coordinate_frame)
	#x2 = SkyCoord(P1q[0] * u.arcsec, P1q[1] * u.arcsec, frame=smap.coordinate_frame)
	#x3 = SkyCoord(P1c[0] * u.arcsec, P1c[1] * u.arcsec, frame=smap.coordinate_frame)

	#sub.draw_rectangle(x1, 125 * u.arcsec, 125 * u.arcsec)
	sub.draw_rectangle(x1, 20 * u.arcsec, 20 * u.arcsec, color='r')

	#sub.draw_rectangle(x2, 125 * u.arcsec, 125 * u.arcsec)
	#sub.draw_rectangle(x2, 25 * u.arcsec, 25 * u.arcsec)

	#sub.draw_rectangle(x3, 125 * u.arcsec, 125 * u.arcsec)
	#sub.draw_rectangle(x3, 25 * u.arcsec, 25 * u.arcsec)

	sub.plot(title=False)

plt.tight_layout()
#plt.show()
plt.savefig('obs_data.pdf')