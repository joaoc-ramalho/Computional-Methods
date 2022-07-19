# 2022 Scientific Computing Intro

Welcome! This is a demo repository with the example of a data analysis' project using R.
# Joao Carlos Project

## Project structure

```
project/
*    ├── data/
*    │   ├── raw
*    │   └── processed
     ├── docs/
*    ├── figs/
     ├── R/
*    ├── output/
*    └── README.md
```
In the `R` directory you will find the scripts. Let's start using R!

````
Using github:

- 1°: We need to open the git bash executor. For that, we need to open the 
windows file executor in our project file, click with the right button in a
empty space and open Git Bash
- 2° Then, we need to initiate our git repository, with the command "git init".
- 3° if is your first time using this git bash, you should set up your 
user name with "git config --global user.name nome " and your email
"git config --global user.email email"
- 4°Then, we will type "git remote -v" to see if there is any remote in the 
#moment
- 5° Now, if there are no remotes, we can just add our work in git by using
"git add file.name", starting by our .gitignore file. Then we can just type
"git add ." to add every file in your git repository
- 6° then we can commit all files that were added by typing "git commit -m 'a 
message of your commit' "
- 7° now we have the security part that is taking our key in RStudio and bring
it to git. This process shoul be done just one time per PC.
We will open here in Rstudio Tools > global options > git/SVN and then click on
"create an RSA key" - Choose the name of it and copy the key.
So, in github web site, we will click in our profile (upper right) > settings >
SSH and GPC keys, and register your key
- 8° Now its time to create a new repository on GitHub. For that, we need to open
our profile in GitHub, click on repositories and then in "new". Then, just set 
the ropository name and don't change nothing else
- 9° Now, we will send our files to that new repository. For that, we will use
the repository key,ssh, that apears when we create the repository.
After copying the key, we need to type "git remote add origin key_to_repository"
in the git terminal
- 10° the we can check if our remote terminal are working by typing again
"git remote -v". If 2 different lines showed up, it means that you have yor
local and remote repositories working, meaning that you can go on
- 11° The last step is to "push" your files to the remote repository. To do that
we just type "git push origin -u master"
- 12° now we can refresh our github page and the files should be there

