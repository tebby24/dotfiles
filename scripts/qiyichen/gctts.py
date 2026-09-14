
#!/usr/bin/env python3

import argparse
import base64
import json
import sys
import urllib.error
import urllib.parse
import urllib.request

API_URL = "https://texttospeech.googleapis.com/v1/text:synthesize"

def synthesize(
api_key,
text,
output,
voice="cmn-CN-Wavenet-A",
language_code="cmn-CN",
speaking_rate=1.0,
pitch=0.0,
):
"""Synthesize text using Google Cloud Text-to-Speech REST API."""

url = API_URL + "?" + urllib.parse.urlencode({"key": api_key})

request_body = {
    "input": {
        "text": text,
    },
    "voice": {
        "languageCode": language_code,
        "name": voice,
    },
    "audioConfig": {
        "audioEncoding": "MP3",
        "speakingRate": speaking_rate,
        "pitch": pitch,
    },
}

data = json.dumps(request_body).encode("utf-8")

request = urllib.request.Request(
    url,
    data=data,
    headers={
        "Content-Type": "application/json; charset=utf-8",
    },
    method="POST",
)

try:
    with urllib.request.urlopen(request) as response:
        result = json.loads(response.read())

except urllib.error.HTTPError as e:
    error_body = e.read().decode("utf-8", errors="replace")

    try:
        error_json = json.loads(error_body)
        message = error_json.get("error", {}).get("message", error_body)
    except json.JSONDecodeError:
        message = error_body

    raise RuntimeError(
        f"Google TTS API error ({e.code}): {message}"
    ) from None

except urllib.error.URLError as e:
    raise RuntimeError(f"Network error: {e.reason}") from None

if "audioContent" not in result:
    raise RuntimeError(
        "Google TTS response did not contain audioContent."
    )

audio = base64.b64decode(result["audioContent"])

with open(output, "wb") as f:
    f.write(audio)
```

def main():
parser = argparse.ArgumentParser(
description="Synthesize speech using Google Cloud Text-to-Speech."
)

```
parser.add_argument(
    "text",
    nargs="?",
    help="Text to synthesize. If omitted, read from stdin.",
)

parser.add_argument(
    "-k",
    "--api-key",
    required=True,
    help="Google Cloud API key.",
)

parser.add_argument(
    "-o",
    "--output",
    default="output.mp3",
    help="Output MP3 filename (default: output.mp3).",
)

parser.add_argument(
    "-v",
    "--voice",
    default="cmn-CN-Wavenet-A",
    help="Google TTS voice name (default: cmn-CN-Wavenet-A).",
)

parser.add_argument(
    "-l",
    "--language",
    default="cmn-CN",
    help="Language code (default: cmn-CN).",
)

parser.add_argument(
    "--rate",
    type=float,
    default=1.0,
    help="Speaking rate (default: 1.0).",
)

parser.add_argument(
    "--pitch",
    type=float,
    default=0.0,
    help="Voice pitch in semitones (default: 0.0).",
)

args = parser.parse_args()

if args.text is not None:
    text = args.text
else:
    text = sys.stdin.read().strip()

if not text:
    parser.error("No text provided.")

try:
    synthesize(
        api_key=args.api_key,
        text=text,
        output=args.output,
        voice=args.voice,
        language_code=args.language,
        speaking_rate=args.rate,
        pitch=args.pitch,
    )

except RuntimeError as e:
    print(f"Error: {e}", file=sys.stderr)
    sys.exit(1)

print(f"Saved to {args.output}")
```

if **name** == "**main**":
main()
