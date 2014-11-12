
# *Git* and the Command Line

## Using the command line ##

Use the command line to navigate the directory tree.

* Use `cd /u/dokumente/` to dive into your documents directory.
* Use `pwd` to print the current working directory.
* Use `ls` to list all files and directories
* You can use `cd ..` to get to the parent directory

## Using git on the command line ##

		
1. If you haven't cloned your github repo, to your local machine, do it now! Navigate to the directory where you want to create the repo, then type:

		git clone https://github.com/YOUR_GITHUB_NAME/Principia-Textilica-Course.git
		
	replacing *YOUR_GITHUB_NAME* by your github name.
	
2. When using git on the command line always make sure you are inside the git repo.

   		git status
 
  	If you are outside the repo you will get this:
   
		fatal: Not a git repository (or any of the parent directories): .git

3. Navigate into the `Principia-Textilica-Course` repo using the command line.
		
4. Now add your teachers repo as a remote

		git remote add martin https://github.com/bitcraftlab/Principia-Textilica-Course.git

5. List all the remote repos

		git remote -v

5. To pull the latest code from your teachers's repo type:

		git pull martin master

