import paramiko,traceback
from paramiko import SSHClient
from paramiko_expect import SSHClientInteraction
from paramiko.ssh_exception import BadHostKeyException, AuthenticationException, SSHException

class RemoteConnect():
  def __init__(self,ip):
    self.ip = ip
    self.client = None
    self._connect()

  def _connect(self):
    try:
      self.connect = paramiko.SSHClient()
      self.client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
      self.connect(ip=self.ip,
                  username=USERNAME,
                  password=PASSWORD)
    except AuthenticationException as error:
      print('Authentication Failed: Please check your network/ssh key')
    finally:
      return self.client

  def exec_command(self,command):
    if self.client == None:
      self.client == self._connect()
    stdin,stdout,stderr = self.client.exec_command(command)
    status = stdout.channel.recv_exit_status()
    if status == 0:
      return stdout.read()
    else:
      return None

class InitialConfig():
  def __init__(self,client):
    self.client = None
  def change_password(self):
    client = paramiko.SSHClient()
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    try:
      client.connect(ip,username=xg_user,password=xg_default_password)
      with SSHClientInteraction(client, timeout=10, display=True) as interact:
        interact.expect('Select Menu Number')
        interact.send('2')
        interact.expect('Select Menu Number')
    except Exception:
      traceback.print_exc()
    finally:
      try:
        client.close()
      except Exception:
        pass




