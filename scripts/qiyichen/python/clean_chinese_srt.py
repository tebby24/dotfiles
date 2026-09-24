import re

def clean_chinese_srt(input_filepath, output_filepath):
    with open(input_filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    # Split the file into block groups separated by blank lines
    blocks = content.strip().split('\n\n')
    cleaned_blocks = []

    for block in blocks:
        lines = block.splitlines()
        if len(lines) >= 3:
            index = lines[0]
            timestamp = lines[1]
            
            # Combine all subsequent text lines into a single string
            text_lines = lines[2:]
            combined_text = "".join(text_lines)
            
            # Remove spaces between Chinese characters
            cleaned_text = re.sub(r'(?<=[\u4e00-\u9fff])\s+(?=[\u4e00-\u9fff])', '', combined_text)
            
            cleaned_blocks.append(f"{index}\n{timestamp}\n{cleaned_text}")
        else:
            # Fallback for unexpected formats
            cleaned_blocks.append(block)

    with open(output_filepath, 'w', encoding='utf-8') as f:
        f.write("\n\n".join(cleaned_blocks) + "\n")

# Example Usage:
# clean_chinese_srt('input.srt', 'output.srt')
