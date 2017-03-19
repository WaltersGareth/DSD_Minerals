from boto3.s3.transfer import S3Transfer
import boto3, uuid, sys, os, json, arcpy, glob

## Global variables
bucket_name = 'dsd-mer-reg-app'
args = sys.argv
access_key = ''
secret_key = ''
object_key = ''
attachmentsFolder = "C:/DSD_Minerals/Attachments/"

 
#### Initialise the connections required for AWS
def initialiseS3():
    print "initialiseS3 "
	##Register a session and as a client
    s3client = boto3.client('s3')

    session = boto3.Session()
    credentials = session.get_credentials()
    access_key = credentials.access_key
    secret_key = credentials.secret_key
    print access_key, secret_key

    getBucket(s3client)
	
## Find the DBYD bucket	
def getBucket(s3client):
    print "getBucket "
    list_buckets_resp = s3client.list_buckets()

    for bucket in list_buckets_resp['Buckets']:
        if bucket['Name'] == bucket_name:
            uploadFile(s3client, bucket, bucket_name)
            break            
##
#### This function runs the upload of data	
def uploadFile(s3client, bucket, bucket_name):
##    dbydBucket = bucket
    print('Uploading some data...')

    for path, subdirs, files in os.walk(attachmentsFolder):
        for sub in subdirs:
            print sub
            folderKey = os.path.join(attachmentsFolder, sub)
            
            for path2, subdirs2, files2 in os.walk(folderKey):
                for file in files2:
                    print file
                    object_key = os.path.join(path2, file)
                    print object_key
                    transfer = S3Transfer(s3client)
                    name = sub + '/' + file
                    transfer.upload_file(object_key, bucket_name, name, callback=ProgressPercentage(object_key))
    print('Completed')

initialiseS3()
