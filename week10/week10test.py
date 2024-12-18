#!/usr/bin/env python

import numpy
import scipy
import matplotlib.pyplot as plt
import imageio
import plotly
import plotly.express as px

na = numpy.newaxis

genes = ['APEX1', 'PIM2', 'POLR2B', 'SRSF1']
images = {}
for gene in genes: 
    images[gene]= [] 
    for field in range(2):
# Load image into numpy array
# img = imageio.v3.imread("APEX1_field0_DAPI.tif")
# img = img.astype(numpy.float32) - numpy.amin(img)
# img /= numpy.amax(img)

# img1 = imageio.v3.imread("APEX1_field0_PCNA.tif")
# img1 = img1.astype(numpy.float32) - numpy.amin(img1)
# img1 /= numpy.amax(img1)

# img2 = imageio.v3.imread("APEX1_field0_nascentRNA.tif")
# img2 = img2.astype(numpy.float32) - numpy.amin(img2)
# img2 /= numpy.amax(img2)

        images[gene].append(numpy.zeros((520, 616, 3), numpy.uint16)) #I changed the dimensions because it gave me an error message, with these specific dimensions
        for i, name in enumerate(['DAPI', 'PCNA', 'nascentRNA']):
            images[gene][field][:, :, i] = imageio.v3.imread(f"{gene}_field{field}_{name}.tif")

        plt.imshow(images[gene][field])
        plt.show()

# rgbimg = rgbimg.astype(numpy.float32)
# for i in range(3):
#     rgbimg[:, :, i] -= numpy.amin(rgbimg[:, :, i])
#     rgbimg[:, :, i] /= numpy.amax(rgbimg[:, :, i])
# print(numpy.amax(rgbimg.reshape(-1, 3), axis=0))
# rgbimg = (numpy.minimum(255, numpy.floor(rgbimg * 256))).astype(numpy.uint8)
# plt.imshow(rgbimg)
# plt.show()

# numpy.mean(img)
