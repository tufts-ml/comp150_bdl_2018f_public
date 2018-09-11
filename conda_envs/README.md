Three steps to install the BDL Python environment anywhere


1) Download and install miniconda

```
wget https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh
```

Then run that script (`bash Miniconda2-latest-Linux-x86_64.sh`).

2) Clone this repo

```
$ git clone https://github.com/tufts-ml/comp150_bdl_2018f_public.git
```

3) Create the conda environment

```
cd path/to/comp150_bdl_2018f_public/conda_envs/

conda env create -f bdl_basic_env.yml
```

