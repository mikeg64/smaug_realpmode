from matplotlib.ticker import FixedLocator, FixedFormatter
from scipy.signal import savgol_filter
import matplotlib.pyplot as plt
import colorednoise as cn
import numpy.ma as ma
import pandas as pd
import julian as jd
import numpy as np
import datetime
import h5py


def export_peaks(X, Y_diff):

    frequency = np.linspace(X.min(), X.max(), len(X))

    m = ma.masked_where(Y_diff == -1, Y_diff)

    masked_time = np.ma.masked_array(X, m.mask).tolist()
    masked_peak = np.ma.masked_array(m, m.mask).tolist()

    sig_period = np.array([x
                           for x in masked_time
                           if x is not None and np.isfinite(x)])

    sig_peak = np.array([x
                         for x in masked_peak
                         if x is not None and np.isfinite(x)])

    slice_t = []
    slice_p = []

    #print(frequency)
    #for i in range(1, 31):
    for i in frequency:
        if i in sig_period:
            inx = np.where(sig_period == i)

            if np.shape(inx)[1] > 1:
                slice_t.append(sig_period[inx].mean())
                slice_p.append(sig_peak[inx].mean())

            else:
                slice_t.append(sig_period[inx][0])
                slice_p.append(sig_peak[inx][0])

        else:
            slice_t.append(np.nan)
            slice_p.append(np.nan)

    slice_t = np.array(slice_t)

    return slice_t, slice_p


def fft_power(title, data, Yhann, noise, noise_orig, X, N):

    Y = 2.0 * np.abs(Yhann[:N]) / N
    Y = Y[5:-5]
    X = X[5:-5]
    noise = noise[5:-5]

    plt.figure(figsize=(6, 5))

    ax = plt.subplot(2, 1, 1)
    #ax.set_title(title[0])
    ax.plot(time, data, c='k')
    #ax.plot(time, noise_orig)
    plt.xlabel('Time (min)')
    plt.ylabel('Z-Score')

    X = (X / 60)
    bx = plt.subplot(2, 1, 2)
    plt.ylabel('FFT')
    plt.xlabel('Frequency [Hz]')
    bx.plot(X, Y, c='k')
    bx.plot(X, noise, color='k', linestyle='--')
    #x_lab = [(round(1 / x, 2) if x else '') for x in bx.get_xticks().tolist()]
    #bx.set_xticklabels(x_lab)
    #bx.set_xlim([0, 0.05])

    plt.tight_layout()
    plt.savefig('fft_2010/' + title[1] + '.pdf')




def noise_gen(data):
    noise = []
    noise_orig = []
    for i in range(100000):
        n = cn.powerlaw_psd_gaussian(-1, len(data))
        hann = np.hanning(len(data))
        Y = np.fft.fft(hann * n)
        N = int(len(Y) / 2 + 1)
        Y = 2.0 * np.abs(Y[:N]) / N

        yhat = Y
        noise.append(yhat)
        noise_orig.append(n)

    noise = np.array(noise)

    return [noise_orig[0],
            np.mean(noise, axis=0) + (5 * np.std(noise, axis=0))]


def fft_analysis(data, time, title):

    # Real DATA
    data = (data - data.mean()) / data.std()  # Normalized dataset
    data[data > 3] = 3
    data[data < -3] = -3
    noise_orig, noise = noise_gen(data)



    hann = np.hanning(len(data))

    #Yhann = np.fft.fft(hann * data)
    Yhann = np.fft.fft(data)

    N = int(len(Yhann) / 2 + 1)

    X = np.linspace(0, 1 / 2, N, endpoint=True)

    fft_power(title, data, Yhann, noise, noise_orig, X, N)


def time_homogenisation(data, timejd):

    data = np.diff(data)
    timejd = timejd[:-1]

    time = []
    data = np.array(data)

    for i in range(len(timejd)):

        time.append(jd.from_jd(timejd[i], fmt='jd'))

        t_now = datetime.timedelta(microseconds=time[-1].microsecond)

        time[-1] = time[-1] - t_now

    index = pd.DatetimeIndex(time)
    data = pd.Series(data, index=index)

    #data = data.resample('60S', how='mean')
    data = data.resample('60S')
    
    data=data.mean()
    print(data)
    #data = data.as_matrix()

    time = np.arange(len(data))

    return data, time


def plot_matrix(t_matrix, p_matrix, labelarray, wavelength, size_title):



    fig = plt.figure(1000, figsize=(6, 5))
    ax = plt.subplot(3, 1, 1)
    fig.subplots_adjust(wspace=0, hspace=0)
    fig.suptitle('AIA' + wavelength)

    ax.matshow(p_matrix[:3], cmap=plt.cm.Blues)
    ax.set_title(size_title[0])
    ax.set_yticks(np.arange((3)))
    ax.yaxis.set_major_formatter(FixedFormatter(labelarray[:3]))

    bx = plt.subplot(3, 1, 2)

    bx.matshow(p_matrix[3:6], cmap=plt.cm.Blues)
    bx.set_title(size_title[1])
    bx.set_yticks(np.arange((3)))
    bx.yaxis.set_major_formatter(FixedFormatter(labelarray[3:6]))

    cx = plt.subplot(3, 1, 3)

    cx.matshow(p_matrix[6:], cmap=plt.cm.Blues)
    cx.set_title(size_title[2])
    cx.set_yticks(np.arange((3)))
    cx.yaxis.set_major_formatter(FixedFormatter(labelarray[6:]))

    fig.tight_layout()
    plt.savefig('fft_2010/' + wavelength + '.pdf')
    #plt.show()


hf = h5py.File('../2010-08-22.h5', 'r')


#regions = ['/AR', '/QS']
regions = ['/region1', '/region2']
sizes = ['/50px']
idl = ['AR','QS']


wavelengths = ['1600']

'''
2010-08-22
region1 = AR
region2 = QS
region3 = CH

2013-06-19
region1 = QS
region2 = AR
region3 = CH
'''

for size in sizes:
    for i, region in enumerate(regions):

        new = True

        for wavelength in wavelengths:

            print(wavelength)

            timejd = np.array(hf.get(wavelength + region + '/JD'), dtype=float)
            data = np.array(hf.get(wavelength + region + size))

            if size != '/point':
                data_mean = []
                for j in range(len(timejd)):

                    matrix = np.matrix(data[:, :, j])
                    data_mean.append(matrix.mean())
                data = np.array(data_mean)

            data, time = time_homogenisation(data, timejd)

            title = 'Wavelength: ' + wavelength +\
                    ' / Region: ' + idl[i] + ' / Size: ' + size[1:]

            fname = idl[i] + '/' + size[1:] + '/' + 'AIA' + wavelength +\
                '_' + idl[i] + '_' + size[1:]

            fft_analysis(data, time, [title, fname])

            '''
            if new:

                new = False
                t_matrix = t
                p_matrix = p

            else:

                t_matrix = np.vstack([t_matrix, t])
                p_matrix = np.vstack([p_matrix, p])

            '''
        #plot_matrix(t_matrix, p_matrix)
