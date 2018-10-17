# README : Getting Started Guide to Using SLURM HPC scheduler to submit many jobs to batch scheduler

### Step 1: Understand the basic experiment: Train an autoencoder

We'd like to train an autoencoder (AE), just like in BDL class [Homework 4](https://www.cs.tufts.edu/comp/150BDL/2018f/assignments/hw4.html)

We're interested in exploring several settings:
* learning rate (lr) of 0.010 and 0.001
* number of hidden units of 032, 128, and 512

Suppose we've got a script that can train an AE under different settings: `hw4_ae.py`

Recall the Usage of this script:
```
$ python hw4_ae.py --help
  --help            show this help message and exit
  --n_epochs N_EPOCHS   number of epochs (default: 10)
  --batch_size BATCH_SIZE
                        batch size (default: 1024)
  --lr LR               Learning rate for grad. descent (default: 0.001)
  --hidden_layer_sizes HIDDEN_LAYER_SIZES
                        Comma-separated list of size values (default: "32")
  --filename_prefix FILENAME_PREFIX
  --q_sigma Q_SIGMA     Fixed variance of approximate posterior (default: 0.1)
  --n_mc_samples N_MC_SAMPLES
                        Number of Monte Carlo samples (default: 1)
  --seed SEED           random seed (default: 8675309)

```

So we could simply just manually call this script at different settings, like
```
python hw4_ae.py \
    --lr 0.001 \
    --hidden_layer_sizes 32 \
    --filename_prefix myresult
```

But this is boring! Let's use the cluster to run all 6 jobs (2 lr settings, 3 arch size settings) simultaneously!

### Step 2: Create a "do_experiment.slurm" script to perform our work

Take a look at do_experiment.slurm. You'll see it's like a standard shell script, but with a weird header (lines that start with '#')

The main body should look familiar:
* load the conda environment
* call the python script
* clean up after itself (deactivate the conda environment)

We can ignore the header for now. Try it out! It's just like any shell script:

```
$ bash do_experiment.slurm lr=0.001 hidden_layer_sizses=032
```

EXPECTED OUT:

```
Saving with prefix: mydemo
==== evaluation after epoch 0
Total images 60000. Total on pixels: 6221431. Frac pixels on: 0.132
  epoch   0  train loss 0.701  bce 0.701  l1 0.502
Total images 10000. Total on pixels: 1052359. Frac pixels on: 0.134
  epoch   0  test  loss 0.701  bce 0.701  l1 0.502
====  done with eval at epoch 0
  epoch   1 | frac_seen 0.100 | avg loss 4.824e-03 | batch loss  2.844e-03 | batch l1  0.185
  epoch   1 | frac_seen 0.200 | avg loss 3.768e-03 | batch loss  2.659e-03 | batch l1  0.175
...
```


### Step 2: Create two scripts

We'll need two scripts:
* one to loop over all settings (launch_experiment.sh) 
* one to do the work at each setting (do_experiment.slurm)

Our desired end behavior is to just call the "launch_experiment.sh" script with a desired action:
```
$ bash launch_experiment.sh list      ## Just list out the settings we'll explore
$ bash launch_experiment.sh run_here  ## Actually run the experiment here in this terminal
$ bash launch_experiment.sh submit    ## Send the work to the HPC cluster to be scheduled, via 'sbatch'

```

As a test, please try the first command at your terminal. Don't try the others just yet.

If you peek at launch_experiment.sh, you'll see that we:
* loop over all settings of the variables
* at each one call do_experiment.sh

Note that we are using Environment Variables to store and pass information between the two scripts.


