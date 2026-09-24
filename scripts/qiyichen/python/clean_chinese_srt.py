import argparse
import os
import re

def clean_chinese_srt(input_filepath, output_filepath=None):
    if not os.path.exists(input_filepath):
        print(f"Error: File '{input_filepath}' not found.")
        return

    # Default output path if not provided: input_cleaned.srt
    if not output_filepath:
        base, ext = os.path.splitext(input_filepath)
        output_filepath = f"{base}_cleaned{ext}"

    with open(input_filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    # Split the file into block groups separated by blank lines
    blocks = re.split(r'\n\s*\n', content.strip())
    cleaned_blocks = []

    for block in blocks:
        lines = block.splitlines()
        if len(lines) >= 3:
            index = lines[0]
            timestamp = lines[1]
            
            # Combine all text lines into a single string
            text = "".join(lines[2:])
            
            # Remove spaces between Chinese characters
            cleaned_text = re.sub(r'(?<=[\u4e00-\u9fff])\s+(?=[\u4e00-\u9fff])', '', text)
            
            cleaned_blocks.append(f"{index}\n{timestamp}\n{cleaned_text}")
        else:
            cleaned_blocks.append(block)

    with open(output_filepath, 'w', encoding='utf-8') as f:
        f.write("\n\n".join(cleaned_blocks) + "\n")

    print(f"Successfully cleaned: '{output_filepath}'")

if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        description="Clean up spaces and extra line breaks in Chinese SRT subtitle files."
    )
    parser.add_argument("input_file", help="Path to the input .srt file")
    parser.add_argument(
        "-o", "--output", 
        help="Path to the output .srt file (optional, defaults to <input_name>_cleaned.srt)",
        default=None
    )

    args = parser.parse_args()
    clean_chinese_srt(args.input_file, args.output)
