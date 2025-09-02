#This function will take data from a bucket and active the Glue Job to run on that bucket
#Make sure S3 Bucket or EventBridge (with the proper bucket) is set as a trigger and proper permissions are enabled
from __future__ import print_function
import boto3
import urllib

print('Loading function')

glue = boto3.client('glue')

def lambda_handler(event, context):
    gluejobname='insert-glue-job-here'

    try:
        runId = glue.start_job_run(JobName=gluejobname)
        status = glue.get_job_run(JobName=gluejobname, RunId=runId['JobRunId'])
        print("Job Status : ", status['JobRun']['JobRunState'])
    except Exception as e:
        print(e)
    raise e