#!/usr/bin/env python3
import json
import time
import pathlib
import subprocess
import shutil

from datetime import datetime, timezone, date

ROOT = pathlib.Path.home() / "openclaw-drive"
AGENT_OUT = ROOT / "agent-out"
REQ_DIR = AGENT_OUT / "requests"
RESP_DIR = ROOT / "responded_requests"
COMP_DIR = AGENT_OUT / "completed_requests"
LOG_DIR = ROOT / "logs"

RESP_DIR.mkdir(parents=True, exist_ok=True)
COMP_DIR.mkdir(parents=True, exist_ok=True)
LOG_DIR.mkdir(parents=True, exist_ok=True)


def now():
    return datetime.now(timezone.utc).isoformat().replace("+00:00", "Z")


def log_event(ev):
    day = date.today().isoformat()
    log_path = LOG_DIR / f"requests-{day}.jsonl"
    with log_path.open("a") as f:
        f.write(json.dumps(ev) + "\n")


def handle_request(path: pathlib.Path):
    with path.open() as f:
        req = json.load(f)

    rid = req.get("id", path.name)
    rtype = req.get("type")
    payload = req.get("payload", {})

    if rtype != "shell_command":
        log_event(
            {"id": rid, "type": rtype, "status": "ignored_unknown_type", "ts": now()}
        )
        # unknown types: just drop the request
        path.unlink()
        return

    cmd = payload["command"]
    cwd = payload.get("cwd") or str(pathlib.Path.home())
    timeout = int(payload.get("timeout_sec", 60))

    log_event(
        {
            "id": rid,
            "type": rtype,
            "payload": payload,
            "status": "received",
            "ts": now(),
        }
    )

    try:
        log_event({"id": rid, "status": "running", "ts": now()})
        result = subprocess.run(
            cmd,
            shell=True,
            cwd=cwd,
            capture_output=True,
            text=True,
            timeout=timeout,
        )

        # enrich the original JSON with execution result
        req["status"] = "done"
        req["exit_code"] = result.returncode
        req["stdout"] = result.stdout
        req["stderr"] = result.stderr
        req["completed_at"] = now()

        log_event(
            {
                "id": rid,
                "status": "done",
                "exit_code": result.returncode,
                "stdout": result.stdout,
                "stderr": result.stderr,
                "ts": now(),
            }
        )

    except Exception as e:
        req["status"] = "error"
        req["error"] = str(e)
        req["completed_at"] = now()

        log_event(
            {
                "id": rid,
                "status": "error",
                "error": str(e),
                "ts": now(),
            }
        )

    # write back updated JSON to the same path
    tmp = path.with_suffix(".tmp")
    with tmp.open("w") as f:
        json.dump(req, f)
    tmp.replace(path)

    # copy to responded_requests (keep original request)
    dest = RESP_DIR / path.name
    shutil.copy2(str(path), dest)


def cleanup_responded():
    # delete responded_requests entries that already have a completed copy
    for resp_path in RESP_DIR.glob("*.json"):
        comp_path = COMP_DIR / resp_path.name
        if comp_path.exists():
            resp_path.unlink()


def main():
    REQ_DIR.mkdir(parents=True, exist_ok=True)
    while True:
        for path in sorted(REQ_DIR.glob("*.json")):
            handle_request(path)

        cleanup_responded()
        time.sleep(3)


if __name__ == "__main__":
    main()
