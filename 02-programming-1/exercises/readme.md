Exercises
========= 

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


 

## *exercise_02_01* ##

1. Install Processing on your local machine and run it.
2. Browse the repo on your local machine to find `exercise_02_01.pde` and run it
3. Modify the code of the processing sketch to show your name.
4. Play with the code some more
5. Commit the files you changed to your repo
		
		git add --all
		
6. Push the changes to your github




## *exercise_02_02* ##

1. Open the Mathematica Notebook inside the solutions folder.

2. Create a function of one variable. Example:

		fn[x_] := Sin[x] + Sin[2 x] / 2
	
3. Plot it using the various plot commands. Example:

		Plot[fn[x], {x, 0, 2 Pi}]
		
4. Now create a function of two variables. Example:

		fn[x_, y_] := Sin[x] + Cos[2 y] / 2

4. Plot it using various 3D plot commands

		ContourPlot[fn[x, y], {x, 0, 2 Pi}, {y, 0, 2 Pi}]

5. Use the various headlines, sections and text style to add some information

6. Add the code to your repo, commit and push!


