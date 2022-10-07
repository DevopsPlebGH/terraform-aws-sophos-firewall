#!/usr/bin/env python
import paramiko
import traceback
import os
import boto3
import base64
import logging
from botocore.exceptions import ClientError
from paramiko.ssh_exception import BadHostKeyException, AuthenticationException, SSHException
from paramiko_expect import SSHClientInteraction

HOST_IP=os.getenv("HOST_IP",None)
DEFAULT_USER=os.getenv("DEFAULT_USER",None)
DEFAULT_PASSWORD=os.getenv("DEFAULT_PASSWORD",None)
CONSOLE_SECRET_ARN=os.getenv("CONSOLE_SECRET_ARN",None)
REGION_NAME=os.getenv("REGION_NAME",None)


def ssh_connect(self):
  client = paramiko.SSHClient()
  client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
  try:
    client.connect(ip=HOST_IP,
                  username=USERNAME,
                  password=PASSWORD)
  except AuthenticationException as error:
    print('Authentication Failed: Please check your network/ssh key')
  finally:
    return client

def write_to_file(msg):
      with open('output.log', 'a') as f:
            f.write(msg)

def get_secret():
    secret_name = os.getenv("CONSOLE_SECRET_ARN")
    region_name = os.getenv("REGION_NAME")

    # Create a Secrets Manager client
    session = boto3.session.Session()
    client = session.client(
        service_name='secretsmanager',
        region_name=region_name
    )

    # In this sample we only handle the specific exceptions for the 'GetSecretValue' API.
    # See https://docs.aws.amazon.com/secretsmanager/latest/apireference/API_GetSecretValue.html
    # We rethrow the exception by default.

    try:
        get_secret_value_response = client.get_secret_value(
            SecretId=secret_name
        )
    except ClientError as e:
        if e.response['Error']['Code'] == 'DecryptionFailureException':
            # Secrets Manager can't decrypt the protected secret text using the provided KMS key.
            # Deal with the exception here, and/or rethrow at your discretion.
            raise e
        elif e.response['Error']['Code'] == 'InternalServiceErrorException':
            # An error occurred on the server side.
            # Deal with the exception here, and/or rethrow at your discretion.
            raise e
        elif e.response['Error']['Code'] == 'InvalidParameterException':
            # You provided an invalid value for a parameter.
            # Deal with the exception here, and/or rethrow at your discretion.
            raise e
        elif e.response['Error']['Code'] == 'InvalidRequestException':
            # You provided a parameter value that is not valid for the current state of the resource.
            # Deal with the exception here, and/or rethrow at your discretion.
            raise e
        elif e.response['Error']['Code'] == 'ResourceNotFoundException':
            # We can't find the resource that you asked for.
            # Deal with the exception here, and/or rethrow at your discretion.
            raise e
    else:
        # Decrypts secret using the associated KMS key.
        # Depending on whether the secret is a string or binary, one of these fields will be populated.
        if 'SecretString' in get_secret_value_response:
            secret = get_secret_value_response['SecretString']
        else:
            decoded_binary_secret = base64.b64decode(get_secret_value_response['SecretBinary'])

    # Your code goes here.
    return secret

def eula(client):
  client = paramiko.SSHClient()
  client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
  try:
    client.connect(HOST_IP,username=DEFAULT_USER,password=DEFAULT_PASSWORD)
    with SSHClientInteraction(client, timeout=10, display=True) as interact:
      interact.expect('End User License Agreement')
      interact.send('A')
  except Exception:
    traceback.print_exc()
  finally:
    try:
      client.close()
    except Exception:
      pass

def change_password(client):
  consolepassword=get_secret()
  client = paramiko.SSHClient()
  client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
  try:
    print (consolepassword)
    client.connect(HOST_IP,username=DEFAULT_USER,password=DEFAULT_PASSWORD)
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
      interact.send(consolepassword)
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
  logger = logging.getLogger()
  logger.setLevel(logging.DEBUG)
  client = ssh_connect(HOST_IP)
  eula(client="client")
  change_password(client="client")

if __name__ == "__main__":
    main()
