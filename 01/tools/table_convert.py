"""
Excelからコピーした表をTypstのコードに変換するスクリプト
"""
import sys
from typing import List

def create_typst_table(title: str, columns: int, header: List[str], rows: List[List[str]], table_id: str) -> str:
    header_str = ', '.join(f'[{h}]' for h in header)
    table_lines = [
        f'#tb(',
        f'  "{title}",',
        f'  table(',
        f'    columns: {columns},',
        f'    table.header({header_str}),'
    ]
    
    for row in rows:
        row_str = ', '.join(f'[{v}]' for v in row)
        table_lines.append(f'    {row_str},')
        
    table_lines.extend([
        '  ),',
        f'  "{table_id}"',
        ')'
    ])
    
    return '\n'.join(table_lines)

def convert_excel_to_typst(data: str, table_id: str, table_title: str) -> str:
    """TSVデータ（Excelからのコピペ）をパースしてTypstのテーブルコードに変換します。"""
    if not data.strip():
        return ""
        
    lines = data.strip().splitlines()
    header = lines[0].split('\t')
    rows = [line.split('\t') for line in lines[1:]]
    
    return create_typst_table(table_title, len(header), header, rows, table_id)

if __name__ == "__main__":
    data = []
    table_id = input("Table Id: ")
    table_title = input("Table Title: ")
    while True:
        try:
            line = input()
            if line == "":
                break
            data.append(line)
        except EOFError:
            break
            
    input_data = "\n".join(data)
    if input_data:
        print(convert_excel_to_typst(input_data, table_id, table_title))
