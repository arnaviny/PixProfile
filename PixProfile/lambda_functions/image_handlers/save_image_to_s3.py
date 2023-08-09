import json
import boto3

# הגדרה של ה-Client של S3
s3 = boto3.client('s3')
IMAGES_BUCKET_NAME = 'user-images-bucket'

def save_image_handler(event, context):
    # הנחה שהקובץ מגיע בצורה של מחרוזת מקודדת ב-base64
    file_content = event['file_content']
    file_name = event['file_name']

    # שמירת התמונה ב-S3
    s3.put_object(Bucket=IMAGES_BUCKET_NAME, Key=file_name, Body=file_content)

    return {
        'statusCode': 200,
        'body': json.dumps('Image saved successfully!')
    }
