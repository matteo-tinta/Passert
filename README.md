# Passert

Passert is a file transfer utility that uses ngrok and scp to move file securily through the web.

## Instructions
1. Create an account and an access key into ngrok website
2. run the container
```bash
mkdir -p ./upload
docker run -it --rm -v ./upload:/upload -e NGROK_AUTHTOKEN=$NGROK_AUTHTOKEN passert tcp 22
```
3. Use scp command utility to copy files back and forth

**All files will be automatically visible on your machine. Enjoy!**

## Known issues
- Cannot reach the ssh service: Check your ISP or router for outbound trafic. Otherwise, use your phone hotspot

