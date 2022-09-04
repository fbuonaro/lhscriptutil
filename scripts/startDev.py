#!python3.7

import argparse
import os
import subprocess
import sys

def getParser():
    parser = argparse.ArgumentParser(
        description='start development container')
    cwd = os.getcwd()

    parser.add_argument(
        '-i', '--image',
        help='image name' )
    parser.add_argument(
        '-p', '--project_root',
        help='root of project, default to $PWD',
        default=cwd )

    return parser

def main():
    parser = getParser()
    args = parser.parse_args()
    dockerParams = \
    [
        'docker',
        'run',
        '--rm',
        '-it',
        '-v',
        '{0}:/local-dev'.format( args.project_root ),
        '--cap-add=SYS_PTRACE', 
        '--entrypoint',
        '/bin/bash',
        args.image
    ]
    proc = subprocess.Popen( dockerParams )

    proc.wait()

    ret = proc.returncode

    return ret

if __name__ == '__main__':
    ret = main()
    sys.exit( ret )