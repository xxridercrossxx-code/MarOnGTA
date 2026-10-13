#!/usr/bin/env python3
"""Download the game files the build needs from YOUR OWN server.

The build needs the engine (b/8b0b5899ed/game.wasm), the file list
(data/manifest.json) and the shaders (b/8b0b5899ed/shaders: index.json and
18 shader packs, about 75 MB), which are precompiled into the app for Metal.
Everything else streams to the phone while you play. Nothing is downloaded
from anywhere except the server you give.
"""
import argparse
import hashlib
import json
import sys
import urllib.request
from pathlib import Path

ENGINE = 'b/8b0b5899ed/game.wasm'
ENGINE_SHA256 = '11ca8d2c04c5e843d18ff4aea4899d72c86973c6b031df334e67c446b2ae83e0'
SHADERS = 'b/8b0b5899ed/shaders'
SHADER_INDEX_SHA256 = '11c331895051b30126980ef666bd8935314ab400348b17c56ef8fe8983f50ee0'

parser = argparse.ArgumentParser()
parser.add_argument('--server', required=True, help='e.g. https://my-pc.tailnet-name.ts.net')
parser.add_argument('--out', type=Path, required=True, help='folder to place a minimal mirror in')
args = parser.parse_args()
server = args.server.rstrip('/')

def fetch(relative):
    target = args.out / relative
    target.parent.mkdir(parents=True, exist_ok=True)
    print(f'Downloading {relative} from your server...', flush=True)
    try:
        with urllib.request.urlopen(f'{server}/{relative}', timeout=120) as response, target.open('wb') as stream:
            while chunk := response.read(1 << 20):
                stream.write(chunk)
    except Exception as error:
        sys.exit(f'Could not download {server}/{relative}: {error}\n'
                 'Check that the server is running, reachable, and serves the folder that contains data/ and b/.')
    return target

engine = fetch(ENGINE)
if hashlib.sha256(engine.read_bytes()).hexdigest() != ENGINE_SHA256:
    sys.exit('Your game.wasm is not the build this port supports (8b0b5899ed). '
             'The engine patches are made for that exact file.')
fetch('data/manifest.json')
index = fetch(SHADERS + '/index.json')
if hashlib.sha256(index.read_bytes()).hexdigest() != SHADER_INDEX_SHA256:
    sys.exit('Your shader index does not match game build 8b0b5899ed.')
for pack in json.loads(index.read_text())['_packs']:
    if not (args.out / SHADERS / pack['file']).exists():
        fetch(SHADERS + '/' + pack['file'])
print('Game files OK.')
