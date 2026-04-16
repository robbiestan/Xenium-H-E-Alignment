# Xenium–H&E Image Alignment (MATLAB)

## Overview

This repository provides MATLAB scripts for aligning post-Xenium H&E-stained whole slide images to Xenium spatial transcriptomics data. The workflow computes a transformation between the hematoxylin signal from H&E images and the DAPI channel from Xenium, then applies this transformation to generate an H&E image in Xenium coordinate space.

This enables direct spatial comparison between histology and molecular data.

---

## Experimental Context

Following a Xenium Analyzer (10x Genomics) imaging run:

* Xenium slides were immersed in Quencher removal solution
* A modified H&E staining protocol was applied (see 10x Genomics protocol)
* Slides were scanned using a Pannoramic scanner (3DHistech) with a 20× / 0.8 NA objective
* A hematoxylin channel was extracted via color deconvolution from the H&E whole slide image

Alignment was performed by registering the hematoxylin channel to the Xenium DAPI image using:

* Linear registration (`imregcorr`)
* Followed by nonlinear registration (`imregdemons`)

The resulting transformation was applied to the full H&E image to produce an aligned image in Xenium space.

---

## Repository Structure

```
xenium-he-alignment/
│
├── computeAlignment.m    # Computes transformation between Xenium DAPI and H&E hematoxylin
├── warp_image.m          # Applies transformation to H&E image
└── README.md
```

---

## Requirements

* MATLAB (tested on version R20XX or later)
* Image Processing Toolbox

---

## Workflow

### Step 1: Compute Alignment

Compute the spatial transformation between the Xenium DAPI image and the hematoxylin channel extracted from the H&E image.

```matlab
tform = computeAlignment('xenium_dapi.tif', 'he_image.tif');
```

**Details:**

* Hematoxylin signal is extracted via color deconvolution from the H&E image
* Initial alignment is performed using intensity-based linear registration (`imregcorr`)
* Refinement is performed using nonlinear registration (`imregdemons`)

---

### Step 2: Apply Transformation

Apply the computed transformation to the full H&E image.

```matlab
aligned_he = warp_image('he_image.tif', tform);
imshow(aligned_he)
```

---

## Inputs

* **Xenium DAPI image** (TIFF)
* **H&E whole slide image** (TIFF)

---

## Outputs

* Transformed H&E image aligned to Xenium coordinate space

---

## Notes and Considerations

* Alignment quality depends on tissue preservation and section similarity
* Nonlinear registration improves local alignment but may introduce distortions if images differ significantly
* Whole slide images may require substantial memory depending on resolution
* Preprocessing (e.g., resizing, cropping) may improve performance in large datasets

---

## Authors

* [Eric Rosiek]
* [Robert Stanley]

---

## License

This project is licensed under the MIT License. See the LICENSE file for details.

---

## Citation

If you use this code in your work, please cite the associated manuscript (if applicable) and/or reference this repository.

---

## Acknowledgments

* 10x Genomics for Xenium platform and staining protocols
* MATLAB Image Processing Toolbox for registration methods
