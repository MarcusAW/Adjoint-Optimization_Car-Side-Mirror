#!/bin/bash
#SBATCH --job-name=optimizationMeshing
#SBATCH --time=1:00:00
#SBATCH --ntasks=36
#SBATCH --nodes=1
#SBATCH --mem-per-cpu=1G

module load OpenFOAM/v2206-foss-2022a
. ${FOAM_BASH}

rm -r 0 1 2 3 pro*
cp -r C0.orig 0
blockMesh
surfaceFeatureExtract
decomposePar
mpirun -np 36 snappyHexMesh -parallel -overwrite
reconstructParMesh -constant
rm -rf processor*

