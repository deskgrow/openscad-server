from flask import Flask, request, send_file
import subprocess, uuid

app = Flask(__name__)

@app.route("/stl")
def make_stl():
    # URL例: /stl?len=230&depth=90&height=80
    L = request.args.get("len", 200)
    D = request.args.get("depth", 80)
    H = request.args.get("height", 70)

    tmpfile = f"/tmp/{uuid.uuid4()}.stl"

    subprocess.run([
        "openscad", "-o", tmpfile,
        "-D", f"len={L}",
        "-D", f"depth={D}",
        "-D", f"height={H}",
        "base.scad"
    ], check=True)

    return send_file(tmpfile, as_attachment=True)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=10000)
