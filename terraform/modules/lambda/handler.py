# Simple Lambda handler used for demo.
# - reads S3_BUCKET and DDB_TABLE environment variables
# - expects to be invoked by SQS (event is in event['Records'])
# - places an item into DynamoDB and uploads the message body to S3

import os
import boto3

s3 = boto3.client('s3')
ddb = boto3.client('dynamodb')

S3_BUCKET = os.environ.get('S3_BUCKET')
DDB_TABLE = os.environ.get('DDB_TABLE')

def lambda_handler(event, context):
    print("lambda invoked with event:", event)
    for rec in event.get('Records', []):
        body = rec.get('body', '')
        message_id = rec.get('messageId', 'unknown-id')

        # Put item into DynamoDB (simple structure)
        ddb.put_item(
            TableName=DDB_TABLE,
            Item={
                'id': {'S': message_id},
                'payload': {'S': body}
            }
        )

        # Put an object into S3 so you can browse it in the bucket
        s3.put_object(
            Bucket=S3_BUCKET,
            Key=f"{message_id}.txt",
            Body=body.encode('utf-8')
        )

    return { "statusCode": 200 }