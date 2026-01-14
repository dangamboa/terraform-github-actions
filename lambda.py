from datetime import datetime, timezone

def lambda_handler(event, context):
    time_utc = datetime.now(timezone.utc).strftime("%Y-%m-%d %H:%M:%S UTC")
    
    return {
        "statusCode": 200,
        "headers": {
            "Content-Type": "text/plain; charset=utf-8"
        },
        "body": "Hello world from lambda at " + time_utc
    }
