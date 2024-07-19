
# Instream Flow Management Code
Location for code related to calculating the unimpaired flow and applying different water allocation approaches to determine how the flow would change based on each approach.  This code was used to support the analysis for a paper entitled "Evaluating  approaches for protecting environmental flows in decentralized water management systems" that is currently in preparation for publication in a peer-reviewed journal.

The code is written as jupyter notebooks and is based on a series of python files written by Jesse Rowles (jesserowles@gmail.com).  Those python files are included as reference files in this repo in the XX folder. Note that these instructions and the environment are designed to run the jupyter notebook files and not the python files, so additional python packages may be needed to run that code.  See the readme in that folder for more details.
 
# Getting started

For use on windows machines, use the miniconda package manager.

## 1. Download and install Conda

Download Miniconda from https://conda.io/miniconda.html. Make sure to install the Python3 and 64-bit version. Installation instructions for windows is here https://docs.anaconda.com/miniconda/miniconda-install/

After it is installed, click on the start menu on the lower left of the screen to see all programs installed.  You should see a "Anaconda3 (64 bit)" folder and inside that folder should be a program called "Anaconda Prompt".  Start that program.  A new code window will open up.  You can check the installation by typing ```conda --version```. It is also adviceable to run ```conda update conda``` before you start.

## 2. Downlaod and install Git 

Test whether Git is installed on your system by typing in the same Anaconda Prompt window:

```
git --version
```

If no version number is returned, install Git from https://git-scm.com/.


## 3. Create a project directory named ```instream-flow-management```

We need a directory where the project will live. On a windows machine,you may use a directory like "C:\Users\USERNAME\Documents\workspace" where USERNAME is your user name for your computer.  Some of the files are quite large so make sure you have a several GB of free space.  I will refer to this location as PATH.  In the "Anaconda Prompt" window, navigate to this location by using typing in the correct drive (most people it will be "C:" but for me it is the "E:" drive) and then use the "cd" notation for "change directory".  Type in "cd" a space, and your PATH name.  For me it is 

```
E:
cd E:\Users\kklausmeyer\Documents\workspace
```

For you it may be different.  Now the prompt should read "(base) PATH>" where PATH is your path.  


In order to create a new directory ```instream-flow-management```

```
mkdir instream-flow-management
```

mkdir stands for make directory.  Now navigate to that directory by using the cd notation.

```
cd instream-flow-management
```

Now the prompt should read "(base) PATH\instream-flow-management>" where PATH is your path.

## 4. Git clone or pull the project

From within the ```instream-flow-management``` directory run:

```
git clone https://github.com/tnc-ca-geo/instream-flow-management.git
```

This will create a new folder or directory with the same name "instream-flow-management" inside the "instream-flow-management" folder.  Moving forward, we will refer to the two folders as the outer flow-update directory and the inner flow-update directory.

If an (inner) instream-flow-management directory already exists within the (outer) instream-flow-management directory, you will get an error message. In this case change using into the (inner) ```instream-flow-management``` directory and run

```
cd instream-flow-management
git pull origin
```

**Repeat this whenever you start working with the project to get the latest version**.


## 5. Create a conda environment using the conda_environment.yml file

It should (hopefully) be very easy to create the environment from the ```conda_environment.yml``` file in the repository. Change into the (inner) instream-flow-management directory, make sure ```conda_environments.yml``` is there (use the ```dir``` command) and run.


```
conda env create --file conda_environment.yml
```

This will take awhile and download a bunch of dependencies, eventually it should exit wthout an error message.

If you want to learn how to create an environment manually and how to add depencies to that environment see https://conda.io/docs/.

Please keep the ```conda_environment.yml``` file up to date if you introduce new dependencies into the project. As the project evolves other programmers might introduce new dependencies as well. You should update the environment after pulling a newer version of the project from Github

```
conda env update --file conda_environment.yml

```

## 5. Activate the environment

Type 

```
conda activate instream-flow-management
```

into a ```cmd``` shell in order to activate the environment.

**Note**: You need to do this whenever you open a new ```cmd``` shell. Environment activations are bound to the shell. Different shells may have different environments activated. If you use any integrated development environment such as IDLE, there are project-level settings that determine which environment will be used if you press the play button.

## 6. Install additional packages

Some of the packages are not available to install via conda forge and require the use of pip to install.  Once the environment is active, type the following commands:

```
pip install -U kaleido
pip install loess
```

## 7. Activate the Jupyter kernal

This project uses Jupyter notebooks to review output in real time.  When you set up the environment, you need to create a new kernel associated with the environment.  This command will do that:

```
python -m ipykernel install --user --name instream-flow-management --display-name "Python (instream-flow-management)"
```

**Note** If you have trouble with a Kernal Error in jupyter notebook, try installing pypiwin32.  Do this at the conda prompt and type 

```
pip install pypiwin32
```


# Updating the Code

When returning to the project to update the code, folow these steps:
1. Launch the "Anaconda Prompt" from your start menu (on a windows machine)
2. Use the cd notation to navigate to the inner directory of your working folder
```
cd PATH\instream-flow-management\instream-flow-management
```
or
```
cd C:\Users\kklausmeyer\Documents\workspace\instream-flow-management\instream-flow-management
```
3. (optional) Update the environment:
```
conda env update --file conda_environment.yml
```
4. Activate the environment
```
conda activate instream-flow-management
```
5. Get the latest version of the code from GitHub
```
git pull origin
```
6. Start Jupyter notebook
```
jupyter notebook
```



Here is a nice summary of the basic git commands to sync changes to the master repo
https://confluence.atlassian.com/bitbucketserver/basic-git-commands-776639767.html
