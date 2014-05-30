# Function Regression in Ecology and Evolution (FREE)

This README is for the R package FREE (Function Regression in Ecology and Evolution).

Copyright &copy; 2014, Jian Yen

*****

## Licence details
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

*****

## Overview
FREE is a collection of R helper functions for fitting regression models where response and/or predictor variables are functions, rather than scalar quantities. The emphasis is on easy model fitting and straightforward interfaces, with a focus on ecological and evolutionary applications. All functions in FREE are written in R 3.0.2.

Several additional packages are required (see Installation, below); and some of these packages are not available through CRAN.

Currently only functional response variables are considered but future updates will introduce functional predictors.

A purpose-built Gibbs sampler has been developed and is intended to replace the other packages. This Gibbs sampler method is included in the current package but is in development, so other methods have not yet been removed. We intend to incorporate both functional predictors and responses into this package using a Gibbs sampler. We are releasing FREE in its current form because functional data analysis has the potential to provide new insight into ecological and evolutionary questions and the testing and development of our purpose-built Bayesian approach could take several years.


Created 13 February 2014

Updated 25 March 2014

*****

## Installation
FREE is distributed as an R package but is not currently available through the CRAN. There are two versions of the FREE package, one for Windows systems (tested on Windows 7 and Windows XP) and one for OSX/UNIX systems (tested only on OSX 10.6; not currently up-to-date).

For Windows users: simply download the file FREE_x.x.tar.gz into a local directory on your computer (replace x.x with the appropriate version number).

For OSX users: navigate to the folder OSX/ and download the file FREE_x.x.tar.gz into a local directory on your computer. If you install this version, you do not need to install the rstan, R2WinBUGS, coda or boot packages

#### Experimental
A simple install procedure has been developed, but is currently experimental and may not work on all systems.

Simply enter the following into your R console (setting OSX.install=TRUE for OSX users).
```
source("https://github.com/jdyen/FREE/installFREE")
installFREE(OSX.install=FALSE)
```

You still need to install a C++ compiler if using rstan. See the instructions below for details (or see [gcc](https://github.com/kennethreitz/osx-gcc-installer/) for OSX users and [Rtools](https://github.com/stan-dev/rstan/wiki/Install-Rtools-for-Windows) for Windows users).
*****

Before installing this R package several additional packages must be installed within R:

1. [rstan](http://mc-stan.org/rstan.html) (Windows users only)
2. [INLA](http://www.r-inla.org/)

See the links above for relevant details. Note that rstan and INLA are not currently available through the CRAN and must be installed according to the instructions on their websites.

FREE imports functions from several packages (see Depends and Imports in the DESCRIPTION file) and these packages must be installed for FREE to install and load correctly. There is a separate DESCRIPTION file for OSX users in the OSX/ folder. With the exception of rstan and INLA, all other packages are available through the CRAN and should be easy to install.

If package `maptools` is not installed correctly from the CRAN, try
```
install.packages("maptools", repos="http://R-Forge.R-project.org")
```

Once the appropriate packages have been installed, you simply need to place the file FREE_x.x.tar.gz in the current working directory (where x.x is replaced with the current version number) and use
```
install.packages("FREE_x.x.tar.gz", repos=NULL, type="source")
```
to install the FREE R package. This package then can be loaded in R using `library(FREE)`.

Errors during installation often are related to the installation of required packages. Restarting R and making sure all required packages can be loaded using `library(pkgName)` will identify missing or incorrectly installed packages.

An error might occur if rstan has been installed only for 64-bit architecture. There are two possible solutions to this problem:

- install FREE for 64-bit architecture only:
```
install.packages("FREE_1.0.tar.gz", repos = NULL, type = "source", INSTALL_opts=c("--no-multiarch"))
```
- install rstan for 32- and 64-bit architectures:
```
install.packages('rstan', type = 'source', INSTALL_opts = "--merge-multiarch")
```

Either one of these options should work.

NOTE: The BUGS methods require WinBUGS 1.4 and its jump add-in to be installed locally. See the [WinBUGS](http://www2.mrc-bsu.cam.ac.uk/bugs/) and [rjMCMC](http://www.winbugs-development.org.uk/rjmcmc.html) websites for details. WinBUGS does not install easily on non-Windows operating systems. Note that installing WinBUGS is not necessary to use other methods within package FREE.

NOTE: The BUGS and stan methods are not available in the OSX version. The required packages either are not available or do not install correctly on OSX systems. If you want to get the stan method working and can install and load the [rstan](http://mc-stan.org/rstan.html) package then it is possible to install the Windows version of FREE on OSX systems. The `stan` function within the `rstan` package causes R to crash on all OSX systems we have used.

*****

## Usage
Once FREE has been installed there are two main functions to use: `FREEfit` and `FREEfitCV`. Both of these functions have a formula interface (`FREEfit.formula` and `FREEfitCV.formula`) and information about their use can be found by typing `?FREEfit` and `?FREEfitCV` in the R console.

Mathematical and statistical details for each implementation, as well as a comparison of their performance, are discussed in:
Yen JDL, et al. (in preparation) Function regression in ecology and evolution.

Models fitted using `FREEfit` are of class FREEfit and have several S3 methods available: `print`, `summary`, `plot`, `coef`, `predict`, `fitted` and `residuals`. Models fitted using `FREEfitCV` are of class FREEfitCV and have several S3 methods available: `print`, `summary`, `plot` and `residuals`.

*****

## Feedback
Please send comments and bug reports to
<jdl.yen@gmail.com>