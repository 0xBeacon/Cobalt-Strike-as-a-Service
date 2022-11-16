
<p align="center">
  <img src="CSaaS.png">
</p>

# CSaaS?  Not quite...

No, this is not CSaaS.  This is a janky little script that literally sets Cobalt Strike's team server up as a Linux service.

Red teamers often run their team servers under screen sessions, which can be fraught with problems. Therefore, I figured out how to set up a team server to run as a service so screen sessions are a thing of the past.


### Usage

```
git clone https://github.com/0xBeacon/Cobalt-Strike-as-a-Service.git
cd Cobalt-Strike-as-a-Service
chmod +x ./setup.sh 
./setup.sh
```

Running setup.sh will ask the following questions: 

- The location of your cobalt strike directory
- The IP your team server is using
- The password for your team server
- The location of your malleable c2 profile

**Note:** _There is no vetting of information provided, so make sure it's correct._


```
root@teamserver:~# ./setup.sh
[+] What is your Cobalt Strike TeamServer directory?
/root/cobaltstrike
[+] What is the TeamServer listening IP?
127.0.0.1
[+] What is the TeamServer Password?
password123
[+] What is the path to your c2 profile?
/root/cobaltstrike/c2.profile
[+] Does this TeamServer startup command look correct?
/root/cobaltstrike/teamserver 127.0.0.1 password123 /root/cobaltstrike/c2.profile
[+] Enter (y/n)
y
○ teamserver.service - Cobalt Strike Team Server
     Loaded: loaded (/etc/systemd/system/teamserver.service; disabled; vendor preset: enabled)
     Active: inactive (dead)
● teamserver.service - Cobalt Strike Team Server
     Loaded: loaded (/etc/systemd/system/teamserver.service; disabled; vendor preset: enabled)
     Active: activating (auto-restart) (Result: exit-code) since Wed 2022-11-16 17:41:27 UTC; 27ms ago
    Process: 2273 ExecStart=/root/cobaltstrike/teamserver 127.0.0.1 password123 /root/cobaltstrike/c2.profile (code=exited, status=203/EXEC)
   Main PID: 2273 (code=exited, status=203/EXEC)
        CPU: 828us
Created symlink /etc/systemd/system/multi-user.target.wants/teamserver.service → /etc/systemd/system/teamserver.service.
```

