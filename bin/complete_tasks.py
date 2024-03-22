from datetime import datetime
import re
import sys

# タスクリストを受け取り、完了済みのタスクを整形して返す


def convert_tasklist(tasklist):
    pending_tasks = []
    completed_tasks = []

    for task in tasklist:
        if re.match(r"^\s*- \[ \]", task):
            pending_tasks.append(task)
        elif re.match(r"^\s*- \[x\]", task):
            completed_tasks.append(re.sub(r"^\s*", "", task))

    output = []
    output.extend(pending_tasks)

    if completed_tasks:
        output.append("\n# 完了済\n")
        output.append(f"## {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
        output.extend(completed_tasks)

    return "\n".join(output)


def main():
    md_text = sys.stdin.read()
    tasklist = md_text.split("\n")
    converted_tasklist = convert_tasklist(tasklist)
    print(converted_tasklist)


if __name__ == "__main__":
    main()
