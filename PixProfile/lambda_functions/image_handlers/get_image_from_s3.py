import boto3

# הגדרה של ה-Client של S3
s3 = boto3.client('s3')
IMAGES_BUCKET_NAME = 'user-images-bucket'

def get_image_handler(event, context):
    file_name = event['pathParameters']['fileName']

    # קבלת התמונה מ-S3
    response = s3.get_object(Bucket=IMAGES_BUCKET_NAME, Key=file_name)

    return {
        'statusCode': 200,
        'body': response['Body'].read(),
        'headers': {
            'Content-Type': 'image/jpeg'  # הנחה שזו תמונת JPEG, שנה לפי הצורך
        }
    }
