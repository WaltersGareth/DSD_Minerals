from boto3.s3.transfer import S3Transfer
import boto3, uuid, sys, os, json, arcpy, glob, time

## Global variables
bucket_name = 'dsd-mer-reg-app'
args = sys.argv
access_key = ''
secret_key = ''
object_key = ''
attachmentsFolder = "C:/DSD_Minerals/Attachments/"

##CMD Arguments
prefix = sys.argv[1]

##
#### This class helps the upload method detail the percentage of file upload
class ProgressPercentage(object):
    def __init__(self, filename):
        self._filename = filename
        self._size = float(os.path.getsize(filename))
        self._seen_so_far = 0
        #self._lock = threading.Lock()

    def __call__(self, bytes_amount):
    # To simplify we'll assume this is hooked up
    # to a single filename.
        #with self._lock:
        self._seen_so_far += bytes_amount
        percentage = (self._seen_so_far / self._size) * 100
		#sys.stdout.write("\\r%s  %s / %s  (%.2f%%)" % (self._filename, self._seen_so_far, self._size, percentage))
        sys.stdout.write("%.2f%%\n" % (percentage))
        sys.stdout.flush()
 
## check the file added
def checkFile():
    filesize = os.path.getsize(object_key)
    if filesize == 0:
        sys.exit('The map package maybe faulty or corrupt as the file size is 0.')
    else:
        print 'approx. ' + str((filesize / 1024) / 1024 ) + 'gb'
        ## Connect to the AWS instance. This is automatically looking for credentials in the .AWS folder
        print "testing " + object_key
        initialiseS3()    
 
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
##            prefix = 'testFinal'
            global prefix
            for file in s3client.list_objects_v2(Bucket=bucket_name, Prefix=prefix)['Contents']:
                print file['Key']
                name = file['Key'][len(prefix)+1:]
                print "prefix: " + prefix
                downloadFolder = os.path.join("C:\\DSD_Minerals\\Attachments", prefix)
                if not os.path.exists(downloadFolder):
                    os.makedirs(downloadFolder)
                outputfile = os.path.join(downloadFolder, name)
                s3 = boto3.resource('s3')
                bucket = s3.Bucket(bucket_name)
                transfer = S3Transfer(s3client)
                if not os.path.exists(outputfile):
                    transfer.download_file(bucket_name, file['Key'], outputfile)
                else:
                    print "already downloaded."
            break            

initialiseS3()
