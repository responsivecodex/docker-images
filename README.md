<img src="https://avatars.githubusercontent.com/u/80433485?v=4" alt="drawing" style="width:80px; border-radius:50%; border: 0.5px solid gray;"/>

# Docker Images
Provide a set of images Docker's to work.

# System
## S.O.
- Linux Alpine

## Languajes
- Java
- Javascript
- HTML5
- CSS3

## Frameworks, engines
- NodeJS:
- Angular/Cli
- OpenSHH Server & Client, include commands like ssh-keygen, ssh-add

# Notes
- Users
  - Was generated a user named: admin
  - Was generated a user named: vscode
-Groups
- Was generated a group named:responsivecodex
  - This group was added to sudoers.d, then is a adinistrative group.
  - El user admin was added to this group
- Exposed
  --Port TCP  3030

## Relevant
- The settings allow redirect the trafic to real world
- You can access to host using the ip of your real machine.
  - If you have a application running on exposed port then try
    > ``http://<ip-real-machine>:3030/``
- You must run the forwardip.sh script o your container with this command:
    - docker exec -it dev-container /usr/scripts/forwardip.sh


# Some commnad useful...
- Ckecking OS version
  - cat /etc/os-release

# Setup VS Code
- Starting:
  - Terminal its not configured!, then open settings.json y paste this (apply if running VS Code on Windows):
   
    ```
      "workbench.colorTheme": "Default Dark Modern",
      "editor.minimap.enabled": false,
      "prettier.printWidth": 180,
      "files.autoSave": "afterDelay",
      "files.autoSaveDelay": 2000,
      "terminal.integrated.profiles.windows": {
        "Custom Init": {
            "path": "C:\\Windows\\System32\\cmd.exe",
            "args": [
                
            ]
        }
      },
      "terminal.integrated.defaultProfile.windows": "Custom Init"
    ```
    3.     
  
# Docker commands
- Build a image
  - docker build --network host -f Dockerfile .

- Running the image as a container, remember: this image does not have a background process so it only starts and ends immediately
  - Using this you have access to shell into the container.
    1. docker run -dit -p 3000:3000 --name dev-container  responsivecodex/alpine-nodejs-angular:1.0.0
    2. docker exec -it dev-container /usr/scripts/forwardip.sh
    3. If you don't need forward th IP:  
        - docker exec -it dev-container /bin/ash
    4. Later you can see the prompt and you can shot commands like "npm -v"

- List images running
  - docker ps
  
- Debug the startup of a image...
  1. docker events&
  2. Then run your failing docker run ... command. Then you should see something like the following on screen:
      - 2022-03-31T12:55:31.149870400-06:00 network disconnect 4af98db1e64560e9c3d849b8dff6b8b963c599a424e9ecb6b9a5cb8769ef16c9 (container=<ccotainer_id in format hex>, name=bridge, type=bridge)
  3. Then you can get the startup hex id from previous message or the output of the run command. 
  4. Then you can use it with the logs command:
      - docker logs <copy the instance id from docker events messages on screen>
      - You should now see some output from the failed image startup.

# Autor
- responsivecodex
- rrss
  
  - https://twitter.com/responsivecodex
  - https://instagram.com/responsivecodex
  - https://t.me/responsivecodex
  - https://codepen.io/responsivecodex
  - https://responsivecodex.livejournal.com
   -https://github.com/responsivecodex
  - https://www.youtube.com/channel/UCphNZaOu2Q5M9n_1XuTQSnA
  - https://responsivecodex.wordpress.com
