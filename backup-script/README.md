This script was written in ubuntu.
Before creating the script, set up ssmtp for sending mail from ubuntu. 

Steps to setup ssmtp in ubuntu:
- Update to latest version: sudo apt update
- Install ssmpt: sudo apt install ssmtp
- After installing ssmtp, edit ssmtp config files with your details
    - Using a text editor (eg. vim) open ssmtp.conf: sudo vim /etc/ssmtp/ssmtp.conf
    - Make the following changes:
        - root=your.mail@gmail.com
        - mailhub=smtp.gmail.com:587
        - AuthUser=your.mail@gmail.com
        - AuthPass=----------------
        - UseTLS=YES
        - UseSTARTTLS=YES
- (AuthPass is a 16 character AppPassword which you can get from your gmail account)
- Next edit the 'revaliases' file of ssmtp
    - Using a text editor (eg. vim) open revaliases: sudo vim /etc/ssmtp/revaliases
    - Add the following:
        - root:your.mail@gmail.com:smtp.gmail.com:587

With that your ssmtp should be setup for sending mail to any gmail accounts.
      
Now we will first setup our backup configuration file which will contain valid paths for source directory and destination directory respectively. It will also contain your email.
(Check backup.conf file)

Code instruction:
- vim backup.conf
    - create a variable for source directory and input path to source
    - create a variable for destination directory and input path to destination
    - create a variable for email and give your email as the value.

Next we will start writing our script
(check backup_script.sh)

- write the shbang line.
- load backup.conf file
    - if file exists, then source it. Else give an error message.
- define variable that will be used in the script
- using mkdir -p command, create the file and all the folder leading to the file (BACKUP_Destination + backup_File)
- Start logging and create backup.
-   
