#!/bin/bash
#SBATCH --job-name=cessna_Solve
#SBATCH --time=24:00:00
#SBATCH --ntasks=36
#SBATCH --nodes=1
#SBATCH --mem-per-cpu=1G

module load OpenFOAM/v2206-foss-2022a
. ${FOAM_BASH}

rm -r pro* opt*
potentialFoam
decomposePar
renumberMesh -overwrite
mpirun -np 36 adjointOptimisationFoam -parallel
mpirun -np 36 cumulativeDisplacement -parallel

