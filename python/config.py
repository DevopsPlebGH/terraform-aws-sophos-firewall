#!/usr/bin/env python
import paramiko
import traceback
import os
from paramiko.ssh_exception import BadHostKeyException, AuthenticationException, SSHException
from paramiko_expect import SSHClientInteraction

IP=os.getenv(IP)
USERNAME=os.getenv(USERNAME)
DEFAULT_PASSWORD=os.getenv(DEFAULT_PASSWORD)
CONSOLE_PASSWORD=os.getenv(CONSOLE_PASSWORD)


def ssh_connect(self):
  client = paramiko.SSHClient()
  client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
  try:
    client.connect(ip=IP,
                  username=USERNAME,
                  password=PASSWORD)
  except AuthenticationException as error:
    print('Authentication Failed: Please check your network/ssh key')
  finally:
    return client

def logging(enable,event):
  if enable:
    print("DEBUG: " + event)
  return

def change_password(client):
  client = paramiko.SSHClient()
  client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
  try:
    client.connect(IP,username=USERNAME,password=DEFAULT_PASSWORD)
    with SSHClientInteraction(client, timeout=10, display=True) as interact:
      interact.expect('Select Menu Number')
      interact.send('2')
      interact.expect('Select Menu Number')
      interact.send('1')
      interact.expect('continue?')
      interact.send('Y')
      interact.expect('Enter current password:')
      interact.send(DEFAULT_PASSWORD)
      interact.expect('Enter new password')
      interact.send(consolepassword)
      interact.expect('Re-Enter new Password')
      interact.send(consolepassword
      interact.expect('Password Changed')
      interact.send()
  except Exception:
    traceback.print_exc()
  finally:
    try:
      client.close()
    except Exception:
      pass

def main():
  client = ssh_connect(IP)
  change_password(client="client")

if __name__ == "__main__":
    main()
