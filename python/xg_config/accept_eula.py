#!/usr/bin/env python
import paramiko
import traceback
import logging
import os
import getpass
from paramiko.ssh_exception import BadHostKeyException, AuthenticationException, SSHException
from paramiko_expect import SSHClientInteraction

HOST_IP=os.getenv("HOST_IP",None)
DEFAULT_USER=os.getenv("DEFAULT_USER",None)
DEFAULT_PASSWORD=os.getenv("DEFAULT_PASSWORD",None)
CONSOLE_SECRET_ARN=os.getenv("CONSOLE_SECRET_ARN",None)
REGION_NAME=os.getenv("REGION_NAME",None)

ip = input("Enter Host: ")
username = input("Enter Username: ")
password = getpass.getpass()

remote_conn_pre = paramiko.SSHClient()
remote_conn_pre.set_missing_host_key_policy(paramiko.AutoAddPolicy())
remote_conn_pre.connect(ip, username=DEFAULT_USER, password=DEFAULT_PASSWORD, allow_agent=False, look_for_keys=False)
print ("SSH connection established to %s" % ip)

remote_conn = remote_conn_pre.invoke_shell()
output = remote_conn.recv(1000).decode("utf-8")
prompt = output.strip()
remote_conn.close()

remote_conn = remote_conn_pre.invoke_shell()
output = remote_conn.recv(1000).decode("utf-8")
prompt = output.strip()
remote_conn.close()

remote_conn_pre.connect(ip, username=username, password=password, allow_agent=False, look_for_keys=False)
interact = SSHClientInteraction(remote_conn_pre, timeout=20, display=False)

remote_conn = remote_conn_pre.invoke_shell()
output = remote_conn.recv(1000).decode("utf-8")
prompt = output.strip()
remote_conn.close()

# Now we reconnect with the paramiko expect module and we have a nice interactive conversation.
remote_conn_pre.connect(ip, username=username, password=password, allow_agent=False, look_for_keys=False)
interact = SSHClientInteraction(remote_conn_pre, timeout=20, display=False)

#Logged in, wait for the prompt to display.
interact.expect(prompt)
#Shut off the --more-- prompting
interact.send('terminal length 0')
interact.expect(prompt)
#We don't care about the output for that last command, so just clear the buffer.
cmd_output = interact.current_output_clean
#Let's grab something BIG that use dto be a real timing issue the old way, not knowing how long it might take to get a full
# running config over a WAN link. Now we do not care, we will simply wait to the prompt shows up.


#Close our session
remote_conn_pre.close()
