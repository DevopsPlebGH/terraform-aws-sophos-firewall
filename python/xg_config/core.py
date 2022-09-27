class RemoteConnect():
    def __init__(self,host):
        self.host = host
        self.client = None
        self.scp = None
        self._connect()

    def _connect(self):
        try:
            self.client = SSHClient()
            self.client.load_system_host_keys()
            self.client.set_missing_host_key_policy(AutoAddPolicy())
            self.client.connect(hostname=self.host,
                                username=USERNAME,
                                password=PASSWORD)
            self.scp = SCPClient(self.client.get_transport())
        except AuthenticationException as error:
            print('Authentication Failed: Please check your network/ssh key')
        finally:
            return self.client

    def disconnect(self):
        self.client.close()
        self.scp.close()

    def exec_command(self,command):
        if self.client is None:
            self.client == self._connect()
        stdin,stdout,stderr = self.client.exec_command(command)
        status = stdout.channel.recv_exit_status()
        if status == 0:
            return stdout.read()
        else:
            return None

    def transfer(self,file,remotepath):
        try:
            if self.client is None:
                self.client = self._connect()
            self.scp.put(file,
                         remotepath,
                         recursive=True)
        except SCPException as error:
            print('SCPException: Failed transferring data')


