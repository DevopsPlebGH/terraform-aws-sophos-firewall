#!/usr/bin/env python
import paramiko
import traceback
from paramiko.ssh_exception import BadHostKeyException, AuthenticationException, SSHException
from paramiko_expect import SSHClientInteraction

ip="52.52.203.132"
xg_user="admin"
xg_default_password="admin"

def logging(enable,event):
  if enable:
    print("DEBUG: " + event)
  return
def ssh_client():
  client = paramiko.SSHClient()
  client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
  try:
    client.connect(ip,username=xg_user,password=xg_default_password)
def main():

  client = paramiko.SSHClient()
  client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
  try:
    client.connect(ip,username=xg_user,password=xg_default_password)
    with SSHClientInteraction(client, timeout=10, display=True) as interact:
      interact.expect('Select Menu Number')
      interact.send('2')
      interact.expect('Select Menu Number')
      interact.send('1')
      interact.expect('SFOS')
  except Exception:
    traceback.print_exc()
  finally:
    try:
      client.close()
    except Exception:
      pass

if __name__ == "__main__":
    main()
