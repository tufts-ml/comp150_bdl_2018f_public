#!/bin/bash

export n_epochs=50
export batch_size=100
export n_mc_samples=1
export q_sigma=0.1

## Learning rate for adam
for lr in 0.001 0.010
do
    export lr=$lr

## Architecture size (num hidden units)
for arch in 032 128 512
do
    export hidden_layer_sizes=$arch

    ## Use this line to see where you are in the loop
    echo "lr=$lr  hidden_layer_sizes=$hidden_layer_sizes"

    ## Use this line to submit the experiment to the batch scheduler
    # sbatch < do_experiment.slurm

    ## Use this line to just run interactively
    # bash do_experiment.slurm

done
done


