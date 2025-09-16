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
    - Write the line: exec >> >(tee -a "$LOG_FILE") 2>&1 , if you want the stdout to be displayed on the screen and saved in the log file.
    - Using tar command with -c (create), -z (g-zip), -f (file name) and give it the destination + filename, -C source location, .
    - eg., tar -czf "$BACKUP_DST/backup_$BACKUP_DATE/$BACKUP_FILENAME" -C "$BACKUP_SRC" .
    - the . indicates it to zip everything is current directory, i.e., the source directory
- Verify successful creation of backup
    - If file was created successfully,
        - print to the screen that backup was successsful and the filename
        - Here you can send a mail using ssmtp to inform about successful creation of backup.
    - Else,
        - print to the screen that backup was failed
        - Here you can send a mail using ssmtp to inform about failure of backing up.
- Next you can implement a backup rotation which keeps count of the number of backups available and deletes the excess (you can decide the number of backups to keep).
    - Define a variable which will be the number of backups you want at a time to exist.
    - Change to the backup directory and in this directory find the directories that start with "backup_*", sort in reverse order and using sed iterate through the sorted list of directories and remove the first n number of lines (where n is your variable which stores max number of backup) from the backup and pass the remaining to 'xargs rm -rf' as arguments which will make it delete the old backups.
    - Do the same for the log files.
- The backup script is complete, you can exit safely using 'exit 0'

To automate this process, use crontab and give your specific timings and the path to your file.

NOTE: 
    - Give your script executable permission using chmod +x filename
    - If you cannot execute the file due to lacking permission, use sudo to execute it
        - In case you need to use sudo for executing, make sure to write sudo before the path to your file in crontab.
  

