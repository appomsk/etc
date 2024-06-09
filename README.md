# History 1 Directory structure and .profile

Structure:

ETC=$HOME/usr/etc
LIB=$HOME/usr/lib
VAR=$HOME/var

$VAR/profile.d
$ETC/apps/{a,b,c..}/init

Profile - only set very global variables - PATH, etc. for applications. In apps - inits install vars for different applications in local profile.d

# History 2 making good .profile, testing 

Кажется работает.
