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
(AuthPass is a 16 character AppPassword which you can get from your gmail account)
- Next edit the 'revaliases' file of ssmtp
    - Using a text editor (eg. vim) open revaliases: sudo vim /etc/ssmtp/revaliases
    - Add the following:
        - root:your.mail@gmail.com:smtp.gmail.com:587
With that your ssmtp should be setup for sending mail to any gmail accounts.
      
